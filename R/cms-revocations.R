#' Revoked Providers & Suppliers
#'
#' @description
#' Information on providers and suppliers currently revoked from the Medicare program.
#'
#' ### Details
#' The Revoked Medicare Providers and Suppliers dataset contains information on
#' providers and suppliers who are revoked and under a current re-enrollment bar.
#' This dataset includes provider and supplier names, NPIs, revocation
#' authorities pursuant to [42 CFR § 424.535](https://www.ecfr.gov/current/title-42/chapter-IV/subchapter-B/part-424/subpart-P/section-424.535), revocation effective dates, and
#' re-enrollment bar expiration dates. This dataset is based on information
#' gathered from the Provider Enrollment, Chain and Ownership System (PECOS).
#'
#' @source
#'    - [API: Revoked Medicare Providers and Suppliers](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revoked-medicare-providers-and-suppliers)
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
#' @param set `<lgl>` Return the entire dataset
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' revocations(count = TRUE)
#' revocations(count = TRUE, org_name = not_na())
#' revocations(specialty = contains("CARDIO"), state = excludes("TX", "OH"))
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
  count = FALSE,
  set = FALSE
) {
  check_bool(multi, allow_null = TRUE)

  exec_cms(
    COUNT = count,
    SET = set,
    ARG = param_cms(
      NPI = npi,
      ENRLMT_ID = enid,
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
