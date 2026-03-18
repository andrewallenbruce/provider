#' A variety of different query operators
#'
#' @description
#' Helpers for use in constructing conditions in queries.
#'
#' @details
#' Query modifiers are a small DSL for use in constructing query conditions,
#' in the [JSON-API](https://www.drupal.org/docs/core-modules-and-themes/core-modules/jsonapi-module/filtering) format.
#'
#' @param x parameter input
#' @param ... parameter input
#' @param or_equal `<lgl>` append `=` to `greater_than()`/`less_than()`
#' @name modifier
#' @examples
#' params()
#' @returns An S7 `<Modifier>` object.
#' @source [JSON-API: Query Parameters](https://jsonapi.org/format/#query-parameters)
NULL

#' @noRd
Modifier <- S7::new_class(
  name = "Modifier",
  parent = S7::class_character,
  package = NULL,
  properties = list(
    value = S7::class_atomic
  )
)
#' @noRd
is_modifier <- function(x) {
  S7::S7_inherits(x, Modifier)
}

#' @noRd
cli_bld_red <- cli::combine_ansi_styles("red", "bold")

#' @exportS3Method base::print
print.Modifier <- function(x, ...) {
  cli::cli_text(cli::col_cyan("<Modifier>"))
  cli::cli_text(c(
    cli::col_silver("Operator: "),
    cli_bld_red(operator(x))
  ))

  LEN <- length(value(x)) > 1L

  cli::cli_text(
    c(
      cli::col_silver(if (LEN) "Values: " else "Value: "),
      cli::col_yellow(if (LEN) toString(value(x), width = 20L) else value(x))
    )
  )
}

#' @noRd
operator <- S7::new_generic("operator", "x")

#' @noRd
value <- S7::new_generic("value", "x")

#' @noRd
S7::method(operator, Modifier) <- function(x) {
  S7::S7_data(x)
}

#' @noRd
S7::method(value, Modifier) <- function(x) {
  S7::prop(x, "value")
}

# @rdname modifier
# @examples
# any_of(state.abb)
# @export
# any_of <- function(...) {
#   check_dots_unnamed()
#   x <- c(...)
#   Modifier("IN", value = x)
# }

#' @rdname modifier
#' @examples
#' x <- excludes(state.abb[1:5])
#' x
#' operator(x)
#' value(x)
#' @export
excludes <- function(...) {
  check_dots_unnamed()
  x <- c(...)
  Modifier("NOT+IN", value = x)
}

#' @rdname modifier
#' @examples
#' contains("baz")
#' @export
contains <- function(x) {
  check_required(x)
  Modifier("CONTAINS", value = x)
}

#' @rdname modifier
#' @examples
#' not(1000)
#' @export
not <- function(x) {
  check_required(x)
  Modifier("<>", value = x)
}

#' @rdname modifier
#' @examples
#' between(0.125, 2)
#' @export
between <- function(...) {
  check_dots_unnamed()
  x <- c(...)
  check_numeric(x)
  Modifier("BETWEEN", value = collapse::frange(x, na.rm = TRUE))
}

#' @rdname modifier
#' @examples
#' greater_than(1000)
#' greater_than(0.125, or_equal = TRUE)
#' @export
greater_than <- function(x, or_equal = FALSE) {
  check_number_decimal(x)
  check_bool(or_equal)
  Modifier(ifelse(!or_equal, ">", ">="), value = x)
}

#' @rdname modifier
#' @examples
#' less_than(1000)
#' less_than(0.125, or_equal = TRUE)
#' @export
less_than <- function(x, or_equal = FALSE) {
  check_number_decimal(x)
  check_bool(or_equal)
  Modifier(ifelse(!or_equal, "<", "<="), value = x)
}

#' @rdname modifier
#' @examples
#' starts_with("foo")
#' @export
starts_with <- function(x) {
  check_string(x)
  Modifier("STARTS WITH", value = x)
}

#' @rdname modifier
#' @examples
#' ends_with("bar")
#' @export
ends_with <- function(x) {
  check_string(x)
  Modifier("ENDS WITH", value = x)
}
