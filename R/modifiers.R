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
    call_name(call_match(
      call = caller_call(),
      fn = caller_fn()
    )),
    operator = "NOT+IN",
    value = x
  )
}

#' @rdname modifier
#' @export
between <- function(x, y) {
  check_number_decimal(x)
  check_number_decimal(y)
  Modifier(
    call_name(call_match(
      call = caller_call(),
      fn = caller_fn()
    )),
    operator = "BETWEEN",
    value = c(x, y)
  )
}

#' @rdname modifier
#' @export
contains <- function(x) {
  check_atomic(x)
  Modifier(
    call_name(call_match(
      call = caller_call(),
      fn = caller_fn()
    )),
    operator = "CONTAINS",
    value = x
  )
}

#' @rdname modifier
#' @export
not <- function(x) {
  check_atomic(x)
  Modifier(
    call_name(call_match(
      call = caller_call(),
      fn = caller_fn()
    )),
    operator = "<>",
    value = x
  )
}

#' @noRd
equals <- function(x) {
  check_atomic(x)
  Modifier(
    call_name(call_match(
      call = caller_call(),
      fn = caller_fn()
    )),
    operator = "=",
    value = x
  )
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
  check_number_decimal(x)
  check_bool(equal)
  Modifier(
    call_name(call_match(
      call = caller_call(),
      fn = caller_fn()
    )),
    operator = ifelse(!equal, ">", ">="),
    value = x
  )
}

#' @rdname modifier
#' @export
less <- function(x, equal = FALSE) {
  check_number_decimal(x)
  check_bool(equal)
  Modifier(
    call_name(call_match(
      call = caller_call(),
      fn = caller_fn()
    )),
    operator = ifelse(!equal, "<", "<="),
    value = x
  )
}

#' @rdname modifier
#' @export
starts <- function(x) {
  check_atomic(x)
  Modifier(
    call_name(call_match(
      call = caller_call(),
      fn = caller_fn()
    )),
    operator = "STARTS WITH",
    value = x
  )
}

#' @rdname modifier
#' @export
ends <- function(x) {
  check_atomic(x)
  Modifier(
    call_name(call_match(
      call = caller_call(),
      fn = caller_fn()
    )),
    operator = "ENDS WITH",
    value = x
  )
}
