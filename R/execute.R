#' @noRd
URL_CMS <- c("https://data.cms.gov/data-api/v1/dataset/", "/data")

#' @noRd
list_cms <- S7::new_class(
  "list_cms",
  package = NULL,
  properties = list(
    end = S7::class_character,
    id = S7::class_character,
    url = S7::new_property(S7::class_list, getter = function(self) {
      uid <- uuid_cms_list(self@end)
      set_names2(as.list(paste0(URL_CMS[1], uid, URL_CMS[2])), uid)
    }),
    count = S7::class_logical,
    set = S7::class_logical,
    limit = S7::new_property(S7::class_integer, default = 5000L),
    arg = arg_cms,
    query = S7::new_property(S7::class_character, getter = function(self) {
      if (length(self@arg) != 0L) build(self@arg)
    }),
    N = S7::new_property(S7::class_integer, getter = function(self) {
      url <- paste0(self@url, "/stats?")

      # set = TRUE OR [count = TRUE AND empty query]
      if (self@set || (self@count && !length(self@arg))) {
        return(multi_count(flatten_url(url), self@url, "total_rows"))
      }
      # count = TRUE OR query present
      if (self@count || length(self@arg)) {
        return(multi_count(
          flatten_url(url, self@query),
          self@url,
          "found_rows"
        ))
      }
    })
  )
)

#' @noRd
S7::method(req_empty, list_cms) <- function(x) {
  cli_empty(x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = NULL,
    opts = opts_cms(size = 10L)
  ) |>
    multi_base(x@url, x@id)
}

#' @noRd
S7::method(req_single, list_cms) <- function(x) {
  cli_results2(x@N, x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = x@query,
    opts = opts_cms()
  ) |>
    multi_base(x@url, x@id)
}

#' @noRd
S7::method(req_multi, list_cms) <- function(x) {
  cli_pages2(x@N, x@limit, x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = x@query,
    opts = opts_cms(offset = "<<i>>")
  ) |>
    multi_parallel(x@N, x@limit, x@url, x@id)
}

#' @noRd
S7::method(req_set, list_cms) <- function(x) {
  cli_pages2(x@N, x@limit, x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = NULL,
    opts = opts_cms(offset = "<<i>>")
  ) |>
    multi_parallel(x@N, x@limit, x@url, x@id)
}

#' @noRd
base_cms2 <- S7::new_class(
  "base_cms2",
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
S7::method(req_empty, base_cms2) <- function(x) {
  cli_empty(x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = NULL,
    opts = opts_cms(size = 10L)
  ) |>
    base_request()
}

#' @noRd
S7::method(req_single, base_cms2) <- function(x) {
  cli_results(x@N, x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = x@query,
    opts = opts_cms()
  ) |>
    base_request()
}

#' @noRd
S7::method(req_multi, base_cms2) <- function(x) {
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
S7::method(req_set, base_cms2) <- function(x) {
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

#' @noRd
URL_PROV <- c(
  "https://data.cms.gov/provider-data/api/1/datastore/query/",
  "/0?"
)

#' @noRd
base_prov2 <- S7::new_class(
  "base_prov2",
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
S7::method(req_empty, base_prov2) <- function(x) {
  cli_empty(x@end)
  flatten_url(x@url, opts = opts_prov(limit = 10L)) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_single, base_prov2) <- function(x) {
  cli_results(x@N, x@end)
  flatten_url(x@url, x@query, opts_prov()) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_multi, base_prov2) <- function(x) {
  cli_pages(x@N, x@limit, x@end)
  flatten_url(x@url, x@query, opts_prov(offset = "<<i>>")) |>
    offset2(x@N, x@limit) |>
    parallel_request(query = "results")
}

#' @noRd
S7::method(req_set, base_prov2) <- function(x) {
  cli_pages(x@N, x@limit, x@end)
  flatten_url(x@url, opts = opts_prov(offset = "<<i>>")) |>
    offset2(x@N, x@limit) |>
    parallel_request(query = "results")
}

#' @noRd
S7::method(execute, base_cms2 | base_prov2) <- function(x) {
  if (!length(x@arg)) {
    if (x@set) {
      return(polish(req_set(x), x@end))
    }

    if (x@count) {
      cli_total(x@N, x@end)
      return(invisible(x))
    }

    return(polish(req_empty(x), x@end))
  }

  if (x@N == 0L || x@count) {
    cli_results(x@N, x@end)
    return(invisible(x))
  }

  if (x@N <= x@limit) {
    return(polish(req_single(x), x@end))
  }

  polish(req_multi(x), x@end)
}

#' @noRd
S7::method(execute, list_cms) <- function(x) {
  if (!length(x@arg)) {
    if (x@set) {
      return(polish(req_set(x), x@end, x@id))
    }

    if (x@count) {
      cli_total2(x@N, x@end)
      return(invisible(x))
    }

    return(polish(req_empty(x), x@end, x@id))
  }

  if (sum2(x@N) == 0L || x@count) {
    cli_results2(x@N, x@end)
    return(invisible(x))
  }

  if (all2(x@N <= x@limit)) {
    return(polish(req_single(x), x@end, x@id))
  }

  polish(req_multi(x), x@end, x@id)
}
