#' @include base-generics.R

#' @noRd
URL_CMS <- c("https://data.cms.gov/data-api/v1/dataset/", "/data")

#' @noRd
arg_cms <- S7::new_class("arg_cms", S7::class_list, NULL)

#' @noRd
base_cms <- S7::new_class(
  "base_cms",
  package = NULL,
  properties = list(
    end = S7::class_character,
    url = S7::new_property(
      S7::class_character,
      getter = function(self) {
        paste0(URL_CMS[1], uuid_cms(self@end), URL_CMS[2])
      }
    ),
    count = S7::class_logical,
    set = S7::class_logical,
    limit = S7::new_property(S7::class_integer, default = 5000L),
    arg = arg_cms,
    query = S7::new_property(S7::class_character, getter = function(self) {
      if (length(self@arg) != 0L) build(self@arg)
    }),
    N = S7::new_property(S7::class_integer, getter = function(self) {
      url <- paste0(self@url, "/stats?")
      if (self@set || (self@count && !length(self@arg))) {
        return(base_request(flatten_url(url), "total_rows"))
      }
      if (self@count || length(self@arg)) {
        return(base_request(flatten_url(url, self@query), "found_rows"))
      }
    })
  )
)

#' @noRd
S7::method(req_empty, base_cms) <- function(x) {
  cli_empty(x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = NULL,
    opts = opts_cms(size = 10L)
  ) |>
    base_request()
}

#' @noRd
S7::method(req_single, base_cms) <- function(x) {
  cli_results(x@N, x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = x@query,
    opts = opts_cms()
  ) |>
    base_request()
}

#' @noRd
S7::method(req_multi, base_cms) <- function(x) {
  cli_pages(x@N, x@limit, x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = x@query,
    opts = opts_cms(offset = "<<i>>")
  ) |>
    base_parallel(
      cnt = x@N,
      lmt = x@limit
    )
}

#' @noRd
S7::method(req_set, base_cms) <- function(x) {
  cli_pages(x@N, x@limit, x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = NULL,
    opts = opts_cms(offset = "<<i>>")
  ) |>
    base_parallel(
      cnt = x@N,
      lmt = x@limit
    )
}
