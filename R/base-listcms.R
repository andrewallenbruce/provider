#' @noRd
uuid_cms_list <- function(endpoint) {
  switch(
    endpoint,
    pending = list(
      Physician = "6bd6b1dd-208c-4f9c-88b8-b15fec6db548",
      `Non-Physician` = "261b83b6-b89f-43ad-ae7b-0d419a3bc24b"
    ),
    utilization = list(
      Geography = "6fea9d79-0129-4e4c-b1b8-23cd86a4f435",
      Provider = "8889d81e-2ee7-448f-8713-f071038289b5",
      Service = "92396110-2aed-4d63-a6a2-5d6207d46a29"
    ),
    cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
  )
}

#' @noRd
URL_ListCMS <- function(x) {
  x <- uuid_cms_list(x)
  set_names2(
    as.list(paste0("https://data.cms.gov/data-api/v1/dataset/", x, "/data")),
    x
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
