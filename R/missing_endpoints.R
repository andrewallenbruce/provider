#' Providers Missing Endpoints in NPPES
#'
#' @description
#' `missing_endpoints()` allows you to search for providers with missing
#' digital contact information in NPPES.
#'
#' ## NPPES Endpoints
#' Digital contact information, also known as [endpoints](https://nppes.cms.hhs.gov/webhelp/nppeshelp/HEALTH%20INFORMATION%20EXCHANGE.html),
#' provides a secure way for health care entities to send authenticated,
#' encrypted health information to trusted recipients over the internet.
#'
#' Health care organizations seeking to engage in electronic health information
#' exchange need accurate information about the electronic addresses (e.g.,
#' Direct address, FHIR server URL, query endpoint, or other digital contact
#' information) of potential exchange partners to facilitate this information exchange.
#'
#' @section Links:
#'  - [CMS Public Reporting of Missing Digital Contact Information API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)
#'  - [Endpoints Information](https://nppes.cms.hhs.gov/webhelp/nppeshelp/HEALTH%20INFORMATION%20EXCHANGE.html)
#'  - [Methodology & Policy](https://data.cms.gov/sites/default/files/2021-12/8eb2b4bf-6e5f-4e05-bcdb-39c07ad8f77a/Missing_Digital_Contact_Info_Methods%20.pdf)
#'
#' @section Update Frequency: **Quarterly**
#'
#' @param npi The provider’s National Provider Identifier
#' @param name Provider's full name, in the form "last, first"
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @seealso [nppes()]
#'
#' @examples
#' # A provider that appears in the search results
#' # of the Missing Information API has no Endpoints
#' # entered into the NPPES NPI Registry and vice versa.
#'
#' ## Appears
#' missing_endpoints(name = "Clouse, John")
#'
#' ## No Endpoints in NPPES
#' nppes(npi = 1144224569,
#'       tidy = FALSE) |>
#'       dplyr::select(endpoints)
#'
#' ## Does Not Appear
#' missing_endpoints(npi = 1003000423)
#'
#' ## Has Endpoints in NPPES
#' nppes(npi = 1003000423, tidy = FALSE) |>
#' dplyr::select(endpoints) |>
#' tidyr::unnest(cols = c(endpoints)) |>
#' janitor::clean_names() |>
#' dplyr::select(dplyr::contains("endpoint"))
#'
#' @autoglobal
#' @export
missing_endpoints <- function(npi  = NULL,
                              name = NULL,
                              tidy = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}
  if (!is.null(name)) {name <- stringr::str_replace(name, " ", "")}

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
