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
#' @param clean_names Convert column names to snakecase; default is `TRUE`.
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
                              clean_names      = TRUE) {
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

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  id     <- "3746498e-874d-45d8-9c69-68603cafea60"
  url    <- paste0(http, id, post, params_args)

  # send request ------------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(resp,
         check_type = FALSE, simplifyVector = TRUE)) |>
    dplyr::rename(NPI = "National Provider Identifier") |>
    dplyr::mutate(dplyr::across(dplyr::contains("Eligible"), yn_logical)) |>
    dplyr::mutate(dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                  dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")),
                  dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "N/A")))

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- dplyr::rename_with(results, str_to_snakecase)}

  return(results)
}
