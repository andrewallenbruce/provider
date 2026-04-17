#' @noRd
check_unnamed <- function(x, arg = caller_arg(x), call = caller_env()) {
  if (any2(rlang::have_name(x))) {
    cli::cli_abort("Inputs cannot be named.", arg = arg, call = call)
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
check_numeric <- function(
  x,
  ...,
  allow_null = FALSE,
  arg = caller_arg(x),
  call = caller_env()
) {
  if (!missing(x)) {
    if (rlang::is_bare_numeric(x)) {
      return(invisible(NULL))
    }
    if (allow_null && is_null(x)) {
      return(invisible(NULL))
    }
  }

  rlang::stop_input_type(
    x,
    "a numeric vector",
    ...,
    allow_null = allow_null,
    arg = arg,
    call = call
  )
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

# check_modifiers(param_prov(ccn = excludes("ASGSAH")), "add")
#' @noRd
check_modifiers <- function(x, end) {
  if (any2(purrr::map_lgl(x, is_modifier))) {
    if (any2(unlist_(x) %in% c("ENDS WITH", "NOT+IN"))) {
      cli::cli_abort(
        c("Invalid {.cls modifier} usage: ",
          "x" = "{.fn ends_with} & {.fn excludes} cannot be used with {.fn {end}}."),
        call = call2(end)
      )
    }
  }
}

# param_prov(ccn = excludes("ASGSAH", not_na()))
#' @noRd
check_not_modifier <- function(x, arg = caller_arg(x), call = caller_env()) {
  if (any2(purrr::map_lgl(x, is_modifier))) {
    cli::cli_abort(
      "A {.cls modifier} cannot be an input to another {.cls modifier}.",
      arg = arg,
      call = call
    )
  }
}
