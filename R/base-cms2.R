#' @noRd
CMS_ <- c("https://data.cms.gov/data-api/v1/dataset/", "/data")

#' @noRd
arg_cms <- S7::new_class("arg_cms", S7::class_list, package = NULL)

#' @noRd
par_cms <- function(...) {
  arg_cms(params(...))
}

#' @noRd
S7::method(build, arg_cms) <- function(x) {
  S7::S7_data(x) |>
    purrr::imap(\(x, n) query(api = "cms", x, n)) |>
    flatten_query()
}

#' @noRd
base_cms <- S7::new_class(
  "base_cms",
  package = NULL,
  properties = list(
    end = S7::new_property(
      S7::class_character,
      default = rlang::expr(rlang::call_name(rlang::call_match(
        call = rlang::caller_call(),
        fn = rlang::caller_fn()
      )))
    ),
    url = S7::new_property(
      S7::class_character,
      getter = function(self) {
        paste0(CMS_[1], uuid_cms(self@end), CMS_[2])
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

#' @noRd
list_cms <- S7::new_class(
  "list_cms",
  package = NULL,
  properties = list(
    end = S7::new_property(
      S7::class_character,
      default = rlang::expr(rlang::call_name(rlang::call_match(
        call = rlang::caller_call(),
        fn = rlang::caller_fn()
      )))
    ),
    id = S7::class_character,
    url = S7::new_property(S7::class_list, getter = function(self) {
      uid <- uuid_cms_list(self@end)
      set_names2(as.list(paste0(CMS_[1], uid, CMS_[2])), uid)
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
S7::method(execute, base_cms) <- function(x) {
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
