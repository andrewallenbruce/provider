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
#'   ## Links
#' * [Medicare Multiple Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/multiple-chronic-conditions)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Annually**
#' @param year integer, YYYY, calendar year of Medicare enrollment. Run the
#'  helper function `provider:::cc_multiple_years()` to return a vector of
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
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @format ## In addition to the searchable columns:
#' \describe{
#'   \item{mcc}{To classify MCC for each Medicare beneficiary, the 21 chronic conditions are counted and grouped into four categories (0-1, 2-3, 4-5 and 6 or more).}
#'   \item{prevalence}{Prevalence estimates are calculated by taking the beneficiaries within the MCC category divided by the total number of beneficiaries in the fee-for-service population, expressed as a percentage.}
#'   \item{tot_std_pymt_percap}{Medicare standardized spending includes total Medicare payments for all covered services in Parts A and B and is presented per beneficiary (i.e. per capita). Standardized payments are presented to allow for comparisons across geographic areas in health care use among beneficiaries.}
#'   \item{tot_pymt_percap}{Medicare spending includes total Medicare payments for all covered services in Parts A and B and is presented per beneficiary (i.e. per capita).}
#'   \item{hosp_readmsn_rate}{Hospital readmissions are expressed as a percentage of all admissions. A 30-day readmission is defined as an admission to an acute care hospital for any cause within 30 days of discharge from an acute care hospital. Except when the patient died during the stay, each inpatient stay is classified as an index admission, a readmission, or both.}
#'   \item{er_visits_per_1k}{Emergency department visits are presented as the number of visits per 1,000 beneficiaries. ED visits include visits where the beneficiary was released from the outpatient setting and where the beneficiary was admitted to an inpatient setting.}
#' }
#' @examples
#' \dontrun{
#' cc_multiple(year = 2018, level  = "State", sublevel = "California")
#' cc_multiple(year = 2007, level = "National", demographic = "Race")
#' }
#' @autoglobal
#' @export
cc_multiple <- function(year,
                        level         = NULL,
                        sublevel      = NULL,
                        fips          = NULL,
                        age_group     = NULL,
                        demographic   = NULL,
                        subdemo       = NULL,
                        tidy          = TRUE) {

  # match args ----------------------------------------------------
  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(cc_multiple_years()))
  if (!is.null(level)) {rlang::arg_match(level, c("National", "State", "County"))}
  if (!is.null(age_group)) {rlang::arg_match(age_group, c("All", "<65", "65+"))}
  if (!is.null(demographic)) {rlang::arg_match(demographic, c("All", "Dual Status", "Sex", "Race"))}

  if (!is.null(subdemo)) {rlang::arg_match(subdemo, c("All", "Medicare Only",
  "Medicare and Medicaid", "Female", "Male", "Asian Pacific Islander",
  "Hispanic", "Native American", "non-Hispanic Black", "non-Hispanic White"))}

  # update distribution ids -------------------------------------------------
  id <- cms_update(api = "Multiple Chronic Conditions", check = "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                 ~y,
    "Bene_Geo_Lvl",     level,
    "Bene_Geo_Desc",    sublevel,
    "Bene_Geo_Cd",      fips,
    "Bene_Age_Lvl",     age_group,
    "Bene_Demo_Lvl",    demographic,
    "Bene_Demo_Desc",   subdemo)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ------------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (httr2::resp_header(response, "content-length") == "0") {

    cli_args <- tibble::tribble(
      ~x,             ~y,
      "year",         as.character(year),
      "level",        level,
      "sublevel",     sublevel,
      "fips",         as.character(fips),
      "age_group",    age_group,
      "demographic",  demographic,
      "subdemo",      subdemo) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
    return(invisible(NULL))
  }

    results <- tibble::tibble(httr2::resp_body_json(response,
      check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {

    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(year = as.integer(year)) |>
      dplyr::select(year,
                    level               = bene_geo_lvl,
                    sublevel            = bene_geo_desc,
                    fips                = bene_geo_cd,
                    age_group           = bene_age_lvl,
                    demographic         = bene_demo_lvl,
                    subdemo             = bene_demo_desc,
                    mcc                 = bene_mcc,
                    prevalence          = prvlnc,
                    tot_std_pymt_percap = tot_mdcr_stdzd_pymt_pc,
                    tot_pymt_percap     = tot_mdcr_pymt_pc,
                    hosp_readmsn_rate,
                    er_visits_per_1k    = er_visits_per_1000_benes) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(c(prevalence,
                                    tot_std_pymt_percap,
                                    tot_pymt_percap,
                                    hosp_readmsn_rate,
                                    er_visits_per_1k),
                                  as.double),
                    mcc = convert_breaks(mcc))
    }
  return(results)
}

#' Check the current years available for the Multiple Chronic Conditions API
#' @return integer vector of years available
#' @examples
#' cc_multiple_years()
#' @autoglobal
#' @export
cc_multiple_years <- function() {
  cms_update("Multiple Chronic Conditions", "years") |>
    as.integer()
  }
