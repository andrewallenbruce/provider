#' @noRd
method(execute, API) <- function(x) {
  if (empty(x)) {
    report_total(x)
    if (x@action == "set") {
      return(request_multi(x))
    }

    if (x@action == "count") {
      return(x@count)
    }

    return(request_preview(x))
  }

  if (x@count == 0L || x@action == "count") {
    report_count(x)
    return(x@count)
  }

  if (x@count <= x@limit) {
    return(request_single(x))
  }
  request_multi(x)
}

#' @noRd
method(execute, ListCMS) <- function(x) {
  if (empty(x)) {
    report_total(x)
    if (x@action == "set") {
      return(request_multi(x))
    }
    if (x@action == "count") {
      return(x@count)
    }
    return(request_preview(x))
  }
  report_count(x)

  if (sum2(x@count) == 0L || x@action == "count") {
    return(x@count)
  }

  if (all2(x@count <= x@limit)) {
    return(request_single(x))
  }
  request_multi(x)
}

#' @export
`print.provider::Modifier` <- function(x, ...) {
  v <- if (any2(x@value == "")) {
    encodeString(x@value, quote = '"', na.encode = FALSE)
  } else {
    x@value
  }

  cli::cli_text(cli::col_cyan("<modifier[{length(v)}]>"))

  cli::cli_text(c(
    cli::col_silver("Operator: "),
    cli::col_red(cli::style_bold(S7::S7_data(x)))
  ))

  cli::cli_text(
    c(
      cli::col_silver("{cli::qty(length(v))}Value{?s}: "),
      cli::col_yellow(toString(v, width = 20L))
    )
  )
  invisible(x)
}
