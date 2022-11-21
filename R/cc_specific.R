#' Search the Medicare Specific Chronic Conditions API
#'
#' @description Information on prevalence, use and spending by count of
#'    select chronic conditions among Original Medicare (or fee-for-service)
#'    beneficiaries.
#'
#' @details The Select Chronic Conditions dataset provides information on
#'    21 selected chronic conditions among Original Medicare beneficiaries.
#'    The dataset contains prevalence, use and spending organized by
#'    geography and distinct chronic conditions listed below.
#'
#' • Alcohol Abuse Drug Abuse/ Substance Abuse
#' • Alzheimer’s Disease and Related Dementia
#' • Arthritis (Osteoarthritis and Rheumatoid)
#' • Asthma
#' • Atrial Fibrillation
#' • Autism Spectrum Disorders
#' • Cancer (Breast, Colorectal, Lung, and Prostate)
#' • Chronic Kidney Disease
#' • Chronic Obstructive Pulmonary Disease
#' • Depression
#' • Diabetes
#' • Drug Abuse/ Substance Abuse
#' • Heart Failure
#' • Hepatitis (Chronic Viral B & C)
#' • HIV/AIDS
#' • Hyperlipidemia (High cholesterol)
#' • Hypertension (High blood pressure)
#' • Ischemic Heart Disease
#' • Osteoporosis
#' • Schizophrenia and Other Psychotic Disorders
#' • Stroke
#'
#' ## Links
#' * [Medicare Specific Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Annually**
#'
#' @param year YYYY, calendar year of Medicare enrollment. 2007-2018 data is
#'    currently available.
#' @param geo_lvl Geographic level of data; options are "National", "State",
#'    and "County"
#' @param geo_desc The state and/or county where the Medicare beneficiary
#'    resides. The values include the 50 United States, District of Columbia,
#'    Puerto Rico or U.S. Virgin Islands. Data aggregated at the National
#'    level are identified by "National'.
#' @param fips FIPS state and/or county code where the Medicare beneficiary
#'    resides. The Bene_Geo_Cd will be blank for data aggregated at the
#'    National level or for Puerto Rico and Virgin Islands.
#' @param age_lvl Identifies the age level of the population that the data
#'    has been aggregated. A value of 'All' indicates the data in the row
#'    represents all Fee-for-Service Medicare Beneficiaries. A value of
#'    '<65' or '65+' indicates that the data is aggregated by the age of
#'    the Medicare Beneficiaries at the end of the calendar year.
#' @param demo_lvl Identifies the demographic level of the population that
#'    the data has been aggregated. A value of 'All' indicates the data in
#'    the row is represents all Fee-for-Service Medicare beneficiaries. A
#'    value of 'Sex' indicates that the data has been aggregated by the
#'    Medicare beneficiary's sex. A value of 'Race' indicates that the data
#'    has been aggregated by the Medicare beneficiary's race. A value of
#'    'Dual Status' indicates that the data has been aggregated by the
#'    Medicare beneficiary's dual eligibility status.
#' @param demo_desc For Bene_Demo_Lvl='Sex', a beneficiary’s sex is classified
#'    as Male or Female and is identified using information from the CMS
#'    enrollment database. For Bene_Demo_Lvl='Race', the race/ethnicity
#'    classifications are: Non-Hispanic White, Black or African American,
#'    Asian/Pacific Islander, Hispanic, and American Indian/Alaska Native.
#'    All the chronic condition reports use the variable RTI_RACE_CD, which
#'    is available on the Master Beneficiary Files in the CCW. For
#'    Bene_Demo_Lvl='Dual Status',beneficiaries can be classified as
#'    'Medicare & Medicaid' or 'Medicare Only'. Beneficiares enrolled in
#'    both Medicare and Medicaid are known as “dual eligibles.” Medicare
#'    beneficiaries are classified as dual eligibles if in any month in the
#'    given calendar year they were receiving full or partial Medicaid
#'    benefits.
#' @param condition Identifies the chronic condition for which the prevalence
#'    and utilization is compiled. There are 21 chronic conditions identified
#'    using Medicare administrative claims. A Medicare beneficiary is
#'    considered to have a chronic condition if the CMS administrative data
#'    have a claim indicating that the beneficiary received a service or
#'    treatment for the specific condition. Beneficiaries may have more than
#'    one of the chronic conditions listed.
#' @param prevalence Prevalence estimates are calculated by taking the
#'    beneficiaries within the MCC category divided by the total number of
#'    beneficiaries in the fee-for-service population, expressed as a
#'    percentage.
#' @param stnd_pymt_pc Medicare standardized spending includes total Medicare
#'    payments for all covered services in Parts A and B and is presented per
#'    beneficiary (i.e. per capita). Standardized payments are presented to
#'    allow for comparisons across geographic areas in health care use among
#'    beneficiaries.
#' @param pymt_pc Medicare spending includes total Medicare payments for all
#'    covered services in Parts A and B and is presented per beneficiary
#'    (i.e. per capita).
#' @param readmit_rate Hospital readmissions are expressed as a percentage of
#'    all admissions. A 30-day readmission is defined as an admission to an
#'    acute care hospital for any cause within 30 days of discharge from an
#'    acute care hospital. Except when the patient died during the stay, each
#'    inpatient stay is classified as an index admission, a readmission,
#'    or both.
#' @param er_vis_per1k Emergency department visits are presented as the number
#'    of visits per 1,000 beneficiaries. ED visits include visits where the
#'    beneficiary was released from the outpatient setting and where the
#'    beneficiary was admitted to an inpatient setting.
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' cc_specific(year     = 2018,
#'             geo_lvl  = "State",
#'             geo_desc = "California")
#'
#' cc_specific(year     = 2007,
#'             geo_lvl  = "National",
#'             demo_lvl = "Race")
#' }
#' @autoglobal
#' @export

