#' Quality Payment Program Eligibility
#'
#' @description
#' Access to information on eligibility in the Merit-based Incentive Payment
#' System (MIPS) and Advanced Alternative Payment Models (APMs) tracks.
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
#' @section __stats__ == `TRUE`:
#' Public statistics derived from all QPP providers:
#'
#' ## HCC Risk Score Average:
#' National average individual (NPI) or group (TIN) risk score for MIPS
#' eligible individual/group. Scores are calculated as follows:
#'
#' + __Individual__ = `sum(Clinician Risk Scores) / n(Eligible Clinicians)`
#' + __Group__ = `sum(Practice Risk Scores) / n(Eligible Practices)`
#'
#' ## Dual Eligibility Average:
#' National average individual (NPI) or group (TIN) dual-eligibility score for
#' MIPS eligible individual/group.
#'
#' + __Individual__ = `sum(Clinician Dual-Eligibility Scores) / n(Eligible Clinicians)`
#' + __Group__ = sum(Practice Dual-Eligibility Scores) / n(Eligible Practices)
#'
#' @section Links:
#' + [QPP Eligibility API Documentation](https://cmsgov.github.io/qpp-eligibility-docs/)
#' + [QPP Eligibility & MVP/CAHPS/Subgroups Registration Services (v6)](https://qpp.cms.gov/api/eligibility/docs/?urls.primaryName=Eligibility%2C%20v6)
#' + [QPP Eligibility & MVP/CAHPS/Subgroups Registration Services (v6) (Multiple NPIs)](https://qpp.cms.gov/api/eligibility/docs/?urls.primaryName=Eligibility%2C%20v6#/Unauthenticated/get_api_eligibility_npis__npi_)
#'
#' @section Update Frequency: __Annually__
#'
#' @name quality_eligibility
#'
#' @param year < *integer* > // __required__ QPP performance year, in `YYYY`format.
#' Run [qpp_years()] to return a vector of the years currently available.
#' @param npi < *integer* > 10-digit Individual National Provider Identifier
#' assigned to the clinician when they enrolled in Medicare. Multiple rows for
#' the same NPI indicate multiple TIN/NPI combinations.
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param unnest < *boolean* > // __default:__ `TRUE` Tidy output
#' @param pivot < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `FALSE` Remove empty rows and columns
#' @param stats < *boolean* > // __default:__ `FALSE` Return QPP stats
#' @param ... Empty
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @rdname quality_eligibility
#'
#' @examplesIf interactive()
#' # Single NPI/year
#' quality_eligibility(year = 2020, npi = 1144544834)
#'
#' # Multiple NPIs
#' aff_npis <- affiliations(facility_ccn = 331302) |>
#'             dplyr::pull(npi)
#'
#' quality_eligibility(year = 2021,
#'                     npi = c(aff_npis[1:5],
#'                             1234567893,
#'                             1043477615,
#'                             1144544834))
#'
#' # Multiple NPIs/years
#' 2017:2023 |>
#' purrr::map(\(x)
#'        quality_eligibility(year = x,
#'                            npi = c(aff_npis[1:5],
#'                                    1234567893,
#'                                    1043477615,
#'                                    1144544834))) |>
#'        purrr::list_rbind()
#'
#' # Same as
#' quality_eligibility_(npi = c(aff_npis[1:5],
#'                              1234567893,
#'                              1043477615,
#'                              1144544834))
#'
#' # Quality Stats
#' 2017:2023 |>
#' purrr::map(\(x) quality_eligibility(year = x, stats = TRUE)) |>
#' purrr::list_rbind()
#'
#' # Same as
#' quality_eligibility_(stats = TRUE)
#'
#' @autoglobal
#' @export
quality_eligibility <- function(year,
                                npi,
                                tidy   = TRUE,
                                unnest = TRUE,
                                pivot  = TRUE,
                                na.rm  = FALSE,
                                stats  = FALSE,
                                ...) {

  rlang::check_required(year)
  year <- as.character(year)
  year <- rlang::arg_match(year,
          as.character(2017:lubridate::year(lubridate::now())))

  if (stats) {

    url <- glue::glue("https://qpp.cms.gov/api/eligibility/stats/?year={year}")

    response <- httr2::request(url) |>
      httr2::req_headers(Accept = "application/vnd.qpp.cms.gov.v6+json") |>
      httr2::req_perform() |>
      httr2::resp_body_json(simplifyVector = TRUE)

    ind <- response$data$individual
    grp <- response$data$group

    results <- dplyr::tibble(
      year    = as.integer(year),
      type    = factor(rep(c("Individual", "Group"), each = 2)),
      measure = factor(rep(c("HCC Risk Score", "Dual Eligibility"), 2)),
      average = as.double(c(ind$hccRiskScoreAverage %||% 0,
                            ind$dualEligibilityAverage %||% 0,
                            grp$hccRiskScoreAverage %||% 0,
                            grp$dualEligibilityAverage %||% 0)))

    return(results)
  }

  rlang::check_required(npi)
  if (length(npi) == 1L) npi <- npi %nn% validate_npi(npi)

  if (length(npi) > 1L) {
    npi <- purrr::map_vec(npi, validate_npi)
    npi <- paste0(unique(npi), collapse = ",")
  }

  url <- glue::glue("https://qpp.cms.gov/api/eligibility/npis/{npi}/?year={year}")

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

  results <- dplyr::tibble(year = year, results$data)

  if (tidy) {

    results <- results |>
      tidyr::unnest(organizations, keep_empty = TRUE, names_sep = "_") |>
      tidyr::unite("organizations_address",
                   dplyr::any_of(c('organizations_addressLineOne',
                                   'organizations_addressLineTwo')),
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      dplyr::rename(ind = organizations_individualScenario,
                    grp = organizations_groupScenario,
                    apms = organizations_apms,
                    vrgrp = organizations_virtualGroups) |>
      unnest_if_name('vrgrp', wide = TRUE) |>
      unnest_if_name('apms', wide = TRUE) |>
      tidyr::unpack(ind, names_sep = ".") |>
      tidyr::unpack(grp, names_sep = ".")

    if (unnest) {

      results <- results |>
        unnest_if_name('specialty') |>
        unnest_if_name('apms.extremeHardshipReasons') |>
        unnest_if_name('apms.extremeHardshipSources', wide = TRUE) |>
        unnest_if_name('apms.qpPatientScores') |>
        unnest_if_name('apms.qpPaymentScores') |>

        unnest_if_name('ind.extremeHardshipReasons') |>
        unnest_if_name('ind.extremeHardshipSources', wide = TRUE) |>
        unnest_if_name('ind.lowVolumeStatusReasons', wide = TRUE) |>
        unnest_if_name('ind.specialty') |>
        unnest_if_name('ind.isEligible') |>

        unnest_if_name('grp.extremeHardshipReasons') |>
        unnest_if_name('grp.extremeHardshipSources', wide = TRUE) |>
        unnest_if_name('grp.lowVolumeStatusReasons', wide = TRUE) |>
        unnest_if_name('grp.isEligible') |>
        unnest_if_name('error') |>
        cols_qelig('tidyup')

      results <- tidyup(results,
             dtype = 'ymd',
             int = c('year',
                     'ind_hosp_vbp_score'
                     # 'apms_lvt_patients',
                     # 'apms_lvt_year'
                     ),
             # dbl = 'apms_lvt_payments',
             zip = 'org_zip',
             lgl = c('newly_enrolled',
                     'is_maqi',
                     'org_facility_based',
                     'ams_mips_eligible',
                     'apms_advanced',
                     'apms_lvt',
                     'apms_lvt_small',
                     'apms_mips_apm',
                     'apms_ext_hardship',
                     'apms_ext_hardship_pi',
                     'apms_ext_hardship_cost',
                     'apms_ext_hardship_ia',
                     'apms_ext_hardship_quality',
                     'ind_hardship_pi',
                     'ind_reweight_pi',
                     'ind_asc',
                     'ind_ext_hardship',
                     'ind_ext_hardship_pi',
                     'ind_ext_hardship_cost',
                     'ind_ext_hardship_ia',
                     'ind_ext_hardship_quality',
                     'ind_hospital_based',
                     'ind_hpsa',
                     'ind_ia_study',
                     'ind_opted_in',
                     'ind_opt_in_eligible',
                     'ind_mips_switch',
                     'ind_non_patient',
                     'ind_rural',
                     'ind_small',
                     'ind_lvt_switch',
                     'ind_has_payment_adjustment_ccn',
                     'ind_has_hospital_vbp_ccn',
                     'ind_facility',
                     'ind_eligible_ind',
                     'ind_eligible_group',
                     'ind_eligible_apm',
                     'ind_eligible_virtual',
                     'grp_hardship_pi',
                     'grp_reweight_pi',
                     'grp_asc',
                     'grp_ext_hardship',
                     'grp_ext_hardship_pi',
                     'grp_ext_hardship_cost',
                     'grp_ext_hardship_ia',
                     'grp_ext_hardship_quality',
                     'grp_hospital_based',
                     'grp_hpsa',
                     'grp_ia_study',
                     'grp_opted_in',
                     'grp_opt_in_eligible',
                     'grp_mips_switch',
                     'grp_non_patient',
                     'grp_rural',
                     'grp_small',
                     'grp_lvt_switch',
                     'grp_eligible')) |>
        dplyr::mutate(npi_type  = fct_entype(npi_type),
                      org_state = fct_stabb(org_state)) |>
        make_interval(start = first_approved_date,
                      end = lubridate::ymd(paste0(year, '-12-31'))) |>
        dplyr::mutate(years_in_medicare = round(timelength_days / 365),
                      .after = first_approved_date) |>
        dplyr::mutate(interval = NULL,
                      period = NULL,
                      timelength_days = NULL) |>
        dplyr::group_by(year) |>
        dplyr::mutate(org_id = dplyr::row_number(), .before = org_name) |>
        dplyr::ungroup()

      if (pivot) {
        by <- dplyr::join_by(year, npi, org_name)

        apm_test <- dplyr::select(results,
                    dplyr::any_of(dplyr::starts_with("apms_")))

        if (vctrs::vec_is_empty(as.vector(apm_test))) {

          results <- cols_qelig(results, 'top') |>
            dplyr::left_join(cols_qelig(results, 'ind'), by) |>
            dplyr::left_join(cols_qelig(results, 'grp'), by)

          } else {

            results <- cols_qelig(results, 'top') |>
              dplyr::left_join(cols_qelig(results, 'apms'), by) |>
              dplyr::left_join(cols_qelig(results, 'ind'), by) |>
              dplyr::left_join(cols_qelig(results, 'grp'), by)
          }
        }
      }
    if (na.rm) results <- narm(results)
  }
  return(results)
}

#' Parallelized [quality_eligibility()]
#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run [qpp_years()] to return a vector of the years currently available.
#' @param ... Pass arguments to [quality_eligibility()].
#' @rdname quality_eligibility
#' @autoglobal
#' @export
quality_eligibility_ <- function(year = 2017:2023, ...) {
  furrr::future_map_dfr(year, quality_eligibility, ...,
                        .options = furrr::furrr_options(seed = NULL))
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
#' @param type description
#' @autoglobal
#' @noRd
cols_qelig <- function(df, type = c('tidyup', 'top', 'apms', 'ind', 'grp')) {

  if (type == 'tidyup') {

    cols <- c('year'                = 'year',
              'npi'                 = 'npi',
              'npi_type'            = 'nationalProviderIdentifierType',
              'first'               = 'firstName',
              'middle'              = 'middleName',
              'last'                = 'lastName',
              'first_approved_date' = 'firstApprovedDate',
              # 'years_in_medicare'   = 'yearsInMedicare',
              # 'pecos_year'          = 'pecosEnrollmentDate',
              'newly_enrolled'      = 'newlyEnrolled',
              'specialty_desc'      = 'specialty.specialtyDescription',
              'specialty_type'      = 'specialty.typeDescription',
              'specialty_cat'       = 'specialty.categoryReference',
              'is_maqi'             = 'isMaqi',
              'org_name'            = 'organizations_prvdrOrgName',
              'org_hosp_vbp_name'   = 'organizations_hospitalVbpName',
              'org_facility_based'  = 'organizations_isFacilityBased',
              'org_address'         = 'organizations_address',
              'org_city'            = 'organizations_city',
              'org_state'           = 'organizations_state',
              'org_zip'             = 'organizations_zip',
              # 'org_tin'           = 'organizations_TIN',
              'qp_status'           = 'qpStatus',
              'ams_mips_eligible'   = 'amsMipsEligibleClinician',
              'qp_score_type'       = 'qpScoreType',
              'error_message'       = 'error.message',
              'error_type'          = 'error.type',

              'apms_advanced'             = 'apms.advancedApmFlag',
              'apms_id'                   = 'apms.apmId',
              'apms_name'                 = 'apms.apmName',
              'apms_entity_name'          = 'apms.entityName',
              'apms_opted_in'             = 'apms.isOptedIn',
              'apms_lvt'                  = 'apms.lvtFlag',
              'apms_lvt_patients'         = 'apms.lvtPatients',
              'apms_lvt_payments'         = 'apms.lvtPayments',
              'apms_lvt_small'            = 'apms.lvtSmallStatus',
              # 'apms_lvt_year'             = 'apms.lvtPerformanceYear',
              'apms_mips_apm'             = 'apms.mipsApmFlag',
              'apms_ext_hardship'         = 'apms.extremeHardship',
              'apms_ext_hardship_pi'      = 'apms.extremeHardshipReasons.aci',
              'apms_ext_hardship_cost'    = 'apms.extremeHardshipReasons.cost',
              'apms_ext_hardship_ia'      = 'apms.extremeHardshipReasons.improvementActivities',
              'apms_ext_hardship_quality' = 'apms.extremeHardshipReasons.quality',
              'apms_ext_hardship_type'    = 'apms.extremeHardshipEventType',
              'apms_ext_hardship_sources' = 'apms.extremeHardshipSources.1',
              'apms_sub_id'               = 'apms.subdivisionId',
              'apms_sub_name'             = 'apms.subdivisionName',
              'apms_final_qpc_score'      = 'apms.finalQpcScore',
              'apms_relationship'         = 'apms.providerRelationshipCode',
              'apms_qp_patient_scores_me' = 'apms.qpPatientScores.me',
              'apms_qp_payment_scores_me' = 'apms.qpPaymentScores.me',

              'virtual_groups'            = 'virtualGroups',

              'ind_hardship_pi'                = 'ind.aciHardship',
              'ind_reweight_pi'                = 'ind.aciReweighting',
              'ind_asc'                        = 'ind.ambulatorySurgicalCenter',
              'ind_ext_hardship'               = 'ind.extremeHardship',
              'ind_ext_hardship_quality'       = 'ind.extremeHardshipReasons.quality',
              'ind_ext_hardship_ia'            = 'ind.extremeHardshipReasons.improvementActivities',
              'ind_ext_hardship_pi'            = 'ind.extremeHardshipReasons.aci',
              'ind_ext_hardship_cost'          = 'ind.extremeHardshipReasons.cost',
              'ind_ext_hardship_type'          = 'ind.extremeHardshipEventType',
              'ind_ext_hardship_sources'       = 'ind.extremeHardshipSources.1',
              'ind_hospital_based'             = 'ind.hospitalBasedClinician',
              'ind_hpsa'                       = 'ind.hpsaClinician',
              'ind_ia_study'                   = 'ind.iaStudy',
              'ind_opted_in'                   = 'ind.isOptedIn',
              'ind_opt_in_eligible'            = 'ind.isOptInEligible',
              'ind_mips_switch'                = 'ind.mipsEligibleSwitch',
              'ind_non_patient'                = 'ind.nonPatientFacing',
              'ind_opt_in_date'                = 'ind.optInDecisionDate',
              'ind_rural'                      = 'ind.ruralClinician',
              'ind_small'                      = 'ind.smallGroupPractitioner',
              'ind_lvt_switch'                 = 'ind.lowVolumeSwitch',
              'ind_lvt_status_code'            = 'ind.lowVolumeStatusReasons.lowVolStusRsnCd',
              'ind_lvt_status_desc'            = 'ind.lowVolumeStatusReasons.lowVolStusRsnDesc',
              'ind_has_payment_adjustment_ccn' = 'ind.hasPaymentAdjustmentCCN',
              'ind_has_hospital_vbp_ccn'       = 'ind.hasHospitalVbpCCN',
              'ind_hosp_vbp_name'              = 'ind.hospitalVbpName',
              'ind_hosp_vbp_score'             = 'ind.hospitalVbpScore',
              'ind_facility'                   = 'ind.isFacilityBased',
              'ind_specialty_code'             = 'ind.specialtyCode',
              'ind_specialty_desc'             = 'ind.specialty.specialtyDescription',
              'ind_specialty_type'             = 'ind.specialty.typeDescription',
              'ind_specialty_cat'              = 'ind.specialty.categoryReference',
              'ind_eligible_ind'               = 'ind.isEligible.individual',
              'ind_eligible_group'             = 'ind.isEligible.group',
              'ind_eligible_apm'               = 'ind.isEligible.mipsApm',
              'ind_eligible_virtual'           = 'ind.isEligible.virtualGroup',
              # 'ind_agg_level'                = 'ind.aggregationLevel',
              # 'ind_scenario'                 = 'ind.eligibilityScenario',

              'grp_hardship_pi'          = 'grp.aciHardship',
              'grp_reweight_pi'          = 'grp.aciReweighting',
              'grp_asc'                  = 'grp.ambulatorySurgicalCenter',
              'grp_ext_hardship'         = 'grp.extremeHardship',
              'grp_ext_hardship_quality' = 'grp.extremeHardshipReasons.quality',
              'grp_ext_hardship_ia'      = 'grp.extremeHardshipReasons.improvementActivities',
              'grp_ext_hardship_pi'      = 'grp.extremeHardshipReasons.aci',
              'grp_ext_hardship_cost'    = 'grp.extremeHardshipReasons.cost',
              'grp_ext_hardship_type'    = 'grp.extremeHardshipEventType',
              'grp_ext_hardship_sources' = 'grp.extremeHardshipSources.1',
              'grp_hospital_based'       = 'grp.hospitalBasedClinician',
              'grp_hpsa'                 = 'grp.hpsaClinician',
              'grp_ia_study'             = 'grp.iaStudy',
              'grp_opted_in'             = 'grp.isOptedIn',
              'grp_opt_in_eligible'      = 'grp.isOptInEligible',
              'grp_mips_switch'          = 'grp.mipsEligibleSwitch',
              'grp_non_patient'          = 'grp.nonPatientFacing',
              'grp_opt_in_date'          = 'grp.optInDecisionDate',
              'grp_rural'                = 'grp.ruralClinician',
              'grp_small'                = 'grp.smallGroupPractitioner',
              'grp_lvt_switch'           = 'grp.lowVolumeSwitch',
              'grp_lvt_status'           = 'grp.lowVolumeStatusReasons',
              'grp_eligible'             = 'grp.isEligible.group'
              # 'grp_agg_level'          = 'grp.aggregationLevel',
              )
    results <- df |> dplyr::select(dplyr::any_of(cols))
  }

  if (type == 'top') {

    top_cols <- c('year',
                  'npi',
                  'npi_type',
                  'first',
                  'middle',
                  'last',
                  'first_approved_date',
                  'years_in_medicare',
                  'newly_enrolled',
                  'specialty_desc',
                  'specialty_type',
                  'specialty_cat',
                  'is_maqi',
                  'org_id',
                  'org_name',
                  'org_hosp_vbp_name',
                  'org_facility_based',
                  'org_address',
                  'org_city',
                  'org_state',
                  'org_zip',
                  'qp_status',
                  'ams_mips_eligible',
                  'qp_score_type',
                  'error_message',
                  'error_type')

    results <- df |> dplyr::select(dplyr::any_of(top_cols))

  }

  if (type == 'apms') {

    apm_flags <- c(
      'Advanced APM'                               = 'apms_advanced',
      'Below Low Volume Threshold'                 = 'apms_lvt',
      'Small Practice Status'                      = 'apms_lvt_small',
      'MIPS APM'                                   = 'apms_mips_apm',
      'Extreme Hardship'                           = 'apms_ext_hardship',
      'Extreme Hardship (Performance Improvement)' = 'apms_ext_hardship_pi',
      'Extreme Hardship (Cost)'                    = 'apms_ext_hardship_cost',
      'Extreme Hardship (Improvement Activities)'  = 'apms_ext_hardship_ia',
      'Extreme Hardship (Quality)'                 = 'apms_ext_hardship_quality'
    )

    results <- df |>
      dplyr::select(year,
                    npi,
                    org_name,
                    dplyr::contains('apms_')) |>
      dplyr::rename(dplyr::any_of(apm_flags)) |>
      tidyr::pivot_longer(cols = dplyr::any_of(names(apm_flags))) |>
      dplyr::filter(!is.na(value)) |>
      dplyr::filter(value == TRUE) |>
      dplyr::mutate(value = NULL) |>
      tidyr::nest(apms_status = name) |>
      janitor::remove_empty(which = c("rows", "cols"))

  }

  if (type == 'ind') {

    ind_flags <- c(
      'Hardship (Performance Improvement)'         = 'ind_hardship_pi',
      'Reweighting (Performance Improvement)'      = 'ind_reweight_pi',
      'Ambulatory Surgical Center'                 = 'ind_asc',
      'Extreme Hardship'                           = 'ind_ext_hardship',
      'Extreme Hardship (Quality)'                 = 'ind_ext_hardship_quality',
      'Extreme Hardship (Improvement Activities)'  = 'ind_ext_hardship_ia',
      'Extreme Hardship (Performance Improvement)' = 'ind_ext_hardship_pi',
      'Extreme Hardship (Cost)'                    = 'ind_ext_hardship_cost',
      'Hospital-based Clinician'                   = 'ind_hospital_based',
      'HPSA Clinician'                             = 'ind_hpsa',
      'Improvement Activities Study'               = 'ind_ia_study',
      'Has Opted In'                               = 'ind_opted_in',
      'Is Opt-In Eligible'                         = 'ind_opt_in_eligible',
      'MIPS Eligible Clinician'                    = 'ind_mips_switch',
      'Non-Patient Facing'                         = 'ind_non_patient',
      'Rural Clinician'                            = 'ind_rural',
      'Small Group Practitioner'                   = 'ind_small',
      'Below Low Volume Threshold'                 = 'ind_lvt_switch',
      'Has Payment Adjustment CCN'                 = 'ind_has_payment_adjustment_ccn',
      'Has Hospital Value-Based CCN'               = 'ind_has_hospital_vbp_ccn',
      'Facility-based Clinician'                   = 'ind_facility',
      'Eligible: Individual'                       = 'ind_eligible_ind',
      'Eligible: Group'                            = 'ind_eligible_group',
      'Eligible: APM'                              = 'ind_eligible_apm',
      'Eligible: Virtual Group'                    = 'ind_eligible_virtual'
    )

    results <- df |>
             dplyr::select(year,
                           npi,
                           org_name,
                           dplyr::contains('ind_')) |>
             dplyr::rename(dplyr::any_of(ind_flags)) |>
             tidyr::pivot_longer(cols = dplyr::any_of(names(ind_flags))) |>
             dplyr::filter(!is.na(value)) |>
             dplyr::filter(value == TRUE) |>
             dplyr::mutate(value = NULL) |>
             dplyr::rename(ind_status = name) |>
             tidyr::nest(ind_status = ind_status) |>
             janitor::remove_empty(which = c("rows", "cols"))

  }

  if (type == 'grp') {

    grp_flags <- c(
      'Hardship (Performance Improvement)'         = 'grp_hardship_pi',
      'Reweighting (Performance Improvement)'      = 'grp_reweight_pi',
      'Ambulatory Surgical Center'                 = 'grp_asc',
      'Extreme Hardship'                           = 'grp_ext_hardship',
      'Extreme Hardship (Quality)'                 = 'grp_ext_hardship_quality',
      'Extreme Hardship (Improvement Activities)'  = 'grp_ext_hardship_ia',
      'Extreme Hardship (Performance Improvement)' = 'grp_ext_hardship_pi',
      'Extreme Hardship (Cost)'                    = 'grp_ext_hardship_cost',
      'Hospital-based Clinician'                   = 'grp_hospital_based',
      'HPSA Clinician'                             = 'grp_hpsa',
      'Improvement Activities Study'               = 'grp_ia_study',
      'Has Opted In'                               = 'grp_opted_in',
      'Is Opt-In Eligible'                         = 'grp_opt_in_eligible',
      'MIPS Eligible Clinician'                    = 'grp_mips_switch',
      'Non-Patient Facing'                         = 'grp_non_patient',
      'Rural Clinician'                            = 'grp_rural',
      'Small Group Practitioner'                   = 'grp_small',
      'Below Low Volume Threshold'                 = 'grp_lvt_switch',
      'Eligible: Group'                            = 'grp_eligible'
    )

    results <- df |>
             dplyr::select(year,
                           npi,
                           org_name,
                           dplyr::contains('grp_')) |>
             dplyr::rename(dplyr::any_of(grp_flags)) |>
             tidyr::pivot_longer(cols = dplyr::any_of(names(grp_flags))) |>
             dplyr::filter(!is.na(value)) |>
             dplyr::filter(value == TRUE) |>
             dplyr::mutate(value = NULL) |>
             dplyr::rename(grp_status = name) |>
             tidyr::nest(grp_status = grp_status) |>
             janitor::remove_empty(which = c("rows", "cols"))

  }
  return(results)
}


#' Convert enumeration types to labelled factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_enum <- function(x) {
  factor(x,
         levels = c("NPI-1", "NPI-2"),
         labels = c("Individual", "Organization"))
}
