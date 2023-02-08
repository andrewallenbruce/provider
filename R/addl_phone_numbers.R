#' Search the CMS Physician - Additional Phone Numbers API
#'
#' @description Dataset of Additional phone numbers when clinicians have more
#'   than one phone number at a single practice address.
#'
#' @details The Doctors and Clinicians national downloadable file is organized
#'   such that each line is unique at the clinician/enrollment
#'   record/group/address level. Clinicians with multiple Medicare enrollment
#'   records and/or single enrollments linking to multiple practice locations
#'   are listed on multiple lines.
#'
#'   ## Links
#'   * [Doctors and Clinicians National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param npi Unique clinician ID assigned by NPPES
#' @param provider_id Unique individual clinician ID assigned by PECOS
#' @param first_name Individual clinician first name
#' @param last_name Individual clinician last name
#' @param middle_name Individual clinician middle name
#' @param city Group or individual's city
#' @param state Group or individual's state
#' @param zip Group or individual's ZIP code (9 digits when available)
#' @param org_pac_id Unique group ID assigned by PECOS to the group
#' @param offset offset; API pagination
#' @param clean_names Clean column names with {janitor}'s `clean_names()`
#'   function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' addl_phone_numbers(npi = 1407263999)
#' addl_phone_numbers(provider_id = "0042100190")
#' addl_phone_numbers(org_pac_id = 6608028899)
#' \dontrun{
#' addl_phone_numbers(city = "Atlanta")
#' addl_phone_numbers(zip = 303421606)
#' }
#' @autoglobal
#' @export

addl_phone_numbers <- function(npi           = NULL,
                               provider_id   = NULL,
                               first_name    = NULL,
                               middle_name   = NULL,
                               last_name     = NULL,
                               city          = NULL,
                               state         = NULL,
                               zip           = NULL,
                               org_pac_id    = NULL,
                               offset        = 0,
                               clean_names   = TRUE,
                               lowercase     = TRUE) {

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,           ~y,
    "npi",        npi,
    "prvdr_id",   provider_id,
    "frst_nm",    first_name,
    "mid_nm",     middle_name,
    "lst_nm",     last_name,
    "cty",        city,
    "st",         state,
    "zip",        zip,
    "org_pac_id", org_pac_id)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |> stringr::str_flatten()

  id <- "a12b0ee3-db05-5603-bd3e-e6f449797cb0"

  id_fmt <- paste0("[SELECT * FROM ", id, "]")

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query="
  post   <- paste0("[LIMIT 10000 OFFSET ", offset, "]&show_db_columns")
  url    <- paste0(http, id_fmt, params_args, post) |>
    param_brackets() |> param_space()

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.numeric(httr2::resp_header(resp, "content-length")) == 0) {
    return(tibble::tibble())
  } else {

    # parse response ---------------------------------------------------------
    results <- tibble::tibble(httr2::resp_body_json(resp,
                                                    check_type = FALSE, simplifyVector = TRUE)) |>
      dplyr::mutate(dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "N/A")))

  }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}
  return(results)
}

