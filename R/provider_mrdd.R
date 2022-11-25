#' Search the Medicare Revalidation Due Date API
#'
#' @description Information on revalidation due dates for Medicare providers.
#'
#' # Medicare Revalidation Due Date API
#'
#' The Revalidation Due Date List dataset contains
#' revalidation due dates for Medicare providers who are due to
#' revalidate in the following six months. If a provider's due
#' date does not fall within the ensuing six months, the due
#' date is marked 'TBD'. In addition the dataset also includes
#' subfiles with reassignment information for a given provider
#' as well as due date listings for clinics and group practices
#' and their providers.
#'
#' ## Data Update Frequency
#' Monthly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#' * [Medicare Revalidation Due Date API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param last Provider's last name
#' @param first Provider's first name
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param full If `TRUE`, downloads the entire dataset; default is `FALSE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' provider_mrdd(npi = 1184699621)
#'
#' provider_mrdd(last = "Byrd", first = "Eric")
#'
#' \dontrun{
#' # Unnamed List of NPIs
#'
#' npi_list <- c(1003026055,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |> purrr::map_dfr(provider_mrdd)
#'
#' # Download First 1,000 Records
#'
#' provider_mrdd(full = TRUE)
#' }
#' @autoglobal
#' @export

provider_mrdd <- function(npi         = NULL,
                          last        = NULL,
                          first       = NULL,
                          clean_names = TRUE,
                          full        = FALSE) {

  # Check internet connection
  attempt::stop_if_not(curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # Medicare Revalidation Due Date Base URL
  http <- "https://"
  site <- "data.cms.gov/data-api/v1/dataset/"
  id   <- "3746498e-874d-45d8-9c69-68603cafea60"
  end  <- "/data"
  url  <- paste0(http, site, id, end)

  # Create request
  req <- httr2::request(url)

  if (isTRUE(full)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query() |>
      httr2::req_perform()

  } else if (!is.null(npi)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query(keyword = npi) |>
      httr2::req_throttle(50 / 60) |>
      httr2::req_perform()

  } else {

  # Create list of arguments
  arg <- stringr::str_c(c(
    last = last,
    first = first), collapse = ",")

  # Check that at least one argument is not null
  attempt::stop_if_all(
    arg, is.null, "You need to specify at least one argument")

  # Send and save response
  resp <- req |>
    httr2::req_url_query(keyword = arg) |>
    httr2::req_throttle(50 / 60) |>
    httr2::req_perform()

  # Save time of API query
  datetime <- resp |> httr2::resp_date()

  }

  # Parse JSON response and save results
  results <- resp |> httr2::resp_body_json(
    check_type = FALSE,
    simplifyVector = TRUE)

  # Convert to tibble
  results <- results |> tibble::tibble()

  # Empty List - NPI is not in the database
  if (isTRUE(insight::is_empty_object(results))) {

    message("NPI is not in database")

  } else {

    # Clean names with janitor
    if (isTRUE(clean_names)) {

      results <- results |>
        janitor::clean_names()
    }

    return(results)
  }
}
