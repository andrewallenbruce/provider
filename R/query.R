#' @noRd
plus <- function(x) {
  gsub(" ", "+", x, fixed = TRUE)
}

#' @autoglobal
#' @noRd
format_query <- function(x, N) {
  V <- plus(unlist_(x))

  c(
    paste0("conditions[<<i>>][property]=", plus(N)),
    paste0("conditions[<<i>>][operator]=", if (length(V) > 1L) "IN" else "="),
    paste0("conditions[<<i>>][value]", if (length(V) > 1L) "[]=" else "=", V)
  )
}

#' @autoglobal
#' @noRd
flatten_query <- function(args) {
  purrr::imap(args, format_query) |>
    unname() |>
    purrr::imap_chr(function(x, idx) {
      gsub(x = x, pattern = "<<i>>", replacement = idx - 1, fixed = TRUE) |>
        paste0(collapse = "&")
    }) |>
    (\(x) paste0(x, collapse = "&"))()
}

#' @autoglobal
#' @noRd
format_query2 <- function(x, N) {
  V <- plus(unlist_(x))

  c(
    paste0("filter[<<i>>][condition][path]=", plus(N)),
    paste0(
      "filter[<<i>>][condition][operator]=",
      if (length(V) > 1L) "IN" else "="
    ),
    paste0(
      "filter[<<i>>][condition][value]",
      if (length(V) > 1L) paste0("[", seq_along(V), "]=") else "=",
      V
    )
  )
}

#' @autoglobal
#' @noRd
flatten_query2 <- function(args) {
  purrr::imap(args, format_query2) |>
    unname() |>
    purrr::imap_chr(function(x, idx) {
      gsub(x = x, pattern = "<<i>>", replacement = idx, fixed = TRUE) |>
        paste0(collapse = "&")
    }) |>
    (\(x) paste0(x, collapse = "&"))()
}
