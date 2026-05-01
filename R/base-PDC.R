#' @include base-generics.R
#' @include base-execute.R
NULL

#' @noRd
URL_PDC <- function(x) {
  paste0(
    "https://data.cms.gov/provider-data/api/1/datastore/query/",
    uuid_prov(x),
    "/0?"
  )
}
#' @noRd
ParamPDC <- new_class("ParamPDC", class_list, package = NULL)

#' @noRd
param_pdc <- function(...) {
  ParamPDC(params(...))
}

#' @noRd
S7::method(build, ParamPDC) <- function(x) {
  S7::S7_data(x) %0% return(NULL)

  S7::S7_data(x) |>
    purrr::imap(\(x, n) query(api = "prov", x, n)) |>
    flatten_query()
}

#' @noRd
PDC <- new_class(
  "PDC",
  package = NULL,
  properties = list(
    end = class_character,
    url = new_property(
      class_character,
      getter = function(self) URL_PDC(self@end)
    ),
    limit = new_property(
      class_integer,
      default = 1500L
    ),
    query = class_character,
    action = class_character,
    results = new_property(
      class_integer,
      getter = function(self) {
        flatten_url(
          self@url,
          self@query %0% NULL,
          opts_prov(results = "false")
        ) |>
          base_request("count")
      }
    )
  )
)

#' @noRd
as_pdc <- function(
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

  PDC(
    end = end,
    query = build(param_pdc(...)) %||% character(0),
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
S7::method(req_empty, PDC) <- function(x) {
  cli_empty(x@end)
  flatten_url(x@url, NULL, opts_prov(limit = 10L)) |>
    base_request("results")
}

#' @noRd
S7::method(req_single, PDC) <- function(x) {
  cli_results(x@results, x@end)
  flatten_url(x@url, x@query, opts_prov()) |>
    base_request("results")
}

#' @noRd
S7::method(req_multi, PDC) <- function(x) {
  cli_pages(x@results, x@limit, x@end)
  flatten_url(x@url, x@query %0% NULL, opts_prov(offset = "<<i>>")) |>
    offset2(x@results, x@limit) |>
    parallel_request("results")
}

#' @noRd
S7::method(req_set, PDC) <- function(x) {
  req_multi(x)
}

#' @noRd
no_query <- S7::new_generic("no_query", "x")

#' @noRd
S7::method(no_query, PDC) <- function(x) {
  length(x@query) == 0L
}

#' @noRd
no_results <- S7::new_generic("no_results", "x")

#' @noRd
S7::method(no_results, PDC) <- function(x) {
  x@results == 0L
}

#' @noRd
get_set <- S7::new_generic("get_set", "x")

#' @noRd
S7::method(get_set, PDC) <- function(x) {
  x@action == "set"
}

#' @noRd
get_count <- S7::new_generic("get_count", "x")

#' @noRd
S7::method(get_count, PDC) <- function(x) {
  x@action == "count"
}

#' @noRd
under_limit <- S7::new_generic("under_limit", "x")

#' @noRd
S7::method(under_limit, PDC) <- function(x) {
  x@results <= x@limit
}

#' @noRd
S7::method(execute, PDC) <- function(x) {
  if (no_query(x)) {
    if (get_set(x)) {
      return(polish(req_set(x), x@end))
    }

    if (get_count(x)) {
      cli_total(x@results, x@end)
      return(invisible(x))
    }

    return(polish(req_empty(x), x@end))
  }

  if (no_results(x) || get_count(x)) {
    cli_results(x@results, x@end)
    return(invisible(x))
  }

  if (under_limit(x)) {
    return(polish(req_single(x), x@end))
  }
  polish(req_multi(x), x@end)
}
