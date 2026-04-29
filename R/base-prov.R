#' @noRd
URL_PROV <- c(
  "https://data.cms.gov/provider-data/api/1/datastore/query/",
  "/0?"
)

#' @noRd
arg_prov <- S7::new_class("arg_prov", S7::class_list, NULL)

#' @noRd
base_prov <- S7::new_class(
  "base_prov",
  package = NULL,
  properties = list(
    end = S7::class_character,
    url = S7::new_property(
      S7::class_character,
      getter = function(self) {
        paste0(URL_PROV[1], uuid_prov(self@end), URL_PROV[2])
      }
    ),
    count = S7::class_logical,
    set = S7::class_logical,
    limit = S7::new_property(S7::class_integer, default = 1500L),
    arg = arg_prov,
    query = S7::new_property(S7::class_character, getter = function(self) {
      if (length(self@arg) != 0L) build(self@arg)
    }),
    N = S7::new_property(S7::class_integer, getter = function(self) {
      if (self@set || (self@count && !length(self@arg))) {
        return(
          flatten_url(self@url, opts = opts_prov(results = "false")) |>
            base_request(query = "count")
        )
      }
      if (self@count || length(self@arg)) {
        return(
          flatten_url(self@url, self@query, opts_prov(results = "false")) |>
            base_request(query = "count")
        )
      }
    })
  )
)

#' @noRd
S7::method(req_empty, base_prov) <- function(x) {
  cli_empty(x@end)
  flatten_url(x@url, opts = opts_prov(limit = 10L)) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_single, base_prov) <- function(x) {
  cli_results(x@N, x@end)
  flatten_url(x@url, x@query, opts_prov()) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_multi, base_prov) <- function(x) {
  cli_pages(x@N, x@limit, x@end)
  flatten_url(x@url, x@query, opts_prov(offset = "<<i>>")) |>
    offset2(x@N, x@limit) |>
    parallel_request(query = "results")
}

#' @noRd
S7::method(req_set, base_prov) <- function(x) {
  cli_pages(x@N, x@limit, x@end)
  flatten_url(x@url, opts = opts_prov(offset = "<<i>>")) |>
    offset2(x@N, x@limit) |>
    parallel_request(query = "results")
}
