#' Revoked Providers & Suppliers
#'
#' @description
#' Information on providers and suppliers currently revoked from the Medicare program.
#'
#' @details
#' The Revoked Medicare Providers and Suppliers dataset contains information on
#' providers and suppliers who are revoked and under a current re-enrollment bar.
#' This dataset includes provider and supplier names, NPIs, revocation
#' authorities pursuant to [42 CFR § 424.535](https://www.ecfr.gov/current/title-42/chapter-IV/subchapter-B/part-424/subpart-P/section-424.535), revocation effective dates, and
#' re-enrollment bar expiration dates. This dataset is based on information
#' gathered from the _Provider Enrollment, Chain and Ownership System (PECOS)_.
#'
#' ### Reasons
#'
#' ```{r, child = "man/md/revocations_reasons.md"}
#' ```
#'
#' @source
#'    - [API: Revoked Medicare Providers and Suppliers](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revoked-medicare-providers-and-suppliers)
#'
#' @inheritParams provider_common_params
#' @param npi `<int>` National Provider Identifier
#' @param enid `<chr>` Medicare Enrollment ID
#' @param first,last `<chr>` Individual provider name
#' @param prov_desc `<chr>` Provider type enrollment description
#' @param state `<chr>` Enrollment state abbreviation
#' @param org_name `<chr>` Organization name
#' @param multi `<lgl>` Provider has multiple NPIs
#' @param reason `<chr>` Reason for revocation
#' @param start_year,end_year `<int>` year of revocation/expiration
#' @examplesIf httr2::is_online()
#' revocations(count = TRUE)
#'
#' revocations(org_name = not_blank(), count = TRUE)
#'
#' revocations(org_name = starts("B"), count = TRUE)
#'
#' revocations(prov_desc = contains("CARDIO"), state = excludes(c("GA", "OH")))
#'
#' @export
revocations <- function(
  npi = NULL,
  enid = NULL,
  first = NULL,
  last = NULL,
  org_name = NULL,
  multi = NULL,
  state = NULL,
  prov_desc = NULL,
  reason = NULL,
  start_year = NULL,
  end_year = NULL,
  count = FALSE
) {
  check_bool_(multi)
  check_numeric(start_year)
  check_numeric(end_year)

  if (!is.null(start_year)) {
    start_year <- starts(start_year)
  }

  if (!is.null(end_year)) {
    end_year <- starts(end_year)
  }

  x <- cms(
    count = count,
    set = FALSE,
    NPI = npi,
    ENRLMT_ID = enid,
    FIRST_NAME = first,
    LAST_NAME = last,
    ORG_NAME = org_name,
    MULTIPLE_NPI_FLAG = tag_bool(multi),
    STATE_CD = state,
    PROVIDER_TYPE_DESC = prov_desc,
    REVOCATION_RSN = reason,
    REVOCATION_EFCTV_DT = start_year,
    REENROLLMENT_BAR_EXPRTN_DT = end_year
  )

  x <- execute(x)

  polish(x)
}
