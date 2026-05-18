#' @noRd
mark <- function(x) {
  prettyNum(x, big.mark = ",")
}

#' @noRd
left <- function(x, ...) {
  format(x, justify = "left", ...)
}

#' @noRd
report_total <- new_generic("report_total", "x")

#' @noRd
report_count <- new_generic("report_count", "x")

#' @noRd
report_pages <- new_generic("report_pages", "x")

#' @noRd
report_empty <- function() {
  cli::cli_alert_warning(c(
    "{.emph No Query} ",
    cli::col_red(cli::symbol$pointer),
    " Returning first {.strong 10} rows."
  ))
  cli::cli_text()
}

#' @noRd
method(report_count, API) <- function(x) {
  msg <- c(
    "{.strong {x@end}} returned ",
    "{.strong {mark(x@count)}} ",
    "{cli::qty(x@count)}result{?s}."
  )
  if (x@count == 0L) {
    cli::cli_alert_warning(msg)
  } else {
    cli::cli_alert_success(msg)
  }
}

#' @noRd
method(report_count, CMSList) <- function(x) {
  msg <- c(
    "{.strong {x@end}} returned ",
    "{.strong {mark(sum2(x@count))}} ",
    "{cli::qty(sum2(x@count))}result{?s}."
  )
  if (sum2(x@count) == 0L) {
    cli::cli_alert_warning(msg)
  } else {
    cli::cli_alert_success(msg)
  }
  cli::cat_bullet(
    paste0(
      cli::col_yellow(left(names(x@count))),
      cli::col_silver(" : "),
      left(mark(unname(x@count)))
    ),
    bullet_col = "silver"
  )
}

#' @noRd
method(report_pages, API) <- function(x) {
  report_count(x)
  cli::cli_alert_info("Retrieving {.strong {x@pages}} page{?s}...")
}

#' @noRd
method(report_total, API) <- function(x) {
  cli::cli_text(
    cli::style_bold(paste0(" ", x@end)),
    " Totals"
  )
  cli::cat_bullet(
    paste0(
      cli::col_yellow(left(c("Rows", "Pages"))),
      cli::col_silver(" : "),
      left(mark(c(x@count, x@pages)))
    ),
    bullet_col = "silver"
  )
  cli::cli_text()
}

#' @noRd
method(report_total, CMSList) <- function(x) {
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
  cli::cli_text()
}

# @export
# `print.provider::Modifier` <- function(x, ...) {
#   value <- if (any2(x@value == "")) {
#     encodeString(x@value, quote = '"', na.encode = FALSE)
#   } else {
#     x@value
#   }
#
#  cli::cli_text(cli::col_silver("<modifier[{length(value)}]>"))
#
#   c::cli_text(c(
#     cli::col_silver("Alias: "),
#     cli::col_red(cli::style_bold(S7::S7_data(x)))
#   ))
#
#   cli::cli_text(c(
#     cli::col_silver("Operator: "),
#     cli::style_bold(x@operator)
#   ))
#
#   cli::cli_text(
#     c(
#       cli::col_silver("{cli::qty(length(v))}Value{?s}: "),
#       cli::col_yellow(toString(value, width = 20L))
#     )
#   )
#   invisible(x)
# }
