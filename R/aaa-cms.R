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
    hospital_owner = "60625dc8-b621-45f0-9423-077fd133b13e",
    snf_enroll = "5f2c306f-3b1c-42cd-b037-187b2ce22126",
    snf_owner = "a4358712-e910-4eaf-8f24-5e90ba3cf8d0",
    hospice_enroll = "25704213-e833-4b8b-9dbc-58dd17149209",
    hospice_owner = "e983965e-1603-4cb8-82b5-c40090e380d1",
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
cms <- function(
  ...,
  .count = FALSE,
  .set = FALSE,
  end = call_name(call_match(
    call = caller_call(),
    fn = caller_fn()
  ))
) {
  CMS(
    end = end,
    query = build(param_cms(...)) %||% character(0),
    action = count_set(.count, .set)
  )
}
#' @noRd
flatten_cms <- function(url, query = NULL, append = "?", ...) {
  flatten_url(
    base = paste0(url, append),
    query %0% NULL,
    opts_cms(...)
  )
}

#' @noRd
method(request_preview, CMS) <- function(x) {
  report_empty()
  flatten_cms(x@url, NULL, size = 10L) |>
    base_request() |>
    add_class(x@end)
}

#' @noRd
method(request_single, CMS) <- function(x) {
  report_count(x)
  flatten_cms(x@url, x@query) |>
    base_request() |>
    add_class(x@end)
}

#' @noRd
method(request_multi, CMS) <- function(x) {
  report_pages(x)
  flatten_cms(x@url, x@query, offset = "<<i>>") |>
    base_parallel(x@count, x@limit) |>
    add_class(x@end)
}
