#' Search the Medicare Revalidation Due Date List API
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
#' @param first_name First name of individual provider
#' @param last_name Last name of individual provider
#' @param org_name Legal business name of organizational provider
#' @param state Enrollment state
#' @param type_code Provider enrollment type code (`1` if _Part A_;
#'    `2` if _DME_; `3` if _Non-DME Part B_)
#' @param prov_type Provider type description
#' @param specialty Enrollment specialty
#' @param month dataset version, `Latest` is default; possible months are
#' `Feb`, `Apr`, `Jun`, `Jul`, `Aug`, `Sep`, `Oct`, `Nov`,`Dec`
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' revalidation_date(enroll_id = "I20031110000070",
#'                   npi = 1184699621)
#'
#' revalidation_date(first_name = "Eric",
#'                   last_name = "Byrd")
#'
#' revalidation_date(state = "FL",
#'                   type_code = "3",
#'                   specialty = "General Practice")
#'
#' revalidation_date(enroll_id = "O20110620000324",
#'                   org_name = "Lee Memorial Health System",
#'                   state = "FL",
#'                   prov_type = "DME",
#'                   type_code = "2")
#' \dontrun{
#' npi_list <- rep(c(1003026055,
#'                   1316405939,
#'                   1720392988,
#'                   1518184605),
#'                   each = 8)
#'
#' months <- rep(c("Nov",
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
#'                 months,
#'                 ~revalidation_date(npi = .x,
#'                 month = .y))
#' }
#' @autoglobal
#' @export
revalidation_date <- function(enroll_id        = NULL,
                              npi              = NULL,
                              first_name       = NULL,
                              last_name        = NULL,
                              org_name         = NULL,
                              state            = NULL,
                              type_code        = NULL,
                              prov_type        = NULL,
                              specialty        = NULL,
                              month            = "Latest",
                              clean_names      = TRUE,
                              lowercase        = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                                ~x,                ~y,
                   "Enrollment ID",         enroll_id,
    "National Provider Identifier",               npi,
                      "First Name",        first_name,
                       "Last Name",         last_name,
               "Organization Name",          org_name,
           "Enrollment State Code",             state,
                 "Enrollment Type",         type_code,
              "Provider Type Text",         prov_type,
            "Enrollment Specialty",         specialty)

  # dataset version ids by month --------------------------------------------
  id <- dplyr::case_when(
    month == "Latest" ~ "3746498e-874d-45d8-9c69-68603cafea60",
    month == "Dec" ~ "d022e5bf-4179-4b24-a349-cc675fdb3faa",
    month == "Nov" ~ "ab4a4ed4-81ed-4285-bb95-20fffaa39045",
    month == "Oct" ~ "5feb2d49-b5f3-474d-ae18-743f819556e6",
    month == "Sep" ~ "68fa7b65-f27a-4218-8380-86127791d335",
    month == "Aug" ~ "d0a18c13-83ae-44a0-bfa2-e95505af25bf",
    month == "Jul" ~ "484a0a8b-1069-4322-bd57-47e5a7d88258",
    month == "Jun" ~ "8b26cdaa-8860-467a-b065-f7ecb11375c2",
    month == "Apr" ~ "d378fb6b-12ad-4bf3-95f6-b6dcb7cbb48d",
    month == "Feb" ~ "6993d4bc-2484-4d16-abd4-b15abe12241e")

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
