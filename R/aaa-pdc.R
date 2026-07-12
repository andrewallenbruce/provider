#' @noRd
check_modifiers <- function(x, end) {
  rlang::check_required(end)
  if (S7::S7_inherits(x, ParamPDC)) {
    if (purrr::some(x, is_modifier)) {
      x <- unlist_(x[purrr::map_lgl(x, is_modifier)])
      if (any2(x %in% c("ends", "excludes"))) {
        cli::cli_abort(
          c(
            "x" = "Invalid query {.cls modifier} used in {.fn {end}}",
            ">" = "Modifiers that do not work with {.strong Provider Data Catalog} endpoints: ",
            "*" = "{.fn ends}",
            "*" = "{.fn excludes}"
          ),
          call = rlang::call2(end)
        )
      }
    }
  }
  invisible()
}

#' @noRd
opts_pdc <- function(
  results = "true",
  limit = 1500L,
  offset = 0L
) {
  flatten_opts(params(
    count = "true",
    results = results,
    limit = limit,
    offset = offset,
    format = "json",
    rowIds = "false",
    schema = "false",
    keys = "true"
  ))
}

#' @noRd
url_pdc <- function(x) {
  paste0(
    "https://data.cms.gov/provider-data/api/1/datastore/query/",
    switch(
      x,
      affiliations = "27ea-46a8",
      ambulatory = "48nr-hqxx", # OAS CAHPS survey for ambulatory surgical centers - Facility
      clinician = "mj5m-pzi6",
      dialysis = "23ew-n7w9",
      hospital2 = "xubh-q36u",
      long_term = "azum-44iv", # Long-Term Care Hospital - General Information
      spending = "rrqw-56er", # Medicare Spending Per Beneficiary - Hospital
      spending2 = "nrth-mfg3", # Medicare Hospital Spending by Claim
      nursing = "4pq5-n9py", # Nursing Homes Provider Information
      psych = "q9vs-r7wp", # Inpatient Psychiatric Facility Quality Measure Data - by Facility
      rehab = "7t8x-u3ir", # Inpatient Rehabilitation Facility - General Information
      supplier = "ct36-nrcq", # Medical Equipment Suppliers
      veteran = "uyx4-5s7f", # Veterans Health Administration Provider Level Data
      cli::cli_abort("{.strong {.pkg PDC} Endpoint} `{.field {x}}` not found.")
    ),
    "/0?"
  )
}

#' @noRd
end_pdc <- function(
  count = FALSE,
  set = FALSE,
  ...,
  end = NULL
) {
  if (is.null(end)) {
    end <- rlang::eval_bare(
      rlang::call_name(rlang::caller_call()),
      parent.frame(3)
    )
  }

  x <- param_pdc(...)

  check_modifiers(x, end)

  x <- EndpointPDC(
    end = end,
    url = url_pdc(end),
    query = build(x) %||% character(0),
    action = count_set(count, set)
  )

  count(x)
}

#' @noRd
flatten_pdc <- function(url, query = NULL, ...) {
  flatten_url(
    base = url,
    query %0% NULL,
    opts_pdc(...)
  )
}
