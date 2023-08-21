#' Quality Payment Program Experience
#'
#' @description Information on participation and performance in the Merit-based
#'    Incentive Payment System (MIPS) and Advanced Alternative Payment Models
#'    (APMs) tracks.
#'
#' @details The Quality Payment Program (QPP) Experience dataset provides
#'    participation and performance information in the Merit-based Incentive
#'    Payment System (MIPS) during each performance year. They cover
#'    eligibility and participation, performance categories, and final score
#'    and payment adjustments. The dataset provides additional details at the
#'    TIN/NPI level on what was published in the previous performance year.
#'    You can sort the data by variables like clinician type, practice size,
#'    scores, and payment adjustments.
#'
#' @section Links:
#'   * [Quality Payment Program Experience](https://data.cms.gov/quality-of-care/quality-payment-program-experience)
#'
#' @section Update Frequency: **Annually**
#' @param year integer, YYYY, QPP Performance year. Run the helper function
#'    `quality_payment_years()` to return a vector of currently
#'    available years.
#' @param npi The NPI assigned to the clinician when they enrolled in Medicare.
#'    Multiple rows for the same NPI indicate multiple TIN/NPI combinations.
#' @param state The State or US territory code location of the
#'    TIN associated with the clinician.
#' @param specialty The specialty description is an identifier corresponding to
#'    the type of service that the clinician submitted most on their Medicare
#'    Part B claims for this TIN/NPI combination.
#' @param participation_type Indicates the level at which performance data was
#'    collected, submitted or reported for the final score attributed to the
#'    clinician. This information drives the data displayed for most of the
#'    remaining fields in this report.
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' quality_payment(year = 2020, npi = 1144544834)
#' @autoglobal
#' @export
quality_payment <- function(year,
                            npi                = NULL,
                            state              = NULL,
                            specialty          = NULL,
                            participation_type = NULL,
                            tidy               = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}

  # match args ----------------------------------------------------
  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(quality_payment_years()))

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                              ~y,
    "npi",                            npi,
    "practice state or us territory", state,
    "clinician specialty",            specialty,
    "participation type",             participation_type)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # update distribution ids -------------------------------------------------
  id <- cms_update("Quality Payment Program Experience", "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  #post   <- "/data.json?"
  post   <- "/data?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- tibble::tribble(
      ~x,                               ~y,
      "year",                           as.character(year),
      "npi",                            as.character(npi),
      "practice state or us territory", state,
      "clinician specialty",            specialty,
      "participation type",             participation_type) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            as.character(cli_args$y),
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
    return(invisible(NULL))

  }

  # parse response ---------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
                check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., " ")),
                    dplyr::across(dplyr::any_of(c("practice_size",
                                                  "years_in_medicare",
                                                  "medicare_patients",
                                                  "services")), as.integer),
                    dplyr::across(dplyr::any_of(c("allowed_charges",
                                                  "payment_adjustment_percentage",
                                                  dplyr::contains("_score"),
                                                  "complex_patient_bonus",
                                                  "quality_improvement_bonus")), as.double),
                    dplyr::across(dplyr::any_of(c("engaged",
                                                  "opted_into_mips",
                                                  "small_practitioner",
                                                  "rural_clinician",
                                                  "hpsa_clinician",
                                                  "ambulatory_surgical_center",
                                                  "hospital_based_clinician",
                                                  "non_patient_facing",
                                                  "facility_based",
                                                  "extreme_hardship",
                                                  "extreme_hardship_quality",
                                                  "quality_bonus",
                                                  "extreme_hardship_pi",
                                                  "pi_hardship",
                                                  "pi_reweighting",
                                                  "pi_bonus",
                                                  "extreme_hardship_ia",
                                                  "ia_study",
                                                  "extreme_hardship_cost")), tf_logical)) |>
      dplyr::mutate(year = as.integer(year)) |>
      dplyr::select(year,
                    npi,
                    practice_state = practice_state_or_us_territory,
                    practice_size,
                    clinician_specialty,
                    years_in_medicare,
                    participation_type,
                    beneficiaries = medicare_patients,
                    services,
                    allowed_charges,
                    final_score,
                    payment_adjustment = payment_adjustment_percentage,
                    quality_score = quality_category_score,
                    pi_score = promoting_interoperability_pi_category_score,
                    ia_score,
                    cost_score,
                    complex_patient_bonus,
                    quality_improvement_bonus,
                    ind_quality_bonus = quality_bonus,
                    ind_engaged = engaged,
                    ind_opted_into_mips = opted_into_mips,
                    ind_small_practitioner = small_practitioner,
                    ind_rural = rural_clinician,
                    ind_hpsa = hpsa_clinician,
                    ind_asc = ambulatory_surgical_center,
                    ind_hospital_based = hospital_based_clinician,
                    ind_non_patient_facing = non_patient_facing,
                    ind_facility_based = facility_based,
                    ind_extreme_hardship = extreme_hardship,
                    ind_extreme_hardship_quality = extreme_hardship_quality,
                    ind_extreme_hardship_pi = extreme_hardship_pi,
                    ind_pi_hardship = pi_hardship,
                    ind_pi_reweighting = pi_reweighting,
                    ind_pi_bonus = pi_bonus,
                    ind_pi_cehrt_id = pi_cehrt_id,
                    ind_extreme_hardship_ia = extreme_hardship_ia,
                    ind_ia_study = ia_study,
                    ind_extreme_hardship_cost = extreme_hardship_cost,
                    dplyr::contains("quality_measure_"),
                    dplyr::contains("pi_measure_"),
                    dplyr::contains("ia_measure_"),
                    dplyr::contains("cost_measure_")) |>
      #janitor::remove_empty(which = c("rows", "cols")) |>
      tidyr::nest(special_statuses = dplyr::contains("ind_"),
                  measures = dplyr::contains("measure_"))
  }
  return(results)
}

