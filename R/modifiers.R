#' @noRd
new_modifier <- function(operator, value) {
  structure(
    list(
      operator = operator,
      value = value
    ),
    class = "modifier"
  )
}

#' @noRd
is_modifier <- function(x) {
  inherits(x, "modifier")
}

#' @exportS3Method base::print
print.modifier <- function(x, ...) {
  cli::cli_text(cli::col_cyan("<modifier>"))
  cli::cli_text(c(
    cli::col_silver("Operator: "),
    cli::col_red(cli::style_bold("{x$operator}"))
  ))
  cli::cli_text(
    c(
      cli::col_silver("{cli::qty(length(x$value))}Value{?s}: "),
      cli::col_yellow("{x$value}")
    )
  )
}

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
#' @param negate `<lgl>` prepend `NOT` to `between()`
#' @name modifier
#' @returns An object of class `<modifier>`
NULL

#' @rdname modifier
#' @examples
#' greater_than(1000)
#' greater_than(0.125, or_equal = TRUE)
#' @export
greater_than <- function(x, or_equal = FALSE) {
  check_number_decimal(x)
  check_bool(or_equal)
  new_modifier(
    operator = ifelse(!or_equal, ">", ">="),
    value = x
  )
}

#' @rdname modifier
#' @examples
#' less_than(1000)
#' less_than(0.125, or_equal = TRUE)
#' @export
less_than <- function(x, or_equal = FALSE) {
  check_number_decimal(x)
  check_bool(or_equal)
  new_modifier(
    operator = ifelse(!or_equal, "<", "<="),
    value = x
  )
}

#' @rdname modifier
#' @examples
#' between(c(1000, 1100))
#' between(c(0.125, 2), negate = TRUE)
#' @export
between <- function(x, negate = FALSE) {
  check_numeric(x)
  check_bool(negate)
  new_modifier(
    operator = ifelse(!negate, "BETWEEN", "NOT+BETWEEN"),
    value = collapse::frange(x)
  )
}

#' @rdname modifier
#' @examples
#' starts_with("foo")
#' @export
starts_with <- function(x) {
  check_character(x)
  new_modifier(
    operator = "STARTS_WITH",
    value = x
  )
}

#' @rdname modifier
#' @examples
#' ends_with("bar")
#' @export
ends_with <- function(x) {
  check_character(x)
  new_modifier(
    operator = "ENDS_WITH",
    value = x
  )
}

#' @rdname modifier
#' @examples
#' contains("baz")
#' @export
contains <- function(x) {
  check_character(x)
  new_modifier(
    operator = "CONTAINS",
    value = x
  )
}

#' @rdname modifier
#' @examples
#' equal(1000)
#' @export
equal <- function(x) {
  new_modifier(
    operator = "=",
    value = x
  )
}

#' @rdname modifier
#' @examples
#' not_equal(1000)
#' @export
not_equal <- function(x) {
  new_modifier(
    operator = "<>",
    value = x
  )
}

#' @rdname modifier
#' @examples
#' any_of(state.abb[10:15])
#' @export
any_of <- function(x) {
  check_character(x)
  new_modifier(
    operator = "IN",
    value = x
  )
}

#' @rdname modifier
#' @examples
#' none_of(state.abb[1:5])
#' @export
none_of <- function(x) {
  check_character(x)
  new_modifier(
    operator = "NOT+IN",
    value = x
  )
}
