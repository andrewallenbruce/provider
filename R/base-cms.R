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
as_cms <- function(
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
  flatten_url(x@url, NULL, opts_prov(limit = 10L)) |>
    base_request() |>
    add_class(x@end)
}

#' @noRd
S7::method(req_single, CMS) <- function(x) {
  cli_results(x@results, x@end)
  flatten_url(paste0(x@url, "?"), x@query, opts_cms()) |>
    base_request()
}

#' @noRd
method(req_multi, CMS) <- function(x) {
  cli_pages(x@results, x@limit, x@end)
  flatten_url(
    paste0(x@url, "?"),
    x@query %0% NULL,
    opts_cms(offset = "<<i>>")
  ) |>
    base_parallel(x@results, x@limit) |>
    add_class(x@end)
}

#' @noRd
method(req_set, CMS) <- function(x) {
  req_multi(x)
}

#' @noRd
method(execute, CMS) <- function(x) {
  if (empty(x)) {
    cli_total(x@results, x@end)
    if (x@action == "set") {
      return(req_set(x))
    }

    if (x@action == "count") {
      return(invisible(x@results))
    }

    return(request_preview(x))
  }

  if (x@results == 0L || x@action == "count") {
    cli_results(x@results, x@end)
    return(invisible(x@results))
  }

  if (x@results <= x@limit) {
    return(req_single(x))
  }
  req_multi(x)
}
