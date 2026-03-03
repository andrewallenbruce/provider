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
