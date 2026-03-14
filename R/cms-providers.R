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
#' @param npi `<int>` 10-digit Individual National Provider Identifier
#' @param pac `<chr>` 10-digit PECOS Associate Control ID
#' @param enid `<chr>` 15-digit Medicare Enrollment ID
#' @param first,middle,last `<chr>` Individual provider's name
#' @param spec `<chr>` Enrollment specialty code
#' @param specialty `<chr>` Enrollment specialty description
#' @param state `<chr>` Enrollment state, full or abbreviation
#' @param org_name `<chr>` Organization name
#' @param multi `<lgl>` Provider has multiple NPIs
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' providers(count = TRUE)
#' providers(enid = "I20040309000221")
#' providers(npi = 1417918293)
#' providers(pac = 2860305554)
#' providers(state = "AK")
#' @autoglobal
#' @export
providers <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  spec = NULL,
  specialty = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL,
  count = FALSE
) {
  END <- rlang::call_name(rlang::call_match())

  .c(BASE, LIMIT, NM) %=% constants(END)

  exec_cms(
    END,
    ARG = params(
      NPI = npi,
      MULTIPLE_NPI_FLAG = cv_lgl(multi),
      PECOS_ASCT_CNTL_ID = pac,
      ENRLMT_ID = enid,
      PROVIDER_TYPE_CD = spec,
      PROVIDER_TYPE_DESC = specialty,
      STATE_CD = state,
      LAST_NAME = last,
      FIRST_NAME = first,
      MDL_NAME = middle,
      ORG_NAME = org_name
    ),
    BASE = BASE,
    LIMIT = LIMIT,
    NM = NM,
    COUNT = count
  )
}