cc_specific <- function(year         = 2018,
                        geo_lvl      = NULL,
                        geo_desc     = NULL,
                        fips         = NULL,
                        age_lvl      = NULL,
                        demo_lvl     = NULL,
                        demo_desc    = NULL,
                        condition    = NULL,
                        prevalence   = NULL,
                        stnd_pymt_pc = NULL,
                        pymt_pc      = NULL,
                        readmit_rate = NULL,
                        er_vis_per1k = NULL,
                        clean_names  = TRUE,
                        lowercase    = TRUE) {

  # dataset version ids by year ---------------------------------------------
  id <- dplyr::case_when(year == 2018 ~ "60ccbf1c-d3f5-4354-86a3-465711d81c5a",
                         year == 2017 ~ "51231049-d7bc-41d2-90aa-07d711c375b2",
                         year == 2016 ~ "547d7d2c-6667-46ca-9973-6c6e93f6a467",
                         year == 2015 ~ "f7675b78-2006-422c-96cf-dc22e3d22b90",
                         year == 2014 ~ "40dab184-4531-4865-8d0b-3ba32d4ac3e9",
                         year == 2013 ~ "3659b970-d9c1-4a8d-8052-9180598fd27c",
                         year == 2012 ~ "d88974a6-3214-4e09-8ae7-b56dc479125e",
                         year == 2011 ~ "dfad5b34-3ad8-45e5-833f-e53d9dbd7584",
                         year == 2010 ~ "c78b10cd-4a19-4468-abf7-0266d1c0dbb9",
                         year == 2009 ~ "b12072e9-e736-4bac-a794-ab3f842813c4",
                         year == 2008 ~ "ab51ced1-1984-4d66-b60a-47857fc48023",
                         year == 2007 ~ "4b079921-8e18-463f-91cc-beb538004498")

  # param_format ------------------------------------------------------------
  param_format <- function(param, arg) {
    if (is.null(arg)) {param <- NULL} else {
      paste0("filter[", param, "]=", arg, "&")}}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                              ~y,
    "Bene_Geo_Lvl",             geo_lvl,
    "Bene_Geo_Desc",            geo_desc,
    "Bene_Geo_Cd",              fips,
    "Bene_Age_Lvl",             age_lvl,
    "Bene_Demo_Lvl",            demo_lvl,
    "Bene_Demo_Desc",           demo_desc,
    "Bene_Cond",                condition,
    "Prvlnc",                   prevalence,
    "Tot_Mdcr_Stdzd_Pymt_PC",   stnd_pymt_pc,
    "Tot_Mdcr_Pymt_PC",         pymt_pc,
    "Hosp_Readmsn_Rate",        readmit_rate,
    "ER_Visits_Per_1000_Benes", er_vis_per1k)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "")

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # create request ----------------------------------------------------------
  req <- httr2::request(url)

  # send response -----------------------------------------------------------
  resp <- req |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- resp |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE) |>
    tibble::tibble() |>
    dplyr::mutate(Year = year) |>
    dplyr::relocate(Year)

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