#' Check the current years available for the Quality Payments API
#' @return integer vector of years available
#' @examples
#' quality_payment_years()
#' @autoglobal
#' @rdname quality_payment
#' @export
quality_payment_years <- function() {
  as.integer(cms_update("Quality Payment Program Experience", "years"))
}

#' Quality Payment Program Eligibility
#'
#' @description Data pulled from across CMS that is used to create an
#'    eligibility determination for a clinician. Using what CMS knows about a
#'    clinician from their billing patterns and enrollments, eligibility is
#'    "calculated" multiple times before and during the performance year.
#'
#' @details The Quality Payment Program (QPP) Eligibility System pulls together
#'    data from across the Centers for Medicare and Medicaid Services (CMS) to
#'    create an eligibility determination for every clinician in the system.
#'    Using what CMS knows about a clinician from their billing patterns and
#'    enrollments, eligibility is "calculated" multiple times before and during
#'    the performance year. Information can be obtained primarily by the
#'    Clinician type. You can query the Clinician type by passing in an National
#'    Provider Identifier, or NPI. This number is a unique 10-digit
#'    identification number issued to health care providers in the United
#'    States by CMS. The information contained in these endpoints includes
#'    basic enrollment information, associated organizations, information
#'    about those organizations, individual and group special status
#'    information, and in the future, any available Alternative Payment Model
#'    (APM) affiliations.
#'
#' @section Links:
#'   * [QPP Eligibility API Documentation](https://cmsgov.github.io/qpp-eligibility-docs/)
#'
#' @section Update Frequency: **Annually**
#' @param year integer, YYYY, QPP eligibility year.
#' @param npi NPI assigned to the clinician when they enrolled in Medicare.
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' quality_eligibility(year = 2020, npi = 1144544834)
#' @autoglobal
#' @export
quality_eligibility <- function(year,
                                npi,
                                tidy = TRUE) {

  url <- glue::glue("https://qpp.cms.gov/api/eligibility/npi/{npi}/?year={year}")

  error_body <- function(resp) {
    httr2::resp_body_json(resp)$error$message
  }

  resp <- httr2::request(url) |>
    httr2::req_error(body = error_body) |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE)

  # Isolate & remove Organization
  org <- resp$data$organizations |> janitor::clean_names()

  resp$data$organizations <- NULL

  # Convert top level to tibble
  top <- resp$data |>
    purrr::compact() |>
    purrr::list_flatten() |>
    purrr::list_flatten() |>
    as.data.frame() |>
    dplyr::tibble() |>
    dplyr::mutate(year = year, .before = 1) |>
    janitor::clean_names()

  results <- dplyr::bind_cols(top, org)

  # clean names -------------------------------------------------------------
  if (tidy) {

    results <- results |>
      tidyr::unnest_wider(c(apms,
                            individual_scenario,
                            group_scenario), names_sep = ".") |>
      tidyr::unnest_wider(c(apms.extremeHardshipReasons,
                            apms.qpPatientScores,
                            apms.qpPaymentScores,
                            individual_scenario.extremeHardshipReasons,
                            individual_scenario.lowVolumeStatusReasons,
                            individual_scenario.specialty,
                            individual_scenario.isEligible,
                            group_scenario.extremeHardshipReasons,
                            group_scenario.lowVolumeStatusReasons,
                            group_scenario.isEligible), names_sep = "_") |>
      tidyr::unnest_wider(c(individual_scenario.lowVolumeStatusReasons_1,
                            group_scenario.lowVolumeStatusReasons_1),
                          names_sep = ".") |>
      # remove_empty(which = c("rows", "cols")) |>
      janitor::clean_names()
  }
  return(results)
}


