#' Revocations of Medicare Enrollments
#'
#' @description
#' Eligibility to order and refer within Medicare
#'
#' @references
#'    - [API: Medicare Order and Referring](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)
#'    - [CMS: Ordering & Certifying](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/chain-ownership-system-pecos/ordering-certifying)
#'
#' @param npi `<int>` 10-digit Individual National Provider Identifier
#' @param enid `<chr>` 15-digit Medicare Enrollment ID
#' @param first,middle,last `<chr>` Individual provider's name
#' @param specialty `<chr>` Enrollment specialty description
#' @param state `<chr>` Enrollment state, full or abbreviation
#' @param org_name `<chr>` Organization name
#' @param multi `<lgl>` Provider has multiple NPIs
#' @param reason `<chr>` reason for revocation
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' revocations(count = TRUE)
#' revocations(state = "GA")
#' revocations(specialty = contains("CARDIO"))
#' @autoglobal
#' @export
revocations <- function(
  npi = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  org_name = NULL,
  multi = NULL,
  state = NULL,
  specialty = NULL,
  reason = NULL,
  count = FALSE
) {
  check_bool(multi, allow_null = TRUE)

  exec_cms(
    END = rlang::call_name(rlang::call_match()),
    COUNT = count,
    ARG = params(
      ENRLMT_ID = enid,
      NPI = npi,
      FIRST_NAME = first,
      MDL_NAME = middle,
      LAST_NAME = last,
      ORG_NAME = org_name,
      MULTIPLE_NPI_FLAG = bool_(multi),
      STATE_CD = state,
      PROVIDER_TYPE_DESC = specialty,
      REVOCATION_RSN = reason
    )
  )
}
