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
#'   - [Quality Payment Program Experience](https://data.cms.gov/quality-of-care/quality-payment-program-experience)
#'
#' @section Update Frequency: **Annually**
#'
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
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' quality_payment(year = 2020, npi = 1144544834)
#' @rdname quality_payment
#' @autoglobal
#' @export
quality_payment <- function(year,
                            npi                = NULL,
                            state              = NULL,
                            specialty          = NULL,
                            participation_type = NULL,
                            tidy               = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(quality_payment_years()))

  args <- dplyr::tribble(
    ~param,                          ~arg,
    "npi",                            npi,
    "practice state or us territory", state,
    "clinician specialty",            specialty,
    "participation type",             participation_type)

  id <- cms_update("Quality Payment Program Experience", "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                               ~y,
      "year",                           year,
      "npi",                            npi,
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

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::tibble() |>
      dplyr::mutate(year = as.integer(year),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
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
      dplyr::select(year,
                    npi,
                    state                        = practice_state_or_us_territory,
                    size                         = practice_size,
                    clinician_specialty,
                    years_in_medicare,
                    participation_type,
                    beneficiaries                = medicare_patients,
                    services,
                    allowed_charges,
                    final_score,
                    payment_adjustment           = payment_adjustment_percentage,
                    quality_score                = quality_category_score,
                    pi_score                     = promoting_interoperability_pi_category_score,
                    ia_score,
                    cost_score,
                    complex_patient_bonus,
                    quality_improvement_bonus,
                    ind_quality_bonus            = quality_bonus,
                    ind_engaged                  = engaged,
                    ind_opted_into_mips          = opted_into_mips,
                    ind_small_practitioner       = small_practitioner,
                    ind_rural                    = rural_clinician,
                    ind_hpsa                     = hpsa_clinician,
                    ind_asc                      = ambulatory_surgical_center,
                    ind_hospital_based           = hospital_based_clinician,
                    ind_non_patient_facing       = non_patient_facing,
                    ind_facility_based           = facility_based,
                    ind_extreme_hardship         = extreme_hardship,
                    ind_extreme_hardship_quality = extreme_hardship_quality,
                    ind_extreme_hardship_pi      = extreme_hardship_pi,
                    ind_pi_hardship              = pi_hardship,
                    ind_pi_reweighting           = pi_reweighting,
                    ind_pi_bonus                 = pi_bonus,
                    ind_pi_cehrt_id              = pi_cehrt_id,
                    ind_extreme_hardship_ia      = extreme_hardship_ia,
                    ind_ia_study                 = ia_study,
                    ind_extreme_hardship_cost    = extreme_hardship_cost,
                    dplyr::contains("quality_measure_"),
                    dplyr::contains("pi_measure_"),
                    dplyr::contains("ia_measure_"),
                    dplyr::contains("cost_measure_"),
                    dplyr::everything()) |>
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
#' @rdname years
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
#'
#' @param year integer, YYYY, QPP eligibility year.
#' @param npi NPI assigned to the clinician when they enrolled in Medicare.
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' quality_eligibility(year = 2020, npi = 1144544834)
#'
#' @rdname quality_payment
#' @autoglobal
#' @export
quality_eligibility <- function(year,
                                npi = NULL,
                                tidy = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(quality_payment_years()))

  url <- glue::glue("https://qpp.cms.gov/api/eligibility/npi/{npi}/?year={year}")

  error_body <- function(resp) {httr2::resp_body_json(resp)$error$message}

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
#' @section Links:
#'   - [QPP Eligibility API Documentation](https://cmsgov.github.io/qpp-eligibility-docs/)
#'
#' @section Update Frequency: **Annually**
#'
#' @param year QPP program year
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' quality_stats(year = 2020)
#'
#' @rdname quality_payment
#' @autoglobal
#' @export
quality_stats <- function(year) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(quality_payment_years()))

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

#' 2021 Quality Payment Performance
#'
#' @description
#' Performance information for Merit-Based Incentive Payment System (MIPS)
#' submitted by groups.
#'
#' @param facility_name Organization name
#' @param pac_id_org Unique organization ID assigned by PECOS
#' @param npi Unique clinician ID assigned by NPPES
#' @param pac_id_ind Unique individual clinician ID assigned by PECOS
#' @param first_name Individual clinician first name
#' @param last_name Individual clinician last name
#' @param offset offset; API pagination
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' mips_2021(pac_id_org = 4789842956)
#' mips_2021(npi = 1316172182)
#' @autoglobal
#' @export
mips_2021 <- function(facility_name = NULL,
                      pac_id_org = NULL,
                      npi = NULL,
                      pac_id_ind = NULL,
                      first_name = NULL,
                      last_name = NULL,
                      offset = 0L,
                      tidy = TRUE) {

  if (all(is.null(c(npi, pac_id_ind, first_name, last_name,
                    facility_name, pac_id_org)))) {
    cli::cli_abort(c("A non-NULL argument is required"))
  }

  if (any(!is.null(c(npi, pac_id_ind, first_name, last_name)))) {
    facility_name <- NULL
    pac_id_org <- NULL

    id <- mips_2021_id("ind")

    if (!is.null(npi)) {npi <- npi_check(npi)}
    if (!is.null(pac_id_ind)) {pac_id_ind <- pac_check(pac_id_ind)}

  }

  if (any(!is.null(c(facility_name, pac_id_org)))) {
    npi <- NULL
    pac_id_ind <- NULL
    first_name <- NULL
    last_name <- NULL

    id <- mips_2021_id("group")

    if (!is.null(pac_id_org)) {pac_id_org <- pac_check(pac_id_org)}
  }

  args <- dplyr::tribble(
    ~param,            ~arg,
    "facility_name",   facility_name,
    "org_pac_id",      pac_id_org,
    "npi",             npi,
    "ind_pac_id",      pac_id_ind,
    "lst_name",        last_name,
    "frst_name",       first_name)

  url <- paste0("https://data.cms.gov/provider-data/api/1/datastore/sql?query=",
                "[SELECT * FROM ", id, "]",
                encode_param(args, type = "sql"),
                "[LIMIT 10000 OFFSET ", offset, "]")

  response <- httr2::request(encode_url(url)) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "facility_name", facility_name,
      "pac_id_org",    pac_id_org,
      "npi",           npi,
      "pac_id_ind",    pac_id_ind,
      "last_name",     last_name,
      "first_name",    first_name) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}",
                          wrap = TRUE)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::tibble() |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")))

    if (any(!is.null(c(facility_name, pac_id_org)))) {
      results <- dplyr::select(results,
                               org_pac_id,
                               facility_name,
                               aco_id_1,
                               aco_nm_1,
                               aco_id_2,
                               aco_nm_2,
                               measure_code = measure_cd,
                               measure_title,
                               measure_inverse = invs_msr,
                               attestation_value,
                               performance_rate = prf_rate,
                               patient_count,
                               star_value,
                               five_star_benchmark,
                               collection_type,
                               measure_care_compare = ccxp_ind,
                               dplyr::everything())
    }

    if (any(!is.null(c(npi, pac_id_ind, first_name, last_name)))) {
      results <- dplyr::select(results,
                               npi,
                               pac_id_ind = ind_pac_id,
                               first_name = frst_nm,
                               last_name = lst_nm,
                               apm_affl_1,
                               apm_affl_2,
                               apm_affl_3,
                               measure_code = measure_cd,
                               measure_title,
                               measure_inverse = invs_msr,
                               attestation_value,
                               performance_rate = prf_rate,
                               patient_count,
                               star_value,
                               five_star_benchmark,
                               collection_type,
                               measure_care_compare = ccxp_ind,
                               dplyr::everything())
    }
  }
  return(results)
}


#' @autoglobal
#' @noRd
mips_2021_id <- function(type = c("ind", "group")) {

  if (type == "ind")   {uuid <- "7d6a-e7a6"}
  if (type == "group") {uuid <- "0ba7-2cb0"}

  url <- glue::glue("https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/{uuid}?show-reference-ids=true")

  response <- httr2::request(url) |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE)

  return(response$distribution$identifier)
}
