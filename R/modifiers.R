#' @rdname modifier
#' @param operator input
#' @param value input
#' @keywords internal
#' @export
new_modifier <- function(operator, value) {
  structure(
    list(
      operator = operator,
      value = value
    ),
    class = "modifier"
  )
}

#' @rdname modifier
#' @keywords internal
#' @export
is_modifier <- function(x) {
  inherits(x, "modifier")
}

#' @export
print.modifier <- function(x, ...) {
  cli::cli_text(cli::col_cyan("<modifier>"))
  cli::cli_text(c(cli::col_silver("Operator: "), cli::col_red(x$operator)))
  cli::cli_text(
    c(
      if (is.numeric(x$value) & length(x$value) > 1L) {
        cli::col_silver("{cli::qty(as.character(x$value))}Value{?s}: ")
        } else {
          cli::col_silver("{cli::qty(x$value)}Value{?s}: ")
          },
      cli::col_yellow("{x$value}")
      )
    )
}

#' Query Modifiers
#'
#' @description
#' Helpers for use in constructing conditions in queries.
#'
#' @details
#' Query modifiers are a small DSL for use in constructing query conditions,
#' in the [JSON-API](https://www.drupal.org/docs/core-modules-and-themes/core-modules/jsonapi-module/filtering) format.
#'
#' @param x,y input
#' @param or_equal `<lgl>` append `=`
#' @param negate `<lgl>` prepend `NOT`
#' @name modifier
#' @returns An object of class `<modifier>`
NULL

#' @rdname modifier
#' @examples
#' greater_than(1000)
#' greater_than(0.125, or_equal = TRUE)
#' @autoglobal
#' @export
greater_than <- function(x, or_equal = FALSE) {
  new_modifier(
    operator = ifelse(!or_equal, ">", ">="),
    value = x
  )
}

#' @rdname modifier
#' @examples
#' less_than(1000)
#' less_than(0.125, or_equal = TRUE)
#' @autoglobal
#' @export
less_than <- function(x, or_equal = FALSE) {
  new_modifier(
    operator = ifelse(!or_equal, "<", "<="),
    value = x
  )
}

#' @rdname modifier
#' @examples
#' between(1000, 1100)
#' between(0.125, 2, negate = TRUE)
#' @autoglobal
#' @export
between <- function(x, y, negate = FALSE) {
  if (x >= y) {
    cli::cli_abort("{.arg x} must be less than {.arg y}.", call. = FALSE)
  }

  new_modifier(
    operator = ifelse(!negate, "BETWEEN", "NOT+BETWEEN"),
    value = c(x, y)
  )
}

#' @rdname modifier
#' @examples
#' starts_with("foo")
#' @autoglobal
#' @export
starts_with <- function(x) {

  new_modifier(
    operator = "STARTS_WITH",
    value = x
  )
}

#' @rdname modifier
#' @examples
#' ends_with("bar")
#' @autoglobal
#' @export
ends_with <- function(x) {
  new_modifier(
    operator = "ENDS_WITH",
    value = x
  )
}

#' @rdname modifier
#' @examples
#' contains("baz")
#' @autoglobal
#' @export
contains <- function(x) {
  new_modifier(
    operator = "CONTAINS",
    value = x
  )
}

#' @rdname modifier
#' @examples
#' equals(1000)
#' equals(1000, negate = TRUE)
#' @autoglobal
#' @export
equals <- function(x, negate = FALSE) {
  new_modifier(
    operator = ifelse(!negate, "=", "<>"),
    value = x
  )
}

#' @rdname modifier
#' @examples
#' any_of(state.abb[10:15])
#' any_of(state.abb[10:15], negate = TRUE)
#' @autoglobal
#' @export
any_of <- function(x, negate = FALSE) {
  new_modifier(
    operator = ifelse(!negate, "IN", "NOT+IN"),
    value = x
  )
}
