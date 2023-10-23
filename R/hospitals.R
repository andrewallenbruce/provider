#' Hospitals Enrolled in Medicare
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [hospitals()] allows the user to search for information on all hospitals
#' currently enrolled in Medicare. Data returned includes the hospital's
#' sub-group types, legal business name, doing-business-as name, organization
#' type and address.
#'
#' *Update Frequency:* **Monthly**
#'
#' @section Links:
#' + [Hospital Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' @param npi < *integer* > 10-digit Organizational National Provider Identifier
#' @param pac_org < *integer* > 10-digit Organizational PECOS Associate Control ID
#' @param enid_org < *character* > 15-digit Organizational Medicare Enrollment ID
#' @param enid_state < *character* > Hospital’s enrollment state
#' @param facility_ccn < *integer* > 6-digit CMS Certification Number
#' @param specialty_code < *character* > Medicare Part A Provider specialty code:
#' + `"00-00"`: Religious Non-Medical Healthcare Institution (RNHCI)
#' + `"00-01"`: Community Mental Health Center
#' + `"00-02"`: Comprehensive Outpatient Rehabilitation Facility (CORF)
#' + `"00-03"`: End-Stage Renal Disease Facility (ESRD)
#' + `"00-04"`: Federally Qualified Health Center (FQHC)
#' + `"00-05"`: Histocompatibility Laboratory
#' + `"00-06"`: Home Health Agency (HHA)
#' + `"00-08"`: Hospice
#' + `"00-09"`: Hospital
#' + `"00-10"`: Indian Health Services Facility
#' + `"00-13"`: Organ Procurement Organization (OPO)
#' + `"00-14"`: Outpatient PT/Occupational Therapy/Speech Pathology
#' + `"00-17"`: Rural Health Clinic (RHC)
#' + `"00-18"`: Skilled Nursing Facility (SNF)
#' + `"00-19"`: Other
#' + `"00-24"`: Rural Emergency Hospital (REH)
#' + `"00-85"`: Critical Access Hospital (CAH)
#' @param organization < *character* > Hospital’s legal business name
#' @param dba < *character* > Hospital’s doing-business-as name
#' @param city < *character* > City of the hospital’s practice location
#' @param state < *character* > State of the hospital’s practice location
#' @param zip < *integer* > Zip code of the hospital’s practice location
#' @param registration < *character* > Hospital's IRS designation:
#' + `"P"`: Registered as __Proprietor__
#' + `"N"`: Registered as __Non-Profit__
#' @param multi_npi < *boolean* > Indicates hospital has more than one NPI
#' @param subgroup < *list* > `subgroup = list(acute = TRUE, swing = FALSE)`
#' Indicates hospital’s subgroup/unit designation:
#' + `acute`: Acute Care
#' + `alc_drug`: Alcohol/Drug
#' + `child`: Children's Hospital
#' + `gen`: General
#' + `long`: Long-Term
#' + `short`: Short-Term
#' + `psych`: Psychiatric
#' + `rehab`: Rehabilitation
#' + `swing`: Swing-Bed Approved
#' + `psych_unit`: Psychiatric Unit
#' + `rehab_unit`: Rehabilitation Unit
#' + `spec`: Specialty Hospital
#' + `other`: Not listed on CMS form
#' @param reh < *boolean* > Indicates a former Hospital or Critical Access
#' Hospital (CAH) that converted to a Rural Emergency Hospital (REH)
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param pivot < *boolean* > // __default:__ `TRUE` Pivot output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**           |**Description**                                                |
#' |:-------------------|:--------------------------------------------------------------|
#' |`npi`               |Hospital's 10-digit National Provider Identifier               |
#' |`pac_org`           |Hospital’s 10-digit PECOS Associate Control ID                 |
#' |`enid_org`          |Hospital’s 15-digit Enrollment ID                              |
#' |`enid_state`        |Hospital’s Enrollment State                                    |
#' |`facility_ccn`      |Hospital’s CMS Certification Number                            |
#' |`organization`      |Hospital’s Legal Business Name                                 |
#' |`doing_business_as` |Hospital’s Doing-Business-As Name                              |
#' |`specialty_code`    |Hospital’s Medicare Part A Provider Specialty Code             |
#' |`specialty`         |Specialty Code Description                                     |
#' |`incorp_date`       |Date the Business was Incorporated                             |
#' |`incorp_state`      |State in which the Business was Incorporated                   |
#' |`structure`         |Hospital’s Organization Structure Type                         |
#' |`address`           |Hospital’s Practice Location Address                           |
#' |`city`              |Hospital’s Practice Location City                              |
#' |`state`             |Hospital’s Practice Location State                             |
#' |`zip`               |Hospital’s Practice Location Zip Code                          |
#' |`location_type`     |Practice Location Type                                         |
#' |`multi_npi`         |Indicates Hospital has more than one NPI                       |
#' |`reh_date`          |Date the Hospital/CAH converted to an REH                      |
#' |`reh_ccns`          |CCNs associated with the Hospital/CAH that converted to an REH |
#' |`registration`      |Hospital’s IRS Registration Status                             |
#' |`subgroup`          |Hospital's Subgroup/Unit Designations, REH Conversion Status   |
#' |`other`             |If `subgroup` is `"Other"`, description of Subgroup/Unit       |
#'
#' @seealso [clinicians()], [providers()], [affiliations()]
#' @family api
#'
#' @examplesIf interactive()
#' hospitals(pac_org = 6103733050)
#'
#' hospitals(state = "GA", reh = TRUE)
#'
#' hospitals(city = "Savannah", state = "GA") |>
#'           dplyr::select(organization, subgroup)
#'
#' hospitals(city = "Savannah", state = "GA",
#'           subgroup = list(acute = FALSE)) |>
#'           dplyr::select(organization, subgroup)
#'
#' hospitals(city = "Savannah", state = "GA",
#'           subgroup = list(gen = TRUE, rehab = FALSE)) |>
#'           dplyr::select(organization, subgroup)
#'
#' @autoglobal
#' @export
hospitals <- function(npi = NULL,
                      facility_ccn = NULL,
                      enid_org = NULL,
                      enid_state = NULL,
                      pac_org = NULL,
                      specialty_code = NULL,
                      organization = NULL,
                      dba = NULL,
                      city = NULL,
                      state = NULL,
                      zip = NULL,
                      registration = NULL,
                      multi_npi = NULL,
                      reh = NULL,
                      subgroup = list(),
                      tidy = TRUE,
                      pivot = TRUE,
                      na.rm = TRUE) {

  npi          <- npi %nn% check_npi(npi)
  pac_org      <- pac_org %nn% check_pac(pac_org)
  enid_org     <- enid_org %nn% check_enid(enid_org, type = "org")
  zip          <- zip %nn% as.character(zip)
  facility_ccn <- facility_ccn %nn% as.character(facility_ccn)
  registration <- registration %nn% rlang::arg_match(registration, c("P", "N"))
  multi_npi    <- multi_npi %nn% tf_2_yn(multi_npi)
  reh          <- reh %nn% tf_2_yn(reh)

  sg <- purrr::compact(subgroup) |> purrr::map(tf_2_yn)

  args <- dplyr::tribble(
    ~param,                             ~arg,
    "NPI",                              npi,
    "CCN",                              facility_ccn,
    "ENROLLMENT ID",                    enid_org,
    "ENROLLMENT STATE",                 enid_state,
    "PROVIDER TYPE CODE",               specialty_code,
    "ASSOCIATE ID",                     pac_org,
    "ORGANIZATION NAME",                organization,
    "DOING BUSINESS AS NAME",           dba,
    "CITY",                             city,
    "STATE",                            state,
    "ZIP CODE",                         zip,
    "PROPRIETARY_NONPROFIT",            registration,
    "MULTIPLE NPI FLAG",                multi_npi,
    "REH CONVERSION FLAG",              reh,
    "SUBGROUP %2D GENERAL",             sg$gen,
    "SUBGROUP %2D ACUTE CARE",          sg$acute,
    "SUBGROUP %2D ALCOHOL DRUG",        sg$alc_drug,
    "SUBGROUP %2D CHILDRENS",           sg$child,
    "SUBGROUP %2D LONG-TERM",           sg$long,
    "SUBGROUP %2D PSYCHIATRIC",         sg$psych,
    "SUBGROUP %2D REHABILITATION",      sg$rehab,
    "SUBGROUP %2D SHORT-TERM",          sg$short,
    "SUBGROUP %2D SWING-BED APPROVED",  sg$swing,
    "SUBGROUP %2D PSYCHIATRIC UNIT",    sg$psych_unit,
    "SUBGROUP %2D REHABILITATION UNIT", sg$rehab_unit,
    "SUBGROUP %2D SPECIALTY HOSPITAL",  sg$spec,
    "SUBGROUP %2D OTHER",               sg$other)

  response <- httr2::request(build_url("hos", args)) |>
    httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,               ~y,
      "npi",            npi,
      "facility_ccn",   facility_ccn,
      "enid_org",       enid_org,
      "enid_state",     enid_state,
      "specialty_code", specialty_code,
      "pac_org",        pac_org,
      "organization",   organization,
      "dba",            dba,
      "city",           city,
      "state",          state,
      "zip",            zip,
      "registration",   registration,
      "multi_npi",      multi_npi,
      "reh",            reh,
      "gen",            sg$gen,
      "acute",          sg$acute,
      "alc_drug",       sg$alc_drug,
      "child",          sg$child,
      "long",           sg$long,
      "psych",          sg$psych,
      "rehab",          sg$rehab,
      "short",          sg$short,
      "swing",          sg$swing,
      "psych_unit",     sg$psych_unit,
      "rehab_unit",     sg$rehab_unit,
      "spec",           sg$spec,
      "other",          sg$other) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results,
                      yn = c("flag", "subgroup"),
                      chr = "zip_code") |>
      combine(address, c('address_line_1',
                         'address_line_2')) |>
      combine(structure, c('organization_type_structure',
                           'organization_other_type_text'), sep = ": ") |>
      combine(location_type, c('practice_location_type',
                               'location_other_type_text'), sep = ": ") |>
      dplyr::mutate(proprietary_nonprofit = dplyr::case_match(proprietary_nonprofit,
                      "P" ~ "Proprietary",
                      "N" ~ "Non-Profit",
                      .default = NA)) |>
      hosp_cols()

    if (pivot) {
      results <- results |>
        dplyr::rowwise() |>
        dplyr::mutate(subtotal = sum(dplyr::c_across(subgroup_general:subgroup_other), na.rm = TRUE),
                      subgroup_none = dplyr::if_else(subtotal == 0, TRUE, FALSE),
                      subtotal = NULL) |>
        hosp_cols2() |>
        tidyr::pivot_longer(cols = dplyr::contains("Subgroup"),
                            names_to = "subgroup",
                            values_to = "flag") |>
        dplyr::mutate(subgroup = stringr::str_remove(subgroup, "Subgroup ")) |>
        dplyr::filter(flag == TRUE) |>
        dplyr::mutate(flag = NULL)

    }
    if (na.rm) results <- narm(results)
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
hosp_cols <- function(df) {

  cols <- c('npi',
            'pac_org'           = 'associate_id',
            'enid_org'          = 'enrollment_id',
            'enid_state'        = 'enrollment_state',
            'facility_ccn'      = 'ccn',
            'organization'      = 'organization_name',
            'doing_business_as' = 'doing_business_as_name',
            'specialty_code'    = 'provider_type_code',
            'specialty'         = 'provider_type_text',
            'incorp_date'       = 'incorporation_date',
            'incorp_state'      = 'incorporation_state',
            'structure',
            'address',
            'city',
            'state',
            'zip'               = 'zip_code',
            'location_type',
            'registration'      = 'proprietary_nonprofit',
            'multi_npi'         = 'multiple_npi_flag',
            'reh_conversion'    = 'reh_conversion_flag',
            'reh_date'          = 'reh_conversion_date',
            'reh_ccns'          = 'cah_or_hospital_ccn',
            'subgroup_general',
            'subgroup_acute_care',
            'subgroup_alcohol_drug',
            'subgroup_childrens',
            'subgroup_long_term',
            'subgroup_psychiatric',
            'subgroup_rehabilitation',
            'subgroup_short_term',
            'subgroup_swing_bed_approved',
            'subgroup_psychiatric_unit',
            'subgroup_rehabilitation_unit',
            'subgroup_specialty_hospital',
            'subgroup_other',
            'other'             = 'subgroup_other_text')

  df |> dplyr::select(dplyr::any_of(cols))

}

