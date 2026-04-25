#' @noRd
URL_PROV <- c(
  "https://data.cms.gov/provider-data/api/1/datastore/query/",
  "/0?"
)

#' @noRd
base_prov <- S7::new_class(
  "base_prov",
  package = NULL,
  properties = list(
    end = S7::class_character,
    limit = S7::new_property(S7::class_integer, default = 1500L),
    url = S7::new_property(
      S7::class_character,
      getter = function(self) {
        paste0(URL_PROV[1], uuid_prov(self@end), URL_PROV[2])
      }
    )
  )
)

#' @noRd
S7::method(req_total, base_prov) <- function(x) {
  flatten_url(x@url, opts = opts_prov(results = "false")) |>
    base_request(query = "count")
}

#' @noRd
S7::method(req_count, base_prov) <- function(x, args = NULL) {
  flatten_url(x@url, args, opts_prov(results = "false")) |>
    base_request(query = "count")
}

#' @noRd
S7::method(req_empty, base_prov) <- function(x) {
  cli_no_query(x@end)
  flatten_url(x@url, opts = opts_prov(limit = 10L)) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_single, base_prov) <- function(x, args = NULL) {
  flatten_url(x@url, args, opts_prov()) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_multi, base_prov) <- function(x, args = NULL, count = NULL) {
  flatten_url(x@url, args, opts_prov(offset = "<<i>>")) |>
    offset2(count, x@limit) |>
    parallel_request(query = "results")
}
