#' @noRd
check_endpoint <- function(
  x,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (!S7::S7_inherits(x, Endpoint)) {
    cli::cli_abort(
      "{.arg {arg}} must be an {.cls Endpoint}, not {.obj_type_friendly {x}}",
      arg = arg,
      call = call
    )
  }
}

#' @noRd
report_preview <- function() {
  msg <- cli::format_inline(
    "Returning first {.strong {cli::col_yellow(10)}} rows"
  )
  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg)
    withr::defer_parent(cli::cli_progress_cleanup(), priority = "last")
  } else {
    cli::cli_alert_success(msg)
  }
}

#' @noRd
report_total <- function(x) {
  check_endpoint(x)

  sep <- cli::style_bold(cli::col_silver(" | "))
  bar <- cli::col_silver(cli::symbol$square_small_filled)
  fmt <- \(x) cli::col_yellow(mark(sum2(x)))

  cli::cli_text(
    bar,
    " ",
    cli::style_bold(x@end),
    " ",
    sep,
    fmt(x@count),
    " rows",
    sep,
    fmt(x@pages),
    " pages"
  )

  invisible(x)
}

#' @noRd
report_count <- function(x) {
  check_endpoint(x)

  N <- sum2(x@count)

  msg <- cli::format_inline(
    "{.strong {x@end}} returned ",
    "{.strong {cli::col_yellow(mark(N))}} ",
    "{cli::qty(N)}result{?s}"
  )

  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg = msg)
    withr::defer_parent(cli::cli_progress_cleanup(), priority = "last")
  } else {
    cli::cli_alert_success(text = msg)
  }
}

#' @noRd
report_pages <- function(x) {
  check_endpoint(x)

  if (S7::S7_inherits(x, EndpointCMSList)) {
    pgs <- length(x@url[names(which(x@count > 0L))])
    msg <- cli::format_inline(
      "Retrieving {.strong {cli::col_yellow(pgs)}} {cli::qty(pgs)}page{?s}"
    )
  }

  if (S7::S7_inherits(x, Endpoint)) {
    msg <- cli::format_inline(
      "Retrieving {.strong {cli::col_yellow(x@pages)}} {cli::qty(x@pages)}page{?s}"
    )
  }

  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg = msg)
    withr::defer_parent(cli::cli_progress_cleanup(), priority = "last")
  } else {
    cli::cli_alert_success(text = msg)
  }
}
