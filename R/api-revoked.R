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
#' gathered from the _Provider Enrollment, Chain and Ownership System (PECOS)_.
#'
#' @source
#'    - [API: Revoked Medicare Providers and Suppliers](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revoked-medicare-providers-and-suppliers)
#'
#' @param npi `<int>` National Provider Identifier
#' @param enid `<chr>` Medicare Enrollment ID
#' @param first,middle,last `<chr>` Individual provider name
#' @param prov_desc `<chr>` Provider type enrollment description
#' @param state `<chr>` Enrollment state abbreviation
#' @param org_name `<chr>` Organization name
#' @param multi `<lgl>` Provider has multiple NPIs
#' @param reason `<chr>` Reason for revocation
#' @param year_start,year_end `<int>` year of revocation/expiration
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' revocations(count = TRUE)
#'
#' revocations(org_name = not_blank(), count = TRUE)
#'
#' revocations(org_name = starts("B"), count = TRUE)
#'
#' revocations(
#'   prov_desc = contains("CARDIO"),
#'   state = excludes(c("GA", "OH")))
#'
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
  prov_desc = NULL,
  reason = NULL,
  year_start = NULL,
  year_end = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_bool_(multi)
  check_numeric(year_start)
  check_numeric(year_end)
  execute(
    base_cms(
      end = eval_bare(END_EXP),
      count = count,
      set = set,
      arg = param_cms(
        NPI = npi,
        ENRLMT_ID = enid,
        FIRST_NAME = first,
        MDL_NAME = middle,
        LAST_NAME = last,
        ORG_NAME = org_name,
        MULTIPLE_NPI_FLAG = bool_(multi),
        STATE_CD = state,
        PROVIDER_TYPE_DESC = prov_desc,
        REVOCATION_RSN = reason,
        REVOCATION_EFCTV_DT = year_start,
        REENROLLMENT_BAR_EXPRTN_DT = year_end
      )
    )
  )
}
