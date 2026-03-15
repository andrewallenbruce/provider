#' @noRd
offset <- function(n, limit, which = "size") {
  if (n == 0L) {
    return(0L)
  }

  if (n <= limit) {
    return(switch(
      which,
      size = 1L,
      seq = 0L
    ))
  }

  switch(
    which,
    size = cheapr::seq_size(from = 0L, to = n, by = limit),
    seq = cheapr::seq_(from = 0L, to = n, by = limit)
  )
}

#' @noRd
create_offset <- function(n, limit, url) {
  offset(n, limit, "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = url, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })
}

#' @noRd
params <- function(...) {
  purrr::compact(rlang::list2(...))
}

#' @noRd
opts <- function(
  count = NULL,
  results = NULL,
  schema = NULL,
  size = NULL,
  limit = NULL,
  offset = 0
) {
  x <- params(
    count = count,
    results = results,
    schema = schema,
    size = size,
    limit = limit,
    offset = offset
  )
  paste0(names(x), "=", unlist_(x), collapse = "&")
}

#' @noRd
url_ <- function(base, opts, query = NULL) {
  if (is.null(query)) {
    return(paste0(base, opts))
  }
  paste(paste0(base, opts), query, sep = "&")
}

#' @noRd
limit <- function(endpoint) {
  switch(
    endpoint,
    affiliations = ,
    clinicians = 1500L,
    5000L
  )
}

#' @noRd
constants <- function(endpoint) {
  list(
    url = uuid(endpoint),
    limit = limit(endpoint),
    names = column_renames(endpoint)
  )
}
