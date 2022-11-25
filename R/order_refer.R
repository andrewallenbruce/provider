#' Search the Medicare Order and Referring API
#'
#' @description All physicians and non-physician practitioners who are legally
#'    eligible to order and refer in the Medicare program and who have current
#'    enrollment records in Medicare.
#'
#' @details The Medicare Order and Referring dataset provides information on
#'    all physicians and non-physician practitioners, by their National
#'    Provider Identifier (NPI), who are of a type/specialty that is legally
#'    eligible to order and refer in the Medicare program and who have current
#'    enrollment records in Medicare.
#'
#' ## Data Update Frequency
#' Weekly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#' * [Medicare Order and Referring API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param last Provider's last name
#' @param first Provider's first name
#' @param partb logical
#' @param dme logical
#' @param hha logical
#' @param pmd logical
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' order_refer(npi = 1003026055)
#'
#' order_refer(last = "phadke",
#'             first = "radhika")
#'
#' # Unnamed List of NPIs
#' npi_list <- c(1003026055,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |>
#' purrr::map_dfr(order_refer)
#'
#' # Data frame of NPIs
#' npi_df <- data.frame(npi = c(1003026055,
#'                              1316405939,
#'                              1720392988,
#'                              1518184605,
#'                              1922056829,
#'                              1083879860))
#' npi_df |>
#' tibble::deframe() |>
#' purrr::map_dfr(order_refer)
#' }
#' @autoglobal
#' @export

order_refer <- function(npi         = NULL,
                        last        = NULL,
                        first       = NULL,
                        partb       = NULL,
                        dme         = NULL,
                        hha         = NULL,
                        pmd         = NULL,
                        clean_names = TRUE,
                        lowercase   = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,           ~y,
    "NPI",        npi,
    "LAST_NAME",  last,
    "FIRST_NAME", first,
    "PARTB",      partb,
    "DME",        dme,
    "HHA",        hha,
    "PMD",        pmd)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "1cb95115-25c9-4097-8d12-a8f76b266591"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(resp,
             check_type = FALSE, simplifyVector = TRUE)) |>
             dplyr::mutate(PARTB = dplyr::case_when(
               PARTB == as.character("Y") ~ as.logical(TRUE),
               PARTB == as.character("N") ~ as.logical(FALSE), TRUE ~ NA),
               HHA = dplyr::case_when(
               HHA == as.character("Y") ~ as.logical(TRUE),
               HHA == as.character("N") ~ as.logical(FALSE), TRUE ~ NA),
               DME = dplyr::case_when(
               DME == as.character("Y") ~ as.logical(TRUE),
               DME == as.character("N") ~ as.logical(FALSE), TRUE ~ NA),
               PMD = dplyr::case_when(
               PMD == as.character("Y") ~ as.logical(TRUE),
               PMD == as.character("N") ~ as.logical(FALSE), TRUE ~ NA))

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

    return(results)
}
