#' @noRd
cli_no_query <- function() {
  cli::cli_alert_warning(c(
    "{.emph No Query} ",
    cli::symbol$arrow_right,
    " Returning first {.strong 10} rows."
  ))
}

#' @noRd
cli_results <- function(x, endpoint) {
  if (length(x) > 1L) {
    x <- sum(x, na.rm = TRUE)
  }

  cli::cli_alert_success(c(
    "{.fn {endpoint}} returned {.strong ",
    format(x, big.mark = ","),
    "} ",
    "{cli::qty(x)}result{?s}."
  ))
}

#' @noRd
cli_pages <- function(x, p, endpoint) {
  cli_results(x, endpoint)
  P <- if (length(x) > 1L) {
    purrr::map_int(x, \(X) offset(n = X, limit = p)) |> sum()
  } else {
    offset(n = x, limit = p)
  }
  cli::cli_alert_info(c(
    "Retrieving {.strong {P}} page{?s}..."
  ))
}
