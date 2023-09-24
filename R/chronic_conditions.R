#' Search the Medicare Specific Chronic Conditions API
#'
#' @description Information on prevalence, use and spending by count of
#'    select chronic conditions among Original Medicare (or fee-for-service)
#'    beneficiaries.
#'
#' @details The Select Chronic Conditions dataset provides information on
#'    21 selected chronic conditions among Original Medicare beneficiaries.
#'    The dataset contains prevalence, use and spending organized by
#'    geography and distinct chronic conditions listed below:
#'
#'   * Alcohol Abuse
#'   * Alzheimer’s Disease/Dementia
#'   * Arthritis
#'   * Asthma
#'   * Atrial Fibrillation
#'   * Autism Spectrum Disorders
#'   * Cancer
#'   * Chronic Kidney Disease
#'   * COPD
#'   * Depression
#'   * Diabetes
#'   * Drug Abuse/Substance Abuse
#'   * Heart Failure
#'   * Hepatitis (Chronic Viral B & C)
#'   * HIV/AIDS
#'   * Hyperlipidemia
#'   * Hypertension
#'   * Ischemic Heart Disease
#'   * Osteoporosis
#'   * Schizophrenia and Other Psychotic Disorders
#'   * Stroke
#'
#' ### Links
#' * [Medicare Specific Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions)
#'
#' *Update Frequency:* **Annually**
#'
#' @param year integer, YYYY, calendar year of Medicare enrollment. Run the
#'  helper function `cc_years()` to return a vector of
#'  currently available years.
#' @param level Geographic level of data; options are `National`, `State`,
#'   and `County`
#' @param sublevel The state and/or county where the Medicare beneficiary
#'   resides. The values include the 50 United States, District of Columbia,
#'   Puerto Rico or U.S. Virgin Islands. Data aggregated at the National level
#'   are identified by "National'.
#' @param fips FIPS state and/or county code where the Medicare beneficiary
#'   resides. This column will be blank for data aggregated at the National
#'   level or for Puerto Rico and Virgin Islands.
#' @param age_group Identifies the age level of the population that the data has
#'   been aggregated. A value of `All` indicates the data in the row represents
#'   all Fee-for-Service Medicare Beneficiaries. A value of `<65` or `65+`
#'   indicates that the data is aggregated by the age of the Medicare
#'   Beneficiaries at the end of the calendar year.
#' @param demographic Identifies the demographic level of the population that the
#'   data has been aggregated. A value of `All` indicates the data in the row
#'   represents all Fee-for-Service Medicare beneficiaries. A value of `Sex`
#'   indicates that the data has been aggregated by the Medicare beneficiary's
#'   sex. A value of `Race` indicates that the data has been aggregated by the
#'   Medicare beneficiary's race. A value of `Dual Status` indicates that the
#'   data has been aggregated by the Medicare beneficiary's dual eligibility
#'   status.
#' @param subdemo For `Sex`, a beneficiary’s sex is classified
#'   as Male or Female and is identified using information from the CMS
#'   enrollment database. For `Race`, the race/ethnicity classifications are:
#'   Non-Hispanic White, Black or African American, Asian/Pacific Islander,
#'   Hispanic, and American Indian/Alaska Native. For `Dual Status`,
#'   beneficiaries can be classified as 'Medicare and Medicaid' or 'Medicare Only'.
#'   Beneficiaries enrolled in both Medicare and Medicaid are known as “dual
#'   eligibles.” Medicare beneficiaries are classified as dual eligibles if in
#'   any month in the given calendar year they were receiving full or partial
#'   Medicaid benefits.
#' @param condition Identifies the chronic condition for which the prevalence
#'    and utilization is compiled. There are 21 chronic conditions identified
#'    using Medicare administrative claims. A Medicare beneficiary is
#'    considered to have a chronic condition if the CMS administrative data
#'    have a claim indicating that the beneficiary received a service or
#'    treatment for the specific condition. Beneficiaries may have more than
#'    one of the chronic conditions listed.
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @format
#' \describe{
#'   \item{prevalence}{Prevalence estimates are calculated by taking the beneficiaries within the MCC category divided by the total number of beneficiaries in the fee-for-service population, expressed as a percentage.}
#'   \item{tot_std_pymt_percap}{Medicare standardized spending includes total Medicare payments for all covered services in Parts A and B and is presented per beneficiary (i.e. per capita). Standardized payments are presented to allow for comparisons across geographic areas in health care use among beneficiaries.}
#'   \item{tot_pymt_percap}{Medicare spending includes total Medicare payments for all covered services in Parts A and B and is presented per beneficiary (i.e. per capita).}
#'   \item{hosp_readmsn_rate}{Hospital readmissions are expressed as a percentage of all admissions. A 30-day readmission is defined as an admission to an acute care hospital for any cause within 30 days of discharge from an acute care hospital. Except when the patient died during the stay, each inpatient stay is classified as an index admission, a readmission, or both.}
#'   \item{er_visits_per_1k}{Emergency department visits are presented as the number of visits per 1,000 beneficiaries. ED visits include visits where the beneficiary was released from the outpatient setting and where the beneficiary was admitted to an inpatient setting.}
#' }
#' @examplesIf interactive()
#' cc_specific(year = 2018, level = "State", sublevel = "CA")
#' cc_specific(year = 2007, level  = "National", demographic = "Race")
#' @autoglobal
#' @export
cc_specific <- function(year,
                        condition     = NULL,
                        sublevel      = NULL,
                        level         = NULL,
                        fips          = NULL,
                        age_group     = NULL,
                        demographic   = NULL,
                        subdemo       = NULL,
                        tidy          = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(cc_years()))

  if (!is.null(level))       {rlang::arg_match(level, c("National", "State", "County"))}
  if (!is.null(age_group))   {rlang::arg_match(age_group, c("All", "<65", "65+"))}
  if (!is.null(demographic)) {rlang::arg_match(demographic, c("All", "Dual Status", "Sex", "Race"))}
  if (!is.null(fips))        {fips <- as.character(fips)}

  if (!is.null(sublevel) && (sublevel %in% state.abb)) {
    sublevel <- dplyr::tibble(x = state.abb, y = state.name) |>
      dplyr::filter(x == sublevel) |>
      dplyr::pull(y)
  }

  if (!is.null(subdemo)) {rlang::arg_match(subdemo, c("All", "Medicare Only",
  "Medicare and Medicaid", "Female", "Male", "Asian Pacific Islander",
  "Hispanic", "Native American", "non-Hispanic Black", "non-Hispanic White"))}

  id <- cms_update("Specific Chronic Conditions", "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  args <- dplyr::tribble(
    ~param,            ~arg,
    "Bene_Geo_Lvl",     level,
    "Bene_Geo_Desc",    sublevel,
    "Bene_Geo_Cd",      fips,
    "Bene_Age_Lvl",     age_group,
    "Bene_Demo_Lvl",    demographic,
    "Bene_Demo_Desc",   subdemo,
    "Bene_Cond",        condition)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "year",         year,
      "level",        level,
      "sublevel",     sublevel,
      "fips",         fips,
      "age_group",    age_group,
      "demographic",  demographic,
      "subdemo",      subdemo,
      "condition",    condition) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(year = as.integer(year),
                    dplyr::across(c(prvlnc,
                                    tot_mdcr_stdzd_pymt_pc,
                                    tot_mdcr_pymt_pc,
                                    hosp_readmsn_rate,
                                    er_visits_per_1000_benes),
                                  as.double)) |>
      ccs_cols()

  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