#' Program-Wide Statistics from Quality Payment Program
#'
#' @description Data pulled from across CMS that is used to create an
#'    eligibility determination for a clinician. Using what CMS knows about a
#'    clinician from their billing patterns and enrollments, eligibility is
#'    "calculated" multiple times before and during the performance year.
#'
#' @details The Quality Payment Program (QPP) Eligibility System pulls together
#'    data from across the Centers for Medicare and Medicaid Services (CMS) to
#'    create an eligibility determination for every clinician in the system.
#'    Using what CMS knows about a clinician from their billing patterns and
#'    enrollments, eligibility is "calculated" multiple times before and during
#'    the performance year. Information can be obtained primarily by the
#'    Clinician type. You can query the Clinician type by passing in an National
#'    Provider Identifier, or NPI. This number is a unique 10-digit
#'    identification number issued to health care providers in the United
#'    States by CMS. The information contained in these endpoints includes
#'    basic enrollment information, associated organizations, information
#'    about those organizations, individual and group special status
#'    information, and in the future, any available Alternative Payment Model
#'    (APM) affiliations.
#'
#' @section Links:
#'   * [QPP Eligibility API Documentation](https://cmsgov.github.io/qpp-eligibility-docs/)
#' @section Update Frequency: **Annually**
#' @param year QPP program year
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' quality_stats(year = 2020)
#' @autoglobal
#' @export
quality_stats <- function(year) {

  url <- glue::glue("https://qpp.cms.gov/api/eligibility/stats/?year={year}")

  error_body <- function(resp) {
    httr2::resp_body_json(resp)$error$message
    }

  resp <- httr2::request(url) |>
    httr2::req_error(body = error_body) |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE)

  return(dplyr::tibble(
    year = as.integer(year),
    type = c("Individual",
             "Individual",
             "Group",
             "Group"),
    stat = c("HCC Risk Score Average",
             "Dual Eligibility Average",
             "HCC Risk Score Average",
             "Dual Eligibility Average"),
    value = c(resp$data$individual$hccRiskScoreAverage,
              resp$data$individual$dualEligibilityAverage,
              resp$data$group$hccRiskScoreAverage,
              resp$data$group$dualEligibilityAverage)))
}
