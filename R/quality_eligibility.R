#' Quality Payment Program Eligibility
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [quality_eligibility()] allows the user access to information on eligibility
#' in the Merit-based Incentive Payment System (MIPS) and Advanced Alternative
#' Payment Models (APMs) tracks.
#'
#' Data pulled from across CMS is used to create an eligibility determination
#' for a clinician. Using what CMS knows about a clinician from their billing
#' patterns and enrollments, eligibility is "calculated" multiple times before
#' and during the performance year.
#'
#' @section Quality Payment Program (QPP) Eligibility:
#' The QPP Eligibility System aggregates data from across CMS to create an
#' eligibility determination for every clinician in the system. Using what CMS
#' knows about a clinician from their billing patterns and enrollments,
#' eligibility is "calculated" multiple times before and during the performance
#' year.
#'
#' The information contained in these endpoints includes basic enrollment
#' information, associated organizations, information about those organizations,
#' individual and group special status information, and in the future, any
#' available Alternative Payment Model (APM) affiliations.
#'
#' @section Types:
#' + __Clinicians__ represent healthcare providers and are referenced using a NPI.
#'
#' + __Practices__ represent a clinician or group of clinicians that assign their
#' billing rights to the same TIN. These are represented with a TIN, EIN, or
#' SSN, and querying by this number requires an authorization token.
#'
#' + __Virtual Groups__ represent a combination of two or more TINs with certain
#' characteristics, represented by a virtual group identifier, also requiring an
#' authorization token.
#'
#' + __APM Entities__ represent a group of practices which participate in an
#' APM, characterized by an APM Entity ID.
#'
#'
#' @section Links:
#' + [QPP Eligibility API Documentation](https://cmsgov.github.io/qpp-eligibility-docs/)
#' + [QPP Eligibility & MVP/CAHPS/Subgroups Registration Services (v6)](https://qpp.cms.gov/api/eligibility/docs/?urls.primaryName=Eligibility%2C%20v6)
#'
#' @section Update Frequency: **Annually**
#'
#' @param year < *integer* > // __required__ QPP performance year, in `YYYY`format.
#' Run [qpp_years()] to return a vector of the years currently available.
#' @param npi < *integer* > 10-digit Individual National Provider Identifier
#' assigned to the clinician when they enrolled in Medicare. Multiple rows for
#' the same NPI indicate multiple TIN/NPI combinations.
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `FALSE` Remove empty rows and columns
#' @param ... For future use.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' quality_eligibility(year = 2020, npi = 1144544834)
#' @autoglobal
#' @export
quality_eligibility <- function(year,
                                npi,
                                tidy = TRUE,
                                na.rm = FALSE,
                                ...) {

  rlang::check_required(year)
  year <- as.character(year)
  # rlang::arg_match(year, values = as.character(qpp_years()))
  npi <- npi %nn% validate_npi(npi)
  url <- glue::glue("https://qpp.cms.gov/api/eligibility/npi/{npi}/?year={year}")
  error_body <- function(response) httr2::resp_body_json(response)$error$message

  response <- httr2::request(url) |>
    httr2::req_headers(Accept = "application/vnd.qpp.cms.gov.v6+json") |>
    httr2::req_error(body = error_body) |>
    httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "year",         year,
      "npi",          npi) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  results <- list(
    year                  = year,
    npi                   = results$data$npi,
    npi_type              = results$data$nationalProviderIdentifierType,
    first                 = results$data$firstName,
    middle                = results$data$middleName,
    last                  = results$data$lastName,
    first_approved_date   = results$data$firstApprovedDate,
    years_in_medicare     = results$data$yearsInMedicare,
    pecos_enroll_year     = results$data$pecosEnrollmentDate,
    newly_enrolled        = results$data$newlyEnrolled,
    specialty_description = results$data$specialty$specialtyDescription,
    specialty_type        = results$data$specialty$typeDescription,
    specialty_category    = results$data$specialty$categoryReference,
    is_maqi               = results$data$isMaqi,
    organization          = results$data$organizations$prvdrOrgName,
    hosp_vbp_name         = results$data$organizations$hospitalVbpName,
    facility_based        = results$data$organizations$isFacilityBased,
    address_1             = results$data$organizations$addressLineOne,
    address_2             = results$data$organizations$addressLineTwo,
    city                  = results$data$organizations$city,
    state                 = results$data$organizations$state,
    zip                   = results$data$organizations$zip,
    apms                  = results$data$organizations$apms,
    virtual               = results$data$organizations$virtualGroups,
    ind                   = results$data$organizations$individualScenario,
    group                 = results$data$organizations$groupScenario) |>
    purrr::compact() |>
    purrr::list_flatten() |>
    purrr::list_flatten() |>
    as.data.frame()

  if (!tidy) results <- df2chr(results)

  if (tidy) {
    results <- results |>
      dplyr::tibble()
    # results <- tidyup(results,
    #                   yn = 'telehlth',
    #                   int = c('num_org_mem', 'grd_yr')) |>
    #   combine(address, c('adr_ln_1', 'adr_ln_2')) |>
    #   dplyr::mutate(gndr = fct_gen(gndr),
    #                 state = fct_stabb(state)) |>
    #   cols_clin()

    if (na.rm) results <- narm(results)
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_qelig <- function(df) {

    cols <- c('year',
              'npi',
              'npi_type',
              'first',
              'middle',
              'last',
              'first_approved_date',
              'years_in_medicare',
              'pecos_enroll_year',
              'newly_enrolled',
              'specialty_description',
              'specialty_type',
              'specialty_category',
              'is_maqi',
              'organization',
              'hosp_vbp_name',
              'facility_based',
              'address_1',
              'address_2',
              'city',
              'state',
              'zip',

              'ind.aciHardship',
              'ind.aciReweighting',
              'ind.ambulatorySurgicalCenter',
              'ind.extremeHardship',
              'ind.extremeHardshipReasons',
              'ind.extremeHardshipEventType',
              'ind.extremeHardshipSources',
              'ind.hospitalBasedClinician',
              'ind.hpsaClinician',
              'ind.iaStudy',
              'ind.isOptedIn',
              'ind.isOptInEligible',
              'ind.mipsEligibleSwitch',
              'ind.nonPatientFacing',
              'ind.optInDecisionDate',
              'ind.ruralClinician',
              'ind.smallGroupPractitioner',
              'ind.lowVolumeSwitch',
              'ind.lowVolumeStatusReasons',
              'ind.hasPaymentAdjustmentCCN',
              'ind.hasHospitalVbpCCN',
              'ind.aggregationLevel',
              'ind.hospitalVbpName',
              'ind.hospitalVbpScore',
              'ind.isFacilityBased',
              'ind.specialtyCode',
              'ind.specialty',
              'ind.isEligible',
              'ind.eligibilityScenario',

              'group.aciHardship',
              'group.aciReweighting',
              'group.ambulatorySurgicalCenter',
              'group.extremeHardship',
              'group.extremeHardshipReasons',
              'group.extremeHardshipEventType',
              'group.extremeHardshipSources',
              'group.hospitalBasedClinician',
              'group.hpsaClinician',
              'group.iaStudy',
              'group.isOptedIn',
              'group.isOptInEligible',
              'group.mipsEligibleSwitch',
              'group.nonPatientFacing',
              'group.optInDecisionDate',
              'group.ruralClinician',
              'group.smallGroupPractitioner',
              'group.lowVolumeSwitch',
              'group.lowVolumeStatusReasons',
              'group.aggregationLevel',
              'group.isEligible'
              )

  df |> dplyr::select(dplyr::any_of(cols))
}

##------------------------------------------------------------------------------
#' @autoglobal
#' @noRd
# nocov start
quality_eligibility2 <- function(year,
                                 npi,
                                 tidy = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(qpp_years()))

  npi <- npi %nn% validate_npi(npi)

  url <- glue::glue("https://qpp.cms.gov/api/eligibility/npi/{npi}/?year={year}")

  error_body <- function(resp) httr2::resp_body_json(resp)$error$message

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

  if (!tidy) results <- df2chr(results)

  if (tidy) {

    # tidyr::unnest_longer(e1, apms, keep_empty = TRUE) |>
    #   tidyr::unpack(apms, names_sep = ".") |>
    #   tidyr::unnest_longer(virtual_groups, keep_empty = TRUE) |>
    #   tidyr::unpack(virtual_groups, names_sep = ".") |>
    #   tidyr::unnest_longer(individual_scenario, keep_empty = TRUE) |>
    #   tidyr::unpack(individual_scenario, names_sep = ".") |>
    #   tidyr::unnest_longer(group_scenario, keep_empty = TRUE) |>
    #   tidyr::unpack(group_scenario, names_sep = ".")

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
#' @examplesIf interactive()
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
    cli::cli_abort(c("A non-NULL argument is required")) # nolint
  }

  if (any(!is.null(c(npi, pac_id_ind, first_name, last_name)))) {
    facility_name <- NULL
    pac_id_org    <- NULL

    id <- mips_2021_id("ind")

    if (!is.null(npi)) {npi <- validate_npi(npi)}
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
# nocov end
