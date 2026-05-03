#' @noRd
build <- new_generic("build", "x")

#' @noRd
execute <- new_generic("execute", "x")

#' @noRd
empty <- new_generic("empty", "x")

#' @noRd
method(empty, API) <- function(x) {
  length(x@query) == 0L
}

#' @noRd
request_preview <- new_generic("request_preview", "x")

#' @noRd
request_single <- new_generic("request_single", "x")

#' @noRd
request_multi <- new_generic("request_multi", "x")

#' @noRd
report_total <- new_generic("report_total", "x")

#' @noRd
report_count <- new_generic("report_count", "x")

#' @noRd
method(report_count, API) <- function(x) {
  cli_results(x@count, x@end)
}

#' @noRd
method(report_count, ListCMS) <- function(x) {
  cli_results(sum2(x@count), x@end)
  cli_apis(x@count)
}

#' @noRd
method(report_total, API) <- function(x) {
  cli::cli_text(
    cli::style_bold(cli::col_grey(cli::symbol$double_line)),
    cli::style_bold(cli::col_cyan(paste0(" ", x@end))),
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
method(report_total, ListCMS) <- function(x) {
  cli::cli_text(
    cli::style_bold(cli::col_grey(cli::symbol$double_line)),
    cli::style_bold(cli::col_cyan(paste0(" ", x@end))),
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
