#' Beneficiary Enrollment in Medicare
#'
#' @description
#' Access current data on enrolled Medicare beneficiaries.
#'
#' @section Medicare Monthly Enrollment:
#' Current monthly information on the number of Medicare beneficiaries with
#' hospital/medical coverage and prescription drug coverage, available for
#' several geographic areas including national, state and county.
#'
#' The hospital/medical coverage data can be broken down further by health care
#' delivery (Original Medicare versus Medicare Advantage and Other Health Plans)
#' and the prescription drug coverage data can be examined by those enrolled in
#' stand-alone Prescription Drug Plans and those enrolled in Medicare Advantage
#' Prescription Drug plans.
#'
#' The dataset includes enrollee counts on a *rolling 12 month basis*.
#'
#' @section Links:
#' + [Medicare Monthly Enrollment](https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param year < *integer* > Calendar year of Medicare enrollment; current years
#' can be checked with:
#' + `bene_years("year")`: Years available for all 12 months
#' + `bene_years("month")`: Years available for individual months
#' @param period < *character* > Time frame of Medicare enrollment; options
#' are `"Year"`, `Month`, or any individual month name
#' @param level < *character* > Geographic level of data; options are
#' `"National"`, `"State"`, or `"County"`
#' @param state < *character* > Full state name or abbreviation of
#' beneficiary residence
#' @param county < *character* > County of beneficiary residence
#' @param fips < *character* > FIPS code of beneficiary residence
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param ... Empty
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**           |**Description**                                         |
#' |:-------------------|:-------------------------------------------------------|
#' |`year`              |Enrollment calendar year                                |
#' |`period`            |Enrollment time frame                                   |
#' |`level`             |Geographic level of data                                |
#' |`state`             |Beneficiary residence state                             |
#' |`state_name`        |Beneficiary residence state name                        |
#' |`county`            |Beneficiary residence county                            |
#' |`fips`              |Beneficiary residence FIPS code                         |
#' |`bene_total`        |Total Medicare beneficiaries                            |
#' |`bene_orig`         |Original Medicare beneficiaries                         |
#' |`bene_ma_oth`       |Medicare Advantage beneficiaries                        |
#' |`bene_total_aged`   |Aged beneficiaries                                      |
#' |`bene_aged_esrd`    |Aged beneficiaries with ESRD                            |
#' |`bene_aged_no_esrd` |Aged beneficiaries without ESRD                         |
#' |`bene_total_dsb`    |Disabled beneficiaries                                  |
#' |`bene_dsb_esrd`     |Disabled with ESRD and ESRD-only beneficiaries          |
#' |`bene_dsb_no_esrd`  |Disabled beneficiaries without ESRD                     |
#' |`bene_total_ab`     |Total Medicare Part A and B beneficiaries               |
#' |`bene_ab_orig`      |Original Medicare Part A and B beneficiaries            |
#' |`bene_ab_ma_oth`    |Medicare Advantage Part A and B beneficiaries           |
#' |`bene_total_rx`     |Total Medicare Part D beneficiaries                     |
#' |`bene_rx_pdp`       |Medicare Prescription Drug Plan beneficiaries           |
#' |`bene_rx_mapd`      |Medicare Advantage Prescription Drug Plan beneficiaries |
#' |`bene_rx_lis_elig`  |Part D Low Income Subsidy Eligible (Full) Beneficiaries |
#' |`bene_rx_lis_full`  |Part D Low Income Subsidy Full Beneficiaries            |
#' |`bene_rx_lis_part`  |Part D Low Income Subsidy Partial Beneficiaries         |
#' |`bene_rx_lis_no`    |Part D No Low Income Subsidy Beneficiaries              |
#'
#' @examplesIf interactive()
#' beneficiaries(year   = 2022,
#'               period = "Year",
#'               level  = "County",
#'               county = "Autauga")
#'
#' beneficiaries(year   = 2022,
#'               period = "July",
#'               state  = "Georgia")
#'
#' beneficiaries(level = "State", fips  = "10")
#'
#' @autoglobal
#' @export
beneficiaries <- function(year = NULL,
                          period = NULL,
                          level = NULL,
                          state = NULL,
                          county = NULL,
                          fips = NULL,
                          tidy = TRUE,
                          ...) {

  args <- list(year   = year,
               period = period,
               level  = level,
               state  = state,
               county = county,
               fips   = fips) |>
    unlist(use.names  = FALSE)

  if (length(args) == 1L && args %in% "Month") {
    cli::cli_abort(c("{.arg period = 'Month'} cannot be the only argument.")) # nolint
  }

  state_name <- NULL

  if (!is.null(year)) {
    year <- as.character(year)

    if (!is.null(period) && period %in% "Year") {
      year <- rlang::arg_match0(year, as.character(bene_years("Year")))}

    if (!is.null(period) && period %in% c("Month", month.name)) {
      year <- rlang::arg_match0(year, as.character(bene_years("Month")))}
  }

  if (!is.null(period)) {
    period <- rlang::arg_match0(period, c("Year", "Month", month.name))
    if (period == "Month") period <- NULL
  }

  level <- level %nn% rlang::arg_match0(level, c("National", "State", "County"))

  if (!is.null(state)) {
    state <- rlang::arg_match0(state, c(state.abb, state.name, "US"))

    if (state %in% c(state.name, "United States")) {
      state_name <- state
      state      <- NULL
    }
  }

  if (is.null(state)) state_name <- NULL

  args <- dplyr::tribble(
    ~param,              ~arg,
    "YEAR",              year,
    "MONTH",             period,
    "BENE_GEO_LVL",      level,
    "BENE_STATE_ABRVTN", state,
    "BENE_STATE_DESC",   state_name,
    "BENE_COUNTY_DESC",  county,
    "BENE_FIPS_CD",      fips)

  response <- httr2::request(build_url("ben", args)) |>
    httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,           ~y,
      "year",       year,
      "period",     period,
      "level",      level,
      "state",      state,
      "county",     county,
      "fips",       fips) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- cols_bene(tidyup(results, int = c('year', '_benes'))) |>
      dplyr::mutate(period = fct_period(period),
                    level = fct_level(level),
                    state = fct_stabb(state),
                    state_name = fct_stname(state_name))
    if (!is.null(period) && period == "Month") results <- dplyr::filter(results, period %in% month.name)
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_bene <- function(df) {

  cols <- c("year",
            "period"            = "month",
            "level"             = "bene_geo_lvl",
            "state"             = "bene_state_abrvtn",
            "state_name"        = "bene_state_desc",
            "county"            = "bene_county_desc",
            "fips"              = "bene_fips_cd",
            "bene_total"        = "tot_benes",
            "bene_orig"         = "orgnl_mdcr_benes",
            "bene_ma_oth"       = "ma_and_oth_benes",
            "bene_total_aged"   = "aged_tot_benes",
            "bene_aged_esrd"    = "aged_esrd_benes",
            "bene_aged_no_esrd" = "aged_no_esrd_benes",
            "bene_total_dsb"    = "dsbld_tot_benes",
            "bene_dsb_esrd"     = "dsbld_esrd_and_esrd_only_benes",
            "bene_dsb_no_esrd"  = "dsbld_no_esrd_benes",
            "bene_total_ab"     = "a_b_tot_benes",
            "bene_ab_orig"      = "a_b_orgnl_mdcr_benes",
            "bene_ab_ma_oth"    = "a_b_ma_and_oth_benes",
            "bene_total_rx"     = "prscrptn_drug_tot_benes",
            "bene_rx_pdp"       = "prscrptn_drug_pdp_benes",
            "bene_rx_mapd"      = "prscrptn_drug_mapd_benes",
            "bene_rx_lis_elig"  = "prscrptn_drug_deemed_eligible_full_lis_benes",
            "bene_rx_lis_full"  = "prscrptn_drug_full_lis_benes",
            "bene_rx_lis_part"  = "prscrptn_drug_partial_lis_benes",
            "bene_rx_lis_no"    = "prscrptn_drug_no_lis_benes")

  df |> dplyr::select(dplyr::any_of(cols))
}
