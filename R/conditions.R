#' Beneficiary Chronic Conditions Prevalence
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [conditions()] allows the user access to data concerning chronic conditions
#' among Original Medicare (or fee-for-service) beneficiaries.
#'
#' @section `set = "specific"`:
#'
#' The __Specific Chronic Conditions__ dataset provides information on
#' prevalence, use and spending organized by geography and 21 distinct chronic
#' conditions among Original Medicare beneficiaries:
#'
#' 1. Alcohol Abuse
#' 1. Alzheimer’s Disease/Dementia
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
#' @section `set = "multiple"`:
#'
#' The __Multiple Chronic Conditions__ dataset provides information on
#' prevalence, use and spending organized by geography and the count of chronic
#' conditions from the set of select 21 chronic conditions. The count of
#' conditions is grouped into four categories:
#'
#' 1. __0-1__
#' 1. __2-3__
#' 1. __4-5__
#' 1. __6 or More__
#'
#' @section Prevalence:
#' Prevalence estimates are calculated by taking the beneficiaries within the
#' MCC category divided by the total number of beneficiaries in the
#' fee-for-service population, expressed as a percentage.
#'
#' @section Hospital Readmission Rates:
#' Hospital readmissions are expressed as a percentage of all admissions. A
#' 30-day readmission is defined as an admission to an acute care hospital for
#' any cause within 30 days of discharge from an acute care hospital. Except
#' when the patient died during the stay, each inpatient stay is classified as
#' an index admission, a readmission, or both.
#'
#' @section Emergency Department Visits:
#' Emergency department visits are presented as the number of visits per 1,000
#' beneficiaries. ED visits include visits where the beneficiary was released
#' from the outpatient setting and where the beneficiary was admitted to an
#' inpatient setting.
#'
#' @section Payment Per Capita:
#' Medicare spending includes total Medicare payments for all covered services
#' in Parts A and B and is presented per beneficiary (i.e. per capita).
#' Standardized payments are presented to allow for comparisons across
#' geographic areas in health care use among beneficiaries.
#'
#' @section Links:
#' + [Medicare Multiple Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/multiple-chronic-conditions)
#' + [Medicare Specific Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions)
#'
#' @param year < *integer* > Calendar year of Medicare enrollment, in `YYYY`
#' format. Run [cc_years()] to return a vector of currently available years.
#' @param set < *character* > // **required** `"multiple"` or `"specific"`
#' @param level < *character* > Geographic level of aggregation: `"national"`, `"state"`, or `"county"`
#' @param sublevel < *character* > Beneficiary's state or county
#' @param fips < *character* > Beneficiary's state or county FIPS code
#' @param age < *character* > Age level of aggregation: `"all"`, `"<65"`, or `"65+"`
#' @param demo,subdemo < *character* > __Demographic__, _subdemographic_ level of
#' aggregation: __`"all"`__, __`"sex"`__ (`"male"`, `"female"`), __`"race"`__ (`"white"`,
#' `"black"`, `"island"`, `"hispanic"`, `"native"`), __`"dual"`__ (`"nondual"`, `"dual"`).
#' @param mcc < *character* > Number of chronic conditions: `"0-1"`, `"2-3"`, `"4-5"`, `"6+"`
#' @param condition < *character* > Chronic condition for which the prevalence
#' and utilization is compiled (see above for list of conditions)
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @returns A [tibble][tibble::tibble-package] with the following columns:
#'
#' @examplesIf interactive()
#' conditions(year = 2018, set = "specific", sublevel = "CA", demo = "all")
#' conditions(year = 2018, set = "specific", sublevel = "CA", subdemo = "female", age = "all")
#' conditions(year = 2018, set = "multiple", sublevel = "California", subdemo = "female")
#'
#' conditions(year = 2007, set = "specific", level = "national", demo = "race")
#' conditions(year = 2007, set = "multiple", level = "national", demo = "race")
#' @autoglobal
#' @export
conditions <- function(year,
                       condition = NULL,
                       sublevel = NULL,
                       set = c("multiple", "specific"),
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

  rlang::arg_match(year, as.character(cc_years()))
  rlang::arg_match(set, c("multiple", "specific"))

  if (!is.null(mcc)) {
    if (set == "specific") {
      cli::cli_abort(c("{.arg mcc} is only available for {.arg type = 'specific'}."))}
    rlang::arg_match(mcc, mcc())
    mcc <- mcc_convert(mcc)
  }

  if (!is.null(condition)) {
    if (set == "multiple") {
      cli::cli_abort(c("{.arg condition} is only available for {.arg type = 'multiple'}."))}
  }

  if (!is.null(level)) {
    rlang::arg_match(level, levels())
    level <- stringr::str_to_title(level)
  }

  if (!is.null(age)) {
    rlang::arg_match(age, ages())
    if (age == "all") {age <- "All"}
  }

  if (!is.null(demo)) {
    rlang::arg_match(demo, demo())
    demo <- demo_convert(demo)
  }

  if (!is.null(subdemo)) {
    rlang::arg_match(subdemo, subdemo())
    subdemo <- subdemo_convert(subdemo)
  }

  if (!is.null(sublevel) && (sublevel %in% state.abb)) {
    sublevel <- abb2full(sublevel)
  }

  fips <- fips %nn% as.character(fips)

  args <- dplyr::tribble(
    ~param,            ~arg,
    "Bene_Geo_Lvl",     level,
    "Bene_Geo_Desc",    sublevel,
    "Bene_Geo_Cd",      fips,
    "Bene_Age_Lvl",     age,
    "Bene_Demo_Lvl",    demo,
    "Bene_Demo_Desc",   subdemo,
    "Bene_MCC",         mcc,
    "Bene_Cond",        condition)

  if (set == "multiple") yr <- api_years("mcc")
  if (set == "specific") yr <- api_years("scc")

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
      "mcc",          mcc) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results$year <- year
    results <- cols_cc(tidyup(results,
                              int = "year",
                              dbl = c("prvlnc", "_pc", "er_"),
                              yr = "year"))
  if (na.rm) {results <- narm(results)}}
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
            'mcc'                 = "bene_mcc",
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
levels <- function() {c("national", "state", "county")}

