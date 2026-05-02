#' A variety of different query operators
#'
#' @description Helpers for use in constructing conditions in queries.
#'
#' @details Query modifiers are a small DSL for use in constructing query
#'   conditions, in the
#'   [JSON-API](https://www.drupal.org/docs/core-modules-and-themes/core-modules/jsonapi-module/filtering)
#'   format.
#'
#' @param x input
#' @param y input
#' @param equal `<lgl>` append `=` to `less()` or `greater()`
#'
#' @name modifier
#'
#' @examples
#' list(
#'    `excludes(c("AL", "AK", "AZ"))` = excludes(c("AL", "AK", "AZ")),
#'    `ends("bar")` = ends("bar"),
#'    `starts("foo")` = starts("foo"),
#'    `less(1000)` = less(1000),
#'    `less(0.125, equal = TRUE)` = less(0.125, equal = TRUE),
#'    `greater(1000)` = greater(1000),
#'    `greater(0.125, equal = TRUE)` = greater(0.125, equal = TRUE),
#'    `between(0.125, 2)` = between(0.125, 2),
#'    `contains("baz")` = contains("baz"),
#'    `not("zzz")` = not("zzz"),
#'    `not_blank()` = not_blank(),
#'    `is_blank()` = is_blank()
#'  )
#' @returns An S7 `<Modifier>` object.
#' @source [JSON-API: Query Parameters](https://jsonapi.org/format/#query-parameters)
NULL

#' @rdname modifier
#' @export
excludes <- function(x) {
  check_not_modifier(x)
  Modifier("NOT+IN", value = x)
}

#' @rdname modifier
#' @export
between <- function(x, y) {
  check_not_modifier(x)
  check_not_modifier(y)
  check_numeric(x)
  check_numeric(y)
  Modifier("BETWEEN", value = c(x, y))
}

#' @rdname modifier
#' @export
contains <- function(x) {
  check_required(x)
  check_not_modifier(x)
  Modifier("CONTAINS", value = x)
}

#' @rdname modifier
#' @export
not <- function(x) {
  check_required(x)
  check_not_modifier(x)
  Modifier("<>", value = x)
}

#' @noRd
equals <- function(x) {
  check_required(x)
  check_not_modifier(x)
  Modifier("=", value = x)
}

#' @rdname modifier
#' @export
not_blank <- function() {
  not("")
}

#' @rdname modifier
#' @export
is_blank <- function() {
  equals("")
}

#' @rdname modifier
#' @export
greater <- function(x, equal = FALSE) {
  check_required(x)
  check_number_decimal(x)
  check_bool(equal)
  Modifier(ifelse(!equal, ">", ">="), value = x)
}

#' @rdname modifier
#' @export
less <- function(x, equal = FALSE) {
  check_required(x)
  check_number_decimal(x)
  check_bool(equal)
  Modifier(ifelse(!equal, "<", "<="), value = x)
}

#' @rdname modifier
#' @export
starts <- function(x) {
  check_required(x)
  check_not_modifier(x)
  Modifier("STARTS WITH", value = x)
}

#' @rdname modifier
#' @export
ends <- function(x) {
  check_required(x)
  check_not_modifier(x)
  Modifier("ENDS WITH", value = x)
}
