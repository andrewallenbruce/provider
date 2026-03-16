#' @noRd
plus <- function(x) {
  gsub(" ", "+", x, fixed = TRUE)
}

#' @noRd
under <- function(x) {
  gsub(" ", "_", x, fixed = TRUE)
}

#' @noRd
format_query_pro <- function(x, N) {
  V <- if (is_modifier(x)) {
    plus(x@value)
  } else {
    plus(unlist_(x))
  }

  O <- if (is_modifier(x)) {
    tolower(plus(S7::S7_data(x)))
  } else if (length(V) > 1L) {
    "IN"
  } else {
    "="
  }

  property <- "conditions[<<i>>][property]="
  operator <- "conditions[<<i>>][operator]="
  value <- "conditions[<<i>>][value]"
  index <- if (length(V) > 1L) "[]=" else "="

  c(
    paste0(property, plus(N)),
    paste0(operator, O),
    paste0(value, index, V)
  )
}

#' @noRd
format_query_cms <- function(x, N) {
  V <- if (is_modifier(x)) {
    plus(x@value)
  } else {
    plus(unlist_(x))
  }

  O <- if (is_modifier(x)) {
    under(S7::S7_data(x))
  } else if (length(V) > 1L) {
    "IN"
  } else {
    "="
  }

  property <- "filter[<<i>>][condition][path]="
  operator <- "filter[<<i>>][condition][operator]="
  value <- "filter[<<i>>][condition][value]"
  index <- if (length(V) > 1L) paste0("[", seq_along(V), "]=") else "="

  c(
    paste0(property, plus(N)),
    paste0(operator, O),
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
