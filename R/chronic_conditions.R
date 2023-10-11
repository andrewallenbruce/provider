#' Chronic Conditions
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' These functions allow the user access to data concerning chronic conditions
#' among Original Medicare (or fee-for-service) beneficiaries.
#'
#' @section [cc_specific()]:
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
#' @section [cc_multiple()]:
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
#' @section Links:
#' + [Medicare Multiple Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/multiple-chronic-conditions)
#' + [Medicare Specific Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions)
#'
#' *Update Frequency:* **Annually**
#'
#' @returns A [tibble][tibble::tibble-package].
#' @format
#' \describe{
#'   \item{prevalence}{Prevalence estimates are calculated by taking the beneficiaries within the MCC category divided by the total number of beneficiaries in the fee-for-service population, expressed as a percentage.}
#'   \item{tot_std_pymt_percap}{Medicare standardized spending includes total Medicare payments for all covered services in Parts A and B and is presented per beneficiary (i.e. per capita). Standardized payments are presented to allow for comparisons across geographic areas in health care use among beneficiaries.}
#'   \item{tot_pymt_percap}{Medicare spending includes total Medicare payments for all covered services in Parts A and B and is presented per beneficiary (i.e. per capita).}
#'   \item{hosp_readmsn_rate}{Hospital readmissions are expressed as a percentage of all admissions. A 30-day readmission is defined as an admission to an acute care hospital for any cause within 30 days of discharge from an acute care hospital. Except when the patient died during the stay, each inpatient stay is classified as an index admission, a readmission, or both.}
#'   \item{er_visits_per_1k}{Emergency department visits are presented as the number of visits per 1,000 beneficiaries. ED visits include visits where the beneficiary was released from the outpatient setting and where the beneficiary was admitted to an inpatient setting.}
#' }
#'
#' @examplesIf interactive()
#' cc_specific(year = 2018, level = "State", sublevel = "CA")
#' cc_multiple(year = 2018, level = "State", sublevel = "California")
#'
#' cc_specific(year = 2007, level = "National", demo = "Race")
#' cc_multiple(year = 2007, level = "National", demo = "Race")
#'
#' @name chronic_conditions
NULL

#' @param year < *integer* > // **required** Calendar year of Medicare
#' enrollment, in `YYYY` format. Run [cc_years()] to return a vector of
#' currently available years.
#' @param level < *character* > Geographic level of aggregation
#' + `"National"`
#' + `"State"`
#' + `"County"`
#' @param sublevel < *character* > Beneficiary's state or county
#' @param fips < *character* > Beneficiary's state or county FIPS code
#' @param age < *character* > Age group level of aggregation
#' + `"All"`
#' + `"<65"`
#' + `"65+"`
#' @param demo,subdemo < *character* > Demographic level of aggregation
#' + `"All"`
#' + `"Sex"` /// `"Male"` // `"Female"`
#' + `"Race"` /// `"non-Hispanic White"` // `"non-Hispanic Black"` // `"Asian Pacific Islander"` // `"Hispanic"` // `"Native American"`
#' + `"Dual Status"` /// `"Medicare and Medicaid"` // `"Medicare Only"`
#' @param mcc < *character* > Number of chronic conditions
#' + `"0-1"`
#' + `"2-3"`
#' + `"4-5"`
#' + `"6+"`
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @rdname chronic_conditions
#' @autoglobal
#' @export
cc_multiple <- function(year,
                        level = NULL,
                        sublevel = NULL,
                        fips = NULL,
                        age = NULL,
                        demo = NULL,
                        subdemo = NULL,
                        mcc = NULL,
                        tidy = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, as.character(cc_years()))

  if (!is.null(level)) {rlang::arg_match(level, c("National", "State", "County"))}
  if (!is.null(age)) {rlang::arg_match(age, c("All", "<65", "65+"))}
  if (!is.null(demo)) {rlang::arg_match(demo, c("All", "Dual Status", "Sex", "Race"))}
  if (!is.null(subdemo)) {rlang::arg_match(subdemo, subdemo())}
  if (!is.null(mcc)) {rlang::arg_match(mcc, c("0 to 1", "2 to 3", "4 to 5", "6+"))}
  if (!is.null(fips)) {fips <- as.character(fips)}

  if (!is.null(sublevel) && (sublevel %in% state.abb)) {
    sublevel <- dplyr::tibble(x = state.abb, y = state.name) |>
      dplyr::filter(x == state) |>
      dplyr::pull(y)
  }

  args <- dplyr::tribble(
    ~param,            ~arg,
    "Bene_Geo_Lvl",     level,
    "Bene_Geo_Desc",    sublevel,
    "Bene_Geo_Cd",      fips,
    "Bene_Age_Lvl",     age,
    "Bene_Demo_Lvl",    demo,
    "Bene_Demo_Desc",   subdemo,
    "Bene_MCC",         mcc)

  id <- api_years("mcc") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

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
      "age",          age,
      "demo",         demo,
      "subdemo",      subdemo,
      "mcc",          mcc) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {results <- cols_cc(tidyup(results, int = c("year"),
                                       dbl = c("prvlnc", "_pc", "er_")))}
  return(results)
}

