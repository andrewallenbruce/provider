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
add_class <- function(x, endpoint) {
  structure(x, class = c(endpoint, "tbl_df", "tbl", "data.frame"))
}

#' @noRd
request_preview <- S7::new_generic("request_preview", "x")

#' @noRd
S7::method(request_preview, PDC) <- function(x) {
  cli_empty(x@end)
  flatten_url(x@url, NULL, opts_prov(limit = 10L)) |>
    base_request("results") |>
    add_class(x@end)
}

#' @noRd
S7::method(req_single, PDC) <- function(x) {
  cli_results(x@results, x@end)
  flatten_url(x@url, x@query, opts_prov()) |>
    base_request("results") |>
    add_class(x@end)
}

#' @noRd
S7::method(req_multi, PDC) <- function(x) {
  cli_pages(x@results, x@limit, x@end)
  flatten_url(x@url, x@query %0% NULL, opts_prov(offset = "<<i>>")) |>
    offset2(x@results, x@limit) |>
    parallel_request("results") |>
    add_class(x@end)
}

#' @noRd
S7::method(req_set, PDC) <- function(x) {
  req_multi(x)
}

#' @noRd
empty <- S7::new_generic("empty", "x")

#' @noRd
S7::method(empty, PDC) <- function(x) {
  length(x@query) == 0L
}

#' @noRd
S7::method(execute, PDC) <- function(x) {
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

#' Polish generic
#'
#' Defines data cleaning methods for results
#'
#' @param x data.frame
#'
#' @returns data.frame
#'
#' @export
#' @keywords internal
polish2 <- function(x) {
  UseMethod("polish2")
}

#' @export
#' @keywords internal
polish2.default <- function(x) {
  invisible(x)
}

#' @export
#' @keywords internal
polish2.affiliations <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      provider_first_name = "first",
      provider_last_name = "last",
      provider_middle_name = "middle",
      suff = "suffix",
      npi = "npi",
      ind_pac_id = "pac",
      facility_type = "facility_type",
      facility_affiliations_certification_number = "facility_ccn",
      facility_type_certification_number = "parent_ccn"
    )) |>
    rc_integer("npi") |>
    data_frame()
}

#' @export
#' @keywords internal
polish2.clinicians <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      provider_first_name = "first",
      provider_middle_name = "middle",
      provider_last_name = "last",
      suff = "suffix",
      gndr = "gender",
      cred = "cred",
      med_sch = "school",
      grd_yr = "grad_year",
      pri_spec = "specialty",
      sec_spec_all = "spec_other",
      npi = "npi",
      ind_pac_id = "pac",
      ind_enrl_id = "enid",
      facility_name = "org_name",
      org_pac_id = "org_pac",
      num_org_mem = "org_mem",
      adr_ln_1 = "add_1",
      adr_ln_2 = "add_2",
      citytown = "org_city",
      state = "org_state",
      zip_code = "org_zip",
      telephone_number = "org_phone"
    )) |>
    RC_clinicians() |>
    data_frame()
}

#' @export
#' @keywords internal
polish2.esrd <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      cms_certification_number_ccn = "ccn",
      facility_name = "facility_name",
      five_star = "stars",
      network = "network",
      profit_or_nonprofit = "status",
      chain_organization = "chain_name",
      certification_date = "cert_date",
      address_line_1 = "add_1",
      address_line_2 = "add_2",
      citytown = "city",
      state = "state",
      zip_code = "zip",
      countyparish = "county",
      telephone_number = "phone"
    )) |>
    RC_esrd() |>
    data_frame()
}
