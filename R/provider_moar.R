#' Search the Medicare Order and Referring API
#'
#' @description All physicians and non-physician practitioners who are legally
#'    eligible to order and refer in the Medicare program and who have current
#'    enrollment records in Medicare.
#'
#' # Medicare Order and Referring API
#'
#' The Order and Referring dataset provides information on all physicians and
#' non-physician practitioners, by their National Provider Identifier (NPI),
#' who are of a type/specialty that is legally eligible to order and refer in
#' the Medicare program and who have current enrollment records in Medicare.
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
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param full If true, downloads the first 1000 rows of data;
#'    default is `FALSE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' provider_moar(npi = 1003026055)
#'
#' provider_moar(last = "phadke", first = "radhika")
#'
#' # Unnamed List of NPIs
#' npi_list <- c(1003026055,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |> purrr::map_dfr(provider_moar)
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
#' purrr::map_dfr(provider_moar)
#'
#' # Download First 1,000 Rows of Dataset =====================================
#' provider_moar(full = TRUE)
#' }
#' @autoglobal
#' @export

provider_moar <- function(npi         = NULL,
                          last        = NULL,
                          first       = NULL,
                          clean_names = TRUE,
                          full        = FALSE) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # Medicare Order and Referring Base URL
  moar_url <- "https://data.cms.gov/data-api/v1/dataset/c99b5865-1119-4436-bb80-c5af2773ea1f/data"

  # Create request
  req <- httr2::request(moar_url)

  if (isTRUE(full)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query() |>
      httr2::req_perform()

  } else if (!is.null(npi)) {

    # Luhn check
    attempt::stop_if_not(provider_luhn(npi) == TRUE,
                         msg = "Luhn Check: NPI may be invalid.")

    # Send and save response
    resp <- req |>
      httr2::req_url_query(keyword = npi) |>
      httr2::req_throttle(50 / 60) |>
      httr2::req_perform()

  } else {

  # Create list of arguments
  arg <- stringr::str_c(c(
    last = last,
    first = first
  ), collapse = ",")

  # Check that at least one argument is not null
  attempt::stop_if_all(arg, is.null,
          "You need to specify at least one argument")

  # Send and save response
  resp <- req |>
    httr2::req_url_query(keyword = arg) |>
    httr2::req_throttle(50 / 60) |>
    httr2::req_perform()

  }

  # Parse JSON response and save results
  results <- resp |> httr2::resp_body_json(
    check_type = FALSE,
    simplifyVector = TRUE)


  # Empty List - NPI is not in the database
  if (isTRUE(is.null(nrow(results))) & isTRUE(is.null(ncol(results)))) {

    return(message(paste("Provider", npi, arg, "is not in the database")))

    } else {

      results <- results |>
        tibble::tibble() |>
        dplyr::mutate(
          PARTB = dplyr::case_when(
            PARTB == as.character("Y") ~ as.logical(TRUE),
            PARTB == as.character("N") ~ as.logical(FALSE),
            TRUE ~ NA),
          HHA = dplyr::case_when(
            HHA == as.character("Y") ~ as.logical(TRUE),
            HHA == as.character("N") ~ as.logical(FALSE),
            TRUE ~ NA),
          DME = dplyr::case_when(
            DME == as.character("Y") ~ as.logical(TRUE),
            DME == as.character("N") ~ as.logical(FALSE),
            TRUE ~ NA),
          PMD = dplyr::case_when(
            PMD == as.character("Y") ~ as.logical(TRUE),
            PMD == as.character("N") ~ as.logical(FALSE),
            TRUE ~ NA)
          )

      # Clean names with janitor

      if (isTRUE(clean_names)) {

        results <- results |> janitor::clean_names()

      }

    }

    return(results)
}
