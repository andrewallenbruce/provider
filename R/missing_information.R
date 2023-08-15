#' Search the CMS Public Reporting of Missing Digital Contact Information API
#'
#' @description Information on providers missing digital contact information
#'    in NPPES.
#'
#' @details In the May 2020 CMS Interoperability and Patient Access final rule,
#'    CMS finalized the policy to publicly report the names and NPIs of those
#'    providers who do not have digital contact information included in the
#'    NPPES system (85 FR 25584). This data includes the NPI and provider
#'    name of providers and clinicians without digital contact
#'    information in NPPES.
#'
#' ## Links
#' * [CMS Public Reporting of Missing Digital Contact Information API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Quarterly**
#' @param npi The provider’s National Provider Identifier
#' @param name Provider's full name, without spaces, in the form "Last,First"
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examples
#' missing_information(npi = 1134122013)
#' missing_information(name = "Henry,Timothy")
#' @autoglobal
#' @export
missing_information <- function(npi  = NULL,
                                name = NULL,
                                tidy = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,               ~y,
    "NPI",            npi,
    "Provider Name",  name)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # update distribution id -------------------------------------------------
  id <- cms_update("Public Reporting of Missing Digital Contact Information",
                   "id") |>
    dplyr::slice_head() |>
    dplyr::pull(distro)

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data?"
  #post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # create request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28) {

    cli_args <- tibble::tribble(
      ~x,            ~y,
      "npi",         as.character(npi),
      "name",        name) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}",
                          wrap = TRUE)

    return(invisible(NULL))
  }

  results <- tibble::tibble(httr2::resp_body_json(response,
                check_type = FALSE,
                simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- tidyr::separate(results,
                               col = "Provider Name",
                               into = c("last_name", "first_name"),
                               sep = ",") |>
      dplyr::select(npi = NPI, last_name, first_name)
    }
  return(results)
}
