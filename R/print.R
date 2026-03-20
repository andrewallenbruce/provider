#' @export
#' @exportS3Method base::print
print.Modifier <- function(x, ...) {
  cli::cli_text(cli::col_cyan("<Modifier>"))
  cli::cli_text(c(
    cli::col_silver("Operator: "),
    cli_red(operator(x))
  ))

  LEN <- length(value(x)) > 1L

  cli::cli_text(
    c(
      cli::col_silver(if (LEN) "Values: " else "Value: "),
      cli::col_yellow(if (LEN) toString(value(x), width = 20L) else value(x))
    )
  )
  invisible(x)
}

#' @export
#' @exportS3Method base::print
print.subgroups <- function(x, ...) {
  cli::cli_text(cli::col_cyan("<subgroups>"))
  if (!length(x)) {
    cli::cli_text(cli::col_red("<empty>"))
  } else {
    cli::cat_bullet(
      paste0(
        format(names(x), justify = "left"),
        cli::col_silver(" : "),
        format(unname(x), justify = "left")
      ),
      bullet_col = "silver"
    )
  }
  invisible(x)
}
