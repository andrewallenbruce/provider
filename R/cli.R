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

#' @noRd
check_online <- function() {
  if (!httr2::is_online()) {
    cli::cli_abort(c(
      "You are not online.",
      "i" = "Check your internet connection."
    ))
  }
}

#' @noRd
check_numeric <- function(x) {
  if (!rlang::is_bare_numeric(x)) {
    cli::cli_abort(c(
      "{.arg x} must be a numeric vector, not {.obj_type_friendly {x}}"
    ))
  }
}
