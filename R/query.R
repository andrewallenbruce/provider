#' @noRd
is_modifier <- function(x) {
  S7_inherits(x, Modifier)
}

#' @noRd
preprocess <- function(x) {
  V <- if (is_modifier(x)) {
    plus(x@value)
  } else {
    plus(unlist_(x))
  }

  O <- if (is_modifier(x)) {
    x@operator
  } else if (length(V) > 1L) {
    "IN"
  } else {
    "="
  }

  list(V = V, O = O)
}

#' @noRd
query <- function(api, x, N) {
  x <- preprocess(x)

  switch(
    api,
    pdc = c(
      paste0("conditions[<<i>>][property]=", plus(N)),
      paste0("conditions[<<i>>][operator]=", tolower(plus(x$O))),
      paste0(
        "conditions[<<i>>][value]",
        if (length(x$V) > 1L) "[]=" else "=",
        x$V
      )
    ),
    cms = c(
      paste0("filter[<<i>>][condition][path]=", plus(N)),
      paste0("filter[<<i>>][condition][operator]=", under(x$O)),
      paste0(
        "filter[<<i>>][condition][value]",
        if (length(x$V) > 1L) paste0("[", seq_along(x$V), "]=") else "=",
        x$V
      )
    )
  )
}

#' @noRd
flatten_query <- function(x) {
  unname(x) |>
    purrr::imap_chr(\(x, i) {
      paste0(sub_idx(x, i - 1L), collapse = "&")
    }) |>
    (\(x) paste0(x, collapse = "&"))()
}

#' @noRd
params <- function(...) {
  purrr::compact(rlang::list2(...))
}

#' @noRd
method(build, ParamCMS) <- function(x) {
  S7_data(x) %0% return(NULL)

  S7_data(x) |>
    purrr::imap(\(x, n) query("cms", x, n)) |>
    flatten_query()
}

#' @noRd
method(build, ParamPDC) <- function(x) {
  S7_data(x) %0% return(NULL)

  S7_data(x) |>
    purrr::imap(\(x, n) query("pdc", x, n)) |>
    flatten_query()
}
