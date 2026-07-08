#' Inpatient Hospitals
#'
#' @param year `<int>` Year data was reported
#' @param ccn `<int>` 10-digit national provider identifier
#' @param org_name `<chr>` Individual/Organizational provider's name
#' @param city,state,zip `<chr>` The provider's city and state, as reported in NPPES.
#' @param patients `<int>` Total Medicare beneficiaries receiving services from
#'   the provider
#' @param discharges description
#' @param charge `<int>` The total charges that the provider submitted for all
#'   services
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
#' inpatient(count = TRUE)
#' inpatient(state = "GA", city = "Valdosta")
#' @export
inpatient <- function(
  year = NULL,
  ccn = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  patients = NULL,
  discharges = NULL,
  charge = NULL,
  payment = NULL,
  avg_age = NULL,
  avg_risk = NULL,
  dual = NULL,
  ndual = NULL,
  count = FALSE
) {
  check_numeric(year)

  x <- end_cmslist(
    count = count,
    set = FALSE,
    select = year,
    Rndrng_Prvdr_CCN = ccn,
    Rndrng_Prvdr_Org_Name = org_name,
    Rndrng_Prvdr_City = city,
    Rndrng_Prvdr_State_Abrvtn = state,
    Rndrng_Prvdr_Zip5 = zip,
    Tot_Benes = patients,
    Tot_Dschrgs = discharges,
    Tot_Submtd_Cvrd_Chrg = charge,
    Tot_Pymt_Amt = payment,
    Bene_Dual_Cnt = dual,
    Bene_Ndual_Cnt = ndual,
    Bene_Avg_Age = avg_age,
    Bene_Avg_Risk_Scre = avg_risk
  )

  x <- execute(x)

  polish(x)
}

#' Outpatient Hospitals
#'
#' @param year `<int>` Year data was reported
#' @param ccn `<int>` 10-digit national provider identifier
#' @param org_name `<chr>` Individual/Organizational provider's name
#' @param city,state,zip `<chr>` The provider's city and state, as reported in NPPES.
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
#' @param outliers description
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' outpatient(count = TRUE)
#' outpatient(state = "GA", city = "Valdosta")
#' @export
outpatient <- function(
  year = NULL,
  ccn = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  patients = NULL,
  services = NULL,
  charge = NULL,
  allowed = NULL,
  payment = NULL,
  outliers = NULL,
  count = FALSE
) {
  check_numeric(year)

  x <- end_cmslist(
    count = count,
    set = FALSE,
    select = year,
    Rndrng_Prvdr_CCN = ccn,
    Rndrng_Prvdr_Org_Name = org_name,
    Rndrng_Prvdr_City = city,
    Rndrng_Prvdr_State_Abrvtn = state,
    Rndrng_Prvdr_Zip5 = zip,
    Bene_Cnt = patients,
    CAPC_Srvcs = services,
    Avg_Tot_Sbmtd_Chrgs = charge,
    Avg_Mdcr_Alowd_Amt = allowed,
    Avg_Mdcr_Pymt_Amt = payment,
    Outlier_Srvcs = outliers
  )

  x <- execute(x)

  polish(x)
}
