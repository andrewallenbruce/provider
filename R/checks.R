#' @noRd
check_named <- function(x, call = rlang::caller_env()) {
  if (rlang::is_named(x)) {
    cli::cli_abort("Inputs cannot be named.", call = call)
  }
}

#' @noRd
check_online <- function() {
  if (!httr2::is_online()) {
    cli::cli_abort(c(
      "You are not online.",
      "i" = "Check your internet connection."
    ))
  }
}

#' @noRd
check_numeric <- function(x) {
  if (!rlang::is_bare_numeric(x)) {
    cli::cli_abort(c(
      "{.arg x} must be a numeric vector, not {.obj_type_friendly {x}}"
    ))
  }
}

#' @noRd
check_subgroups <- function(x) {
  if (!is_subgroups(x)) {
    cli::cli_abort(c(
      "{.arg subgroup} must be a {.cls subgroups} object, not a {.cls {class(x)}}",
      "i" = "Use the {.fn subgroups} helper function"
    ))
  }
}

#' @noRd
check_modifiers <- function(x, end, call = call) {
  if (any2(purrr::map_lgl(x, is_modifier))) {
    if (any2(unlist_(x) %in_% c("ENDS WITH", "NOT+IN"))) {
      cli::cli_abort("{.fn ends_with} & {.fn excludes} cannot be used in {.fn {end}}.", call = call)
    }
  }
}
