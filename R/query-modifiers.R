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
#' @param equal `<lgl>` append `=` to `less_than()` or `greater_than()`
#' @name modifier
#' @examples
#' list(
#'    `excludes("AL", "AK", "AZ")` = excludes("AL", "AK", "AZ"),
#'    `ends_with("bar")` = ends_with("bar"),
#'    `starts_with("foo")` = starts_with("foo"),
#'    `less_than(1000)` = less_than(1000),
#'    `less_than(0.125, equal = TRUE)` = less_than(0.125, equal = TRUE),
#'    `greater_than(1000)` = greater_than(1000),
#'    `greater_than(0.125, equal = TRUE)` = greater_than(0.125, equal = TRUE),
#'    `between(0.125, 2)` = between(0.125, 2),
#'    `contains("baz")` = contains("baz"),
#'    `not("zzz")` = not("zzz"),
#'    `not_na()` = not_na(),
#'    `na()` = na()
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
check_not_modifier <- function(x, arg = caller_arg(x), call = caller_env()) {
  if (any2(purrr::map_lgl(x, is_modifier))) {
    cli::cli_abort(
      "A {.cls Modifier} cannot be an input to another {.cls Modifier}.",
      arg = arg,
      call = call
    )
  }
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
  x <- rlang::list2(...)
  check_required(x)
  check_not_modifier(x)
  x <- unlist_(x)
  Modifier("NOT+IN", value = x)
}

#' @rdname modifier
#' @export
between <- function(...) {
  x <- rlang::list2(...)
  check_required(x)
  check_not_modifier(x)
  x <- unlist_(x)
  check_numeric(x)
  Modifier("BETWEEN", value = collapse::frange(x, na.rm = TRUE))
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
not_na <- function() {
  not("")
}

#' @rdname modifier
#' @export
na <- function() {
  equals("")
}

#' @rdname modifier
#' @export
greater_than <- function(x, equal = FALSE) {
  check_required(x)
  check_not_modifier(x)
  check_number_decimal(x)
  check_bool(equal)
  Modifier(ifelse(!equal, ">", ">="), value = x)
}

#' @rdname modifier
#' @export
less_than <- function(x, equal = FALSE) {
  check_required(x)
  check_not_modifier(x)
  check_number_decimal(x)
  check_bool(equal)
  Modifier(ifelse(!equal, "<", "<="), value = x)
}

#' @rdname modifier
#' @export
starts_with <- function(x) {
  check_required(x)
  check_not_modifier(x)
  Modifier("STARTS WITH", value = x)
}

#' @rdname modifier
#' @export
ends_with <- function(x) {
  check_required(x)
  check_not_modifier(x)
  Modifier("ENDS WITH", value = x)
}
