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
#'    - `"met"`: Met Requirements
#'    - `"admin"`: Administrative Closure
#'    - `"warning"`: Warning Notice
#'    - `"cap"`: CAP Request
#'    - `"closure"`: Closure Notice
#'    - `"cmp"`: CMP Notice
#'    - `"appeal"` : Appealed
#' @param count `<lgl>` Return the dataset's total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' transparency(count = TRUE)
#' transparency(count = TRUE, action = "warning")
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
  check_character(action, allow_null = TRUE)

  exec_cms(
    END = call_name(call_match()),
    COUNT = count,
    SET = set,
    ARG = params(
      Hosp_Name = name,
      Hosp_Address = address,
      City = city,
      State = state,
      Action = enum_(action)
    )
  )
}
