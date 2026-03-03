#' @autoglobal
#' @noRd
flatten_query <- function(args) {
  purrr::imap(args, function(x, N) {
    V <- gsub(" ", "+", unlist_(x), fixed = TRUE)
    O <- if (length(V) > 1L) "IN" else "="
    N <- gsub(" ", "+", N, fixed = TRUE)

    c(
      paste0("conditions[<<i>>][property]=", N),
      paste0("conditions[<<i>>][operator]=", O),
      `if`(
        length(V) > 1L,
        # paste0("conditions[<<i>>][value][", seq_along(V), "]=", V),
        paste0("conditions[<<i>>][value][]=", V),
        paste0("conditions[<<i>>][value]=", V)
      )
    )
  }) |>
    unname() |>
    purrr::imap_chr(function(x, idx) {
      gsub(x = x, pattern = "<<i>>", replacement = idx - 1, fixed = TRUE) |>
        paste0(collapse = "&")
    }) |>
    (\(x) paste0(x, collapse = "&"))()
}

#' @autoglobal
#' @noRd
compact_list <- function(...) {
  purrr::compact(list(...))
}

#' @autoglobal
#' @noRd
flatten_opts <- function(x) {
  paste0(names(x), "=", unlist_(x), collapse = "&")
}

#' @autoglobal
#' @noRd
flatten_url <- function(base, opts, query) {
  paste(paste0(base, opts), query, sep = "&")
}
