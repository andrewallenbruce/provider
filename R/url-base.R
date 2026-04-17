#' @noRd
base_cms <- S7::new_class(
  "base_cms",
  package = NULL,
  properties = list(
    end = S7::class_character,
    url = S7::new_property(
      S7::class_character | S7::class_list,
      getter = function(self) {
        uid <- uuid_cms2(self@end)
        url <- paste0("https://data.cms.gov/data-api/v1/dataset/", uid, "/data")
        if (is_list(uid)) set_names(as.list(url), names2(uid)) else url
      }
    ),
    limit = S7::new_property(
      S7::class_integer,
      default = 5000L
    )
  )
)

#' @noRd
base_prov <- S7::new_class(
  "base_prov",
  package = NULL,
  properties = list(
    end = S7::class_character,
    url = S7::new_property(
      S7::class_character,
      getter = function(self) {
        paste0(
          "https://data.cms.gov/provider-data/api/1/datastore/query/",
          uuid_prov2(self@end),
          "/0?"
        )
      }
    ),
    limit = S7::new_property(
      S7::class_integer,
      default = 1500L
    )
  )
)

#' @noRd
req_count <- S7::new_generic("req_count", "x")

#' @noRd
req_empty <- S7::new_generic("req_empty", "x")

#' @noRd
req_single <- S7::new_generic("req_single", "x")

#' @noRd
req_multi <- S7::new_generic("req_multi", "x")

#' @noRd
S7::method(req_count, base_cms) <- function(x, args = NULL) {
  url <- flatten_url(paste0(x@url, "/stats?"), args)
  if (length(url) > 1L) {
    purrr::map_int(url, base_request, query = "found_rows") |>
      set_names(names2(x@url))
  } else {
    base_request(url, query = "found_rows")
  }
}

#' @noRd
S7::method(req_count, base_prov) <- function(x, args = NULL) {
  flatten_url(x@url, args, opts_prov(count = "true", results = "false")) |>
    base_request(query = "count")
}

#' @noRd
S7::method(req_empty, base_cms) <- function(x) {
  cli_no_query(x@end)
  url <- flatten_url(paste0(x@url, "?"), opts = opts_cms(size = 10L))
  if (length(url) > 1L) {
    purrr::map(url, base_request) |>
      set_names(names2(x@url))
  } else {
    base_request(url)
  }
}

#' @noRd
S7::method(req_empty, base_prov) <- function(x) {
  cli_no_query(x@end)
  flatten_url(x@url, opts = opts_prov(limit = 10L)) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_single, base_cms) <- function(x, args = NULL) {
  url <- flatten_url(paste0(x@url, "?"), args, opts_cms())
  if (length(url) > 1L) {
    purrr::map(url, base_request) |>
      set_names(names2(x@url))
  } else {
    base_request(url)
  }
}

#' @noRd
S7::method(req_single, base_prov) <- function(x, args = NULL) {
  flatten_url(x@url, args, opts_prov()) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_multi, base_cms) <- function(x, args = NULL, count) {
  url <- flatten_url(paste0(x@url, "?"), args, opts_cms(offset = "<<i>>"))
  if (length(url) > 1L) {
    purrr::map2(url, count, \(y, z) offset2(y, z, x@limit)) |>
      purrr::map(parallel_request) |>
      set_names(names2(x@url))
  } else {
    offset2(url, count, x@limit) |>
      parallel_request()
  }
}

#' @noRd
S7::method(req_multi, base_prov) <- function(x, args = NULL, count) {
  flatten_url(x@url, args, opts_prov(offset = "<<i>>")) |>
    offset2(count, x@limit) |>
    parallel_request(query = "results")
}
