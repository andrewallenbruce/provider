#' @noRd
Modifier <- new_class(
  "Modifier",
  class_character,
  package = NULL,
  properties = list(
    operator = class_character,
    value = class_atomic
  )
)

#' A variety of different query operators
#'
#' @description Helpers for use in constructing conditions in queries.
#'
#' @details Query modifiers are a small DSL for use in constructing query
#'   conditions, in the
#'   [JSON-API](https://www.drupal.org/docs/core-modules-and-themes/core-modules/jsonapi-module/filtering)
#'   format.
#'
#' @param x,y input
#' @param equal `<lgl>` append `=` to `less()` or `greater()`
#' @name modifier
#' @examples
#' excludes(c("AL", "AK", "AZ"))
#'
#' ends("bar")
#'
#' starts("foo")
#'
#' contains("baz")
#'
#' not("zzz")
#'
#' less(1000)
#'
#' less(0.125, equal = TRUE)
#'
#' greater(1000)
#'
#' greater(0.125, equal = TRUE)
#'
#' between(0.125, 2)
#'
#' not_blank()
#'
#' is_blank()
#'
#' @returns An S7 `<Modifier>` object.
#' @source [JSON-API: Query Parameters](https://jsonapi.org/format/#query-parameters)
NULL

#' @rdname modifier
#' @export
excludes <- function(x) {
  check_atomic(x)
  Modifier(
    "excludes",
    operator = "NOT+IN",
    value = x
  )
}

#' @rdname modifier
#' @export
contains <- function(x) {
  check_atomic(x)
  Modifier(
    "contains",
    operator = "CONTAINS",
    value = x
  )
}

#' @rdname modifier
#' @export
starts <- function(x) {
  check_atomic(x)
  Modifier(
    "starts",
    operator = "STARTS WITH",
    value = x
  )
}

#' @rdname modifier
#' @export
ends <- function(x) {
  check_atomic(x)
  Modifier(
    "ends",
    operator = "ENDS WITH",
    value = x
  )
}

#' @rdname modifier
#' @export
not <- function(x) {
  check_atomic(x)
  Modifier(
    "not",
    operator = "<>",
    value = x
  )
}

#' @rdname modifier
#' @export
not_blank <- function() {
  Modifier(
    "not_blank",
    operator = "<>",
    value = ""
  )
}

#' @rdname modifier
#' @export
is_blank <- function() {
  Modifier(
    "is_blank",
    operator = "=",
    value = ""
  )
}

#' @rdname modifier
#' @export
greater <- function(x, equal = FALSE) {
  check_number_decimal(x)
  check_bool(equal)
  Modifier(
    "greater",
    operator = ifelse(equal, ">=", ">"),
    value = x
  )
}

#' @rdname modifier
#' @export
less <- function(x, equal = FALSE) {
  check_number_decimal(x)
  check_bool(equal)
  Modifier(
    "less",
    operator = ifelse(equal, "<=", "<"),
    value = x
  )
}

#' @rdname modifier
#' @export
between <- function(x, y) {
  check_number_decimal(x, min = 0, allow_infinite = FALSE)
  check_number_decimal(y, allow_infinite = FALSE)

  if (x >= y) {
    cli::cli_abort("{.var x} must be less than {.var y}")
  }

  Modifier(
    "between",
    operator = "BETWEEN",
    value = c(x, y)
  )
}
