#' Search the CMS Doctors and Clinicians National Downloadable File API
#'
#' @description Dataset of providers' facility affiliations
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
#' @param pac_id Unique individual clinician ID assigned by PECOS
#' @param enroll_id Unique ID for the clinician enrollment that is the source
#'   for the data in the observation
#' @param last_name Individual clinician last name
#' @param first_name Individual clinician first name
#' @param middle_name Individual clinician middle name
#' @param gender Individual clinician gender
#' @param med_sch Individual clinician’s medical school
#' @param grad_year Individual clinician’s medical school graduation year
#' @param prim_spec Primary medical specialty reported by the individual
#'   clinician in the selected enrollment
#' @param city Group or individual's city
#' @param state Group or individual's state
#' @param zip Group or individual's ZIP code (9 digits when available)
#' @param ind_assign Indicator for whether clinician accepts Medicare approved
#'   amount as payment in full. `Y` = Clinician accepts Medicare approved amount
#'   as payment in full. `M` = Clinician may accept Medicare Assignment.
#' @param group_assign Indicator for whether group accepts Medicare approved
#'   amount as payment in full. `Y` = Clinician accepts Medicare approved amount
#'   as payment in full. `M` = Clinician may accept Medicare Assignment.
#' @param offset offset; API pagination
#' @param clean_names Clean column names with {janitor}'s `clean_names()`
#'   function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' doctors_and_clinicians(npi = 1407263999)
#' doctors_and_clinicians(pac_id = 4688974991)
#' doctors_and_clinicians(enroll_id = "I20081002000549")
#' \dontrun{
#' doctors_and_clinicians(first_name = "John")
#' doctors_and_clinicians(med_sch = "NEW YORK UNIVERSITY SCHOOL OF MEDICINE")
#' doctors_and_clinicians(grad_year = 2003)
#' }
#' @autoglobal
#' @export

doctors_and_clinicians <- function(npi           = NULL,
                                   pac_id        = NULL,
                                   enroll_id     = NULL,
                                   last_name     = NULL,
                                   first_name    = NULL,
                                   middle_name   = NULL,
                                   gender        = NULL,
                                   med_sch       = NULL,
                                   grad_year     = NULL,
                                   prim_spec     = NULL,
                                   city          = NULL,
                                   state         = NULL,
                                   zip           = NULL,
                                   ind_assign    = NULL,
                                   group_assign  = NULL,
                                   offset        = 0,
                                   clean_names   = TRUE,
                                   lowercase     = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                   ~y,
    "NPI",                npi,
    "Ind_PAC_ID",         pac_id,
    "Ind_enrl_ID",        enroll_id,
    "lst_nm",             last_name,
    "frst_nm",            first_name,
    "mid_nm",             middle_name,
    "gndr",               gender,
    "Med_sch",            med_sch,
    "Grd_yr",             grad_year,
    "pri_spec",           prim_spec,
    "cty",                city,
    "st",                 state,
    "zip",                zip,
    "ind_assgn",          ind_assign,
    "grp_assgn",          group_assign)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |> stringr::str_flatten()

  id <- "ed54fac3-f8ec-5713-9a0e-740b4cbd7ba4"

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

