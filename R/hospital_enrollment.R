#' Search the CMS Hospital Enrollments API
#'
#' @description Information on hospitals currently enrolled in Medicare.
#'
#' @details The Hospital Enrollments dataset provides enrollment information of
#'   all Hospitals currently enrolled in Medicare. This data includes
#'   information on the Hospital's sub-group type, legal business name, doing
#'   business as name, organization type and address.
#'
#'   ## Links
#'   * [Hospital Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#' @param npi Hospital’s National Provider Identifier (NPI)
#' @param facility_ccn Hospital’s CMS Certification Number (CCN), formerly called an
#'   OSCAR Number
#' @param enroll_id Hospital’s enrollment ID
#' @param enroll_state Hospital’s enrollment state
#' @param specialty_code Enrollment application and specialty type code
#' @param pac_id_org Hospital’s PECOS Associate Control (PAC) ID
#' @param org_name Hospital’s legal business name
#' @param dba_name Hospital’s doing-business-as name
#' @param city City of the hospital’s practice location address
#' @param state State of the hospital’s practice location address.
#' @param zipcode Zip code of the hospital’s practice location address
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examples
#' \dontrun{
#' hospital_enrollment(npi = 1689653487)
#' hospital_enrollment(facility_ccn = "440058")
#' hospital_enrollment(pac_id_org = 6103733050)
#' hospital_enrollment(city = "Atlanta")
#' hospital_enrollment(zipcode = 117771928)
#' }
#' @autoglobal
#' @export

hospital_enrollment <- function(npi            = NULL,
                                facility_ccn   = NULL,
                                enroll_id      = NULL,
                                enroll_state   = NULL,
                                specialty_code = NULL,
                                pac_id_org     = NULL,
                                org_name       = NULL,
                                dba_name       = NULL,
                                city           = NULL,
                                state          = NULL,
                                zipcode        = NULL,
                                tidy           = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                       ~y,
    "NPI",                    npi,
    "CCN",                    facility_ccn,
    "ENROLLMENT ID",          enroll_id,
    "ENROLLMENT STATE",       enroll_state,
    "PROVIDER TYPE CODE",     specialty_code,
    "ASSOCIATE ID",           pac_id_org,
    "ORGANIZATION NAME",      org_name,
    "DOING BUSINESS AS NAME", dba_name,
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
  id     <- "f6f6505c-e8b0-4d57-b258-e2b94133aaf2"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (httr2::resp_header(response, "content-length") == "0") {

    cli_args <- tibble::tribble(
      ~x,               ~y,
      "npi",            npi,
      "facility_ccn",   facility_ccn,
      "enroll_id",      enroll_id,
      "enroll_state",   enroll_state,
      "specialty_code", specialty_code,
      "pac_id_org",     pac_id_org,
      "org_name",       org_name,
      "dba_name",       dba_name,
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
      dplyr::mutate(dplyr::across(dplyr::contains(c("flag", "subgroup", "proprietary")), yn_logical),
                    dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                    dplyr::across(dplyr::contains("date"), ~lubridate::ymd(.)),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "N/A")),
                    incorp_duration = lubridate::as.duration(lubridate::today() - incorporation_date)) |>
      tidyr::unite("address",
                   address_line_1:address_line_2,
                   remove = TRUE, na.rm = TRUE) |>
      dplyr::select(npi,
                    enroll_id = enrollment_id,
                    enroll_state = enrollment_state,
                    specialty_code = provider_type_code,
                    specialty_desc = provider_type_text,
                    facility_ccn = ccn,
                    pac_id_org = associate_id,
                    org_name = organization_name,
                    doing_business_as = doing_business_as_name,
                    incorp_date = incorporation_date,
                    incorp_duration,
                    incorp_state = incorporation_state,
                    org_structure = organization_type_structure,
                    org_other = organization_other_type_text,
                    address,
                    city,
                    state,
                    zipcode = zip_code,
                    location_type = practice_location_type,
                    location_other = location_other_type_text,
                    multiple_npis = multiple_npi_flag,
                    proprietary_nonprofit,
                    sg_general = subgroup__general,
                    sg_acute_care = subgroup__acute_care,
                    sg_alcohol_drug = subgroup__alcohol_drug,
                    sg_childrens = subgroup__childrens,
                    sg_long_term = subgroup__long_term,
                    sg_short_term = subgroup__short_term,
                    sg_psychiatric = subgroup__psychiatric,
                    sg_psychiatric_unit = subgroup__psychiatric_unit,
                    sg_rehabilitation = subgroup__rehabilitation,
                    sg_rehabilitation_unit = subgroup__rehabilitation_unit,
                    sg_swing_bed_approved = subgroup__swing_bed_approved,
                    sg_specialty_hospital = subgroup__specialty_hospital,
                    sg_other = subgroup__other,
                    sg_other_text = subgroup__other_text)

    }
  return(results)
}
