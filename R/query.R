#' @noRd
plus <- function(x) {
  gsub(" ", "+", x, fixed = TRUE)
}

#' @noRd
format_query <- function(x, N) {
  MOD <- is_modifier(x)
  V <- if (MOD) plus(x$value) else plus(unlist_(x))
  O <- if (MOD) {
    tolower(plus(gsub("_", " ", x$operator, fixed = TRUE)))
  } else if (length(V) > 1L) {
    "IN"
  } else {
    "="
  }

  PRP <- "conditions[<<i>>][property]="
  OPR <- "conditions[<<i>>][operator]="
  VAL <- "conditions[<<i>>][value]"

  c(
    paste0(PRP, plus(N)),
    paste0(OPR, O),
    paste0(VAL, if (length(V) > 1L) "[]=" else "=", V)
  )
}

#' @noRd
format_query2 <- function(x, N) {
  MOD <- is_modifier(x)
  V <- if (MOD) plus(x$value) else plus(unlist_(x))
  O <- if (MOD) {
    plus(x$operator)
  } else if (length(V) > 1L) {
    "IN"
  } else {
    "="
  }

  PRP <- "filter[<<i>>][condition][path]="
  OPR <- "filter[<<i>>][condition][operator]="
  VAL <- "filter[<<i>>][condition][value]"

  c(
    paste0(PRP, plus(N)),
    paste0(OPR, O),
    paste0(
      VAL,
      if (length(V) > 1L) paste0("[", seq_along(V), "]=") else "=",
      V
    )
  )
}

#' @noRd
query <- function(args) {
  purrr::imap(args, format_query) |>
    unname() |>
    purrr::imap_chr(function(x, idx) {
      gsub(x = x, pattern = "<<i>>", replacement = idx - 1, fixed = TRUE) |>
        paste0(collapse = "&")
    }) |>
    (\(x) paste0(x, collapse = "&"))()
}

#' @noRd
query2 <- function(args) {
  purrr::imap(args, format_query2) |>
    unname() |>
    purrr::imap_chr(function(x, idx) {
      gsub(x = x, pattern = "<<i>>", replacement = idx, fixed = TRUE) |>
        paste0(collapse = "&")
    }) |>
    (\(x) paste0(x, collapse = "&"))()
}
