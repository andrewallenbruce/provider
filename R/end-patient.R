#' Inpatient Hospitals
#'
#' @source
#'    * [API: Medicare Inpatient Hospitals - by Provider](https://data.cms.gov/provider-data/dataset/uyx4-5s7f)
#'
#' @param year `<int>` Year data was reported
#' @param ccn `<int>` The CMS Certification Number (CCN) of the provider billing
#'   for inpatient hospital services.
#' @param org_name `<chr>` Organizational provider's name
#' @param city,state,zip `<chr>` The provider's city and state, as reported in
#'   NPPES.
#' @param patients `<int>` Total Medicare beneficiaries receiving services from
#'   the provider
#' @param discharges `<int>` The number of discharges billed by the provider for
#'   inpatient hospital services.
#' @param charge `<int>` The total submitted charge of all provider services
#'   covered by Medicare.
#' @param payment `<dbl>` The total payments to providers for the DRG including
#'   the MSDRG amount, teaching, disproportionate share, capital, and outlier
#'   payments for all cases. Also included in total payments are co-payment and
#'   deductible amounts that the patient is responsible for and any additional
#'   payments by third parties for coordination of benefits.
#' @param avg_age `<dbl>` The average age of Medicare enrollees who used a
#'   covered health care or medical service from the provider.
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
#' ### Outlier Payments
#'
#' OPPS APC payment amounts are based on the average costs for a set of
#' services. In the event that a hospital’s costs for these services exceed a
#' given threshold tied to the average APC payment, CMS must issue an outlier
#' payment to the hospital to that service to compensate for the costly
#' provision of service.
#'
#' @source
#'    * [API: Medicare Outpatient Hospitals - by Provider and Service](https://data.cms.gov/provider-data/dataset/uyx4-5s7f)
#'
#' @param year `<int>` Year data was reported
#' @param ccn `<int>` The CMS Certification Number (CCN) of the provider billing
#'   for outpatient hospital services.
#' @param org_name `<chr>` Organizational provider's name
#' @param patients `<int>` The number of Medicare fee-for-service beneficiaries
#'   receiving outpatient hospital services.
#' @param services `<int>` The number of primary HCPCS services billed by the
#'   provider for outpatient hospital services.
#' @param charge `<int>` The provider's average estimated submitted charge for
#'   services covered by Medicare for the Ambulatory Payment Classification
#'   (APC).
#' @param allowed `<dbl>` The average of total regular payments the provider
#'   receives for the APC. It includes both Medicare direct provider payments as
#'   well as beneficiaries’ co-payment and deductible payments. It excludes
#'   special outlier payments which is reported in a separate column.
#' @param payment `<dbl>` The average of total regular payments the provider
#'   receives directly from Medicare. It excludes special outlier payments which
#'   is reported in a separate column.
#' @param outliers `<int>` The number of comprehensive APC services with outlier
#'   payments.
#' @param city,state,zip `<chr>` The provider's city and state, as reported in
#'   NPPES.
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' outpatient(count = TRUE)
#' outpatient(state = "GA", city = "Valdosta")
#' @export
#' @rdname inpatient
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
