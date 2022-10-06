#' Remove NULL elements from vector
#'
#' Implements the basic functionality found in the \pkg{purrr} package's
#' \code{compact} function.
#' @noRd
remove_null <- function(l) {
  Filter(Negate(is.null), l)
}

#' Clean up credentials
#'
#' @param x Character vector of credentials
#' @return List of cleaned character vectors, with one list element per element
#'   of \code{x}
#' @noRd
clean_credentials <- function(x) {
  if (!is.character(x)) {
    stop("x must be a character vector")
  }

  out <- gsub("\\.", "", x)
  out <- stringr::str_split(out, "[,\\s;]+", simplify = FALSE)
  out
}


#' Create full address from elements
#'
#' @param df Data frame
#' @param address_1 Quoted column name in \code{df} containing a character
#'   vector of first-street-line addresses
#' @param address_2 Quoted column name in \code{df} containing a character
#'   vector of second-street-line addresses
#' @param city Quoted column name in \code{df} containing a character vector of
#'   cities
#' @param state Quoted column name in \code{df} containing a character vector of
#'   two-letter state abbreviations
#' @param postal_code Quoted column name in \code{df} containing a character or
#'   numeric vector of postal codes
#'
#' @return Character vector containing full one-line addresses
#' @noRd
make_full_address <- function(df, address_1, city, state, postal_code) {

  stopifnot(is.data.frame(df), all(c(address_1, city, state, postal_code) %in% names(df)))

    stringr::str_c(stringr::str_trim(df[[address_1]], "both"),
                   ifelse(df[[address_2]] == "", "", " "),
                   stringr::str_trim(df[[address_2]], "both"), ", ",
                   stringr::str_trim(df[[city]], "both"), ", ",
                   stringr::str_trim(df[[state]], "both"), " ",
                   stringr::str_trim(df[[postal_code]], "both"))
  }


#' Send API requests
#'
#' Sends API requests and stores the responses in a list.
#'
#' @param results A list of query results.
#' @return A list of API results.
#' @noRd
npi_get_results <- function(results = list(), ...) {
  msg <- glue::glue(
    "Requesting records {...$skip}-{...$skip + ...$limit}..."
  )
  rlang::inform("status_pre_request", message = msg)

  result <- npi_get(npi_url(), query = ...)
  append(results, list(result))
}



#' @noRd
calc_results_stats <- function(results, user_n) {
  # Determine how many records were returned and how many are left
  last_n_returned <- ifelse(rlang::is_empty(results),
                            0L,
                            length(utils::tail(results, 1)[[1]])
  )
  tot_n_returned <- sum(vapply(results, length, integer(1L)))
  n_remaining <- user_n - tot_n_returned

  # Return stats needed for error control and params for the next query
  list(
    last_n_returned = last_n_returned,
    n_remaining = n_remaining,
    params = list(
      skip = tot_n_returned,
      limit = ifelse(
        n_remaining < MAX_N_PER_REQUEST,
        n_remaining,
        MAX_N_PER_REQUEST
      )
    )
  )
}



#' Page API requests
#'
#' Gets the maximum number of records allowed by the API in the fewest number
#' of requests.
#'
#' @param params A list of query parameters.
#' @param user_n A scalar integer representing the maximum number of records
#'   the user requested.
#' @param results A list of request results
#' @return A final list of API results.
#' @noRd
npi_control_requests <- function(params, user_n, results = list()) {
  result_stats <- calc_results_stats(results = results, user_n = user_n)

  # Avoid an endless loop when the API returns no records
  if (!rlang::is_empty(results) && result_stats[["last_n_returned"]] == 0L) {
    return(tibble::tibble())
  }

  # Return `results` when either (1) we have `user_n` number of records, or
  # (2) there were some records in the last result but not the max possible.
  if (result_stats[["n_remaining"]] == 0L ||
      (result_stats[["last_n_returned"]] > 0L &&
       result_stats[["last_n_returned"]] < MAX_N_PER_REQUEST)) {
    return(results)
  }

  query <- utils::modifyList(params, result_stats[["params"]])
  results <- npi_get_results(results = results, query = query)
  Sys.sleep(1.5)
  npi_control_requests(params = params, user_n = user_n, results = results)
}
