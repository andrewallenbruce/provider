#' @noRd
report_preview <- function() {
  if (rlang::is_interactive()) {
    cli::cli_progress_step("Returning first {.strong 10} rows")
  } else {
    cli::cli_alert_success("Returning first {.strong 10} rows")
  }
}

#' @noRd
report_cleanup <- function() {
  if (rlang::is_interactive()) {
    cli::cli_progress_cleanup()
  }
}

#' @noRd
mark <- function(x) {
  prettyNum(x, big.mark = ",")
}

#' @noRd
left <- function(x, ...) {
  format(x, justify = "left", ...)
}

#' @noRd
report_total <- S7::new_generic("report_total", "x")

#' @noRd
report_count <- S7::new_generic("report_count", "x")

#' @noRd
report_pages <- S7::new_generic("report_pages", "x")

#' @noRd
S7::method(report_count, API) <- function(x) {
  total <- sum2(x@count)
  msg <- cli::format_inline(
    "{.strong {x@end}} returned ",
    "{.strong {mark(total)}} ",
    "{cli::qty(total)}result{?s}"
  )

  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg = msg)
  } else {
    cli::cli_alert_success(text = msg)
  }
}

# method(report_count, CMSList) <- function(x) {
#   msg <- c(
#     "{.strong {x@end}} returned ",
#     "{.strong {mark(sum2(x@count))}} ",
#     "{cli::qty(sum2(x@count))}result{?s}."
#   )
#   if (sum2(x@count) == 0L) {
#     cli::cli_alert_warning(msg)
#   } else {
#     cli::cli_alert_success(msg)
#   }
#
#   if (sum2(x@count) > 0L) {
#     END <- names(which(x@count > 0L))
#     N <- unname(x@count[END])
#     cli::cat_bullet(
#       paste0(
#         cli::col_yellow(left(END)),
#         cli::col_silver(" : "),
#         left(mark(N))
#       ),
#       bullet_col = "silver"
#     )
#   }
# }

#' @noRd
S7::method(report_pages, API) <- function(x) {
  msg <- cli::format_inline("Retrieving {.strong {x@pages}} page{?s}")

  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg = msg)
  } else {
    cli::cli_alert_success(text = msg)
  }
}

#' @noRd
S7::method(report_pages, CMSList) <- function(x) {
  pgs <- length(x@url[names(which(x@count > 0L))])
  msg <- cli::format_inline("Retrieving {.strong {pgs}} page{?s}")

  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg = msg)
  } else {
    cli::cli_alert_success(text = msg)
  }
}

#' @noRd
S7::method(report_total, API) <- function(x) {
  cli::cli_text(
    cli::style_bold(paste0(" ", x@end, " ")),
    cli::style_underline(cli::style_dim("summary"))
  )
  cli::cat_bullet(
    paste0(
      cli::col_yellow(left(c("Rows", "Pages"))),
      cli::col_silver(" : "),
      left(mark(c(x@count, x@pages)))
    ),
    bullet = "circle_filled",
    bullet_col = "silver"
  )
  invisible(x)
}

#' @noRd
S7::method(report_total, CMSList) <- function(x) {
  cli::cli_text(
    cli::style_bold(paste0(" ", x@end)),
    " Totals"
  )
  cli::cat_bullet(
    paste0(
      cli::col_yellow(left(c("Rows", "Pages"))),
      cli::col_silver(" : "),
      left(mark(c(sum2(x@count), x@pages)))
    ),
    bullet_col = "silver"
  )
  invisible(x)
}
