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
#' @param month dataset version, `Latest` is default; possible months are
#' `Jan`, `Feb`, `Apr`, `Jun`, `Jul`, `Aug`, `Sep`, `Oct`, `Nov`, `Dec`
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
#'\dontrun{
#' npi_list <- rep(c(1326063900,
#'                   1588191308,
#'                   1639176803,
#'                   1326057050), each = 9)
#'
#' months <- rep(c("Dec",
#'                 "Nov",
#'                 "Oct",
#'                 "Sep",
#'                 "Aug",
#'                 "Jul",
#'                 "Jun",
#'                 "Apr",
#'                 "Feb"),
#'                 times = 4)
#'
#' purrr::map2_dfr(npi_list,
#' months, ~revalidation_reassign(ind_npi = .x, month = .y))
#' }
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
                                  month           = "Latest",
                                  clean_names     = TRUE,
                                  lowercase       = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,           ~y,
    "Group PAC ID", group_pac_id,
    "Group Enrollment ID", group_enroll_id,
    "Group Legal Business Name", group_bus_name,
    "Group State Code", group_state,
    "Record Type", record_type,
    "Individual Enrollment ID", ind_enroll_id,
    "Individual NPI", ind_npi,
    "Individual First Name", ind_first,
    "Individual Last Name", ind_last,
    "Individual State Code", ind_state,
    "Individual Specialty Description", ind_specialty)


  # dataset version ids by month --------------------------------------------
  id <- dplyr::case_when(
    month == "Latest" ~ "20f51cff-4137-4f3a-b6b7-bfc9ad57983b",
    month == "Dec" ~ "ff893063-7d95-4970-8024-65bdd9d000f1",
    month == "Nov" ~ "ee93d955-39d5-4f8a-902d-8754373bf89a",
    month == "Oct" ~ "455b5698-bd49-4a23-b114-ce58514abf90",
    month == "Sep" ~ "290d532e-db33-4d92-844a-402ad8d2c466",
    month == "Aug" ~ "831e09fe-634b-44c3-b934-31fee577e59b",
    month == "Jul" ~ "244d678f-be10-4a87-ba8b-8e509604c597",
    month == "Jun" ~ "e433f043-39b5-4c1a-bf06-e8c0a4b50b3a",
    month == "Apr" ~ "09e7d601-a1c4-4d19-b6aa-25dd30332e8a",
    month == "Feb" ~ "e8916717-c807-4e09-b90d-0b1c242c1dcc")

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  #post   <- "/data?"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ------------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  res <- tibble::tibble(httr2::resp_body_json(resp,
          check_type = FALSE, simplifyVector = TRUE))

  # append data version -----------------------------------------------------
  if (month == "Latest") {

    results <- dplyr::mutate(res,
               Month = as.Date(httr2::resp_date(resp)), .before = 1)
  } else {
    version <- paste(2022, month, "01", sep = "-")
    results <- dplyr::mutate(res, Month = lubridate::ymd(
      version, truncated = 2), .before = 1)
  }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
