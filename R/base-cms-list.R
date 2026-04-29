#' @include base-cms.R

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
