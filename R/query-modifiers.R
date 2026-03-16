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
#' @param or_equal `<lgl>` append `=` to `greater_than()`/`less_than()`
#' @name modifier
#' @returns An S7 `<Modifier>` object.
#' @source [JSON-API: Query Parameters](https://jsonapi.org/format/#query-parameters)
NULL

#' @noRd
Modifier <- S7::new_class(
  name = "Modifier",
  parent = S7::class_character,
  package = NULL,
  properties = list(
    value = S7::class_character | S7::class_numeric
  )
)
#' @noRd
is_modifier <- function(x) {
  S7::S7_inherits(x, Modifier)
}

#' @exportS3Method base::print
print.Modifier <- function(x, ...) {
  cli::cli_text(cli::col_cyan("<Modifier>"))
  cli::cli_text(c(
    cli::col_silver("Operator: "),
    cli::col_red(cli::style_bold(S7::S7_data(x)))
  ))
  cli::cli_text(
    c(
      cli::col_silver(if (length(x@value) > 1L) "Values: " else "Value: "),
      cli::col_yellow(if (length(x@value) > 1L) toString(x@value, width = 20L) else x@value)
    )
  )
}

#' @rdname modifier
#' @examples
#' any_of(state.abb)
#' @export
any_of <- function(x) {
  Modifier("IN", value = x)
}

#' @rdname modifier
#' @examples
#' none_of(state.abb)
#' @export
none_of <- function(x) {
  Modifier("NOT+IN", value = x)
}

#' @rdname modifier
#' @examples
#' contains("baz")
#' @export
contains <- function(x) {
  Modifier("CONTAINS", value = x)
}

#' @rdname modifier
#' @examples
#' not(1000)
#' @export
not <- function(x) {
  Modifier("<>", value = x)
}

#' @rdname modifier
#' @examples
#' between(c(0.125, 2))
#' @export
between <- function(x) {
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
