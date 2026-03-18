#' @noRd
fmt_mod <- function(x) {
  M <- is_modifier(x)
  V <- if (M) plus(value(x)) else plus(unlist_(x))
  O <- if (M) {
    operator(x)
  } else if (length(V) > 1L) {
    "IN"
  } else {
    "="
  }
  list(V = V, O = O)
}

#' @autoglobal
#' @noRd
format_query_pro <- function(x, N) {
  .c(V, O) %=% fmt_mod(x)

  property <- "conditions[<<i>>][property]="
  operator <- "conditions[<<i>>][operator]="
  value <- "conditions[<<i>>][value]"
  index <- if (length(V) > 1L) "[]=" else "="

  c(
    paste0(property, plus(N)),
    paste0(operator, tolower(plus(O))),
    paste0(value, index, V)
  )
}

#' @autoglobal
#' @noRd
format_query_cms <- function(x, N) {
  .c(V, O) %=% fmt_mod(x)

  property <- "filter[<<i>>][condition][path]="
  operator <- "filter[<<i>>][condition][operator]="
  value <- "filter[<<i>>][condition][value]"
  index <- if (length(V) > 1L) paste0("[", seq_along(V), "]=") else "="

  c(
    paste0(property, plus(N)),
    paste0(operator, under(O)),
    paste0(value, index, V)
  )
}

#' @noRd
query_pro <- function(args) {
  purrr::imap(args, format_query_pro) |>
    unname() |>
    purrr::imap_chr(function(x, idx) {
      gsub(x = x, pattern = "<<i>>", replacement = idx - 1, fixed = TRUE) |>
        paste0(collapse = "&")
    }) |>
    (\(x) paste0(x, collapse = "&"))()
}

#' @noRd
query_cms <- function(args) {
  purrr::imap(args, format_query_cms) |>
    unname() |>
    purrr::imap_chr(function(x, idx) {
      gsub(x = x, pattern = "<<i>>", replacement = idx, fixed = TRUE) |>
        paste0(collapse = "&")
    }) |>
    (\(x) paste0(x, collapse = "&"))()
}

#' @noRd
query <- function(endpoint, args) {
  switch(
    endpoint,
    affiliations = ,
    clinicians = query_pro(args),
    query_cms(args)
  )
}
