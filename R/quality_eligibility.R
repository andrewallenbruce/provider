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

    results <- dplyr::tibble(
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

    results <- results |>
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

    results <- results |>
      unnest_if_name('org_apms') |>
      unnest_if_name('org_apms.extremeHardshipReasons') |>
      unnest_if_name('org_apms.extremeHardshipSources', wide = TRUE) |>
      unnest_if_name('org_apms.qpPatientScores') |>
      unnest_if_name('org_apms.qpPaymentScores') |>

      unnest_if_name('ind.extremeHardshipReasons') |>
      unnest_if_name('ind.extremeHardshipSources', wide = TRUE) |>
      unnest_if_name('ind.lowVolumeStatusReasons', wide = TRUE) |>
      unnest_if_name('ind.specialty') |>
      unnest_if_name('ind.isEligible') |>

      unnest_if_name('grp.extremeHardshipReasons') |>
      unnest_if_name('grp.extremeHardshipSources', wide = TRUE) |>
      unnest_if_name('grp.lowVolumeStatusReasons', wide = TRUE) |>
      unnest_if_name('grp.isEligible') |>
      cols_qelig()

    if (na.rm) results <- narm(results)
  }
  return(results)
}

#' @param df data frame
#' @param name quoted column name
#' @param unpack `TRUE` for nested list columns __(default)__,
#'    `FALSE` for nested 'data frame' columns
#' @param wide unnest wide instead of long, default `FALSE`
#' @autoglobal
#' @noRd
unnest_if_name <- function(df, name, unpack = TRUE, wide = FALSE) {

  if (rlang::has_name(df, name)) {

    if (wide) return(tidyr::unnest_wider(df, name, names_sep = "."))

    df <- tidyr::unnest_longer(df, name, keep_empty = TRUE)

  if (unpack) df <- tidyr::unpack(df, name, names_sep = ".")
  }
  return(df)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_qelig <- function(df) {

    cols <- c('year'                  = 'year',
              'npi'                   = 'npi',
              'npi_type'              = 'npi_type',
              'first'                 = 'first',
              'middle'                = 'middle',
              'last'                  = 'last',
              'first_approved_date'   = 'first_approved_date',
              'years_in_medicare'     = 'years_in_medicare',
              'pecos_enroll_year'     = 'pecos_enroll_year',
              'newly_enrolled'        = 'newly_enrolled',
              'specialty_description' = 'specialty_description',
              'specialty_type'        = 'specialty_type',
              'specialty_category'    = 'specialty_category',
              'is_maqi'               = 'is_maqi',
              'org_name'              = 'org_prvdrOrgName',
              'org_hosp_vbp_name'     = 'org_hospitalVbpName',
              'org_facility_based'    = 'org_isFacilityBased',
              'org_address'           = 'org_address',
              'org_city'              = 'org_city',
              'org_state'             = 'org_state',
              'org_zip'               = 'org_zip',
              'org_tin'               = 'org_TIN',

              'org_apms.advanced_apm_flag'                = 'org_apms.advancedApmFlag',
              'org_apms.apm_id'                           = 'org_apms.apmId',
              'org_apms.name'                             = 'org_apms.apmName',
              'org_apms.entity_name'                      = 'org_apms.entityName',
              'org_apms.is_opted_in'                      = 'org_apms.isOptedIn',
              'org_apms.lvt_flag'                         = 'org_apms.lvtFlag',
              'org_apms.lvt_patients'                     = 'org_apms.lvtPatients',
              'org_apms.lvt_payments'                     = 'org_apms.lvtPayments',
              'org_apms.qp_patient_scores'                = 'org_apms.qpPatientScores.me',
              'org_apms.qp_payment_scores'                = 'org_apms.qpPaymentScores.me',
              'org_apms.lvt_small_status'                 = 'org_apms.lvtSmallStatus',
              'org_apms.lvt_performance_year'             = 'org_apms.lvtPerformanceYear',
              'org_apms.mips_apm_flag'                    = 'org_apms.mipsApmFlag',
              'org_apms.extreme_hardship'                 = 'org_apms.extremeHardship',
              'org_apms.extreme_hardship_reasons.pi'      = 'org_apms.extremeHardshipReasons.aci',
              'org_apms.extreme_hardship_reasons.cost'    = 'org_apms.extremeHardshipReasons.cost',
              'org_apms.extreme_hardship_reasons.ia'      = 'org_apms.extremeHardshipReasons.improvementActivities',
              'org_apms.extreme_hardship_reasons.quality' = 'org_apms.extremeHardshipReasons.quality',
              'org_apms.extreme_hardship_event_type'      = 'org_apms.extremeHardshipEventType',
              'org_apms.extreme_hardship_sources_1'       = 'org_apms.extremeHardshipSources.1',
              'org_apms.subdivision_id'                   = 'org_apms.subdivisionId',
              'org_apms.subdivision_name'                 = 'org_apms.subdivisionName',
              'org_apms.final_qpc_score'                  = 'org_apms.finalQpcScore',
              'org_apms.provider_relationship_code'       = 'org_apms.providerRelationshipCode',

              'org_virtual_groups'= 'org_virtualGroups',

              'ind.pi_hardship'                           = 'ind.aciHardship',
              'ind.pi_reweighting'                        = 'ind.aciReweighting',
              'ind.ambulatory_surgical_center'            = 'ind.ambulatorySurgicalCenter',
              'ind.extreme_hardship'                      = 'ind.extremeHardship',
              'ind.extreme_hardship_reasons.quality'      = 'ind.extremeHardshipReasons.quality',
              'ind.extreme_hardship_reasons.ia'           = 'ind.extremeHardshipReasons.improvementActivities',
              'ind.extreme_hardship_reasons.pi'           = 'ind.extremeHardshipReasons.aci',
              'ind.extreme_hardship_reasons.cost'         = 'ind.extremeHardshipReasons.cost',
              'ind.extreme_hardship_event.type'           = 'ind.extremeHardshipEventType',
              'ind.extreme_hardship_sources'              = 'ind.extremeHardshipSources.1',
              'ind.hospital_based_clinician'              = 'ind.hospitalBasedClinician',
              'ind.hpsa_clinician'                        = 'ind.hpsaClinician',
              'ind.ia_study'                              = 'ind.iaStudy',
              'ind.is_opted_in'                           = 'ind.isOptedIn',
              'ind.is_opt_in_eligible'                    = 'ind.isOptInEligible',
              'ind.mips_eligible_switch'                  = 'ind.mipsEligibleSwitch',
              'ind.non_patient_facing'                    = 'ind.nonPatientFacing',
              'ind.opt_in_decision_date'                  = 'ind.optInDecisionDate',
              'ind.rural_clinician'                       = 'ind.ruralClinician',
              'ind.small_group_practitioner'              = 'ind.smallGroupPractitioner',
              'ind.low_volume_switch'                     = 'ind.lowVolumeSwitch',
              'ind.low_volume_status_reasons.code'        = 'ind.lowVolumeStatusReasons.lowVolStusRsnCd',
              'ind.low_volume_status_reasons.description' = 'ind.lowVolumeStatusReasons.lowVolStusRsnDesc',
              'ind.has_payment_adjustment_ccn'            = 'ind.hasPaymentAdjustmentCCN',
              'ind.has_hospital_vbp_ccn'                  = 'ind.hasHospitalVbpCCN',
              # 'ind.aggregation_level'                   = 'ind.aggregationLevel',
              'ind.hospital_vbp_name'                     = 'ind.hospitalVbpName',
              'ind.hospital_vbp_score'                    = 'ind.hospitalVbpScore',
              'ind.facility_based'                        = 'ind.isFacilityBased',
              'ind.specialty.code'                        = 'ind.specialtyCode',
              'ind.specialty.description'                 = 'ind.specialty.specialtyDescription',
              'ind.specialty.type'                        = 'ind.specialty.typeDescription',
              'ind.specialty.category'                    = 'ind.specialty.categoryReference',
              'ind.eligible.individual'                   = 'ind.isEligible.individual',
              'ind.eligible.group'                        = 'ind.isEligible.group',
              'ind.eligible.mips_apm'                     = 'ind.isEligible.mipsApm',
              # 'ind.eligibility_scenario.'               = 'ind.eligibilityScenario',
              'ind.eligible.virtual_group'                = 'ind.isEligible.virtualGroup',

              'grp.pi_hardship'                     = 'grp.aciHardship',
              'grp.pi_reweighting'                  = 'grp.aciReweighting',
              'grp.ambulatory_surgical_center'      = 'grp.ambulatorySurgicalCenter',
              'grp.extreme_hardship'                = 'grp.extremeHardship',
              'grp.extreme_hardship_reasons.quality'= 'grp.extremeHardshipReasons.quality',
              'grp.extreme_hardship_reasons.ia'     = 'grp.extremeHardshipReasons.improvementActivities',
              'grp.extreme_hardship_reasons.pi'     = 'grp.extremeHardshipReasons.aci',
              'grp.extreme_hardship_reasons.cost'   = 'grp.extremeHardshipReasons.cost',
              'grp.extreme_hardship_event_type'     = 'grp.extremeHardshipEventType',
              'grp.extreme_hardship_sources'        = 'grp.extremeHardship',
              'grp.extreme_hardship_sources_1'      = 'grp.extremeHardshipSources.1',
              'grp.hospital_based_clinician'        = 'grp.hospitalBasedClinician',
              'grp.hpsa_clinician'                  = 'grp.hpsaClinician',
              'grp.ia_study'                        = 'grp.iaStudy',
              'grp.is_opted_in'                     = 'grp.isOptedIn',
              'grp.is_opt_in_eligible'              = 'grp.isOptInEligible',
              'grp.mips_eligible_switch'            = 'grp.mipsEligibleSwitch',
              'grp.non_patient_facing'              = 'grp.nonPatientFacing',
              'grp.opt_in_decision_date'            = 'grp.optInDecisionDate',
              'grp.rural_clinician'                 = 'grp.ruralClinician',
              'grp.small_group_practitioner'        = 'grp.smallGroupPractitioner',
              'grp.low_volume_switch'               = 'grp.lowVolumeSwitch',
              'grp.low_volume_status_reasons'       = 'grp.lowVolumeStatusReasons',
              # 'grp.aggregation_level'             = 'grp.aggregationLevel',
              'grp.eligible'                        = 'grp.isEligible.group'
              )

  df |> dplyr::select(dplyr::any_of(cols))
}
