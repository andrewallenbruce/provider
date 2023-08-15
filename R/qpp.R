#' Search the CMS Quality Payment Program Experience API
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
#'   ## Links
#'   * [Quality Payment Program Experience](https://data.cms.gov/quality-of-care/quality-payment-program-experience)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Annually**
#' @param year integer, YYYY, QPP Performance year. Run the helper function
#'    `provider:::quality_payment_years()` to return a vector of currently
#'    available years.
#' @param npi The NPI assigned to the clinician when they enrolled in Medicare.
#'    Multiple rows for the same NPI indicate multiple TIN/NPI combinations.
#' @param state The State or United States (US) territory code location of the
#'    TIN associated with the clinician.
#' @param specialty The specialty description is an identifier corresponding to
#'    the type of service that the clinician submitted most on their Medicare
#'    Part B claims for this TIN/NPI combination.
#' @param part_type Indicates the level at which performance data was
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
                            npi       = NULL,
                            state     = NULL,
                            specialty = NULL,
                            part_type = NULL,
                            tidy      = TRUE) {

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
    "participation type",             part_type)

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
      "participation type",             part_type) |>
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
    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., " ")),
                    dplyr::across(dplyr::any_of(c("practice_size",
                                                  "years_in_medicare",
                                                  "medicare_patients",
                                                  "services")), as.integer),
                    dplyr::across(dplyr::any_of(c("allowed_charges",
                                                  "final_score",
                                                  "payment_adjustment_percentage",
                                                  "complex_patient_bonus",
                                                  "quality_category_score",
                                                  "quality_improvement_bonus",
                                                  "ia_score",
                                                  "cost_score",
                                                  dplyr::contains("quality_measure_score"),
                                                  dplyr::contains("pi_measure_score"),
                                                  dplyr::contains("ia_measure_score"),
                                                  dplyr::contains("cost_measure_score"))), as.double),
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
                    provider_key,
                    state = practice_state_or_us_territory,
                    practice_size,
                    specialty = clinician_specialty,
                    years_in_medicare,
                    participation_type,
                    beneficiaries = medicare_patients,
                    allowed_charges,
                    services,
                    final_score,
                    payment_adjustment = payment_adjustment_percentage,
                    complex_patient_bonus,
                    quality_category_score,
                    quality_improvement_bonus,
                    quality_bonus,
                    engaged,
                    opted_into_mips,
                    small_practitioner,
                    rural = rural_clinician,
                    hpsa = hpsa_clinician,
                    asc = ambulatory_surgical_center,
                    hospital_based = hospital_based_clinician,
                    non_patient_facing,
                    facility_based,
                    extreme_hardship,
                    extreme_hardship_quality,
                    dplyr::contains("quality_measure_"),
                    pi_category_score = "promoting_interoperability_(pi)_category_score",
                    extreme_hardship_pi,
                    pi_hardship,
                    pi_reweighting,
                    pi_bonus,
                    pi_cehrt_id,
                    dplyr::contains("pi_measure_"),
                    ia_score,
                    extreme_hardship_ia,
                    ia_study,
                    dplyr::contains("ia_measure_"),
                    cost_score,
                    extreme_hardship_cost,
                    dplyr::contains("cost_measure_"),
                    dplyr::everything())
  }
  return(results)
}

#' Check the current years available for the Quality Payments API
#' @return integer vector of years available
#' @examples
#' quality_payment_years()
#' @autoglobal
#' @export
quality_payment_years <- function() {
  as.integer(cms_update("Quality Payment Program Experience", "years"))
}

#' Search the CMS Quality Payment Program Eligibility API
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
#'   ## Links
#'   * [QPP Eligibility API Documentation](https://cmsgov.github.io/qpp-eligibility-docs/)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Annually**
#' @param year integer, YYYY, QPP Performance year.
#' @param npi The NPI assigned to the clinician when they enrolled in Medicare.
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


#' Retrieve Program-Wide Statistics from CMS' Quality Payment Program Eligibility API
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
#'   ## Links
#'   * [QPP Eligibility API Documentation](https://cmsgov.github.io/qpp-eligibility-docs/)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Annually**
#' @param year year
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' quality_stats(year = 2020)
#' @autoglobal
#' @export
quality_stats <- function(year) {

  url <- glue::glue("https://qpp.cms.gov/api/eligibility/stats/?year={year}")

  error_body <- function(resp) {httr2::resp_body_json(resp)$error$message}

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