#' @param df data frame
#' @autoglobal
#' @noRd
hosp_cols2 <- function(df) {

  cols <- c('npi',
            'pac_org',
            'enid_org',
            'enid_state',
            'facility_ccn',
            'organization',
            'doing_business_as',
            'specialty_code',
            'specialty',
            'incorp_date',
            'incorp_state',
            'structure',
            'address',
            'city',
            'state',
            'zip',
            'location_type',
            'multi_npi',
            'reh_date',
            'reh_ccns',
            'reh_conversion',
            "Subgroup General"             = 'subgroup_general',
            "Subgroup Acute Care"          = 'subgroup_acute_care',
            "Subgroup Alcohol Drug"        = 'subgroup_alcohol_drug',
            "Subgroup Childrens' Hospital" = 'subgroup_childrens',
            "Subgroup Long-term"           = 'subgroup_long_term',
            "Subgroup Psychiatric"         = 'subgroup_psychiatric',
            "Subgroup Rehabilitation"      = 'subgroup_rehabilitation',
            "Subgroup Short-Term"          = 'subgroup_short_term',
            "Subgroup Swing-Bed Approved"  = 'subgroup_swing_bed_approved',
            "Subgroup Psychiatric Unit"    = 'subgroup_psychiatric_unit',
            "Subgroup Rehabilitation Unit" = 'subgroup_rehabilitation_unit',
            "Subgroup Specialty Hospital"  = 'subgroup_specialty_hospital',
            "Subgroup Other"               = 'subgroup_other',
            "Subgroup None"                = 'subgroup_none',
            'other')

  df |> dplyr::select(dplyr::any_of(cols))
}
