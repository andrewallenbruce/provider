#' Hospitals Enrolled in Medicare
#'
#' @description
#' `hospitals()` allows you to search for information on all hospitals
#' currently enrolled in Medicare. Data returned includes the hospital's
#' sub-group types, legal business name, doing-business-as name, organization
#' type and address.
#'
#' ### Links:
#'   - [Hospital Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi Hospital’s National Provider Identifier
#' @param facility_ccn Hospital’s CMS Certification Number (CCN)
#' @param enroll_id_org Hospital’s enrollment ID
#' @param enroll_state Hospital’s enrollment state
#' @param specialty_code Enrollment specialty type code
#' @param pac_id_org Hospital’s PAC ID
#' @param organization_name Hospital’s legal business name
#' @param doing_business_as Hospital’s doing-business-as name
#' @param city City of the hospital’s practice location address
#' @param state State of the hospital’s practice location address
#' @param zip Zip code of the hospital’s practice location address
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @seealso [clinicians()], [providers()], [affiliations()]
#'
#' @examples
#' hospitals(pac_id_org = 6103733050)
#'
#' @autoglobal
#' @export
hospitals <- function(npi               = NULL,
                      facility_ccn      = NULL,
                      enroll_id_org     = NULL,
                      enroll_state      = NULL,
                      specialty_code    = NULL,
                      pac_id_org        = NULL,
                      organization_name = NULL,
                      doing_business_as = NULL,
                      city              = NULL,
                      state             = NULL,
                      zip               = NULL,
                      tidy              = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}
  if (!is.null(enroll_id_org)) {enroll_check(enroll_id_org)}
  if (!is.null(enroll_id_org)) {enroll_org_check(enroll_id_org)}
  if (!is.null(pac_id_org)) {pac_check(pac_id_org)}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                       ~y,
    "NPI",                    npi,
    "CCN",                    facility_ccn,
    "ENROLLMENT ID",          enroll_id_org,
    "ENROLLMENT STATE",       enroll_state,
    "PROVIDER TYPE CODE",     specialty_code,
    "ASSOCIATE ID",           pac_id_org,
    "ORGANIZATION NAME",      organization_name,
    "DOING BUSINESS AS NAME", doing_business_as,
    "CITY",                   city,
    "STATE",                  state,
    "ZIP CODE",               zip)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # update distribution id -------------------------------------------------
  id <- cms_update(api = "Hospital Enrollments", check = "id") |>
    dplyr::slice_head() |>
    dplyr::pull(distro)

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- tibble::tribble(
      ~x,                  ~y,
      "npi",               as.character(npi),
      "facility_ccn",      as.character(facility_ccn),
      "enroll_id_org",     as.character(enroll_id_org),
      "enroll_state",      enroll_state,
      "specialty_code",    specialty_code,
      "pac_id_org",        pac_id_org,
      "organization_name", organization_name,
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

    # parse response ---------------------------------------------------------
    results <- tibble::tibble(httr2::resp_body_json(response,
              check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::mutate(dplyr::across(dplyr::contains(c("flag", "subgroup", "proprietary")), yn_logical),
                    dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                    dplyr::across(dplyr::contains("date"), ~lubridate::ymd(.)),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "N/A"))) |>
      tidyr::unite("address",
                   address_line_1:address_line_2,
                   remove = TRUE, na.rm = TRUE) |>
      dplyr::select(npi,
                    organization_name,
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
                    proprietary_nonprofit,
                    dplyr::contains("subgroup_")) |>
      tidyr::nest(subgroups = dplyr::contains("subgroup_"))

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
#'   ## Links
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
#' @param zipcode Zip code of the provider's location
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
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
                                zipcode        = NULL,
                                tidy           = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                       ~y,
    "NPI",                    npi,
    "ENROLLMENT_ID",          enroll_id,
    "ENROLLMENT_STATE",       enroll_state,
    "TYPE",                   enroll_type,
    "ORGANIZATION_NAME",      org_name,
    "LINE_1_ST_ADR",          address,
    "CITY",                   city,
    "STATE",                  state,
    "ZIP CODE",               zipcode)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "3f37b54d-eb2d-4266-8c18-ad3ecd0bede3"
  post   <- "/data?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- tibble::tribble(
      ~x,               ~y,
      "npi",            as.character(npi),
      "enroll_id",      as.character(enroll_id),
      "enroll_state",   enroll_state,
      "enroll_type",    enroll_type,
      "org_name",       org_name,
      "address",        address,
      "city",           city,
      "state",          state,
      "zipcode",        zipcode) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            as.character(cli_args$y),
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
    return(invisible(NULL))

  }

  # parse response ---------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
                                                  check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      tidyr::unite("address",
                   line_1_st_adr:line_2_st_adr,
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      dplyr::select(npi,
                    enroll_id = enrollment_id,
                    enroll_state = enrollment_state,
                    enroll_type = type,
                    org_name = organization_name,
                    address,
                    city,
                    state,
                    zipcode = zip_code)

  }
  return(results)
}
