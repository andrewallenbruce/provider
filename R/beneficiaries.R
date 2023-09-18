#' Beneficiary Enrollment in Medicare
#'
#' @description `beneficiaries()` allows you to access current data on enrolled
#' Medicare beneficiaries.
#'
#' ### Medicare Monthly Enrollment
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
#' The dataset includes enrollee counts on a *rolling 12 month basis* and also
#' provides information on yearly trends.
#'
#' ### Links
#'    * [Medicare Monthly Enrollment](https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param year Calendar year of Medicare enrollment; current years can be
#' checked with:
#'    * `beneficiaries_years("year")`: Years available for all 12 months
#'    * `beneficiaries_years("month")`: Years available for individual months
#' @param period Time frame of Medicare enrollment; options are:
#'    * `Year`
#'    * `Month`
#'    * Any individual month name
#' @param level Geographic level of data; options are:
#'    * `National`
#'    * `State`
#'    * `County`
#' @param state Full state name or abbreviation of beneficiary residence
#' @param county County of beneficiary residence
#' @param fips FIPS code of beneficiary residence
#' @param tidy Tidy output; default is `TRUE`
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' beneficiaries(year = 2022, period = "Year", level = "County", county = "Autauga")
#' beneficiaries(year = 2022, period = "July", state = "Georgia")
#' beneficiaries(level = "State", fips = "10")
#' @autoglobal
#' @export
beneficiaries <- function(year        = NULL,
                          period      = NULL,
                          level       = NULL,
                          state       = NULL,
                          county      = NULL,
                          fips        = NULL,
                          tidy        = TRUE) {

  if (!is.null(year)) {
    year <- as.character(year)

    if (!is.null(period) && period %in% c("Year")) {
    rlang::arg_match(year, as.character(
      beneficiaries(period = "Year", level = "National")$year))
      }

    if (!is.null(period) && period %in% c("Month", month.name)) {
      rlang::arg_match(year, as.character(
        beneficiaries(period = "January", level = "National")$year))
    }
  }

  if (!is.null(period)) {
    rlang::arg_match(period, c("Year", "Month", month.name))
    if (!is.null(period) && period == "Month") {period <- NULL}
  }

  if (!is.null(level)) {
    rlang::arg_match(level, c("National", "State", "County"))
  }

  if (!is.null(state)) {
    rlang::arg_match(state, c(state.abb, state.name, "US"))

    if (state %in% c(state.name, "United States")) {
      state_name <- state
      state <- NULL
    }
  }

  if (is.null(state)) {state_name <- NULL}

  args <- dplyr::tribble(
                 ~param,       ~arg,
                 "YEAR",       year,
                "MONTH",     period,
         "BENE_GEO_LVL",      level,
    "BENE_STATE_ABRVTN",      state,
      "BENE_STATE_DESC", state_name,
     "BENE_COUNTY_DESC",     county,
         "BENE_FIPS_CD",       fips)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                cms_update("Medicare Monthly Enrollment", "id")$distro[1],
                "/data.json?",
                encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,           ~y,
      "year",       year,
      "period",     period,
      "level",      level,
      "state",      state,
      "county",     county,
      "fips",       fips) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
    return(invisible(NULL))

  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::tibble() |>
      dplyr::select(year,
                    period = month,
                    level = bene_geo_lvl,
                    state = bene_state_abrvtn,
                    state_name = bene_state_desc,
                    county = bene_county_desc,
                    fips = bene_fips_cd,
                    bene_total = tot_benes,
                    bene_orig = orgnl_mdcr_benes,
                    bene_ma_oth = ma_and_oth_benes,
                    bene_total_aged = aged_tot_benes,
                    bene_aged_esrd = aged_esrd_benes,
                    bene_aged_no_esrd = aged_no_esrd_benes,
                    bene_total_dsb = dsbld_tot_benes,
                    bene_dsb_esrd = dsbld_esrd_and_esrd_only_benes,
                    bene_dsb_no_esrd = dsbld_no_esrd_benes,
                    bene_total_ab = a_b_tot_benes,
                    bene_ab_orig = a_b_orgnl_mdcr_benes,
                    bene_ab_ma_oth = a_b_ma_and_oth_benes,
                    bene_total_rx = prscrptn_drug_tot_benes,
                    bene_rx_pdp = prscrptn_drug_pdp_benes,
                    bene_rx_mapd = prscrptn_drug_mapd_benes,
                    bene_rx_lis_elig = prscrptn_drug_deemed_eligible_full_lis_benes,
                    bene_rx_lis_full = prscrptn_drug_full_lis_benes,
                    bene_rx_lis_part = prscrptn_drug_partial_lis_benes,
                    bene_rx_lis_no = prscrptn_drug_no_lis_benes) |>
      dplyr::mutate(year = as.integer(year),
                    fips = stringr::str_squish(fips),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "*")),
                    dplyr::across(dplyr::contains("bene"), as.integer))

  }
    if (!is.null(period) && period == "Month") {
      results <- dplyr::filter(results, period %in% month.name)
    }
  return(results)
}
