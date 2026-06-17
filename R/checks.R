#' @noRd
count_set <- function(count, set, call = rlang::caller_env()) {
  rlang::check_bool(count)
  rlang::check_bool(set)
  if (count && set) {
    cli::cli_abort(
      "Exactly {.emph one} of {.arg count} or {.arg set} can be set to {.val TRUE}.",
      call = call
    )
  }
  if (count) {
    return("count")
  }
  if (set) {
    return("set")
  }
  return("")
}

#' @noRd
check_online <- function(call = rlang::caller_env()) {
  if (!httr2::is_online()) {
    cli::cli_abort(
      c(
        "You are not online.",
        "i" = "Check your internet connection."
      ),
      call = call
    )
  }
}

#' @noRd
check_key <- function(
  x,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (!is_key(x)) {
    cli::cli_abort(
      "{.arg {arg}} must be a {.cls {Key}} object, not {.obj_type_friendly {x}}",
      arg = arg,
      call = call
    )
  }
}

#' @noRd
check_named <- function(x, call = rlang::caller_env()) {
  if (!rlang::is_empty(x) && !all2(rlang::have_name(x))) {
    cli::cli_abort(
      "All arguments of {.obj_type_friendly {x}} must be named",
      call = call
    )
  }
}

#' @noRd
check_bool_ <- function(
  x,
  ...,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (is.null(x)) {
    return(invisible(NULL))
  }
  rlang::check_bool(
    x,
    ...,
    allow_na = FALSE,
    allow_null = TRUE,
    arg = arg,
    call = call
  )
}

#' @noRd
check_char_ <- function(
  x,
  ...,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (is.null(x)) {
    return(invisible(NULL))
  }

  if (!is_modifier(x)) {
    check_character(
      x,
      ...,
      allow_na = FALSE,
      allow_null = TRUE,
      arg = arg,
      call = call
    )
  }
}

#' @noRd
check_numeric <- function(
  x,
  ...,
  allow_null = TRUE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (is.null(x)) {
    return(invisible(NULL))
  }

  if (!is_modifier(x)) {
    if (!missing(x)) {
      if (rlang::is_bare_numeric(x)) {
        return(invisible(NULL))
      }
      if (allow_null && rlang::is_null(x)) {
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
}

#' @noRd
check_atomic <- function(
  x,
  ...,
  allow_null = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (!missing(x)) {
    if (rlang::is_bare_atomic(x)) {
      return(invisible(NULL))
    }
    if (allow_null && rlang::is_null(x)) {
      return(invisible(NULL))
    }
  }

  rlang::stop_input_type(
    x,
    "an atomic vector",
    ...,
    allow_null = allow_null,
    arg = arg,
    call = call
  )
}
