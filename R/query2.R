#' @noRd
get_values <- function(x) {
  if (is_modifier(x)) {
    return(plus(x@value))
  }
  plus(unlist_(x))
}

#' @noRd
get_operators <- function(x) {
  if (is_modifier(x)) {
    return(x@operator)
  }
  if (length(unlist_(x)) > 1L) "IN" else "="
}

#' @noRd
build2 <- new_generic("build2", "x")

#' @noRd
method(build2, ParamCMS) <- function(x) {
  S7_data(x) %0% return(NULL)

  S7_data(x) |>
    purrr::imap(
      \(x, N) {
        V <- get_values(x)
        c(
          paste0("filter[<<i>>][condition][path]=", plus(N)),
          paste0(
            "filter[<<i>>][condition][operator]=",
            under(get_operators(x))
          ),
          paste0(
            "filter[<<i>>][condition][value]",
            if (length(V) > 1L) paste0("[", seq_along(V), "]=") else "=",
            V
          )
        )
      }
    ) |>
    QueryCMS()
}

#' @noRd
method(build2, ParamPDC) <- function(x) {
  S7_data(x) %0% return(NULL)

  S7_data(x) |>
    purrr::imap(
      \(x, N) {
        V <- get_values(x)
        c(
          paste0("conditions[<<i>>][property]=", plus(N)),
          paste0(
            "conditions[<<i>>][operator]=",
            tolower(plus(get_operators(x)))
          ),
          paste0(
            "conditions[<<i>>][value]",
            if (length(V) > 1L) "[]=" else "=",
            V
          )
        )
      }
    ) |>
    QueryPDC()
}

#' @noRd
index <- new_generic("index", "x")

#' @noRd
method(index, Query) <- function(x) {
  S7_data(x) |>
    unname() |>
    purrr::imap_chr(\(x, i) {
      paste0(sub_idx(x, i - 1L), collapse = "&")
    }) |>
    set_names2(S7_data(x))
}

#' @noRd
flatten <- new_generic("flatten", "x")

#' @noRd
method(flatten, class_any) <- function(x) {
  NULL
}

#' @noRd
method(flatten, Query) <- function(x) {
  S7_data(x) |>
    unname() |>
    purrr::imap_chr(\(x, i) {
      paste0(sub_idx(x, i - 1L), collapse = "&")
    }) |>
    (\(x) paste0(x, collapse = "&"))()
}
