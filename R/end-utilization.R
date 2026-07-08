#' Provider Utilization by Year
#'
#' @description
#' Access information on services and procedures provided to Original
#' Medicare (fee-for-service) Part B beneficiaries by physicians and other
#' healthcare professionals; aggregated by provider, service and geography.
#'
#' The __Provider__ dataset allows the user access to data such as
#' services and procedures performed; charges submitted and payment received;
#' and beneficiary demographic and health characteristics for providers
#' treating Original Medicare (fee-for-service) Part B beneficiaries,
#' aggregated by year.
#'
#' @section Links:
#'   - [Medicare Physician & Other Practitioners: by Provider API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)
#'   - [Medicare Physician & Other Practitioners: by Provider and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
#'   - [Medicare Physician & Other Practitioners: by Geography and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service)
#'
#' @param year `<int>` Year data was reported
#' @param npi `<int>` 10-digit national provider identifier
#' @param first,last `<chr>` Individual/Organizational provider's name
#' @param cred `<chr>` Individual provider's credentials
#' @param entity `<chr>` Type of entity reported in NPPES. `I` identifies
#'   individual providers and `O` identifies those registered as organizations.
#' @param city,state `<chr>` The provider's city and state, as reported in NPPES.
#' @param specialty `<chr>` Provider specialty reported on the largest number of
#'   claims submitted
#' @param par `<lgl>` Identifies a provider *with at least one claim*
#'   identifying them as *participating* in Medicare or accepting assignment of
#'   Medicare allowed amounts within HCPCS code and place of service. A
#'   *non-participating* provider is one that may elect to accept Medicare
#'   allowed amounts for some services and not accept Medicare allowed amounts
#'   for other services.
#' @param hcpcs `<int/chr>` Total number of unique HCPCS codes
#' @param drug `<lgl>` Total number of unique HCPCS codes
#' @param pos `<chr>` Total number of unique HCPCS codes
#' @param level `<chr>` National or State
#' @param providers `<int>` Total
#' @param patients `<int>` Total Medicare beneficiaries receiving services from
#'   the provider
#' @param services `<int>` Total provider services
#' @param charge `<int>` The total charges that the provider submitted for all
#'   services
#' @param allowed `<dbl>` The Medicare allowed amount for all provider services.
#'   This figure is the sum of the amount Medicare pays, the deductible and
#'   coinsurance amounts that the beneficiary is responsible for paying, and any
#'   amounts that a third party is responsible for paying.
#' @param payment `<dbl>` Total amount that Medicare paid after deductible and
#'   coinsurance amounts have been deducted for all the provider's line item
#'   services.
#' @param avg_age `<dbl>` Average age of beneficiaries. Beneficiary age is
#'   calculated at the end of the calendar year or at the time of death
#' @param avg_risk `<dbl>` Average Hierarchical Condition Category (HCC) risk
#'   score of beneficiaries
#' @param dual `<int>` Number of Medicare beneficiaries qualified to receive
#'   Medicare and Medicaid benefits. Beneficiaries are classified as Medicare
#'   and Medicaid entitlement if in any month in the given calendar year they
#'   were receiving full or partial Medicaid benefits.
#' @param ndual `<int>` Number of Medicare beneficiaries qualified to receive
#'   Medicare only benefits. Beneficiaries are classified as Medicare only
#'   entitlement if they received zero months of any Medicaid benefits (full or
#'   partial) in the given calendar year.
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' utilization(count = TRUE)
#' services(count = TRUE)
#' geography(count = TRUE)
#'
#' utilization(npi = 1003000423)
#'
#' services(npi = 1003000423)
#'
#' geography(
#'   hcpcs = c("Q0091", "G0101", "99213", "99212", "99203", "81002", "76830"),
#'   pos = "O",
#'   state = c("National", "Ohio"))
#'
#' @export
utilization <- function(
  year = NULL,
  npi = NULL,
  first = NULL,
  last = NULL,
  cred = NULL,
  entity = NULL,
  specialty = NULL,
  par = NULL,
  hcpcs = NULL,
  patients = NULL,
  services = NULL,
  charge = NULL,
  allowed = NULL,
  payment = NULL,
  avg_age = NULL,
  avg_risk = NULL,
  dual = NULL,
  ndual = NULL,
  city = NULL,
  state = NULL,
  count = FALSE
) {
  check_numeric(year)
  check_numeric(npi)
  check_numeric(hcpcs)
  check_numeric(patients)
  check_numeric(services)
  check_numeric(charge)
  check_numeric(allowed)
  check_numeric(payment)
  check_numeric(avg_age)
  check_numeric(avg_risk)
  check_numeric(dual)
  check_numeric(ndual)
  check_char_(city)
  check_char_(state)
  check_char_(specialty)
  check_bool_(par)

  if (!is.null(entity)) {
    entity <- rlang::arg_match0(entity, c("I", "O"))
  }

  x <- end_cmslist(
    count = count,
    set = FALSE,
    select = year,
    Rndrng_NPI = npi,
    Rndrng_Prvdr_Ent_Cd = entity,
    Rndrng_Prvdr_First_Name = first,
    Rndrng_Prvdr_Last_Org_Name = last,
    Rndrng_Prvdr_Crdntls = cred,
    Rndrng_Prvdr_City = city,
    Rndrng_Prvdr_State_Abrvtn = state,
    Rndrng_Prvdr_Type = specialty,
    Rndrng_Prvdr_Mdcr_Prtcptg_Ind = tag_bool(par),
    Tot_HCPCS_Cds = hcpcs,
    Tot_Benes = patients,
    Tot_Srvcs = services,
    Tot_Sbmtd_Chrg = charge,
    Tot_Mdcr_Alowd_Amt = allowed,
    Tot_Mdcr_Pymt_Amt = payment,
    Bene_Avg_Age = avg_age,
    Bene_Avg_Risk_Scre = avg_risk,
    Bene_Dual_Cnt = dual,
    Bene_Ndual_Cnt = ndual
  )

  x <- execute(x)

  polish(x)
}

