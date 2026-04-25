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
      }
    ),
    N = S7::new_property(S7::class_integer,
      getter = function(self) {
        url <- paste0(self@url, "/stats?")
        if (self@set || (self@count && !length(self@arg))) {
          return(base_request(flatten_url(url), "total_rows"))
        }
        if (self@count || length(self@arg)) {
          return(base_request(flatten_url(url, self@query), "found_rows"))
        }
      }
    )
  )
)

# enrolled(count = TRUE)
# enrolled(set = TRUE)
# enrolled(org_name = starts_with("Z"))
# enrolled(org_name = starts_with("AB"), state = c("TX", "CA"), multi = TRUE)
# req_empty(enrolled())
# req_single(enrolled(org_name = starts_with("AB"), state = c("TX", "CA")))
# req_multi(enrolled(org_name = starts_with("U")))

#' @noRd
S7::method(req_empty, base_cms2) <- function(x) {
  cli_no_query(x@end)
  base_request(flatten_url(paste0(x@url, "?"), opts = opts_cms(size = 10L)))
}

#' @noRd
S7::method(req_single, base_cms2) <- function(x) {
  base_request(flatten_url(paste0(x@url, "?"), x@query, opts_cms()))
}

#' @noRd
S7::method(req_multi, base_cms2) <- function(x, count) {
  base_parallel(
    flatten_url(
      paste0(x@url, "?"),
      x@query,
      opts_cms(offset = "<<i>>")),
    x@N,
    x@limit
  )
}

#' @noRd
S7::method(req_set, base_cms2) <- function(x) {
  base_parallel(
    flatten_url(
      paste0(x@url, "?"),
      opts = opts_cms(offset = "<<i>>")),
    x@N,
    x@limit
  )
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
#'
#' enrolled(count = TRUE, org_name = not_blank())
#'
#' enrolled(org_name = starts_with("AB"), state = c("TX", "CA"), multi = TRUE)
#'
#' @autoglobal
#' @noRd
#' @keywords internal
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
}
