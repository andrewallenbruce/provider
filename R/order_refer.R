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
#' ## Links
#' * [Medicare Order and Referring API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Weekly**
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param first_name Provider's first name
#' @param last_name Provider's last name
#' @param partb logical
#' @param dme logical
#' @param hha logical
#' @param pmd logical
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
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
order_refer <- function(npi          = NULL,
                        first_name   = NULL,
                        last_name    = NULL,
                        partb        = NULL,
                        dme          = NULL,
                        hha          = NULL,
                        pmd          = NULL,
                        tidy         = TRUE) {

  if (!is.null(partb)) {partb <- dplyr::case_when(
    partb == TRUE ~ "Y", partb == FALSE ~ "N", .default = NULL)}

  if (!is.null(dme)) {dme <- dplyr::case_when(
    dme == TRUE ~ "Y", dme == FALSE ~ "N", .default = NULL)}

  if (!is.null(hha)) {hha <- dplyr::case_when(
    hha == TRUE ~ "Y", hha == FALSE ~ "N", .default = NULL)}

  if (!is.null(pmd)) {pmd <- dplyr::case_when(
    pmd == TRUE ~ "Y", pmd == FALSE ~ "N", .default = NULL)}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,           ~y,
    "NPI",        npi,
    "FIRST_NAME", first_name,
    "LAST_NAME",  last_name,
    "PARTB",      partb,
    "DME",        dme,
    "HHA",        hha,
    "PMD",        pmd)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "1cb95115-25c9-4097-8d12-a8f76b266591"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) == 0) {

    cli_args <- tibble::tribble(
      ~x,              ~y,
      "npi",           as.character(npi),
      "first_name",    first_name,
      "last_name",     last_name,
      "partb",         as.character(partb),
      "dme",           as.character(dme),
      "hha",           as.character(hha),
      "pmd",           as.character(pmd)) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)


    return(NULL)

  }

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
             check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- results |>
      dplyr::rename_with(str_to_snakecase) |>
      dplyr::mutate(partb = yn_logical(partb),
                    hha = yn_logical(hha),
                    dme = yn_logical(dme),
                    pmd = yn_logical(pmd)) |>
      dplyr::select(npi, first_name, last_name, partb, hha, dme, pmd)
    }
  return(results)
}
