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
  cli::cli_alert_success(
    "Query returned {.strong {format(x, big.mark = ',')}} {cli::qty(x)}result{?s}."
  )
}

#' @noRd
cli_pages <- function(x, p) {
  cli_results(x)
  cli::cli_alert_info("Retrieving {.strong {p}} page{?s}...")
}
