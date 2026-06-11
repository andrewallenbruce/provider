#' @noRd
report_preview <- function() {
  if (rlang::is_interactive()) {
    cli::cli_progress_step("Returning first {.strong 10} rows")
    withr::defer_parent(cli::cli_progress_cleanup(), priority = "last")
  } else {
    cli::cli_alert_success("Returning first {.strong 10} rows")
  }
}

#' @noRd
report_total <- S7::new_generic("report_total", "x")

#' @noRd
report_count <- S7::new_generic("report_count", "x")

#' @noRd
report_pages <- S7::new_generic("report_pages", "x")

#' @noRd
S7::method(report_count, Endpoint) <- function(x) {
  total <- sum2(x@count)
  msg <- cli::format_inline(
    "{.strong {x@end}} returned ",
    "{.strong {mark(total)}} ",
    "{cli::qty(total)}result{?s}"
  )

  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg = msg)
    withr::defer_parent(cli::cli_progress_cleanup(), priority = "last")
  } else {
    cli::cli_alert_success(text = msg)
  }
}

#' @noRd
S7::method(report_pages, Endpoint) <- function(x) {
  msg <- cli::format_inline("Retrieving {.strong {x@pages}} page{?s}")

  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg = msg)
    withr::defer_parent(cli::cli_progress_cleanup(), priority = "last")
  } else {
    cli::cli_alert_success(text = msg)
  }
}

#' @noRd
S7::method(report_pages, EndpointCMSList) <- function(x) {
  pgs <- length(x@url[names(which(x@count > 0L))])
  msg <- cli::format_inline("Retrieving {.strong {pgs}} page{?s}")

  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg = msg)
    withr::defer_parent(cli::cli_progress_cleanup(), priority = "last")
  } else {
    cli::cli_alert_success(text = msg)
  }
}

#' @noRd
S7::method(report_total, Endpoint) <- function(x) {
  cli::cli_text(
    cli::col_silver(cli::symbol$square_small_filled),
    " ",
    cli::style_bold(x@end),
    " ",
    cli::style_dim(cli::style_italic("summary")),
    cli::style_bold(cli::col_silver(" | ")),
    cli::col_yellow(mark(sum2(x@count))),
    " rows",
    cli::col_silver(" | "),
    cli::col_yellow(mark(sum2(x@pages))),
    " pages"
  )
  invisible(x)
}
