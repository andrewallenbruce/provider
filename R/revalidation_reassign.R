#' Search the Medicare Revalidation Reassignment List API
#'
#' @description Reassignments of Providers who are due for Revalidation.
#'
#' @details The Revalidation Reassignment List dataset provides information on
#'    reassignments of providers who are due for revalidation.
#'
#' ## Links
#' * [Medicare Revalidation Reassignment List API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param group_pac_id PAC ID of provider who is receiving reassignment or is
#'    the employer
#' @param group_enroll_id Enrollment ID of provider who is receiving
#'    reassignment or is the employer
#' @param group_bus_name Legal business name of provider who is receiving
#'    reassignment or is the employer
#' @param group_state Enrollment state of provider who is receiving
#'    reassignment or is the employer
#' @param record_type Identifies whether the record is for a reassignment
#'    (`Reassignment`) or employment (`Physician Assistant`)
#' @param ind_enroll_id Enrollment ID of provider who is reassigning their
#'    benefits or is an employee
#' @param ind_npi NPI of provider who is reassigning their benefits or is an
#'    employee
#' @param ind_first First name of provider who is reassigning their benefits
#'    or is an employee
#' @param ind_last Last name of provider who is reassigning their benefits or
#'    is an employee
#' @param ind_state Enrollment state of provider who is reassigning their
#'    benefits or is an employee
#' @param ind_specialty Enrollment specialty of the provider who is
#'    reassigning their benefits or is an employee
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' revalidation_reassign(ind_enroll_id = "I20200929003184",
#'                    ind_npi = 1962026229,
#'                    ind_first = "Rashadda",
#'                    ind_last = "Wong",
#'                    ind_state = "CT",
#'                    ind_specialty = "Physician Assistant")
#'
#' revalidation_reassign(group_pac_id = 9436483807,
#'                    group_enroll_id = "O20190619002165",
#'                    group_bus_name = "1st Call Urgent Care",
#'                    group_state = "FL",
#'                    record_type = "Reassignment")
#' @autoglobal
#' @export
revalidation_reassign <- function(group_pac_id    = NULL,
                                  group_enroll_id = NULL,
                                  group_bus_name  = NULL,
                                  group_state     = NULL,
                                  record_type     = NULL,
                                  ind_enroll_id   = NULL,
                                  ind_npi         = NULL,
                                  ind_first       = NULL,
                                  ind_last        = NULL,
                                  ind_state       = NULL,
                                  ind_specialty   = NULL,
                                  clean_names     = TRUE,
                                  lowercase       = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                                 ~y,
    "Group PAC ID",                     group_pac_id,
    "Group Enrollment ID",              group_enroll_id,
    "Group Legal Business Name",        group_bus_name,
    "Group State Code",                 group_state,
    "Record Type",                      record_type,
    "Individual Enrollment ID",         ind_enroll_id,
    "Individual NPI",                   ind_npi,
    "Individual First Name",            ind_first,
    "Individual Last Name",             ind_last,
    "Individual State Code",            ind_state,
    "Individual Specialty Description", ind_specialty)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  id     <- "20f51cff-4137-4f3a-b6b7-bfc9ad57983b"
  url    <- paste0(http, id, post, params_args)

  # send request ------------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(resp,
             check_type = FALSE, simplifyVector = TRUE)) |>
    dplyr::mutate(dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")),
                  dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "N/A")))

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
