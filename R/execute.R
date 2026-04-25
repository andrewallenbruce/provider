#' @noRd
execute <- S7::new_generic("execute", "x")

# enrolled(org_name = not_blank(), count = TRUE)
#' @noRd
base_cms2 <- S7::new_class(
  "base_cms2",
  package = NULL,
  properties = list(
    end = S7::class_character,
    count = S7::new_property(S7::class_logical, default = FALSE),
    set = S7::new_property(S7::class_logical, default = FALSE),
    limit = S7::new_property(S7::class_integer, default = 5000L),
    query = arg_cms,
    query_empty = S7::new_property(
      S7::class_logical,
      getter = function(self) length(self@query) == 0L
    ),
    url = S7::new_property(
      S7::class_character | S7::class_list,
      getter = function(self) {
        uid <- uuid_cms(self@end)
        url <- paste0(URL_CMS[1], uid, URL_CMS[2])
        if (rlang::is_list(uid)) set_names2(as.list(url), uid) else url
      }
    ),
    url_multi = S7::new_property(
      S7::class_logical,
      getter = function(self) length(self@url) > 1L
    ),
    url_id = NULL | S7::class_character
  )
)

#' @noRd
S7::method(req_total, base_cms2) <- function(x) {
  url <- flatten_url(paste0(x@url, "/stats?"))

  if (x@mult) {
    return(multi_count(url, x@url, "total_rows"))
  }
  base_request(url, "total_rows")
}

#' @noRd
S7::method(execute, base_cms2) <- function(x) {
  if (x@query_empty) {
    if (x@set) {
      N <- req_count(x)
      cli_pages2(N, x@limit, x@end)
      return(
        req_multi(x, count = N, id = .id)
      )
    }

    if (x@count) {
      N <- req_count(x)
      cli_total2(N, x@end)
      return(invisible(N))
    }

    return(req_empty(x, .id))
  }
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
  check_bool(multi, allow_null = TRUE)
  base_cms2(
    end = "providers",
    count = count,
    set = set,
    query = param_cms(
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
