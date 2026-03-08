#' @autoglobal
#' @noRd
parameters <- function(...) {
  purrr::compact(rlang::list2(...))
}

#' @autoglobal
#' @noRd
set_opts <- function(...) {
  x <- rlang::list2(...)
  paste0(names(x), "=", unlist_(x), collapse = "&")
}

#' @autoglobal
#' @noRd
flatten_url <- function(base, opts, query = NULL) {
  if (is.null(query)) {
    paste0(base, opts)
  } else {
    paste(paste0(base, opts), query, sep = "&")
  }
}

#' Generate API Offset Sequence & Size
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
base_url <- function(set) {
  a <- "https://data.cms.gov/"
  p <- \(id) paste0(a, "provider-data/api/1/datastore/query/", id, "/0?")
  m <- \(id) paste0(a, "data-api/v1/dataset/", id, "/data")
  switch(
    set,
    affiliations = p("27ea-46a8"),
    clinicians = p("mj5m-pzi6"),
    providers = m("2457ea29-fc82-48b0-86ec-3b0755de7515"),
    opt_out = m("9887a515-7552-4693-bf58-735c77af46d7"),
    order_refer = m("c99b5865-1119-4436-bb80-c5af2773ea1f"),
    hospitals = m("f6f6505c-e8b0-4d57-b258-e2b94133aaf2"),
    laboratories = m("d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16"),
    reassignments = m("20f51cff-4137-4f3a-b6b7-bfc9ad57983b"),
    cli::cli_abort("{.arg set} not recognized")
  )
}

#' @autoglobal
#' @noRd
limit <- function(set) {
  switch(
    set,
    affiliations = ,
    clinicians = 1500,
    providers = ,
    opt_out = ,
    order_refer = ,
    hospitals = ,
    laboratories = ,
    reassignments = 5000,
    cli::cli_abort("{.arg set} not recognized")
  )
}
