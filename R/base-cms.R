#' @noRd
uuid_cms <- function(endpoint) {
  switch(
    endpoint,
    clia = "d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16",
    hospitals = "f6f6505c-e8b0-4d57-b258-e2b94133aaf2",
    opt_out = "9887a515-7552-4693-bf58-735c77af46d7",
    order_refer = "c99b5865-1119-4436-bb80-c5af2773ea1f",
    providers = "2457ea29-fc82-48b0-86ec-3b0755de7515",
    reassignments = "20f51cff-4137-4f3a-b6b7-bfc9ad57983b",
    revocations = "a6496a7d-4e19-479a-a9ad-d4c0a49e07c3",
    transparency = "6a3aa708-3c9d-411a-a1a4-e046d3ade7ef",
    rhc_enroll = "3b7e7659-067e-41ea-8e36-f9ee2036e1f6",
    rhc_owner = "ab03c9bc-0c22-4ca4-b032-21dd3408210d",
    fqhc_enroll = "4bcae866-3411-439a-b762-90a6187c194b",
    fqhc_owner = "ed289c89-0bb8-4221-a20a-85776066381b",
    quality = "7adb8b1b-b85c-4ed3-b314-064776e50180",
    cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
  )
}

#' @noRd
opts_cms <- function(size = 5000L, offset = 0L) {
  flatten_opts(params(size = size, offset = offset))
}

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
    purrr::imap(\(x, n) query("cms", x, n)) |>
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
