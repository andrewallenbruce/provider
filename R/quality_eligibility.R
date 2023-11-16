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
  rlang::arg_match(year, values = as.character(2017:2024))
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

  if (!tidy) results <- df2chr(results)

  if (tidy) {

    res <- purrr::compact(results) |> purrr::list_flatten()

    r <- dplyr::tibble(
      year                  = as.integer(year),
      npi                   = res$data_npi,
      npi_type              = fct_entype(res$data_nationalProviderIdentifierType),
      first                 = res$data_firstName,
      middle                = res$data_middleName,
      last                  = res$data_lastName,
      first_approved_date   = lubridate::ymd(res$data_firstApprovedDate),
      years_in_medicare     = as.integer(res$data_yearsInMedicare),
      pecos_year            = as.integer(res$data_pecosEnrollmentDate),
      newly_enrolled        = as.logical(res$data_newlyEnrolled),
      specialty_description = res$data_specialty$specialtyDescription,
      specialty_type        = res$data_specialty$typeDescription,
      specialty_category    = res$data_specialty$categoryReference,
      is_maqi               = as.logical(res$data_isMaqi),
      org                   = dplyr::tibble(res$data_organizations))

    r <- r |>
      tidyr::unpack(org, names_sep = "_") |>
      tidyr::unite("org_address",
                   dplyr::any_of(c('org_addressLineOne',
                                   'org_addressLineTwo')),
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      tidyr::unnest_longer(dplyr::any_of(c('org_apms',
                                           'org_virtualGroups')),
                           keep_empty = TRUE) |>
      dplyr::rename(ind = org_individualScenario,
                    grp = org_groupScenario) |>
      tidyr::unpack(ind, names_sep = ".") |>
      tidyr::unpack(grp, names_sep = ".")

    results <- r |>
      tidyr::unnest_longer(ind.extremeHardshipReasons, keep_empty = TRUE) |>
      tidyr::unpack(ind.extremeHardshipReasons, names_sep = ".") |>
      tidyr::unnest_longer(ind.extremeHardshipSources, keep_empty = TRUE) |>
      tidyr::unpack(ind.extremeHardshipSources, names_sep = ".") |>
      tidyr::unnest_longer(ind.lowVolumeStatusReasons, keep_empty = TRUE) |>
      tidyr::unpack(ind.lowVolumeStatusReasons, names_sep = ".") |>
      tidyr::unnest_longer(ind.specialty, keep_empty = TRUE) |>
      tidyr::unpack(ind.specialty, names_sep = ".") |>
      tidyr::unnest_longer(ind.isEligible, keep_empty = TRUE) |>
      tidyr::unpack(ind.isEligible, names_sep = ".") |>
      tidyr::unnest_longer(grp.extremeHardshipReasons, keep_empty = TRUE) |>
      tidyr::unpack(grp.extremeHardshipReasons, names_sep = ".") |>
      tidyr::unnest_longer(grp.extremeHardshipSources, keep_empty = TRUE) |>
      tidyr::unpack(grp.extremeHardshipSources, names_sep = ".") |>
      tidyr::unnest_longer(grp.lowVolumeStatusReasons, keep_empty = TRUE) |>
      tidyr::unpack(grp.lowVolumeStatusReasons, names_sep = ".") |>
      tidyr::unnest_longer(grp.isEligible, keep_empty = TRUE) |>
      tidyr::unpack(grp.isEligible, names_sep = ".")

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