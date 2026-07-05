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
#' @param first,last `<chr>` Individual provider's name
#' @param prov_type,prov_desc `<chr>` Enrollment specialty code/description
#' @param state `<chr>` Enrollment state, full or abbreviation
#' @param org_name `<chr>` Organizational provider's name
#' @param multi `<lgl>` Provider has multiple NPIs
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' providers(count = TRUE)
#'
#' providers(count = TRUE, org_name = not_blank())
#'
#' providers(org_name = starts("AB"), state = "GA")
#'
#' @export
providers <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  last = NULL,
  prov_type = NULL,
  prov_desc = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL,
  count = FALSE
) {
  check_bool_(multi)

  x <- end_cms(
    count = count,
    set = FALSE,
    NPI = npi,
    MULTIPLE_NPI_FLAG = tag_bool(multi),
    PECOS_ASCT_CNTL_ID = pac,
    ENRLMT_ID = enid,
    PROVIDER_TYPE_CD = prov_type,
    PROVIDER_TYPE_DESC = prov_desc,
    STATE_CD = state,
    LAST_NAME = last,
    FIRST_NAME = first,
    ORG_NAME = org_name
  )

  x <- execute(x)
  x <- polish(x)

  if (count) {
    return(invisible(x))
  }

  x <- as_result(x)

  chain(x, keychain$nppes)
}
