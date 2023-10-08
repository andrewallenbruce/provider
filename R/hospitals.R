#' Hospitals Enrolled in Medicare
#'
#' @description
#'
#' `hospitals()` allows you to search for information on all hospitals
#' currently enrolled in Medicare. Data returned includes the hospital's
#' sub-group types, legal business name, doing-business-as name, organization
#' type and address.
#'
#' Links:
#'   - [Hospital Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi < *integer* > 10-digit national provider identifier
#' @param facility_ccn < *character* > 6-digit CMS Certification Number of hospital
#' @param enroll_id_org < *character* > 15-digit organizational provider Medicare
#' enrollment identifier; begins with capital "O"
#' @param enroll_state < *character* > Hospital’s enrollment state
#' @param specialty_code < *character* > Enrollment specialty type code
#' @param pac_org < *integer* > 10-digit organizational/group provider
#' associate-level control identifier
#' @param organization < *character* > Hospital’s legal business name
#' @param doing_business_as < *character* > Hospital’s doing-business-as name
#' @param city < *character* > City of the hospital’s practice location
#' @param state < *character* > State of the hospital’s practice location
#' @param zip < *character* > Zip code of the hospital’s practice location
#' @param proprietary_nonprofit < *character* > `"P"` if hospital registered as
#' proprietor with the IRS; `"N"` if registered as non-profit
#' @param multiple_npis < *boolean* > Indicates hospital has more than one NPI
#' @param general < *boolean* > Indicates hospital’s subgroup/unit is General
#' @param acute_care < *boolean* > Indicates hospital’s subgroup/unit is
#' Acute Care
#' @param alcohol_drug < *boolean* > Indicates hospital’s subgroup/unit is
#' Alcohol/Drug
#' @param childrens < *boolean* > Indicates hospital’s subgroup/unit is
#' Children's Hospital
#' @param long_term < *boolean* > Indicates hospital’s subgroup/unit is
#' Long-Term
#' @param psychiatric < *boolean* > Indicates hospital’s subgroup/unit is
#' Psychiatric
#' @param rehabilitation < *boolean* > Indicates hospital’s subgroup/unit is
#' Rehabilitation
#' @param short_term < *boolean* > Indicates hospital’s subgroup/unit is
#' Short-Term
#' @param swing_bed < *boolean* > Indicates hospital’s subgroup/unit is
#' Swing-Bed Approved
#' @param psych_unit < *boolean* > Indicates hospital’s subgroup/unit is
#' Psychiatric Unit
#' @param rehab_unit < *boolean* > Indicates hospital’s subgroup/unit is
#' Rehabilitation Unit
#' @param specialty_hospital < *boolean* > Indicates hospital’s subgroup/unit
#' is Specialty Hospital
#' @param other < *boolean* > Indicates hospital’s subgroup/unit is not listed
#' on the CMS form
#' @param reh_conversion < *boolean* > Indicates a former Hospital or Critical
#' Access Hospital that converted to a Rural Emergency Hospital
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param pivot < *boolean* > // __default:__ `TRUE` Pivot output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @seealso [clinicians()], [providers()], [affiliations()]
#'
#' @examples
#' hospitals(pac_org = 6103733050)
#'
#' hospitals(state = "GA", reh_conversion = TRUE)
#' @autoglobal
#' @export
hospitals <- function(npi = NULL,
                      facility_ccn = NULL,
                      enroll_id_org = NULL,
                      enroll_state = NULL,
                      specialty_code = NULL,
                      pac_org = NULL,
                      organization = NULL,
                      doing_business_as = NULL,
                      city = NULL,
                      state = NULL,
                      zip = NULL,
                      proprietary_nonprofit = NULL,
                      multiple_npis = NULL,
                      general = NULL,
                      acute_care = NULL,
                      alcohol_drug = NULL,
                      childrens = NULL,
                      long_term = NULL,
                      psychiatric = NULL,
                      rehabilitation = NULL,
                      short_term = NULL,
                      swing_bed = NULL,
                      psych_unit = NULL,
                      rehab_unit = NULL,
                      specialty_hospital = NULL,
                      other = NULL,
                      reh_conversion = NULL,
                      tidy = TRUE,
                      pivot = TRUE,
                      na.rm = TRUE) {

  if (!is.null(npi))           {npi          <- npi_check(npi)}
  if (!is.null(pac_org))       {pac_org      <- pac_check(pac_org)}
  if (!is.null(zip))           {zip          <- as.character(zip)}
  if (!is.null(facility_ccn))  {facility_ccn <- as.character(facility_ccn)}
  if (!is.null(enroll_id_org)) {enroll_check(enroll_id_org)}
  if (!is.null(enroll_id_org)) {enroll_org_check(enroll_id_org)}
  if (!is.null(proprietary_nonprofit)) {rlang::arg_match(proprietary_nonprofit, c("P", "N"))}

  if (!is.null(multiple_npis))      {multiple_npis <- tf_2_yn(multiple_npis)}
  if (!is.null(general))            {general <- tf_2_yn(general)}
  if (!is.null(acute_care))         {acute_care <- tf_2_yn(acute_care)}
  if (!is.null(alcohol_drug))       {alcohol_drug <- tf_2_yn(alcohol_drug)}
  if (!is.null(childrens))          {childrens <- tf_2_yn(childrens)}
  if (!is.null(long_term))          {long_term <- tf_2_yn(long_term)}
  if (!is.null(psychiatric))        {psychiatric <- tf_2_yn(psychiatric)}
  if (!is.null(rehabilitation))     {rehabilitation <- tf_2_yn(rehabilitation)}
  if (!is.null(short_term))         {short_term <- tf_2_yn(short_term)}
  if (!is.null(swing_bed))          {swing_bed <- tf_2_yn(swing_bed)}
  if (!is.null(psych_unit))         {psych_unit <- tf_2_yn(psych_unit)}
  if (!is.null(rehab_unit))         {rehab_unit <- tf_2_yn(rehab_unit)}
  if (!is.null(specialty_hospital)) {specialty_hospital <- tf_2_yn(specialty_hospital)}
  if (!is.null(other))              {other <- tf_2_yn(other)}
  if (!is.null(reh_conversion))     {reh_conversion <- tf_2_yn(reh_conversion)}

  args <- dplyr::tribble(
    ~param,                             ~arg,
    "NPI",                              npi,
    "CCN",                              facility_ccn,
    "ENROLLMENT ID",                    enroll_id_org,
    "ENROLLMENT STATE",                 enroll_state,
    "PROVIDER TYPE CODE",               specialty_code,
    "ASSOCIATE ID",                     pac_org,
    "ORGANIZATION NAME",                organization,
    "DOING BUSINESS AS NAME",           doing_business_as,
    "CITY",                             city,
    "STATE",                            state,
    "ZIP CODE",                         zip,
    "PROPRIETARY_NONPROFIT",            proprietary_nonprofit,
    "MULTIPLE NPI FLAG",                multiple_npis,
    "SUBGROUP %2D GENERAL",             general,
    "SUBGROUP %2D ACUTE CARE",          acute_care,
    "SUBGROUP %2D ALCOHOL DRUG",        alcohol_drug,
    "SUBGROUP %2D CHILDRENS",           childrens,
    "SUBGROUP %2D LONG-TERM",           long_term,
    "SUBGROUP %2D PSYCHIATRIC",         psychiatric,
    "SUBGROUP %2D REHABILITATION",      rehabilitation,
    "SUBGROUP %2D SHORT-TERM",          short_term,
    "SUBGROUP %2D SWING-BED APPROVED",  swing_bed,
    "SUBGROUP %2D PSYCHIATRIC UNIT",    psych_unit,
    "SUBGROUP %2D REHABILITATION UNIT", rehab_unit,
    "SUBGROUP %2D SPECIALTY HOSPITAL",  specialty_hospital,
    "SUBGROUP %2D OTHER",               other,
    "REH CONVERSION FLAG",              reh_conversion)

  response <- httr2::request(build_url("hos", args)) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                      ~y,
      "npi",                   npi,
      "facility_ccn",          facility_ccn,
      "enroll_id_org",         enroll_id_org,
      "enroll_state",          enroll_state,
      "specialty_code",        specialty_code,
      "pac_org",               pac_org,
      "organization",          organization,
      "doing_business_as",     doing_business_as,
      "city",                  city,
      "state",                 state,
      "zip",                   zip,
      "proprietary_nonprofit", proprietary_nonprofit,
      "multiple_npis",         multiple_npis,
      "general",               general,
      "acute_care",            acute_care,
      "alcohol_drug",          alcohol_drug,
      "childrens",             childrens,
      "long_term",             long_term,
      "psychiatric",           psychiatric,
      "rehabilitation",        rehabilitation,
      "short_term",            short_term,
      "swing_bed",             swing_bed,
      "psych_unit",            psych_unit,
      "rehab_unit",            rehab_unit,
      "specialty_hospital",    specialty_hospital,
      "other",                 other,
      "reh_conversion",        reh_conversion) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))

  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(dplyr::across(dplyr::contains(c("flag", "subgroup")), yn_logical),
                    dplyr::across(dplyr::contains("date"), anytime::anydate),
                    proprietary_nonprofit = dplyr::case_match(
                      proprietary_nonprofit,
                      "P" ~ "Proprietary",
                      "N" ~ "Non-Profit",
                      .default = NA)) |>
      tidyr::unite("address",
                   address_line_1:address_line_2,
                   remove = TRUE, na.rm = TRUE) |>
      tidyr::unite("org_structure",
                   organization_type_structure:organization_other_type_text,
                   remove = TRUE, na.rm = TRUE, sep = ": ") |>
      tidyr::unite("location_type",
                   practice_location_type:location_other_type_text,
                   remove = TRUE, na.rm = TRUE, sep = ": ") |>
      hosp_cols()

    if (pivot) {
      results <- hosp_cols2(results) |>
        tidyr::pivot_longer(cols = c("Multiple NPIs", "REH Conversion",
                                     dplyr::contains("Subgroup")),
        names_to = "status",
        values_to = "flag") |>
      dplyr::filter(flag == TRUE) |>
      dplyr::mutate(flag = NULL)
    }

    if (na.rm) {results <- janitor::remove_empty(results,
                              which = c("rows", "cols"))
    }
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
hosp_cols <- function(df) {

  cols <- c('npi',
            'organization' = 'organization_name',
            'doing_business_as' = 'doing_business_as_name',
            'pac_org' = 'associate_id',
            'enroll_id_org' = 'enrollment_id',
            'facility_ccn' = 'ccn',
            'specialty_code' = 'provider_type_code',
            'specialty' = 'provider_type_text',
            'enroll_state' = 'enrollment_state',
            'incorporation_date',
            'incorporation_state',
            'org_structure',
            'address',
            'city',
            'state',
            'zip' = 'zip_code',
            'location_type',
            'associated_ccn' = 'cah_or_hospital_ccn',
            'reh_conversion_date',
            'proprietary_nonprofit',
            'multiple_npi_flag',
            'reh_conversion_flag',
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
            'subgroup_other_text')

  df |> dplyr::select(dplyr::any_of(cols))

}