#' @param year < *integer* > // **required** Calendar year of Medicare
#' enrollment, in `YYYY` format. Run [cc_years()] to return a vector of
#' currently available years.
#' @param level < *character* > Geographic level of aggregation
#' + `"National"`
#' + `"State"`
#' + `"County"`
#' @param sublevel < *character* > Beneficiary's state or county
#' @param fips < *character* > Beneficiary's state or county FIPS code
#' @param age < *character* > Age group level of aggregation
#' + `"All"`
#' + `"<65"`
#' + `"65+"`
#' @param demo,subdemo < *character* > Demographic level of aggregation
#' + __`"All"`__
#' + __`"Sex"`__: `"Male"`, `"Female"`
#' + __`"Race"`__: `"non-Hispanic White"`, `"non-Hispanic Black"`, `"Asian Pacific Islander"`, `"Hispanic"`, `"Native American"`
#' + __`"Dual Status"`__: `"Medicare and Medicaid"`, `"Medicare Only"`
#' @param condition < *character* > Chronic condition for which the prevalence
#' and utilization is compiled
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @rdname chronic_conditions
#' @autoglobal
#' @export
cc_specific <- function(year,
                        condition = NULL,
                        sublevel = NULL,
                        level = NULL,
                        fips = NULL,
                        age = NULL,
                        demo = NULL,
                        subdemo = NULL,
                        tidy = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(cc_years()))

  if (!is.null(level)) {rlang::arg_match(level, c("National", "State", "County"))}
  if (!is.null(age)) {rlang::arg_match(age, c("All", "<65", "65+"))}
  if (!is.null(demo)) {rlang::arg_match(demo, c("All", "Dual Status", "Sex", "Race"))}
  if (!is.null(subdemo)) {rlang::arg_match(subdemo, subdemo())}
  if (!is.null(fips)) {fips <- as.character(fips)}

  if (!is.null(sublevel) && (sublevel %in% state.abb)) {
    sublevel <- dplyr::tibble(x = state.abb, y = state.name) |>
      dplyr::filter(x == sublevel) |>
      dplyr::pull(y)
  }

  args <- dplyr::tribble(
    ~param,            ~arg,
    "Bene_Geo_Lvl",     level,
    "Bene_Geo_Desc",    sublevel,
    "Bene_Geo_Cd",      fips,
    "Bene_Age_Lvl",     age,
    "Bene_Demo_Lvl",    demo,
    "Bene_Demo_Desc",   subdemo,
    "Bene_Cond",        condition)

  id <- api_years("scc") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

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
      "age",          age,
      "demo",         demo,
      "subdemo",      subdemo,
      "condition",    condition) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {results <- cols_cc(tidyup(results, int = c("year"),
                              dbl = c("prvlnc", "_pc", "er_")))}
  return(results)
}

#' @autoglobal
#' @noRd
subdemo <- function(df) {

  c("All",
    "Medicare Only",
    "Medicare and Medicaid",
    "Female",
    "Male",
    "Asian Pacific Islander",
    "Hispanic",
    "Native American",
    "non-Hispanic Black",
    "non-Hispanic White")
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
