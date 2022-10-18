#' Search the Medicare Revalidation Clinic Group Practice Reassignment API
#'
#' @description Information on clinic group practice revalidation
#'    for Medicare enrollment.
#'
#' # Medicare Revalidation Clinic Group Practice Reassignment API
#'
#' The Revalidation Clinic Group Practice Reassignment dataset
#' provides information between the physician and the group
#' practice they reassign their billing to. It also includes
#' individual employer association counts and the revalidation
#' dates for the individual physician as well as the clinic group
#' practice. This dataset is based on information gathered from the
#' Provider Enrollment, Chain and Ownership System (PECOS).
#'
#' ## Data Update Frequency
#' Monthly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#'  * [Medicare Revalidation Clinic Group Practice Reassignment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param last Last name of provider who is reassigning their
#'    benefits or is an employee
#' @param first First name of provider who is reassigning their
#'    benefits or is an employee
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param full If true, downloads the first 1000 rows of data;
#'    default is `FALSE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' provider_rcgpr(npi = 1427050418)
#'
#' provider_rcgpr(last = "Denney", first = "James")
#'
#' # Unnamed List of NPIs
#' npi_list <- c(1003026055,
#'               1871035477,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |> purrr::map_dfr(provider_rcgpr)
#'
#' # Data frame of NPIs
#' npi_df <- data.frame(npi = c(1003026055,
#'                              1871035477,
#'                              1720392988,
#'                              1518184605,
#'                              1922056829,
#'                              1083879860))
#' npi_df |>
#' tibble::deframe() |>
#' purrr::map_dfr(provider_rcgpr)
#'
#' # Download First 1,000 Rows of Dataset =====================================
#' provider_rcgpr(full = TRUE)
#' }
#' @export

provider_rcgpr <- function(npi        = NULL,
                          last        = NULL,
                          first       = NULL,
                          clean_names = TRUE,
                          full        = FALSE) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # Medicare Revalidation Clinic Group Practice Reassignment URL
  rcgpr_url <- "https://data.cms.gov/data-api/v1/dataset/e1f1fa9a-d6b4-417e-948a-c72dead8a41c/data"

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(rcgpr_url)

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

    # Save time of API query
    datetime <- resp |> httr2::resp_date()

  }

  # Parse JSON response and save results
  results <- resp |> httr2::resp_body_json(
    check_type = FALSE,
    simplifyVector = TRUE)

  # Empty List - NPI is not in the database
  if (isTRUE(insight::is_empty_object(results))) {

    message("NPI not in database")

  } else {

    # Clean names with janitor
    if (isTRUE(clean_names)) {

      results <- results |>
        janitor::clean_names()
    }

    return(results)
  }
}
