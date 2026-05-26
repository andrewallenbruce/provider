#' @noRd
count_set <- function(count, set, call = caller_env()) {
  check_bool(count)
  check_bool(set)
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
check_online <- function(call = caller_env()) {
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
check_bool_ <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  check_bool(
    x,
    ...,
    allow_na = FALSE,
    allow_null = TRUE,
    arg = arg,
    call = call
  )
}

#' @noRd
check_char_ <- function(x, ..., arg = caller_arg(x), call = caller_env()) {
  check_character(
    x,
    ...,
    allow_na = TRUE,
    allow_null = TRUE,
    arg = arg,
    call = call
  )
}

#' @noRd
check_numeric <- function(
  x,
  ...,
  allow_null = TRUE,
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
check_atomic <- function(
  x,
  ...,
  allow_null = FALSE,
  arg = caller_arg(x),
  call = caller_env()
) {
  if (!missing(x)) {
    if (rlang::is_bare_atomic(x)) {
      return(invisible(NULL))
    }
    if (allow_null && is_null(x)) {
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
