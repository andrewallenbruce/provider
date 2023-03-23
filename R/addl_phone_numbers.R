#' Search the CMS Physician - Additional Phone Numbers API
#' #### Dataset API no longer available ##################
#' @description Dataset of additional phone numbers when clinicians have more
#'   than one phone number at a single practice address.
#'
#'   ## Links
#'   * [Physician - Additional Phone Numbers](https://data.cms.gov/provider-data/dataset/phys-phon)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param npi Unique clinician ID assigned by NPPES
#' @param pac_id_ind Unique individual clinician ID assigned by PECOS
#' @param pac_id_org Unique group ID assigned by PECOS to the group
#' @param first_name Individual clinician first name
#' @param last_name Individual clinician last name
#' @param middle_name Individual clinician middle name
#' @param city Group or individual's city
#' @param state Group or individual's state
#' @param zip Group or individual's ZIP code (9 digits when available)
#' @param offset offset; API pagination
#' @param clean_names Convert column names to snake case; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' #addl_phone_numbers(npi = 1407263999)
#' #addl_phone_numbers(pac_id_ind = "0042100190")
#' #addl_phone_numbers(pac_id_org = 6608028899)
#' \dontrun{
#' #addl_phone_numbers(city = "Atlanta")
#' addl_phone_numbers(zip = 303421606)
#' }
#' @autoglobal
#' @noRd

addl_phone_numbers <- function(npi           = NULL,
                               pac_id_ind   = NULL,
                               pac_id_org    = NULL,
                               first_name    = NULL,
                               middle_name   = NULL,
                               last_name     = NULL,
                               city          = NULL,
                               state         = NULL,
                               zip           = NULL,
                               offset        = 0,
                               clean_names   = TRUE) {

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,           ~y,
    "npi",        npi,
    "prvdr_id",   pac_id_ind,
    "frst_nm",    first_name,
    "mid_nm",     middle_name,
    "lst_nm",     last_name,
    "cty",        city,
    "st",         state,
    "zip",        zip,
    "org_pac_id", pac_id_org)

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
      dplyr::mutate(dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "N/A")))

  }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- dplyr::rename_with(results, str_to_snakecase)}

  return(results)
}

