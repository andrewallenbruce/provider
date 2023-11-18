#' Chronic Conditions Prevalence
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [conditions()] allows the user access to data concerning chronic conditions
#' among Original Medicare (or fee-for-service) beneficiaries.
#'
#' @section Specific Conditions:
#'
#' The _Specific_ Chronic Conditions(`set = "Specific"`) dataset provides
#' information on prevalence, use and spending organized by geography and 21
#' distinct chronic conditions:
#'
#' 1. Alcohol Abuse
#' 1. Alzheimer's Disease/Dementia
#' 1. Arthritis
#' 1. Asthma
#' 1. Atrial Fibrillation
#' 1. Autism Spectrum Disorders
#' 1. Cancer
#' 1. Chronic Kidney Disease
#' 1. COPD
#' 1. Depression
#' 1. Diabetes
#' 1. Drug Abuse/Substance Abuse
#' 1. Heart Failure
#' 1. Hepatitis (Chronic Viral B & C)
#' 1. HIV/AIDS
#' 1. Hyperlipidemia
#' 1. Hypertension
#' 1. Ischemic Heart Disease
#' 1. Osteoporosis
#' 1. Schizophrenia and Other Psychotic Disorders
#' 1. Stroke
#'
#' @section Multiple Conditions:
#'
#' The _Multiple_ Chronic Conditions(`set = "Multiple"`) dataset provides
#' information on prevalence, use and spending organized by geography and the
#' count of chronic conditions from the set of select 21 chronic conditions.
#' The count of conditions is binned into four categories:
#'
#' 1. __0-1__
#' 1. __2-3__
#' 1. __4-5__
#' 1. __6 or More__
#'
#' @section Prevalence:
#'
#' Prevalence estimates are calculated by taking the beneficiaries within the
#' MCC category divided by the total number of beneficiaries in the
#' fee-for-service population, expressed as a percentage.
#'
#' @section Hospital Readmission Rates:
#'
#' Hospital readmissions are expressed as a percentage of all admissions. A
#' 30-day readmission is defined as an admission to an acute care hospital for
#' any cause within 30 days of discharge from an acute care hospital. Except
#' when the patient died during the stay, each inpatient stay is classified as
#' an index admission, a readmission, or both.
#'
#' @section Emergency Department Visits:
#'
#' Emergency department visits are presented as the number of visits per 1,000
#' beneficiaries. ED visits include visits where the beneficiary was released
#' from the outpatient setting and where the beneficiary was admitted to an
#' inpatient setting.
#'
#' @section Payment Per Capita:
#'
#' Medicare spending includes total Medicare payments for all covered services
#' in Parts A and B and is presented per beneficiary (i.e. per capita).
#' Standardized payments are presented to allow for comparisons across
#' geographic areas in health care use among beneficiaries.
#'
#' @section Links:
#'
#' + [Medicare Multiple Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/multiple-chronic-conditions)
#' + [Medicare Specific Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions)
#'
#' @param year < *integer* > Calendar year of Medicare enrollment, in `YYYY`
#' format. Run [cc_years()] to return a vector of currently available years.
#' @param set < *character* > // **required** `"Multiple"` or `"Specific"`
#' @param level < *character* > Geographic level of aggregation: `"National"`, `"State"`, or `"County"`
#' @param sublevel < *character* > Beneficiary's state or county
#' @param fips < *character* > Beneficiary's state or county FIPS code
#' @param age < *character* > Age level of aggregation: `"All"`, `"<65"`, or `"65+"`
#' @param demo,subdemo < *character* > Demographic/subdemographic level of aggregation:
#'
#' |**`demo`**      |**`subdemo`**                  |
#' |:---------------|:------------------------------|
#' |`'All'`         |`'All'`                        |
#' |`'Sex'`         |`'Male'`                       |
#' | ''             |`'Female'`                     |
#' |`'Race'`        |`'White'`                      |
#' | ''             |`'Black'`                      |
#' | ''             |`'Island'`                     |
#' | ''             |`'Hispanic'`                   |
#' | ''             |`'Native'`                     |
#' |`'Dual Status'` |`'Dual'` (Medicare & Medicaid) |
#' | ''             |`'Nondual'` (Medicare only)    |
#'
#' @param mcc < *character* > Number of chronic conditions: `"0-1"`, `"2-3"`, `"4-5"`, `"6+"`
#' @param condition < *character* > Chronic condition for which the prevalence
#' and utilization is compiled (see details for list of conditions)
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @returns A [tibble][tibble::tibble-package] with the following columns:
#'
#' @examplesIf interactive()
#' conditions(year = 2018,
#'            set = "Specific",
#'            sublevel = "CA",
#'            demo = "All")
#'
#' conditions(year = 2018,
#'            set = "Specific",
#'            sublevel = "CA",
#'            subdemo = "Female",
#'            age = "All")
#'
#' conditions(year = 2018,
#'            set = "Multiple",
#'            sublevel = "California",
#'            subdemo = "Female")
#'
#' conditions(year = 2007,
#'            set = "Specific",
#'            level = "National",
#'            demo = "Race",
#'            condition = "Alzheimer's Disease/Dementia")
#'
#' conditions(year = 2007,
#'            set = "Multiple",
#'            level = "National",
#'            demo = "Race")
#' @autoglobal
#' @export
conditions <- function(year,
                       condition = NULL,
                       sublevel = NULL,
                       set = c("Multiple", "Specific"),
                       level = NULL,
                       fips = NULL,
                       age = NULL,
                       demo = NULL,
                       subdemo = NULL,
                       mcc = NULL,
                       tidy = TRUE,
                       na.rm = TRUE) {

  rlang::check_required(year)
  rlang::check_required(set)
  year <- as.character(year)
  year <- rlang::arg_match(year, as.character(cc_years()))
  set  <- rlang::arg_match(set, c("Multiple", "Specific"))

  if (!is.null(mcc)) {
    if (set == "Specific") {
      cli::cli_abort(c("{.arg mcc} is only available for {.arg set = 'Multiple'}."))} # nolint
    mcc <- rlang::arg_match(mcc, names(mcc()))
    mcc <- lookup(mcc(), mcc)
    condition2 <- NULL
  }

  if (!is.null(condition)) {
    if (set == "Multiple") {
      cli::cli_abort(c("{.arg condition} is only available for {.arg set = 'Specific'}."))} # nolint
    condition <- rlang::arg_match(condition, names(spec_cond()))
    condition2 <- lookup(spec_cond(), condition)
  }

  level <- level %nn% rlang::arg_match(level, levels())
  age   <- age   %nn% rlang::arg_match(age, ages())
  demo  <- demo  %nn% rlang::arg_match(demo, demo())
  fips  <- fips  %nn% as.character(fips)

  if (!is.null(subdemo)) {
    subdemo <- rlang::arg_match(subdemo, names(subdemo()))
    subdemo <- lookup(subdemo(), subdemo)
  }

  if (!is.null(sublevel) && (sublevel %in% state.abb)) sublevel <- abb2full(sublevel)

  args <- dplyr::tribble(
    ~param,            ~arg,
    "Bene_Geo_Lvl",     level,
    "Bene_Geo_Desc",    sublevel,
    "Bene_Geo_Cd",      fips,
    "Bene_Age_Lvl",     age,
    "Bene_Demo_Lvl",    demo,
    "Bene_Demo_Desc",   subdemo,
    "Bene_MCC",         mcc,
    "Bene_Cond",        condition2)

  if (set == "Multiple") yr <- api_years("mcc")
  if (set == "Specific") yr <- api_years("scc")

  id <- dplyr::filter(yr, year == {{ year }}) |> dplyr::pull(distro)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "year",         year,
      "level",        level,
      "sublevel",     sublevel,
      "fips",         fips,
      "age",          age,
      "demo",         demo,
      "subdemo",      subdemo,
      "mcc",          mcc,
      "condition",    condition) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (!tidy) results <- df2chr(results)

  if (tidy) {
    results$year <- year
    results <- cols_cc(tidyup(results,
                              int = "year",
                              dbl = c("prvlnc",
                                      "_pc",
                                      "er_",
                                      "_rate"))) |>
      dplyr::mutate(level       = fct_level(level),
                    sublevel    = fct_stname(sublevel),
                    age         = fct_age(age),
                    demographic = fct_demo(demographic),
                    subdemo     = fct_subdemo(subdemo))

  if (set == "Multiple") results$mcc       <- fct_mcc(results$mcc)
  if (set == "Specific") results$condition <- fct_cc(results$condition)
  if (na.rm) results <- narm(results)
    }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_cc <- function(df) {

  cols <- c('year',
            'level'               = 'bene_geo_lvl',
            'sublevel'            = 'bene_geo_desc',
            'fips'                = 'bene_geo_cd',
            'age'                 = 'bene_age_lvl',
            'demographic'         = 'bene_demo_lvl',
            'subdemo'             = 'bene_demo_desc',
            'mcc'                 = 'bene_mcc',
            'condition'           = 'bene_cond',
            'prevalence'          = 'prvlnc',
            'tot_pymt_percap'     = 'tot_mdcr_pymt_pc',
            'tot_std_pymt_percap' = 'tot_mdcr_stdzd_pymt_pc',
            'hosp_readmit_rate'   = 'hosp_readmsn_rate',
            'er_visits_per_1k'    = 'er_visits_per_1000_benes')

  df |> dplyr::select(dplyr::any_of(cols))
}

