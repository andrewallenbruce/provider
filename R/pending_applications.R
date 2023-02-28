#' Search the Medicare Pending Initial Logging and Tracking API
#'
#' @description A list of enrollment applications pending CMS contractor
#'    review for physicians & non-physicians.
#'
#' @details The Pending Initial Logging and Tracking (L & T) dataset provides
#'    a list of pending applications that have not been processed by CMS
#'    contractors.
#'
#' ## Links
#' * [Medicare Pending Initial Logging and Tracking Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)
#' * [Medicare Pending Initial Logging and Tracking Non-Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Weekly**
#'
#' @param npi National Provider Identifier (NPI) number
#' @param last_name Last name of provider
#' @param first_name First name of provider
#' @param type physician or non-physician
#' @param clean_names Convert column names to snakecase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' pending_applications(npi = 1487003984, type = "physician")
#' pending_applications(npi = 1487003984, type = "non-physician")
#' pending_applications(last_name = "Abbott", type = "non-physician")
#' pending_applications(first_name = "John", type = "physician")
#' @autoglobal
#' @export

pending_applications <- function(npi         = NULL,
                                 last_name   = NULL,
                                 first_name  = NULL,
                                 type = c("physician", "non-physician"),
                                 clean_names = TRUE) {

  # match geo_level args ----------------------------------------------------
  type <- rlang::arg_match(type)

  # update distribution ids -------------------------------------------------
  id <- dplyr::case_when(
    type == "physician" ~ "6bd6b1dd-208c-4f9c-88b8-b15fec6db548",
    type == "non-physician" ~ "261b83b6-b89f-43ad-ae7b-0d419a3bc24b")

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,           ~y,
    "NPI",        npi,
    "LAST_NAME",  last_name,
    "FIRST_NAME", first_name)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.numeric(httr2::resp_header(resp, "content-length")) == 0) {
    results <- tibble::tibble("NPI" = NA,
                              "LAST_NAME" = NA,
                              "FIRST_NAME" = NA)
  } else {

    results <- tibble::tibble(httr2::resp_body_json(resp, check_type = FALSE,
                                                    simplifyVector = TRUE))
  }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- dplyr::rename_with(results, str_to_snakecase)}

  return(results)
}
