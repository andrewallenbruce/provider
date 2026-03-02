#' Generate API Request "Offset" Sequence
#'
#' @param n  `<int>` Number of results in an API request
#' @param limit `<int>` API rate limit
#' @param which `<chr>` Return type, `"seq"` or `"size"` (default)
#' @returns Depending on inputs:
#'    * if `n` == `0`: returns `0`
#'    * if `n` <= `limit`: returns `n`
#'    * if `n` > `limit` and:
#'       * `which` = `"seq"`: sequence `0:n` by `limit`, of length `ceiling(n / limit)`.
#'       * `which` = `"size"`: length of sequence.
#'
#' @examplesIf interactive()
#' offset(n = 100, limit = 10, which = "size")
#' offset(n = 100, limit = 10, which = "seq")
#'
#' offset(n = 10, limit = 100, which = "size")
#' offset(n = 10, limit = 100, which = "seq")
#'
#' offset(n = 47984, limit = 5000, which = "size")
#' offset(n = 47984, limit = 5000, which = "seq")
#'
#' offset(n = 147984, limit = 1500, which = "size")
#' offset(n = 147984, limit = 1500, which = "seq")
#' @autoglobal
#' @noRd
offset <- function(n, limit, which = "size") {
  if (n == 0L) {
    return(0L)
  }

  switch(
    which,
    size = cheapr::seq_size(from = 0L, to = n, by = limit),
    seq = cheapr::seq_(from = 0L, to = n, by = limit)
  )
}

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
