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
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examples
#' \dontrun{
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
                               tidy            = TRUE) {
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

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  id     <- "e1f1fa9a-d6b4-417e-948a-c72dead8a41c"
  url    <- paste0(http, id, post, params_args)

  # send request ------------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
         check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "N/A")))
    }
  return(results)
}
