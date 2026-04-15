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
#' list(
#'    `excludes(c("AL", "AK", "AZ"))` = excludes(c("AL", "AK", "AZ")),
#'    # !x %in% c("AL", "AK", "AZ")
#'    `ends_with("bar")` = ends_with("bar"),
#'    # endsWith(x, "bar")
#'    `starts_with("foo")` = starts_with("foo"),
#'    # startsWith(x, "foo")
#'    `less_than(1000)` = less_than(1000),
#'    # x < 1000
#'    `less_than(0.125, or_equal = TRUE)` = less_than(0.125, or_equal = TRUE),
#'    # x <= 1000
#'    `greater_than(1000)` = greater_than(1000),
#'    # x > 1000
#'    `greater_than(0.125, or_equal = TRUE)` = greater_than(0.125, or_equal = TRUE),
#'    # x >= 1000
#'    `between(0.125, 2)` = between(0.125, 2),
#'    # x > 0.125 & x < 2
#'    `contains("baz")` = contains("baz"),
#'    # grepl("baz", x)
#'    `not("zzz")` = not("zzz"),
#'    # x != "zzz"
#'    `not_na()` = not_na()
#'    # !is.na(x)
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
not_na <- function(x) {
  not("")
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
#' @export
starts_with <- function(x) {
  check_required(x)
  Modifier("STARTS WITH", value = x)
}

#' @rdname modifier
#' @export
ends_with <- function(x) {
  check_required(x)
  Modifier("ENDS WITH", value = x)
}
