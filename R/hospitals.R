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
#' @param pac_id_org < *integer* > 10-digit organizational/group provider
#' associate-level control identifier
#' @param organization < *character* > Hospital’s legal business name
#' @param doing_business_as < *character* > Hospital’s doing-business-as name
#' @param city < *character* > City of the hospital’s practice location
#' @param state < *character* > State of the hospital’s practice location
#' @param zip < *character* > Zip code of the hospital’s practice location
#' @param tidy < *boolean* > Tidy output; default is `TRUE`.
#' @param na.rm < *boolean* > Remove empty rows and columns; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @seealso [clinicians()], [providers()], [affiliations()]
#'
#' @examples
#' hospitals(pac_id_org = 6103733050)
#' @autoglobal
#' @export
hospitals <- function(npi               = NULL,
                      facility_ccn      = NULL,
                      enroll_id_org     = NULL,
                      enroll_state      = NULL,
                      specialty_code    = NULL,
                      pac_id_org        = NULL,
                      organization      = NULL,
                      doing_business_as = NULL,
                      city              = NULL,
                      state             = NULL,
                      zip               = NULL,
                      tidy              = TRUE,
                      na.rm = TRUE) {

  if (!is.null(npi))           {npi          <- npi_check(npi)}
  if (!is.null(pac_id_org))    {pac_id_org   <- pac_check(pac_id_org)}
  if (!is.null(zip))           {zip          <- as.character(zip)}
  if (!is.null(facility_ccn))  {facility_ccn <- as.character(facility_ccn)}
  if (!is.null(enroll_id_org)) {enroll_check(enroll_id_org)}
  if (!is.null(enroll_id_org)) {enroll_org_check(enroll_id_org)}

  args <- dplyr::tribble(
    ~param,                  ~arg,
    "NPI",                    npi,
    "CCN",                    facility_ccn,
    "ENROLLMENT ID",          enroll_id_org,
    "ENROLLMENT STATE",       enroll_state,
    "PROVIDER TYPE CODE",     specialty_code,
    "ASSOCIATE ID",           pac_id_org,
    "ORGANIZATION NAME",      organization,
    "DOING BUSINESS AS NAME", doing_business_as,
    "CITY",                   city,
    "STATE",                  state,
    "ZIP CODE",               zip)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                cms_update("Hospital Enrollments", "id")$distro[1],
                "/data.json?",
                encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                  ~y,
      "npi",               npi,
      "facility_ccn",      facility_ccn,
      "enroll_id_org",     enroll_id_org,
      "enroll_state",      enroll_state,
      "specialty_code",    specialty_code,
      "pac_id_org",        pac_id_org,
      "organization",      organization,
      "doing_business_as", doing_business_as,
      "city",              city,
      "state",             state,
      "zip",               zip) |>
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
      dplyr::mutate(dplyr::across(dplyr::contains(c("flag", "subgroup", "proprietary")), yn_logical),
                    dplyr::across(dplyr::contains("date"), ~anytime::anydate(.)),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      tidyr::unite("address",
                   address_line_1:address_line_2,
                   remove = TRUE, na.rm = TRUE) |>
      dplyr::select(npi,
                    organization = organization_name,
                    doing_business_as      = doing_business_as_name,
                    pac_id_org             = associate_id,
                    enroll_id_org          = enrollment_id,
                    facility_ccn           = ccn,
                    specialty_code         = provider_type_code,
                    specialty              = provider_type_text,
                    enroll_state           = enrollment_state,
                    incorporation_date,
                    incorporation_state,
                    organization_structure = organization_type_structure,
                    org_other              = organization_other_type_text,
                    address,
                    city,
                    state,
                    zip                    = zip_code,
                    location_type          = practice_location_type,
                    location_other         = location_other_type_text,
                    multiple_npis          = multiple_npi_flag,
                    cah_or_hospital_ccn,
                    reh_conversion_flag,
                    reh_conversion_date,
                    proprietary_nonprofit,
                    dplyr::contains("subgroup_"),
                    dplyr::everything()) |>
      tidyr::nest(subgroups = dplyr::contains("subgroup_"))

    if (na.rm) {
      results <- janitor::remove_empty(results, which = c("rows", "cols"))
    }

    }
  return(results)
}


#' Search the Ambulatory Surgical Centers and Independent Free Standing
#' Emergency Departments Enrolled in Medicare As Hospital Providers
#'
#' @description Information on Medicare Enrolled Ambulatory Surgical Center
#'    (ASC) Providers and Independent Free Standing Emergency Departments
#'    (IFEDs) during the COVID-19 public health emergency.
#'
#' @details The Ambulatory Surgical Centers (ASCs) and Independent Free
#'    Standing Emergency Departments (IFEDs) Enrolled in Medicare As Hospital
#'    Providers dataset includes all Medicare enrolled Ambulatory Surgical
#'    Centers (ASC) that converted to Hospitals during the COVID-19 public
#'    health emergency. Additionally, this list includes Independent Free
#'    Standing Emergency Departments (IFEDs) that have been temporarily
#'    certified as Hospitals during the COVID-19 public health emergency.
#'
#'   ### Links
#'   * [ASCs and IFEDs Enrolled in Medicare As Hospital Providers](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' @param npi NPI of the Provider
#' @param enroll_id Unique number assigned by PECOS to the provider
#' @param enroll_state State where the provider is enrolled
#' @param enroll_type Type of enrollment - ASC to Hospital OR IFED
#' @param org_name Organizational name of the enrolled provider
#' @param address description
#' @param city City where the enrolled provider is located
#' @param state State where the provider is located
#' @param zip Zip code of the provider's location
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' asc_ifed_enrollment(city = "Atlanta")
#' @autoglobal
#' @noRd
asc_ifed_enrollment <- function(npi            = NULL,
                                enroll_id      = NULL,
                                enroll_state   = NULL,
                                enroll_type    = NULL,
                                org_name       = NULL,
                                address        = NULL,
                                city           = NULL,
                                state          = NULL,
                                zip            = NULL,
                                tidy           = TRUE) {

  if (!is.null(npi))       {npi <- npi_check(npi)}
  if (!is.null(enroll_id)) {enroll_id <- enroll_check(enroll_id)}

  args <- dplyr::tribble(
    ~param,                  ~arg,
    "NPI",                    npi,
    "ENROLLMENT_ID",          enroll_id,
    "ENROLLMENT_STATE",       enroll_state,
    "TYPE",                   enroll_type,
    "ORGANIZATION_NAME",      org_name,
    "LINE_1_ST_ADR",          address,
    "CITY",                   city,
    "STATE",                  state,
    "ZIP CODE",               zip)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                "3f37b54d-eb2d-4266-8c18-ad3ecd0bede3",
                "/data?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,               ~y,
      "npi",            as.character(npi),
      "enroll_id",      as.character(enroll_id),
      "enroll_state",   enroll_state,
      "enroll_type",    enroll_type,
      "org_name",       org_name,
      "address",        address,
      "city",           city,
      "state",          state,
      "zip",            zip) |>
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
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      tidyr::unite("address",
                   line_1_st_adr:line_2_st_adr,
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      dplyr::select(npi,
                    enroll_id = enrollment_id,
                    enroll_state = enrollment_state,
                    enroll_type = type,
                    organization_name,
                    address,
                    city,
                    state,
                    zip = zip_code)

  }
  return(results)
}