#' @rdname utilization
#' @export
services <- function(
  year = NULL,
  npi = NULL,
  entity = NULL,
  first = NULL,
  last = NULL,
  cred = NULL,
  specialty = NULL,
  par = NULL,
  hcpcs = NULL,
  drug = NULL,
  pos = NULL,
  patients = NULL,
  services = NULL,
  charge = NULL,
  allowed = NULL,
  payment = NULL,
  count = FALSE
) {
  check_numeric(year)
  check_numeric(npi)
  check_numeric(patients)
  check_numeric(services)
  check_numeric(charge)
  check_numeric(allowed)
  check_numeric(payment)
  check_char_(specialty)
  check_bool_(par)

  if (!is.null(entity)) {
    entity <- rlang::arg_match0(entity, c("I", "O"))
  }

  if (!is.null(pos)) {
    pos <- rlang::arg_match0(pos, c("F", "O"))
  }
  x <- end_cmslist(
    count = count,
    set = FALSE,
    select = year,
    Rndrng_NPI = npi,
    Rndrng_Prvdr_First_Name = first,
    Rndrng_Prvdr_Last_Org_Name = last,
    Rndrng_Prvdr_Crdntls = cred,
    Rndrng_Prvdr_Ent_Cd = entity,
    Rndrng_Prvdr_Type = specialty,
    Rndrng_Prvdr_Mdcr_Prtcptg_Ind = tag_bool(par),
    HCPCS_Cd = hcpcs,
    HCPCS_Drug_Ind = tag_bool(drug),
    Place_Of_Srvc = pos,
    Tot_Benes = patients,
    Tot_Srvcs = services,
    Avg_Sbmtd_Chrg = charge,
    Avg_Mdcr_Alowd_Amt = allowed,
    Avg_Mdcr_Pymt_Amt = payment
  )

  x <- execute(x)

  polish(x)
}

#' @rdname utilization
#' @export
geography <- function(
  year = NULL,
  level = NULL,
  state = NULL,
  hcpcs = NULL,
  drug = NULL,
  pos = NULL,
  providers = NULL,
  patients = NULL,
  services = NULL,
  charge = NULL,
  allowed = NULL,
  payment = NULL,
  count = FALSE
) {
  check_numeric(year)
  check_numeric(providers)
  check_numeric(patients)
  check_numeric(services)
  check_numeric(charge)
  check_numeric(allowed)
  check_numeric(payment)

  if (!is.null(pos)) {
    pos <- rlang::arg_match0(pos, c("F", "O"))
  }

  rlang::check_exclusive(level, state, .require = FALSE)

  if (!is.null(level)) {
    level <- rlang::arg_match0(level, c("National", "State"))
  }

  if (!is.null(state)) {
    state <- rlang::arg_match(state, c("National", state.name), multiple = TRUE)
  }

  x <- end_cmslist(
    count = count,
    set = FALSE,
    select = year,
    Rndrng_Prvdr_Geo_Lvl = level,
    Rndrng_Prvdr_Geo_Desc = state,
    HCPCS_Cd = hcpcs,
    HCPCS_Drug_Ind = tag_bool(drug),
    Place_Of_Srvc = pos,
    Tot_Rndrng_Prvdrs = providers,
    Tot_Benes = patients,
    Tot_Srvcs = services,
    Avg_Sbmtd_Chrg = charge,
    Avg_Mdcr_Alowd_Amt = allowed,
    Avg_Mdcr_Pymt_Amt = payment
  )

  x <- execute(x)

  polish(x)
}
