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
#'   • Alcohol Abuse Drug Abuse/ Substance Abuse
#'   • Alzheimer’s Disease and Related Dementia
#'   • Arthritis (Osteoarthritis and Rheumatoid)
#'   • Asthma
#'   • Atrial Fibrillation
#'   • Autism Spectrum Disorders
#'   • Cancer (Breast, Colorectal, Lung, and Prostate)
#'   • Chronic Kidney Disease
#'   • Chronic Obstructive Pulmonary Disease
#'   • Depression
#'   • Diabetes
#'   • Drug Abuse/ Substance Abuse
#'   • Heart Failure
#'   • Hepatitis (Chronic Viral B & C)
#'   • HIV/AIDS
#'   • Hyperlipidemia (High cholesterol)
#'   • Hypertension (High blood pressure)
#'   • Ischemic Heart Disease
#'   • Osteoporosis
#'   • Schizophrenia and Other Psychotic Disorders
#'   • Stroke
#'
#' ## Links
#' * [Medicare Specific Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Annually**
#'
#' @param year YYYY, calendar year of Medicare enrollment. 2007-2018 data is
#'    currently available.
#' @param geo_level Geographic level of data; options are `National`, `State`,
#'    and `County`
#' @param state state
#' @param county county
#' @param fips FIPS state and/or county code where the Medicare beneficiary
#'    resides. The Bene_Geo_Cd will be blank for data aggregated at the
#'    National level or for Puerto Rico and Virgin Islands.
#' @param age_level Identifies the age level of the population that the data
#'    has been aggregated. A value of 'All' indicates the data in the row
#'    represents all Fee-for-Service Medicare Beneficiaries. A value of
#'    '<65' or '65+' indicates that the data is aggregated by the age of
#'    the Medicare Beneficiaries at the end of the calendar year.
#' @param demo_level Identifies the demographic level of the population that
#'    the data has been aggregated. A value of `All` indicates the data in
#'    the row is represents all Fee-for-Service Medicare beneficiaries. A
#'    value of `Sex` indicates that the data has been aggregated by the
#'    Medicare beneficiary's sex. A value of `Race` indicates that the data
#'    has been aggregated by the Medicare beneficiary's race. A value of
#'    `Dual Status` indicates that the data has been aggregated by the
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
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @format ## In addition to the searchable columns:
#' \describe{
#'   \item{Prvlnc}{Prevalence estimates are calculated by taking the beneficiaries within the MCC category divided by the total number of beneficiaries in the fee-for-service population, expressed as a percentage.}
#'   \item{Tot_Mdcr_Stdzd_Pymt_PC}{Medicare standardized spending includes total Medicare payments for all covered services in Parts A and B and is presented per beneficiary (i.e. per capita). Standardized payments are presented to allow for comparisons across geographic areas in health care use among beneficiaries.}
#'   \item{Tot_Mdcr_Pymt_PC}{Medicare spending includes total Medicare payments for all covered services in Parts A and B and is presented per beneficiary (i.e. per capita).}
#'   \item{Hosp_Readmsn_Rate}{Hospital readmissions are expressed as a percentage of all admissions. A 30-day readmission is defined as an admission to an acute care hospital for any cause within 30 days of discharge from an acute care hospital. Except when the patient died during the stay, each inpatient stay is classified as an index admission, a readmission, or both.}
#'   \item{ER_Visits_Per_1000_Benes}{Emergency department visits are presented as the number of visits per 1,000 beneficiaries. ED visits include visits where the beneficiary was released from the outpatient setting and where the beneficiary was admitted to an inpatient setting.}
#' }
#' @examples
#' \dontrun{
#' cc_specific(year = 2018, geo_level = "State", state = "CA")
#' cc_specific(year = 2007, geo_level  = "National", demo_lvl = "Race")
#' }
#' @autoglobal
#' @export

cc_specific <- function(year         = 2018,
                        geo_level    = c("National", "State", "County"),
                        state        = NULL,
                        county       = NULL,
                        fips         = NULL,
                        age_level    = NULL,
                        demo_level   = NULL,
                        demo_desc    = NULL,
                        condition    = NULL,
                        clean_names  = TRUE,
                        lowercase    = TRUE) {

  # arg_match ---------------------------------------------------------------
  rlang::arg_match(geo_level)

  if (is.null(fips)) {

  fips <- dplyr::case_when(geo_level == "State" ~ fipio::as_fips(state),
                           geo_level == "County" ~ fipio::as_fips(state, county),
                           .default = NULL)
  }

  # update distribution ids -------------------------------------------------
  ids <- cms_update_ids(api = "Specific Chronic Conditions")

  # dataset version ids by year ---------------------------------------------
  id <- dplyr::case_when(year == 2018 ~ ids$distribution[2],
                         year == 2017 ~ ids$distribution[3],
                         year == 2016 ~ ids$distribution[4],
                         year == 2015 ~ ids$distribution[5],
                         year == 2014 ~ ids$distribution[6],
                         year == 2013 ~ ids$distribution[7],
                         year == 2012 ~ ids$distribution[8],
                         year == 2011 ~ ids$distribution[9],
                         year == 2010 ~ ids$distribution[10],
                         year == 2009 ~ ids$distribution[11],
                         year == 2008 ~ ids$distribution[12],
                         year == 2007 ~ ids$distribution[13])
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                 ~y,
    "Bene_Geo_Lvl",     geo_level,
    "Bene_Geo_Cd",      fips,
    "Bene_Age_Lvl",     age_level,
    "Bene_Demo_Lvl",    demo_level,
    "Bene_Demo_Desc",   demo_desc,
    "Bene_Cond",        condition)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(resp, check_type = FALSE,
             simplifyVector = TRUE)) |> dplyr::mutate(Year = year) |>
             dplyr::relocate(Year)

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
