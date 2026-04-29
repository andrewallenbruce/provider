#' Provider Enrollment in Medicare
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
#' providers(count = TRUE)
#' providers(count = TRUE, org_name = not_blank())
#' providers()
#' providers(org_name = starts("AB"), state = c("TX", "CA"))
#' providers(org_name = starts("U"), count = TRUE)
#' @autoglobal
#' @export
providers <- function(
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
    base_cms(
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

#' Pending Medicare Enrollments
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' The _Pending Initial Logging and Tracking (L & T)_ dataset provides a list of
#' pending applications for both Physicians and Non-Physicians that have not
#' been processed by CMS contractors.
#'
#' @source
#' Medicare Pending Initial Logging and Tracking:
#'    - [API: Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)
#'    - [API: Non-Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)
#'
#' @param npi `<int>` National Provider Identifier
#' @param first,last `<chr>` Provider's name
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' pending(count = TRUE)
#'
#' pending(first = "Victor", count = TRUE)
#'
#' pending(first = starts("V"))
#'
#' @autoglobal
#' @export
pending <- function(
  npi = NULL,
  first = NULL,
  last = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  execute(
    list_cms(
      end = "pending",
      id = "prov_type",
      count = count,
      set = set,
      arg = param_cms(
        NPI = npi,
        LAST_NAME = last,
        FIRST_NAME = first
      )
    )
  )
}
