#' Search the Medicare Revalidation Due Date API
#'
#' @description Information on revalidation due dates for Medicare providers.
#'    Medicare Providers must validate their enrollment record every three or
#'    five years. CMS sets every Provider’s Revalidation due date at the end
#'    of a month and posts the upcoming six to seven months of due dates
#'    online. A due date of ‘TBD’ means that CMS has not set the due date yet.
#'    These lists are refreshed every two months and two months’ worth of due
#'    dates are appended to the list
#'
#' @details The Revalidation Due Date List dataset contains revalidation due
#'    dates for Medicare providers who are due to revalidate in the following
#'    six months. If a provider's due date does not fall within the ensuing
#'    six months, the due date is marked 'TBD'. In addition the dataset also
#'    includes subfiles with reassignment information for a given provider
#'    as well as due date listings for clinics and group practices and
#'    their providers.
#'
#' ## Links
#' * [Medicare Revalidation Due Date API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param enroll_id Enrollment ID
#' @param npi National Provider Identifier (NPI)
#' @param first First name of individual provider
#' @param last Last name of individual provider
#' @param org_name Legal business name of organizational provider
#' @param enroll_state Enrollment state
#' @param enroll_type Provider type code (`1` if Part A; `2` if DME;
#'    `3` if Non-DME Part B)
#' @param prov_type Provider type description
#' @param enroll_spec Enrollment specialty
#' @param reval_date Previously assigned revalidation due date (blank if not
#'    previously assigned a due date)
#' @param adjust_date Next revalidation due date (blank if not yet assigned)
#' @param indiv_reassign Number of individual enrollment associations that are
#'    reassigning benefits to or are employed by the organizational provider
#' @param benefits_reassign Number of organizational enrollment associations
#'    to which the individual provider reassigns benefits or is employed by
#' @param version dataset version; current possible values are "Feb" - "Nov"
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' revalidation_date(enroll_id = "I20031110000070", npi = 1184699621)
#'
#' revalidation_date(first = "Eric", last = "Byrd")
#'
#' revalidation_date(enroll_state = "FL", enroll_type = "3",
#'                   enroll_spec = "General Practice")
#' \dontrun{
#' npi_list <- rep(c(1003026055, 1316405939,
#'                   1720392988, 1518184605), each = 8)
#' months <- rep(c("Nov", "Oct", "Sep", "Aug",
#'                 "Jul", "Jun", "Apr", "Feb"), times = 4)
#' purrr::map2_dfr(npi_list, months, ~revalidation_date(npi = .x,
#'                                                      version = .y))
#' }
#' @autoglobal
#' @export
revalidation_date <- function(enroll_id         = NULL,
                              npi               = NULL,
                              first             = NULL,
                              last              = NULL,
                              org_name          = NULL,
                              enroll_state      = NULL,
                              enroll_type       = NULL,
                              prov_type         = NULL,
                              enroll_spec       = NULL,
                              reval_date        = NULL,
                              adjust_date       = NULL,
                              indiv_reassign    = NULL,
                              benefits_reassign = NULL,
                              version           = "Nov",
                              clean_names       = TRUE,
                              lowercase         = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                                          ~x,                ~y,
                             "Enrollment ID",         enroll_id,
              "National Provider Identifier",               npi,
                                "First Name",             first,
                                 "Last Name",              last,
                         "Organization Name",          org_name,
                     "Enrollment State Code",      enroll_state,
                           "Enrollment Type",       enroll_type,
                        "Provider Type Text",         prov_type,
                      "Enrollment Specialty",       enroll_spec,
                     "Revalidation Due Date",        reval_date,
                         "Adjusted Due Date",       adjust_date,
              "Individual Total Reassign To",    indiv_reassign,
           "Receiving Benefits Reassignment", benefits_reassign)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # dataset version ids by month --------------------------------------------
  id <- dplyr::case_when(
    version == "Nov" ~ "3746498e-874d-45d8-9c69-68603cafea60",
    version == "Oct" ~ "5feb2d49-b5f3-474d-ae18-743f819556e6",
    version == "Sep" ~ "68fa7b65-f27a-4218-8380-86127791d335",
    version == "Aug" ~ "d0a18c13-83ae-44a0-bfa2-e95505af25bf",
    version == "Jul" ~ "484a0a8b-1069-4322-bd57-47e5a7d88258",
    version == "Jun" ~ "8b26cdaa-8860-467a-b065-f7ecb11375c2",
    version == "Apr" ~ "d378fb6b-12ad-4bf3-95f6-b6dcb7cbb48d",
    version == "Feb" ~ "6993d4bc-2484-4d16-abd4-b15abe12241e")

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data?"
  #post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ------------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(resp,
            check_type = FALSE, simplifyVector = TRUE))


  results <- dplyr::mutate(results,
            Date = as.Date(httr2::resp_date(resp)),
            Data_Version = paste(version, "2022", sep = "-")) |>
            dplyr::relocate(Date, Data_Version)

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
