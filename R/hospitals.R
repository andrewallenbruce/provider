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
#' + [Hospital Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' *Update Frequency:* **Monthly**
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
#' @param gen,acute,alc_drug,child,long,short,psych,rehab,swing,psych_unit,rehab_unit,spec,other < *boolean* >
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
#' @examples
#' hospitals(pac_org = 6103733050)
#'
#' hospitals(state = "GA", reh = TRUE)
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
                      gen = NULL,
                      acute = NULL,
                      alc_drug = NULL,
                      child = NULL,
                      long = NULL,
                      short = NULL,
                      psych = NULL,
                      rehab = NULL,
                      swing = NULL,
                      psych_unit = NULL,
                      rehab_unit = NULL,
                      spec = NULL,
                      other = NULL,
                      reh = NULL,
                      tidy = TRUE,
                      pivot = TRUE,
                      na.rm = TRUE) {

  if (!is.null(npi))           {npi          <- npi_check(npi)}
  if (!is.null(pac_org))       {pac_org      <- pac_check(pac_org)}
  if (!is.null(zip))           {zip          <- as.character(zip)}
  if (!is.null(facility_ccn))  {facility_ccn <- as.character(facility_ccn)}
  if (!is.null(enid_org)) {
    enroll_check(enid_org)
    enroll_org_check(enid_org)
  }

  if (!is.null(registration)) {rlang::arg_match(registration, c("P", "N"))}

  if (!is.null(multi_npi))  {multi_npi <- tf_2_yn(multi_npi)}
  if (!is.null(gen))        {gen <- tf_2_yn(gen)}
  if (!is.null(acute))      {acute <- tf_2_yn(acute)}
  if (!is.null(alc_drug))   {alc_drug <- tf_2_yn(alc_drug)}
  if (!is.null(child))      {child <- tf_2_yn(child)}
  if (!is.null(long))       {long <- tf_2_yn(long)}
  if (!is.null(psych))      {psych <- tf_2_yn(psych)}
  if (!is.null(rehab))      {rehab <- tf_2_yn(rehab)}
  if (!is.null(short))      {short <- tf_2_yn(short)}
  if (!is.null(swing))      {swing <- tf_2_yn(swing)}
  if (!is.null(psych_unit)) {psych_unit <- tf_2_yn(psych_unit)}
  if (!is.null(rehab_unit)) {rehab_unit <- tf_2_yn(rehab_unit)}
  if (!is.null(spec))       {spec <- tf_2_yn(spec)}
  if (!is.null(other))      {other <- tf_2_yn(other)}
  if (!is.null(reh))        {reh <- tf_2_yn(reh)}

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
    "SUBGROUP %2D GENERAL",             gen,
    "SUBGROUP %2D ACUTE CARE",          acute,
    "SUBGROUP %2D ALCOHOL DRUG",        alc_drug,
    "SUBGROUP %2D CHILDRENS",           child,
    "SUBGROUP %2D LONG-TERM",           long,
    "SUBGROUP %2D PSYCHIATRIC",         psych,
    "SUBGROUP %2D REHABILITATION",      rehab,
    "SUBGROUP %2D SHORT-TERM",          short,
    "SUBGROUP %2D SWING-BED APPROVED",  swing,
    "SUBGROUP %2D PSYCHIATRIC UNIT",    psych_unit,
    "SUBGROUP %2D REHABILITATION UNIT", rehab_unit,
    "SUBGROUP %2D SPECIALTY HOSPITAL",  spec,
    "SUBGROUP %2D OTHER",               other,
    "REH CONVERSION FLAG",              reh)

  response <- httr2::request(build_url("hos", args)) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

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
      "gen",            gen,
      "acute",          acute,
      "alc_drug",       alc_drug,
      "child",          child,
      "long",           long,
      "psych",          psych,
      "rehab",          rehab,
      "short",          short,
      "swing",          swing,
      "psych_unit",     psych_unit,
      "rehab_unit",     rehab_unit,
      "spec",           spec,
      "other",          other,
      "reh",            reh) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results, yn = c("flag", "subgroup")) |>
      address(c("address_line_1", "address_line_2")) |>
      dplyr::mutate(proprietary_nonprofit = dplyr::case_match(proprietary_nonprofit,
                      "P" ~ "Proprietary", "N" ~ "Non-Profit", .default = NA),
                    zip_code = as.character(zip_code)) |>
      tidyr::unite("structure",
                   organization_type_structure:organization_other_type_text,
                   remove = TRUE, na.rm = TRUE, sep = ": ") |>
      tidyr::unite("location_type",
                   practice_location_type:location_other_type_text,
                   remove = TRUE, na.rm = TRUE, sep = ": ") |>
      hosp_cols()

    if (pivot) {
      results <- hosp_cols2(results) |>
        tidyr::pivot_longer(cols = c('REH Conversion',
                                     dplyr::contains("Subgroup")),
                            names_to = "subgroup",
                            values_to = "flag") |>
        dplyr::mutate(subgroup = stringr::str_remove(subgroup, "Subgroup "))

    }
    if (na.rm) {results <- narm(results)}
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
            'REH Conversion'               = 'reh_conversion',
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
            'other')

  df |> dplyr::select(dplyr::any_of(cols))
}
