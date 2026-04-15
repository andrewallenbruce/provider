#' @noRd
create_offset <- function(n, limit, url) {
  purrr::map_chr(
    offset(n, limit, "seq"),
    function(x) {
      sub_idx(url, x)
    }
  )
}

#' @noRd
opts <- function(
  count = NULL,
  results = NULL,
  schema = NULL,
  size = NULL,
  limit = NULL,
  offset = NULL
) {
  x <- params(
    count = count,
    results = results,
    schema = schema,
    size = size,
    limit = limit,
    offset = offset
  )

  if (length(x) == 0L) {
    return(NULL)
  }

  paste0(names(x), "=", unlist_(x), collapse = "&")
}

#' @noRd
url_str <- function(base, opts = opts(), args = NULL) {
  if (is.null(args) || length(args) == 0L) {
    return(paste0(base, opts))
  }
  paste(paste0(base, opts), args, sep = "&")
}
