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
#' ### Links:
#'  - [CMS Public Reporting of Missing Digital Contact Information API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)
#'  - [Endpoints Information](https://nppes.cms.hhs.gov/webhelp/nppeshelp/HEALTH%20INFORMATION%20EXCHANGE.html)
#'  - [Methodology & Policy](https://data.cms.gov/sites/default/files/2021-12/8eb2b4bf-6e5f-4e05-bcdb-39c07ad8f77a/Missing_Digital_Contact_Info_Methods%20.pdf)
#'
#' *Update Frequency:* **Quarterly**
#'
#' @param npi The provider’s National Provider Identifier
#' @param name Provider's full name, in the form "last, first"
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @seealso [nppes()]
#'
#' @examplesIf interactive()
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
#' @autoglobal
#' @export
missing_endpoints <- function(npi  = NULL,
                              name = NULL,
                              tidy = TRUE) {

  if (!is.null(npi))  {npi <- npi_check(npi)}
  if (!is.null(name)) {name <- stringr::str_replace(name, " ", "")}

  args <- dplyr::tribble(
    ~param,          ~arg,
    "NPI",            npi,
    "Provider Name",  name)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
         cms_update("Public Reporting of Missing Digital Contact Information",
         "id")$distro[1], "/data?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (isTRUE(vctrs::vec_is_empty(results))) {

    cli_args <- dplyr::tribble(
      ~x,            ~y,
      "npi",         npi,
      "name",        name) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  if (tidy) {
    results <- tidyup(results) |>
      tidyr::separate_wider_delim("Provider Name", ",",
                      names = c("last_name", "first_name")) |>
      dplyr::select(npi = NPI,
                    first = first_name,
                    last = last_name)
    }
  return(results)
}