#' @param df data frame
#' @autoglobal
#' @noRd
hosp_cols2 <- function(df) {

  cols <- c('npi',
            'organization',
            'doing_business_as',
            'pac_org',
            'enroll_id_org',
            'facility_ccn',
            'specialty_code',
            'specialty',
            'enroll_state',
            'incorporation_date',
            'incorporation_state',
            'org_structure',
            'address',
            'city',
            'state',
            'zip',
            'location_type',
            'associated_ccn',
            'reh_conversion_date',
            'proprietary_nonprofit',
            "Multiple NPIs" = 'multiple_npi_flag',
            "REH Conversion" = 'reh_conversion_flag',
            "Subgroup General" = 'subgroup_general',
            "Subgroup Acute Care" = 'subgroup_acute_care',
            "Subgroup Alcohol Drug" = 'subgroup_alcohol_drug',
            "Subgroup Childrens' Hospital" = 'subgroup_childrens',
            "Subgroup Long-term" = 'subgroup_long_term',
            "Subgroup Psychiatric" = 'subgroup_psychiatric',
            "Subgroup Rehabilitation" = 'subgroup_rehabilitation',
            "Subgroup Short-Term" = 'subgroup_short_term',
            "Subgroup Swing-Bed Approved" = 'subgroup_swing_bed_approved',
            "Subgroup Psychiatric Unit" = 'subgroup_psychiatric_unit',
            "Subgroup Rehabilitation Unit" = 'subgroup_rehabilitation_unit',
            "Subgroup Specialty Hospital" = 'subgroup_specialty_hospital',
            "Subgroup Other" = 'subgroup_other')

  df |> dplyr::select(dplyr::any_of(cols))

}
