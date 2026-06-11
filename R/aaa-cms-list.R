#' @noRd
temporal_uuid <- function(rex) {
  x <- RcppSimdJson::fload("https://data.cms.gov/data.json", "/dataset") |>
    collapse::get_elem("distribution") |>
    collapse::rowbind(fill = TRUE)

  x <- collapse::ss(x, grep(rex, x$title, perl = TRUE))
  S <- !cheapr::is_na(x$accessURL) & cheapr::is_na(x$description)
  x <- collapse::ss(x, cheapr::which_(S))
  as.list(uuid_from_url(x$accessURL)) |> rlang::set_names(extract_year(x$title))
}

#' @noRd
url_cms_list <- function(x) {
  x <- switch(
    x,
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
    cli::cli_abort("{.arg endpoint} {.val {x}} is invalid.")
  )

  paste0("https://data.cms.gov/data-api/v1/dataset/", x, "/data") |>
    as.list() |>
    set_names2(x)
}

#' @noRd
cms_list <- function(
  count = FALSE,
  set = FALSE,
  select = NULL,
  ...,
  end = NULL
) {
  if (is.null(end)) {
    end <- rlang::eval_bare(
      rlang::call_name(rlang::caller_call()),
      parent.frame(3)
    )
  }

  x <- param_cms(...)

  url <- url_cms_list(end)

  if (!is.null(select)) {
    match.arg(as.character(select), names(url), several.ok = TRUE)
    url <- url[collapse::fmatch(select, names(url), nomatch = 0L)]
  }

  x <- EndpointCMSList(
    end = end,
    url = url,
    query = build(x) %||% character(0),
    action = count_set(count, set)
  )

  x@count <- request_count(x)

  return(x)
}

#' @noRd
S7::method(request_count, EndpointCMSList) <- function(x) {
  if (length(x@query) > 0L || x@action == "count") {
    u <- flatten_cms(x@url, x@query, "/stats?")
    x <- multi_count(u, x@url, "found_rows")
    return(x)
  }
  return(0L)
}

#' @noRd
S7::method(request_preview, EndpointCMSList) <- function(x) {
  report_preview()

  y <- flatten_cms(x@url, NULL, size = 10L) |>
    purrr::map(httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(parse_string) |>
    set_names2(x@url)

  class(y) <- c(x@end, class(y))
  return(y)
}

#' @noRd
S7::method(request_single, EndpointCMSList) <- function(x) {
  report_count(x)
  report_pages(x)

  u <- x@url[names(which(x@count > 0L))]

  y <- flatten_cms(u, x@query) |>
    purrr::map(httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(parse_string) |>
    set_names2(u)

  class(y) <- c(x@end, class(y))
  return(y)
}

#' @noRd
S7::method(request_multi, EndpointCMSList) <- function(x) {
  report_count(x)
  report_pages(x)

  i <- names(which(x@count > 0L))
  u <- x@url[i]
  n <- unname(x@count[i])

  y <- flatten_cms(u, x@query, offset = "<<i>>") |>
    offset3(n, x@limit) |>
    unlist_() |>
    purrr::map(httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(parse_string) |>
    set_names2(u)

  class(y) <- c(x@end, class(y))
  return(y)
}
