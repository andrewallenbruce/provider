#' @noRd
temporal_uuid <- function(rex) {
  x <- RcppSimdJson::fload("https://data.cms.gov/data.json", "/dataset") |>
    collapse::get_elem("distribution") |>
    collapse::rowbind(fill = TRUE)

  x <- collapse::ss(x, grep(rex, x$title, perl = TRUE))
  S <- !cheapr::is_na(x$accessURL) & cheapr::is_na(x$description)
  x <- collapse::ss(x, cheapr::which_(S))
  x <- as.list(uuid_from_url(x$accessURL)) |> set_names(extract_year(x$title))

  # if (!is.null(year)) {
  #   match.arg(as.character(year), names(x), several.ok = TRUE)
  #   x <- cheapr::sset(x, collapse::fmatch(year, names(x), nomatch = 0L))
  # }
  return(x)
}

#' @noRd
uuid_cms_list <- function(endpoint) {
  switch(
    endpoint,
    pending = list(
      Physician = "6bd6b1dd-208c-4f9c-88b8-b15fec6db548",
      `Non-Physician` = "261b83b6-b89f-43ad-ae7b-0d419a3bc24b"
    ),
    facility = list(
      HHA = "15f64ab4-3172-4a27-b589-ebd67a6d28aa",
      RHC = "3b7e7659-067e-41ea-8e36-f9ee2036e1f6",
      FQHC = "4bcae866-3411-439a-b762-90a6187c194b",
      SNF = "5f2c306f-3b1c-42cd-b037-187b2ce22126",
      Hospice = "25704213-e833-4b8b-9dbc-58dd17149209"
    ),
    owner = list(
      HHA = "fc009b2d-7846-44b1-b4a1-692f0c143879",
      RHC = "ab03c9bc-0c22-4ca4-b032-21dd3408210d",
      FQHC = "ed289c89-0bb8-4221-a20a-85776066381b",
      SNF = "a4358712-e910-4eaf-8f24-5e90ba3cf8d0",
      Hospice = "e983965e-1603-4cb8-82b5-c40090e380d1",
      Hospital = "60625dc8-b621-45f0-9423-077fd133b13e"
    ),
    quality = temporal_uuid("^Quality"),
    utilization = temporal_uuid("Practitioners - by Provider :"),
    service = temporal_uuid("Practitioners - by Provider and Service :"),
    geography = temporal_uuid("Practitioners - by Geography and Service :"),
    cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
  )
}

#' @noRd
URL_CMS_List <- function(x) {
  x <- uuid_cms_list(x)

  paste0("https://data.cms.gov/data-api/v1/dataset/", x, "/data") |>
    as.list() |>
    set_names2(x)
}

#' @noRd
cms_list <- function(
  count = FALSE,
  set = FALSE,
  ...,
  end = call_name(call_match(call = caller_call(), fn = caller_fn()))
) {
  x <- param_cms(...)

  CMSList(
    end = end,
    query = build(x) %||% character(0),
    action = count_set(count, set)
  )
}

#' @noRd
method(request_preview, CMSList) <- function(x) {
  report_empty()

  y <- flatten_cms(x@url, NULL, size = 10L) |>
    purrr::map(httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(parse_string) |>
    set_names2(x@url)

  class(y) <- c(x@end, class(y))

  return(y)
}

#' @noRd
method(request_single, CMSList) <- function(x) {
  report_count(x)

  URL <- x@url[names(which(x@count > 0L))]

  y <- flatten_cms(URL, x@query) |>
    purrr::map(httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(parse_string) |>
    set_names2(URL)

  class(y) <- c(x@end, class(y))

  return(y)
}

#' @noRd
method(request_multi, CMSList) <- function(x) {
  report_pages(x)

  END <- names(which(x@count > 0L))

  URL <- x@url[END]

  N <- unname(x@count[END])

  y <- flatten_cms(URL, x@query, offset = "<<i>>") |>
    offset3(N, x@limit) |>
    unlist_() |>
    purrr::map(httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(parse_string) |>
    set_names2(URL)

  class(y) <- c(x@end, class(y))

  return(y)
}