ccs_cols <- function(df) {

  cols <- c('year',
            'level' = 'bene_geo_lvl',
            'sublevel' = 'bene_geo_desc',
            'fips' = 'bene_geo_cd',
            'age' = 'bene_age_lvl',
            'demographic' = 'bene_demo_lvl',
            'subdemo' = 'bene_demo_desc',
            'condition' = 'bene_cond',
            'prevalence' = 'prvlnc',
            'tot_pymt_percap' = 'tot_mdcr_pymt_pc',
            'tot_std_pymt_percap' = 'tot_mdcr_stdzd_pymt_pc',
            'hosp_readmit_rate' = 'hosp_readmsn_rate',
            'er_visits_per_1k' = 'er_visits_per_1000_benes')

  df |> dplyr::select(dplyr::all_of(cols))

}

#' Search the Medicare Multiple Chronic Conditions API
#'
#' @description Information on prevalence, use and spending by count of select
#'   chronic conditions among Original Medicare (or fee-for-service)
#'   beneficiaries.
#'
#' @details The Multiple Chronic Conditions dataset provides information on the
#'   number of chronic conditions among Original Medicare beneficiaries. The
#'   dataset contains prevalence, use and spending organized by geography and
#'   the count of chronic conditions from the set of select 21 chronic
#'   conditions. The count of conditions is grouped into four categories (0-1,
#'   2-3, 4-5 and 6 or more).
#'
#'   ### Links
#'   - [Medicare Multiple Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/multiple-chronic-conditions)
#'
#' *Update Frequency:* **Annually**
#'
#' @param year integer, YYYY, calendar year of Medicare enrollment. Run the
#'  helper function `cc_years()` to return a vector of
#'  currently available years.
#' @param level Geographic level of data; options are `"National"`, `"State"`,
#'   and `"County"`
#' @param sublevel The state and/or county where the Medicare beneficiary
#'   resides. The values include the 50 United States, District of Columbia,
#'   Puerto Rico or U.S. Virgin Islands. Data aggregated at the National level
#'   are identified by "National'.
#' @param fips FIPS state and/or county code where the Medicare beneficiary
#'   resides. This column will be blank for data aggregated at the National
#'   level or for Puerto Rico and Virgin Islands.
#' @param age_group Population age level at which the data has been aggregated.
#' `"All"` includes all Fee-for-Service Medicare beneficiaries. `"<65"` or
#' `"65+"` returns data by those age groups.
#' @param demographic Population demographic level at which the data has been
#' aggregated. `"All"` includes all Fee-for-Service Medicare beneficiaries.
#' `"Sex"` aggregates by beneficiary gender,  `"Race"` by beneficiary race.
#' `"Dual Status"` aggregates by the beneficiary's dual eligibility status.
#' @param subdemo For `Sex`, a beneficiary’s sex is classified
#'   as Male or Female and is identified using information from the CMS
#'   enrollment database. For `Race`, the race/ethnicity classifications are:
#'   Non-Hispanic White, Black or African American, Asian/Pacific Islander,
#'   Hispanic, and American Indian/Alaska Native. For `Dual Status`,
#'   beneficiaries can be classified as 'Medicare and Medicaid' or 'Medicare Only'.
#'   Beneficiaries enrolled in both Medicare and Medicaid are known as “dual
#'   eligibles.” Medicare beneficiaries are classified as dual eligibles if in
#'   any month in the given calendar year they were receiving full or partial
#'   Medicaid benefits.
#' @param mcc To classify MCC for each Medicare beneficiary, the 21 chronic
#'   conditions are counted and grouped into four categories:
#'      - `"0 to 1"`
#'      - `"2 to 3"`
#'      - `"4 to 5"`
#'      - `"6+"`
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @format
#' \describe{
#'   \item{prevalence}{Prevalence estimates are calculated by taking the beneficiaries within the MCC category divided by the total number of beneficiaries in the fee-for-service population, expressed as a percentage.}
#'   \item{tot_std_pymt_percap}{Medicare standardized spending includes total Medicare payments for all covered services in Parts A and B and is presented per beneficiary (i.e. per capita). Standardized payments are presented to allow for comparisons across geographic areas in health care use among beneficiaries.}
#'   \item{tot_pymt_percap}{Medicare spending includes total Medicare payments for all covered services in Parts A and B and is presented per beneficiary (i.e. per capita).}
#'   \item{hosp_readmsn_rate}{Hospital readmissions are expressed as a percentage of all admissions. A 30-day readmission is defined as an admission to an acute care hospital for any cause within 30 days of discharge from an acute care hospital. Except when the patient died during the stay, each inpatient stay is classified as an index admission, a readmission, or both.}
#'   \item{er_visits_per_1k}{Emergency department visits are presented as the number of visits per 1,000 beneficiaries. ED visits include visits where the beneficiary was released from the outpatient setting and where the beneficiary was admitted to an inpatient setting.}
#' }
#' @examplesIf interactive()
#' cc_multiple(year = 2018, level = "State", sublevel = "California")
#' cc_multiple(year = 2007, level = "National", demographic = "Race")
#' @autoglobal
#' @export
cc_multiple <- function(year,
                        level         = NULL,
                        sublevel      = NULL,
                        fips          = NULL,
                        age_group     = NULL,
                        demographic   = NULL,
                        subdemo       = NULL,
                        mcc           = NULL,
                        tidy          = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, as.character(cc_years()))

  if (!is.null(level))       {rlang::arg_match(level, c("National", "State", "County"))}
  if (!is.null(age_group))   {rlang::arg_match(age_group, c("All", "<65", "65+"))}
  if (!is.null(demographic)) {rlang::arg_match(demographic, c("All", "Dual Status", "Sex", "Race"))}
  if (!is.null(mcc))         {rlang::arg_match(mcc, c("0 to 1", "2 to 3", "4 to 5", "6+"))}
  if (!is.null(fips))        {fips <- as.character(fips)}

  if (!is.null(sublevel) && (sublevel %in% state.abb)) {
    sublevel <- dplyr::tibble(x = state.abb, y = state.name) |>
      dplyr::filter(x == state) |>
      dplyr::pull(y)
  }

  if (!is.null(subdemo)) {rlang::arg_match(subdemo,
          c("All", "Medicare Only", "Medicare and Medicaid", "Female", "Male",
            "Asian Pacific Islander", "Hispanic", "Native American",
            "non-Hispanic Black", "non-Hispanic White"))}

  id <- cms_update("Multiple Chronic Conditions", "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  args <- dplyr::tribble(
    ~param,            ~arg,
    "Bene_Geo_Lvl",     level,
    "Bene_Geo_Desc",    sublevel,
    "Bene_Geo_Cd",      fips,
    "Bene_Age_Lvl",     age_group,
    "Bene_Demo_Lvl",    demographic,
    "Bene_Demo_Desc",   subdemo,
    "Bene_MCC",         mcc)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "year",         year,
      "level",        level,
      "sublevel",     sublevel,
      "fips",         fips,
      "age_group",    age_group,
      "demographic",  demographic,
      "subdemo",      subdemo,
      "mcc",          mcc) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(year = as.integer(year),
                    dplyr::across(c(prvlnc,
                                    tot_mdcr_stdzd_pymt_pc,
                                    tot_mdcr_pymt_pc,
                                    hosp_readmsn_rate,
                                    er_visits_per_1000_benes),
                                  as.double)) |>
      ccm_cols()
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
ccm_cols <- function(df) {

  cols <- c('year',
            'level' = 'bene_geo_lvl',
            'sublevel' = 'bene_geo_desc',
            'fips' = 'bene_geo_cd',
            'age' = 'bene_age_lvl',
            'demographic' = 'bene_demo_lvl',
            'subdemo' = 'bene_demo_desc',
            'mcc' = "bene_mcc",
            'prevalence' = 'prvlnc',
            'tot_pymt_percap' = 'tot_mdcr_pymt_pc',
            'tot_std_pymt_percap' = 'tot_mdcr_stdzd_pymt_pc',
            'hosp_readmit_rate' = 'hosp_readmsn_rate',
            'er_visits_per_1k' = 'er_visits_per_1000_benes')

  df |> dplyr::select(dplyr::all_of(cols))

}

# chronic_conditions <- function(year,
#                                type = c("specific", "multiple"),
#                                sublevel = NULL,
#                                level = NULL,
#                                fips = NULL,
#                                age_group = NULL,
#                                demographic = NULL,
#                                subdemo = NULL,
#                                condition = NULL,
#                                mcc = NULL,
#                                tidy = TRUE) {
#
# }
