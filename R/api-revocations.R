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
      end = "revocations",
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

#' Hospital Transparency Enforcement
#'
#' @description
#' Information on enforcement actions as a result of CMS' assessment of a
#' hospital's compliance with the Hospital Price Transparency regulations.
#'
#' ### Overview
#'
#' The __Hospital Price Transparency Enforcement Activities and Outcomes__ dataset
#' contains information related to enforcement actions taken by CMS following a
#' compliance review of a hospital's obligation to establish, update and make
#' public a list of the hospital's standard charges for items and services
#' provided by the hospital, in accordance with regulation (45 CFR 180).
#'
#' This data set includes the name of each hospital or hospital location, the
#' hospital or hospital location address, the outcome or action following a
#' CMS compliance review and the date of the outcome or action taken.
#'
#' #### Actions:
#'    - __Met Requirements:__ The hospital was reviewed by CMS and no deficiencies
#'    were cited. This category includes hospitals that were found to be in
#'    compliance upon CMS' first review.
#'    - __Administrative Closure:__ Refers to the termination of compliance
#'    review activities due to reasons such as, but not limited to, a hospital
#'    has ceased operations, closed its physical location, is not subject to the
#'    HPT requirements, or has already been deemed to meet the requirements.
#'    - __Warning Notice:__ The hospital was reviewed by CMS and deficiencies
#'    were cited in a warning notice issued to the hospital.
#'    - __CAP Request:__ The hospital was reviewed by CMS and deficiencies were
#'    cited in a request for a corrective action plan (CAP) issued to the hospital.
#'    - __Closure Notice:__ CMS determined that the hospital corrected previously
#'    identified deficiencies and issued a closure notice to the hospital.
#'    - __CMP Notice:__ CMS issued a civil monetary penalty (CMP) to the hospital
#'    if the hospital failed to respond to CMS' request to submit a corrective
#'    action plan or comply with the requirements of a corrective action plan.
#'    CMP [notices are publicized](https://www.cms.gov/priorities/key-initiatives/hospital-price-transparency/enforcement-actions).
#'    - __Appealed:__ The hospital filed an appeal of CMS' decision to issue a
#'    civil monetary penalty.
#'
#' @source
#'    - [API: Hospital Price Transparency Enforcement Activities and Outcomes](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-price-transparency-enforcement-activities-and-outcomes)
#'
#' @param name `<chr>` Hospital name
#' @param address `<chr>` Hospital address
#' @param city `<chr>` Hospital city
#' @param state `<chr>` Hospital state
#' @param action `<enum>` Action taken by CMS following a Compliance Review (see Details)
#'    - `"met"` = Met Requirements
#'    - `"admin"` = Administrative Closure
#'    - `"warn"` = Warning Notice
#'    - `"cap"` = CAP Request
#'    - `"closure"` = Closure Notice
#'    - `"cmp"` = CMP Notice
#'    - `"appeal"` = Appealed
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' transparency(count = TRUE)
#' transparency(count = TRUE, action = "met")
#' transparency(state = "GA", city = "Valdosta")
#' @autoglobal
#' @export
transparency <- function(
  name = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  action = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_char_(action)
  execute(
    base_cms(
      end = "transparency",
      count = count,
      set = set,
      arg = param_cms(
        Hosp_Name = name,
        Hosp_Address = address,
        City = city,
        State = state,
        Action = enum_(action)
      )
    )
  )
}
