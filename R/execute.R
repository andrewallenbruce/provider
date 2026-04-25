#' @noRd
execute <- S7::new_generic("execute", "x")

#' @noRd
base_cms2 <- S7::new_class(
  "base_cms2",
  package = NULL,
  properties = list(
    end = S7::class_character,
    url = S7::new_property(
      S7::class_character,
      getter = function(self) {
        paste0(URL_CMS[1], uuid_cms(self@end), URL_CMS[2])
      }
    ),
    count = S7::class_logical,
    set = S7::class_logical,
    limit = S7::new_property(S7::class_integer, default = 5000L),
    arg = arg_cms,
    query = S7::new_property(S7::class_character, getter = function(self) {
      if (length(self@arg) != 0L) build(self@arg)
    }),
    N = S7::new_property(S7::class_integer, getter = function(self) {
      url <- paste0(self@url, "/stats?")
      if (self@set || (self@count && !length(self@arg))) {
        return(base_request(flatten_url(url), "total_rows"))
      }
      if (self@count || length(self@arg)) {
        return(base_request(flatten_url(url, self@query), "found_rows"))
      }
    })
  )
)

#' @noRd
S7::method(req_empty, base_cms2) <- function(x) {
  cli_no_query(x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = NULL,
    opts = opts_cms(size = 10L)
  ) |>
    base_request()
}

#' @noRd
S7::method(req_single, base_cms2) <- function(x) {
  cli_results(x@N, x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = x@query,
    opts = opts_cms()
  ) |>
    base_request()
}

#' @noRd
S7::method(req_multi, base_cms2) <- function(x) {
  cli_pages(x@N, x@limit, x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = x@query,
    opts = opts_cms(offset = "<<i>>")
  ) |>
    base_parallel(
      cnt = x@N,
      lmt = x@limit
    )
}

#' @noRd
S7::method(req_set, base_cms2) <- function(x) {
  cli_pages(x@N, x@limit, x@end)

  flatten_url(
    base = paste0(x@url, "?"),
    args = NULL,
    opts = opts_cms(offset = "<<i>>")
  ) |>
    base_parallel(
      cnt = x@N,
      lmt = x@limit
    )
}

#' @noRd
S7::method(execute, base_cms2) <- function(x) {
  # N0 QUERY
  if (!length(x@arg)) {
    # RETURN DATASET
    if (x@set) {
      return(polish(req_set(x), x@end))
    }

    # COUNT
    if (x@count) {
      cli_total(x@N, x@end)
      return(invisible(x))
    }

    # EMPTY QUERY
    return(polish(req_empty(x), x@end))
  }

  # NO RESULTS or COUNT
  if (x@N == 0L || x@count) {
    cli_total(x@N, x@end)
    return(invisible(x))
  }

  # COUNT BELOW LIMIT
  if (x@N <= x@limit) {
    return(polish(req_single(x), x@end))
  }

  # COUNT ABOVE LIMIT
  polish(req_multi(x), x@end)
}

#' Enrollment in Medicare
#'
#' @description
#' Enrollment data on individual and organizational providers that are
#'    actively approved to bill Medicare.
#'
#' @references
#'    - [API: Medicare Provider Supplier Enrollment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
#'    - [Provider Enrollment Data Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)
#'
#' @param npi `<int>` National Provider Identifier
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid `<chr>` Medicare Enrollment ID
#' @param first,middle,last `<chr>` Individual provider's name
#' @param prov_type `<chr>` Enrollment specialty code
#' @param prov_desc `<chr>` Enrollment specialty description
#' @param state `<chr>` Enrollment state, full or abbreviation
#' @param org_name `<chr>` Organizational provider's name
#' @param multi `<lgl>` Provider has multiple NPIs
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' enrolled(count = TRUE)
#' enrolled(count = TRUE, org_name = not_blank())
#' enrolled()
#' enrolled(org_name = starts_with("AB"), state = c("TX", "CA"))
#' # enrolled(org_name = starts_with("U"))
#' @autoglobal
#' @export
enrolled <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  prov_type = NULL,
  prov_desc = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_bool_(multi)

  execute(
    base_cms2(
      end = "providers",
      count = count,
      set = set,
      arg = param_cms(
        NPI = npi,
        MULTIPLE_NPI_FLAG = bool_(multi),
        PECOS_ASCT_CNTL_ID = pac,
        ENRLMT_ID = enid,
        PROVIDER_TYPE_CD = prov_type,
        PROVIDER_TYPE_DESC = prov_desc,
        STATE_CD = state,
        LAST_NAME = last,
        FIRST_NAME = first,
        MDL_NAME = middle,
        ORG_NAME = org_name
      )
    )
  )
}
