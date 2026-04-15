#' @noRd
base_cms <- S7::new_class(
  "base_cms",
  package = NULL,
  properties = list(
    end = S7::class_character,
    base = S7::new_property(
      S7::class_character,
      getter = function(self) {
        paste0(
          "https://data.cms.gov/data-api/v1/dataset/",
          uuid_cms2(self@end),
          "/data"
        )
      }
    ),
    opts = S7::new_property(
      S7::class_list,
      default = list(size = 5000L, offset = 0L)
    )
  )
)

#' @noRd
base_prov <- S7::new_class(
  "base_prov",
  package = NULL,
  properties = list(
    end = S7::class_character,
    base = S7::new_property(
      S7::class_character,
      getter = function(self) {
        paste0(
          "https://data.cms.gov/provider-data/api/1/datastore/query/",
          uuid_prov2(self@end),
          "/0?"
        )
      }
    ),
    opts = S7::new_property(
      S7::class_list,
      default = list(
        limit = 1500L,
        offset = 0L,
        results = "false",
        count = "false"
      )
    )
  )
)

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
flatten_opts <- function(x) {
  paste0(names(x), "=", unlist_(x), collapse = "&")
}

#' @noRd
opts_prov <- function(
  count = NULL,
  results = NULL,
  limit = NULL,
  offset = NULL
) {
  x <- params(count = count, results = results, limit = limit, offset = offset)

  if (length(x) == 0L) {
    return(NULL)
  }
  flatten_opts(x)
}

#' @noRd
opts_cms <- function(size = NULL, offset = NULL) {
  x <- params(size = size, offset = offset)

  if (length(x) == 0L) {
    return(NULL)
  }
  flatten_opts(x)
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
  flatten_opts(x)
}

#' @noRd
url_str <- function(base, opts = opts(), args = NULL) {
  if (is.null(args) || length(args) == 0L) {
    return(paste0(base, opts))
  }
  paste(paste0(base, opts), args, sep = "&")
}
