#' Search the Medicare Revalidation Clinic Group Practice Reassignment API
#'
#' @description Information on clinic group practice revalidation for Medicare
#'    enrollment.
#'
#' @details The Revalidation Clinic Group Practice Reassignment dataset
#'    provides information between the physician and the group practice they
#'    reassign their billing to. It also includes individual employer
#'    association counts and the revalidation dates for the individual
#'    physician as well as the clinic group practice.
#'
#' ## Links
#' * [Medicare Revalidation Clinic Group Practice Reassignment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)
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
#' revalidation_group(ind_enroll_id = "I20200929003184",
#'                    ind_npi = 1962026229,
#'                    ind_first = "Rashadda",
#'                    ind_last = "Wong",
#'                    ind_state = "CT",
#'                    ind_specialty = "Physician Assistant")
#'
#' revalidation_group(group_pac_id = 9436483807,
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
#' months <- rep(c("Nov",
#'                 "Oct",
#'                 "Sep",
#'                 "Aug",
#'                 "Jul",
#'                 "Jun",
#'                 "Apr",
#'                 "Feb",
#'                 "Jan"), times = 4)
#'
#' purrr::map2_dfr(npi_list,
#' months, ~revalidation_group(ind_npi = .x, month = .y))
#' }
#' @autoglobal
#' @export
revalidation_group <- function(group_pac_id    = NULL,
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
    month == "Latest" ~ "e1f1fa9a-d6b4-417e-948a-c72dead8a41c",
    month == "Dec" ~ "c3ddc2e3-901c-4549-8d6b-21db3a95a998",
    month == "Nov" ~ "b5d6013d-fdf3-4948-94ff-50171dc69028",
    month == "Oct" ~ "35b1631c-1557-44c4-ada0-d9d6cfdf286f",
    month == "Sep" ~ "d55ce5bf-91ee-4618-b4ce-59cda693e866",
    month == "Aug" ~ "0c55ef7b-098a-47ce-9897-9efcf6f4f4d6",
    month == "Jul" ~ "9389f6ad-5551-4da8-8d83-59f0234c1791",
    month == "Jun" ~ "306e9308-ebdb-47cd-adea-e72b6fb44fa5",
    month == "Apr" ~ "7062cc70-6490-4600-b292-858ca575358c",
    month == "Feb" ~ "3c16d900-64cd-4874-91bc-04a164e94789",
    month == "Jan" ~ "713e0294-e793-42b5-8c63-5f5723fe7ad1")

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
