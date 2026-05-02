#' @noRd
URL_ListCMS <- function(x) {
  set_names2(
    as.list(paste0(
      "https://data.cms.gov/data-api/v1/dataset/",
      uuid_cms_list(x),
      "/data"
    )),
    uuid_cms_list(x)
  )
}

#' @noRd
list_cms <- function(
  ...,
  .count = FALSE,
  .set = FALSE,
  end = call_name(call_match(
    call = caller_call(),
    fn = caller_fn()
  ))
) {
  check_bool_(.count)
  check_bool_(.set)
  check_count_set(.count, .set)

  ListCMS(
    end = end,
    query = build(param_cms(...)) %||% character(0),
    action = if (.count) {
      "count"
    } else if (.set) {
      "set"
    } else {
      ""
    }
  )
}

#' @noRd
method(request_preview, ListCMS) <- function(x) {
  cli_empty(x@end)
  flatten_url(paste0(x@url, "?"), NULL, opts_cms(size = 10L)) |>
    multi_base(x@url) |>
    add_class(x@end)
}

#' @noRd
method(request_single, ListCMS) <- function(x) {
  report_count(x)
  flatten_url(paste0(x@url, "?"), x@query, opts_cms()) |>
    multi_base(x@url) |>
    add_class(x@end)
}

#' @noRd
method(request_multi, ListCMS) <- function(x) {
  cli_pages2(x@count, x@limit, x@end)
  flatten_url(
    paste0(x@url, "?"),
    x@query %0% NULL,
    opts_cms(offset = "<<i>>")
  ) |>
    multi_parallel(x@count, x@limit, x@url) |>
    add_class(x@end)
}


