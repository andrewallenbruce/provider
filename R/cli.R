#' @noRd
inform_preview <- function() {
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
inform_summary <- function(x) {
  check_endpoint(x)

  sep <- cli::style_bold(cli::col_silver(" | "))
  bar <- cli::col_silver(cli::symbol$square_small_filled)
  fmt <- \(x) cli::col_yellow(mark(sum2(x)))

  cli::cli_text(
    bar,
    " ",
    cli::style_bold(S7::prop(x, "end")),
    sep,
    fmt(S7::prop(x, "count")),
    " rows",
    sep,
    fmt(S7::prop(x, "pages")),
    " pages"
  )

  invisible(x)
}

#' @noRd
inform_count <- function(x) {
  check_endpoint(x)

  N <- sum2(S7::prop(x, "count"))
  E <- S7::prop(x, "end")

  msg <- cli::format_inline(
    "{.strong {E}} returned ",
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
inform_pages <- function(x) {
  check_endpoint(x)

  if (S7::S7_inherits(x, EndpointCMSList)) {
    pgs <- length(
      S7::prop(x, "url")[
        rlang::names2(
          cheapr::which_(
            S7::prop(x, "count") > 0L
          )
        )
      ]
    )

    msg <- cli::format_inline(
      "Retrieving {.strong {cli::col_yellow(pgs)}} {cli::qty(pgs)}page{?s}"
    )
  }

  if (S7::S7_inherits(x, Endpoint)) {
    pgs <- S7::prop(x, "pages")
    msg <- cli::format_inline(
      "Retrieving {.strong {cli::col_yellow(pgs)}} {cli::qty(pgs)}page{?s}"
    )
  }

  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg = msg)
    withr::defer_parent(cli::cli_progress_cleanup(), priority = "last")
  } else {
    cli::cli_alert_success(text = msg)
  }
}
