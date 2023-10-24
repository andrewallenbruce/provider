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
#' @autoglobal
#' @noRd
quality_eligibility <- function(year, npi = NULL, tidy = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(qpp_years()))

  npi <- npi %nn% validate_npi(npi)

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
#' @rdname quality_payment
#' @autoglobal
#' @noRd
quality_stats <- function(year) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(qpp_years()))

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
#' @noRd
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
    pac_id_org    <- NULL

    id <- mips_2021_id("ind")

    if (!is.null(npi)) {npi <- check_npi(npi)}
    if (!is.null(pac_id_ind)) {pac_id_ind <- check_pac(pac_id_ind)}

  }

  if (any(!is.null(c(facility_name, pac_id_org)))) {
    npi        <- NULL
    pac_id_ind <- NULL
    first_name <- NULL
    last_name  <- NULL

    id <- mips_2021_id("group")

    if (!is.null(pac_id_org)) {pac_id_org <- check_pac(pac_id_org)}
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

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "facility_name", facility_name,
      "pac_id_org",    pac_id_org,
      "npi",           npi,
      "pac_id_ind",    pac_id_ind,
      "last_name",     last_name,
      "first_name",    first_name) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results)

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
