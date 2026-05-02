#' @noRd
URL_CMS <- function(x) {
  paste0(
    "https://data.cms.gov/data-api/v1/dataset/",
    uuid_cms(x),
    "/data"
  )
}

#' @noRd
param_cms <- function(...) {
  ParamCMS(params(...))
}

#' @noRd
method(build, ParamCMS) <- function(x) {
  S7_data(x) %0% return(NULL)

  S7_data(x) |>
    purrr::imap(\(x, n) query(api = "cms", x, n)) |>
    flatten_query()
}

#' @noRd
cms <- function(
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

  CMS(
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
method(request_preview, CMS) <- function(x) {
  cli_empty(x@end)
  flatten_url(paste0(x@url, "?"), NULL, opts_cms(size = 10L)) |>
    base_request() |>
    add_class(x@end)
}

#' @noRd
method(request_single, CMS) <- function(x) {
  report_count(x)
  flatten_url(paste0(x@url, "?"), x@query, opts_cms()) |>
    base_request() |>
    add_class(x@end)
}

#' @noRd
method(request_multi, CMS) <- function(x) {
  cli_pages(x@count, x@limit, x@end)
  flatten_url(
    paste0(x@url, "?"),
    x@query %0% NULL,
    opts_cms(offset = "<<i>>")
  ) |>
    base_parallel(x@count, x@limit) |>
    add_class(x@end)
}
