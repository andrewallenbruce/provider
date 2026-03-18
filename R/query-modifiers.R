#' A variety of different query operators
#'
#' @description
#' Helpers for use in constructing conditions in queries.
#'
#' @details
#' Query modifiers are a small DSL for use in constructing query conditions,
#' in the [JSON-API](https://www.drupal.org/docs/core-modules-and-themes/core-modules/jsonapi-module/filtering) format.
#'
#' @param x input
#' @param ... input
#' @param or_equal `<lgl>` append `=`
#' @name modifier
#' @examples
#' params(
#'    state = excludes(state.abb[1:5]),
#'    title = ends_with("bar"),
#'    name = starts_with("foo"),
#'    n = less_than(1000),
#'    avg = less_than(0.125, or_equal = TRUE),
#'    rank = greater_than(1000),
#'    score = greater_than(0.125, or_equal = TRUE),
#'    interval = between(0.125, 2),
#'    category = contains("baz"),
#'    type = not("standard")
#'  )
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

#' @rdname modifier
#' @export
excludes <- function(...) {
  x <- c(...)
  check_named(x)
  Modifier("NOT+IN", value = x)
}

#' @rdname modifier
#' @export
contains <- function(x) {
  check_required(x)
  Modifier("CONTAINS", value = x)
}

#' @rdname modifier
#' @export
not <- function(x) {
  check_required(x)
  Modifier("<>", value = x)
}

#' @rdname modifier
#' @export
between <- function(...) {
  x <- c(...)
  check_named(x)
  check_numeric(x)
  Modifier("BETWEEN", value = collapse::frange(x, na.rm = TRUE))
}

#' @rdname modifier
#' @export
greater_than <- function(x, or_equal = FALSE) {
  check_number_decimal(x)
  check_bool(or_equal)
  Modifier(ifelse(!or_equal, ">", ">="), value = x)
}

#' @rdname modifier
#' @export
less_than <- function(x, or_equal = FALSE) {
  check_number_decimal(x)
  check_bool(or_equal)
  Modifier(ifelse(!or_equal, "<", "<="), value = x)
}

#' @rdname modifier
#' @examples
#' @export
starts_with <- function(x) {
  check_string(x)
  Modifier("STARTS WITH", value = x)
}

#' @rdname modifier
#' @export
ends_with <- function(x) {
  check_string(x)
  Modifier("ENDS WITH", value = x)
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
