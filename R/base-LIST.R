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
as_cmslist <- function(
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
method(req_single, ListCMS) <- function(x) {
  cli_results2(x@results, x@end)
  flatten_url(paste0(x@url, "?"), x@query, opts_cms()) |>
    multi_base(x@url) |>
    add_class(x@end)
}

#' @noRd
method(req_multi, ListCMS) <- function(x) {
  cli_pages2(x@results, x@limit, x@end)
  flatten_url(
    paste0(x@url, "?"),
    x@query %0% NULL,
    opts_cms(offset = "<<i>>")
  ) |>
    multi_parallel(x@results, x@limit, x@url) |>
    add_class(x@end)
}

#' @noRd
method(execute, ListCMS) <- function(x) {
  if (empty(x)) {
    cli_total2(x@results, x@end)
    if (x@action == "set") {
      return(req_multi(x))
    }

    if (x@action == "count") {
      return(x@results)
    }

    return(request_preview(x))
  }

  if (sum2(x@results) == 0L || x@action == "count") {
    cli_results2(x@results, x@end)
    return(x@results)
  }

  if (all2(x@results <= x@limit)) {
    return(req_single(x))
  }
  req_multi(x)
}
