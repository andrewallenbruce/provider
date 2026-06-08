#' Provider Utilization & Demographics by Year
#'
#' @description
#' Access information on services and procedures provided to Original
#' Medicare (fee-for-service) Part B beneficiaries by physicians and other
#' healthcare professionals; aggregated by provider, service and geography.
#'
#' @section By Provider:
#' __type =__`"Provider"`:
#'
#' The __Provider__ dataset allows the user access to data such as
#' services and procedures performed; charges submitted and payment received;
#' and beneficiary demographic and health characteristics for providers
#' treating Original Medicare (fee-for-service) Part B beneficiaries,
#' aggregated by year.
#'
#' @section By Provider and Service:
#' __type =__`"Service"`:
#'
#' The __Provider and Service__ dataset is aggregated by:
#'
#'    1. Rendering provider's NPI
#'    2. Healthcare Common Procedure Coding System (HCPCS) code
#'    3. Place of Service (Facility or Non-facility)
#'
#' There can be multiple records for a given NPI based on the number of
#' distinct HCPCS codes that were billed and where the services were
#' provided. Data have been aggregated based on the place of service
#' because separate fee schedules apply depending on whether the place
#' of service submitted on the claim is facility or non-facility.
#'
#' @section Links:
#'   - [Medicare Physician & Other Practitioners: by Provider API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)
#'   - [Medicare Physician & Other Practitioners: by Provider and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
#'   - [Medicare Physician & Other Practitioners: by Geography and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service)
#'
#' @inheritParams provider_common_params
#' @param year `<int>` Year data was reported
#' @param npi `<int>` 10-digit national provider identifier
#' @param first,last `<chr>` Individual/Organizational provider's name
#' @param cred `<chr>` Individual provider's credentials
#' @param entity `<chr>` Provider entity type; `"I"` (Individual), `"O"`
#'   (Organization)
#' @param address,city,state,zip description
#' @param specialty `<chr>` Provider specialty reported on the largest number of
#'   claims submitted
#' @param participating `<lgl>` Identifies whether the provider participates in
#'   Medicare and/or accepts assignment of Medicare allowed amounts
#' @param hcpcs `<int>` Total number of unique HCPCS codes
#' @param patients `<int>` Total Medicare beneficiaries receiving services from
#'   the provider
#' @param services `<int>` Total provider services
#' @param charges `<int>` The total charges that the provider submitted for all
#'   services
#' @param allowed `<dbl>` The Medicare allowed amount for all provider services.
#'   This figure is the sum of the amount Medicare pays, the deductible and
#'   coinsurance amounts that the beneficiary is responsible for paying, and any
#'   amounts that a third party is responsible for paying.
#' @param payment `<dbl>` Total amount that Medicare paid after deductible and
#'   coinsurance amounts have been deducted for all the provider's line item
#'   services.
#' @param avg_age `<int>` Average age of beneficiaries. Beneficiary age is
#'   calculated at the end of the calendar year or at the time of death
#' @param risk_score `<dbl>` Average Hierarchical Condition Category (HCC) risk
#'   score of beneficiaries
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' utilization(count = TRUE)
#'
#' utilization(npi = 1003000423)
#'
#' # utilization(npi = 1003000126)
#'
#' # utilization(npi = 1043477615)
#'
#' @export
utilization <- function(
  year = NULL,
  npi = NULL,
  first = NULL,
  last = NULL,
  cred = NULL,
  entity = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  specialty = NULL,
  participating = NULL,
  hcpcs = NULL,
  patients = NULL,
  services = NULL,
  charges = NULL,
  allowed = NULL,
  payment = NULL,
  avg_age = NULL,
  risk_score = NULL,
  count = FALSE
) {
  check_bool_(participating)

  x <- cms_list(
    count = count,
    set = FALSE,
    select = year,
    Rndrng_NPI = npi,
    Rndrng_Prvdr_First_Name = first,
    Rndrng_Prvdr_Last_Org_Name = last,
    Rndrng_Prvdr_Crdntls = cred,
    Rndrng_Prvdr_Ent_Cd = entity,
    Rndrng_Prvdr_St1 = address,
    Rndrng_Prvdr_City = city,
    Rndrng_Prvdr_State_Abrvtn = state,
    Rndrng_Prvdr_Zip5 = zip,
    Rndrng_Prvdr_Type = specialty,
    Rndrng_Prvdr_Mdcr_Prtcptg_Ind = tag_bool(participating),
    Tot_HCPCS_Cds = hcpcs,
    Tot_Benes = patients,
    Tot_Srvcs = services,
    Tot_Sbmtd_Chrg = charges,
    Tot_Mdcr_Alowd_Amt = allowed,
    Tot_Mdcr_Pymt_Amt = payment,
    Bene_Avg_Age = avg_age,
    Bene_Avg_Risk_Scre = risk_score
  )

  x <- execute(x)

  polish(x)
}
