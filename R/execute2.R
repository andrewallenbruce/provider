#' @noRd
base_prov2 <- S7::new_class(
  "base_prov2",
  package = NULL,
  properties = list(
    end = S7::class_character,
    url = S7::new_property(
      S7::class_character,
      getter = function(self) {
        paste0(URL_PROV[1], uuid_prov(self@end), URL_PROV[2])
      }
    ),
    count = S7::class_logical,
    set = S7::class_logical,
    limit = S7::new_property(S7::class_integer, default = 1500L),
    arg = arg_prov,
    query = S7::new_property(S7::class_character, getter = function(self) {
      if (length(self@arg) != 0L) build(self@arg)
    }),
    N = S7::new_property(S7::class_integer, getter = function(self) {
      if (self@set || (self@count && !length(self@arg))) {
        return(
          flatten_url(self@url, opts = opts_prov(results = "false")) |>
            base_request(query = "count")
        )
      }
      if (self@count || length(self@arg)) {
        return(
          flatten_url(self@url, self@query, opts_prov(results = "false")) |>
            base_request(query = "count")
        )
      }
    })
  )
)

#' @noRd
S7::method(req_empty, base_prov2) <- function(x) {
  cli_no_query(x@end)
  flatten_url(x@url, opts = opts_prov(limit = 10L)) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_single, base_prov2) <- function(x) {
  cli_results(x@N, x@end)
  flatten_url(x@url, x@query, opts_prov()) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_multi, base_prov2) <- function(x) {
  cli_pages(x@N, x@limit, x@end)
  flatten_url(x@url, x@query, opts_prov(offset = "<<i>>")) |>
    offset2(x@N, x@limit) |>
    parallel_request(query = "results")
}

#' @noRd
S7::method(req_set, base_prov2) <- function(x) {
  cli_pages(x@N, x@limit, x@end)
  flatten_url(x@url, opts = opts_prov(offset = "<<i>>")) |>
    offset2(x@N, x@limit) |>
    parallel_request(query = "results")
}

#' @noRd
S7::method(execute, base_prov2) <- function(x) {
  if (!length(x@arg)) {
    if (x@set) {
      return(polish(req_set(x), x@end))
    }

    if (x@count) {
      cli_total(x@N, x@end)
      return(invisible(x))
    }

    return(polish(req_empty(x), x@end))
  }

  if (x@N == 0L || x@count) {
    cli_results(x@N, x@end)
    return(invisible(x))
  }

  if (x@N <= x@limit) {
    return(polish(req_single(x), x@end))
  }

  polish(req_multi(x), x@end)
}

#' Provider-Facility Affiliations
#'
#' @description Access information concerning individual providers'
#'    affiliations with organizations/facilities.
#'
#' @source
#'    * [API: Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'
#' @param npi `<int>` Individual National Provider Identifier
#' @param pac `<chr>` Individual PECOS Associate Control ID
#' @param first,middle,last,suffix `<chr>` Individual provider's name
#' @param facility_type `<enum>` facility type:
#'    - `esrd` = Dialysis facility
#'    - `hha` = Home health agency
#'    - `hospice` = Hospice
#'    - `hospital` = Hospital
#'    - `irf` = Inpatient rehabilitation facility
#'    - `ltch` = Long-term care hospital
#'    - `nurse` = Nursing home
#'    - `snf` = Skilled nursing facility
#' @param facility_ccn `<chr>` CCN of `facility_type` column's
#'    facility **or** of a **unit** within the hospital where the individual
#'    provider provides services.
#' @param parent_ccn `<int>` CCN of the **primary** hospital containing the
#'    unit where the individual provider provides services.
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' affiliated(count = TRUE)
#' affiliated(count = TRUE, facility_ccn = 331302)
#' affiliated()
#' affiliated(parent_ccn = 331302)
#' affiliated(facility_ccn = 331302)
#' # affiliated(first = "Andrew", last = contains("B"), facility_type = "hospital")
#' @autoglobal
#' @export
affiliated <- function(
  npi = NULL,
  pac = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  suffix = NULL,
  facility_type = NULL,
  facility_ccn = NULL,
  parent_ccn = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_char_(facility_type)

  execute(
    base_prov2(
      end = "affiliations",
      count = count,
      set = set,
      arg = param_prov(
        npi = npi,
        ind_pac_id = pac,
        provider_last_name = last,
        provider_first_name = first,
        provider_middle_name = middle,
        suff = suffix,
        facility_type = enum_(facility_type),
        facility_affiliations_certification_number = facility_ccn,
        facility_type_certification_number = parent_ccn
      )
    )
  )
}