#' @autoglobal
#' @noRd
levels <- function() c("National", "State", "County")

#' @autoglobal
#' @noRd
ages <- function() c("All", "<65", "65+")

#' @autoglobal
#' @noRd
demo <- function() c("All", "Dual Status", "Sex", "Race")

#' @autoglobal
#' @noRd
subdemo <- function() {
  c("All"      = "All",
    "Nondual"  = "Medicare Only",
    "Dual"     = "Medicare and Medicaid",
    "Female"   = "Female",
    "Male"     = "Male",
    "Island"   = "Asian Pacific Islander",
    "Hispanic" = "Hispanic",
    "Native"   = "Native American",
    "Black"    = "non-Hispanic Black",
    "White"    = "non-Hispanic White")
}

#' @autoglobal
#' @noRd
mcc <- function() {
  c("0-1" = "0 to 1",
    "2-3" = "2 to 3",
    "4-5" = "4 to 5",
    "6+"  = "6+")
}

#' @param table lookup table, e.g. `mcc()`
#' @param item phrase to search for, e.g. `"0-1"`
#' @autoglobal
#' @noRd
lookup <- function(table, item) {
  out <- table[item]
  unname(out)
}

#' @autoglobal
#' @noRd
spec_cond <- function() {
  c('All'                                         = 'All',
    'Alcohol Abuse'                               = 'Alcohol Abuse',
    "Alzheimer's Disease/Dementia"                = "Alzheimer's Disease%2FDementia",
    'Arthritis'                                   = 'Arthritis',
    'Asthma'                                      = 'Asthma',
    'Atrial Fibrillation'                         = 'Atrial Fibrillation',
    'Autism Spectrum Disorders'                   = 'Autism Spectrum Disorders',
    'Cancer'                                      = 'Cancer',
    'Chronic Kidney Disease'                      = 'Chronic Kidney Disease',
    'COPD'                                        = 'COPD',
    'Depression'                                  = 'Depression',
    'Diabetes'                                    = 'Diabetes',
    'Drug Abuse/Substance Abuse'                  = 'Drug Abuse%2FSubstance Abuse',
    'Heart Failure'                               = 'Heart Failure',
    'Hepatitis (Chronic Viral B & C)'             = 'Hepatitis (Chronic Viral B %26 C)',
    'HIV/AIDS'                                    = 'HIV%2FAIDS',
    'Hyperlipidemia'                              = 'Hyperlipidemia',
    'Hypertension'                                = 'Hypertension',
    'Ischemic Heart Disease'                      = 'Ischemic Heart Disease',
    'Osteoporosis'                                = 'Osteoporosis',
    'Schizophrenia and Other Psychotic Disorders' = 'Schizophrenia and Other Psychotic Disorders',
    'Stroke'                                      = 'Stroke')
}

#' Convert multiple chronic condition groups to labelled, ordered factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_cc <- function(x) {
  factor(x,
         levels = c('All',
                    'Alcohol Abuse',
                    "Alzheimer's Disease/Dementia",
                    'Arthritis',
                    'Asthma',
                    'Atrial Fibrillation',
                    'Autism Spectrum Disorders',
                    'Cancer',
                    'Chronic Kidney Disease',
                    'COPD',
                    'Depression',
                    'Diabetes',
                    'Drug Abuse/Substance Abuse',
                    'Heart Failure',
                    'Hepatitis (Chronic Viral B & C)',
                    'HIV/AIDS',
                    'Hyperlipidemia',
                    'Hypertension',
                    'Ischemic Heart Disease',
                    'Osteoporosis',
                    'Schizophrenia and Other Psychotic Disorders',
                    'Stroke'),
         ordered = TRUE)
}
