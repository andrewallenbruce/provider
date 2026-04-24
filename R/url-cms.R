#' @noRd
URL_CMS <- c("https://data.cms.gov/data-api/v1/dataset/", "/data")

#' @noRd
base_cms <- S7::new_class(
  "base_cms",
  package = NULL,
  properties = list(
    end = S7::class_character,
    limit = S7::new_property(S7::class_integer, default = 5000L),
    url = S7::new_property(
      S7::class_character | S7::class_list,
      getter = function(self) {
        uid <- uuid_cms(self@end)
        url <- paste0(URL_CMS[1], uid, URL_CMS[2])
        if (rlang::is_list(uid)) set_names2(as.list(url), uid) else url
      }
    ),
    mult = S7::new_property(
      S7::class_logical,
      getter = function(self) length(self@url) > 1L
    )
  )
)


#' @noRd
multi_total <- function(url, nm, qry) {
  purrr::map_int(url, base_request, query = qry) |>
    set_names2(nm)
}

#' @noRd
S7::method(req_total, base_cms) <- function(x) {
  url <- flatten_url(paste0(x@url, "/stats?"))

  if (x@mult) {
    return(multi_total(url, x@url, "total_rows"))
  }
  base_request(url, "total_rows")
}

#' @noRd
S7::method(req_count, base_cms) <- function(x, args = NULL) {
  url <- flatten_url(paste0(x@url, "/stats?"), args)

  if (x@mult) {
    return(multi_total(url, x@url, "found_rows"))
  }
  base_request(url, "found_rows")
}

#' @noRd
S7::method(req_empty, base_cms) <- function(x, id = NULL) {
  cli_no_query(x@end)

  url <- flatten_url(paste0(x@url, "?"), opts = opts_cms(size = 10L))

  if (length(url) > 1L) {
    purrr::map(url, base_request) |>
      set_names2(x@url) |>
      rowbind2(nm = id, fill = TRUE)
  } else {
    base_request(url)
  }
}

#' @noRd
S7::method(req_single, base_cms) <- function(x, args = NULL, id = NULL) {
  url <- flatten_url(paste0(x@url, "?"), args, opts_cms())

  if (length(url) > 1L) {
    purrr::map(url, base_request) |>
      set_names2(x@url) |>
      rowbind2(nm = id)
  } else {
    base_request(url)
  }
}

#' @noRd
S7::method(req_multi, base_cms) <- function(
  x,
  args = NULL,
  count = NULL,
  id = NULL
) {
  url <- flatten_url(paste0(x@url, "?"), args, opts_cms(offset = "<<i>>"))

  if (length(url) > 1L) {
    offset3(url, count, x@limit) |>
      purrr::map(parallel_request) |>
      set_names2(x@url) |>
      rowbind2(nm = id)
  } else {
    offset2(url, count, x@limit) |>
      parallel_request()
  }
}
