#' Search the Medicare Opt Out Affidavits API
#'
#' @description A list of practitioners who are currently opted out
#'    of Medicare.
#'
#' @details The Opt Out Affidavits dataset provides information on providers who have decided not to participate in Medicare. It contains the provider's NPI, specialty, address, and effective dates.
#'
#' ## Data Update Frequency
#' Monthly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#' * [Medicare Opt Out Affidavits API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
#'
#' @param first First Name of the Opt Out Provider
#' @param last Last Name of the Opt Out Provider
#' @param npi National Provider Identifier (NPI) number of the Opt Out Provider
#' @param specialty Specialty of the Opt Out Provider
#' @param date_start Date from which the Provider's Opt Out Status is
#'    effective
#' @param date_end Date on which the Provider's Opt Out Status ends
#' @param address Provider's Street Address
#' @param city Provider's City
#' @param state_abb Provider's State Abbreviation
#' @param zip Provider's Zip Code
#' @param eligible Flag indicating whether the Provider is eligible to
#'    Order and Refer
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' opt_out(specialty = "Psychiatry")
#' opt_out(first = "David")
#' opt_out(npi = 1114974490)
#' opt_out(state_abb = "NY", eligible = "N")
#'
#' opt_out(specialty = "Clinical%20Psychologist")
#' opt_out(city = "Los%20Angeles")
#'
#' # Returns empty list i.e., provider is not in the database
#' opt_out(npi = 1326011057)
#' }
#' @autoglobal
#' @export

opt_out <- function(first        = NULL,
                    last         = NULL,
                    npi          = NULL,
                    specialty    = NULL,
                    date_start   = NULL,
                    date_end     = NULL,
                    address      = NULL,
                    city         = NULL,
                    state_abb    = NULL,
                    zip          = NULL,
                    eligible     = NULL,
                    clean_names  = TRUE,
                    lowercase    = TRUE) {

  # param_format ------------------------------------------------------------
  param_format <- function(param, arg) {
    if (is.null(arg)) {param <- NULL} else {
      paste0("filter[", param, "]=", arg, "&")}}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                                        ~x,           ~y,
                            "First%20Name",        first,
                             "Last%20Name",         last,
                                     "NPI",          npi,
                               "Specialty",    specialty,
               "Optout%20Effective%20Date",   date_start,
                     "Optout%20End%20Date",     date_end,
         "First%20Line%20Street%20Address",      address,
                             "City%20Name",         city,
                            "State%20Code",    state_abb,
                              "Zip%20code",          zip,
     "Eligible%20to%20Order%20and%20Refer",     eligible)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "")

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "9887a515-7552-4693-bf58-735c77af46d7"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # create request ----------------------------------------------------------
  req <- httr2::request(url)

  # send response -----------------------------------------------------------
  resp <- req |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- resp |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE) |>
    tibble::tibble() |>
    dplyr::mutate(Date = httr2::resp_date(resp)) |>
    dplyr::relocate(Date)

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
