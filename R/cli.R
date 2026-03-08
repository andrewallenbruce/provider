#' @autoglobal
#' @noRd
cli_no_query <- function() {
  cli::cli_alert_warning(c(
    "{.emph No Query} ",
    cli::symbol$arrow_right,
    " Returning first {.strong 10} rows."
  ))
}

#' @autoglobal
#' @noRd
cli_no_results <- function() {
  cli::cli_alert_danger("Query returned {.strong 0} results.")
}

#' @autoglobal
#' @noRd
cli_results <- function(x) {
  cli::cli_alert_success("Query returned {.strong {x}} result{?s}.")
}

#' @autoglobal
#' @noRd
cli_pages <- function(x, p) {
  cli_results(x)
  cli::cli_alert_info("Retrieving {.strong {p}} page{?s}...")
}