#' @autoglobal
#' @noRd
ages <- function() {c("all", "<65", "65+")}

#' @autoglobal
#' @noRd
demo <- function() {c("all", "dual", "sex", "race")}

#' @param x demo level
#' @return demo level
#' @autoglobal
#' @noRd
demo_convert <- function(x) {
  dplyr::tibble(
    x = demo(),
    y = c("All", "Dual Status", "Sex", "Race")) |>
    dplyr::filter(x == {{ x }}) |>
    dplyr::pull(y)
}

#' @autoglobal
#' @noRd
subdemo <- function() {
  c("all",
    "nondual",
    "dual",
    "female",
    "male",
    "island",
    "hispanic",
    "native",
    "black",
    "white")
}

#' @param x subdemo level
#' @return subdemo level
#' @autoglobal
#' @noRd
subdemo_convert <- function(x) {
  dplyr::tibble(
    x = subdemo(),
    y = c("All",
          "Medicare Only",
          "Medicare and Medicaid",
          "Female",
          "Male",
          "Asian Pacific Islander",
          "Hispanic",
          "Native American",
          "non-Hispanic Black",
          "non-Hispanic White")) |>
    dplyr::filter(x == {{ x }}) |>
    dplyr::pull(y)
}

#' @autoglobal
#' @noRd
mcc <- function() {c("0-1", "2-3", "4-5", "6+")}

#' @param x mcc arg
#' @return mcc arg
#' @autoglobal
#' @noRd
mcc_convert <- function(x) {
  dplyr::tibble(
    x = mcc(),
    y = c("0 to 1", "2 to 3", "4 to 5", "6+")) |>
    dplyr::filter(x == {{ x }}) |>
    dplyr::pull(y)
}
