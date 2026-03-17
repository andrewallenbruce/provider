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
  if (
    collapse::anyv(purrr::map_lgl(x, is_modifier), TRUE) &&
      collapse::anyv(unlist_(x) %in_% c("ENDS WITH", "NOT+IN"), TRUE)
  ) {
    cli::cli_abort(
      message = c(
        "{.fn ends_with} & {.fn none_of} cannot be used in {.fn {end}}."
      ),
      call = call
    )
  }
}
