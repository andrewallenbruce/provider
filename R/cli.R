#' @noRd
cli_no_query <- function() {
  cli::cli_alert_warning(c(
    "{.emph No Query} ",
    cli::symbol$arrow_right,
    " Returning first {.strong 10} rows."
  ))
}

#' @noRd
cli_results <- function(x) {
  cli::cli_alert_success(c(
    "Query returned {.strong ",
    format(x, big.mark = ","),
    "} ",
    "{cli::qty(x)}result{?s}."
  ))
}

#' @noRd
cli_pages <- function(x, p) {
  cli_results(x)
  P <- offset(x, p, "size")
  cli::cli_alert_info(c(
    "Retrieving {.strong {P}} page{?s}..."
  ))
}

#' @noRd
cli_online <- function() {
  if (!httr2::is_online()) {
    cli::cli_abort(c(
      "You are not online.",
      "i" = "Check your internet connection."
    ))
  }
}
