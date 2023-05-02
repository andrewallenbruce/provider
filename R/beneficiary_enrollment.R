#' Search the Medicare Monthly Enrollment API
#'
#' @description Current information on the number of Medicare
#'    beneficiaries with hospital/medical coverage and prescription
#'    drug coverage, available for several geographical areas.
#'
#' @details The Medicare Monthly Enrollment data provides current
#'    monthly information on the number of Medicare beneficiaries
#'    with hospital/medical coverage and prescription drug coverage,
#'    available for several geographic areas including national,
#'    state/territory, and county. The hospital/medical coverage
#'    data can be broken down further by health care delivery
#'    (Original Medicare versus Medicare Advantage and Other
#'    Health Plans) and the prescription drug coverage data can
#'    be examined by those enrolled in stand-alone Prescription
#'    Drug Plans and those enrolled in Medicare Advantage
#'    Prescription Drug plans. The dataset includes enrollee
#'    counts on a *rolling 12 month basis* and also provides
#'    information on yearly trends. The dataset is based on
#'    information gathered from CMS administrative enrollment
#'    data for beneficiaries enrolled in the Medicare program
#'    available from the CMS Chronic Conditions Data Warehouse.
#'
#' ## Links
#' * [Medicare Monthly Enrollment](https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param year Calendar year of Medicare enrollment; current options are
#'    `2017 - 2022`
#' @param month Time frame of Medicare enrollment; options are `Year` or any
#'    month within the 12-month time span of the month in the data set's version
#'    name (listed [here](https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment/api-docs))
#' @param level Geographic level of data; options are `National`, `State`,
#'    and `County`
#' @param state Two-letter state abbreviation of beneficiary residence
#' @param state_name Full state name of beneficiary residence
#' @param county County of beneficiary residence
#' @param fips FIPS code of beneficiary residence
#' @param clean_names Convert column names to snake case; default is `TRUE`.
#'
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' beneficiary_enrollment(year = NULL,
#'                        month = "Year",
#'                        level = "County",
#'                        state = "AL",
#'                        county = "Autauga")
#'
#' beneficiary_enrollment(year = 2021, level = "County", fips = "01001")
#'
#' beneficiary_enrollment(year = 2022,
#'                        month = "July",
#'                        level = "State",
#'                        state_name = "Georgia")
#'
#' beneficiary_enrollment(level = "State", fips = "10")
#' @autoglobal
#' @export

beneficiary_enrollment <- function(year        = NULL,
                                   month       = NULL,
                                   level       = NULL,
                                   state       = NULL,
                                   state_name  = NULL,
                                   county      = NULL,
                                   fips        = NULL,
                                   clean_names = TRUE) {

  # if (period == "month")
  # if (period == "year")

  # match args ----------------------------------------------------
  if (!is.null(month)) {
    month <- rlang::arg_match(month, c("Year", month.name))
    }
  if (!is.null(level)) {
    level <- rlang::arg_match(level, c("National", "State", "County"))
    }
  if (!is.null(state)) {
    state <- rlang::arg_match(state, c(state.abb))
    }
  if (!is.null(state_name)) {
    state_name <- rlang::arg_match(state_name, c(state.name))
    }

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                     ~x,        ~y,
                 "YEAR",      year,
                "MONTH",     month,
         "BENE_GEO_LVL",     level,
    "BENE_STATE_ABRVTN",     state,
      "BENE_STATE_DESC",state_name,
     "BENE_COUNTY_DESC",    county,
         "BENE_FIPS_CD",      fips)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- cms_update_ids("Medicare Monthly Enrollment")$distribution[2]
  post   <- "/data.json?"
  #id     <- "30fe2d89-c56c-4a48-8e3a-3d07ad995c0b"
  #post   <- "/data?"
  url    <- paste0(http, id, post, params_args)

  # create request ----------------------------------------------------------
  request <- httr2::request(url)

  # send request ------------------------------------------------------------
  response <- request |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (httr2::resp_header(response, "content-length") == "0") {

    cli_args <- tibble::tribble(
      ~x,        ~y,
      "year",      as.character(year),
      "month",     month,
      "level",     level,
      "state",     state,
      "state_name",state_name,
      "county",    county,
      "fips",      fips) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    return(cli::cli_alert_danger("No results for {.val {cli_args}}",
                                 wrap = TRUE))

    }

    results <- tibble::tibble(httr2::resp_body_json(response,
      check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {

    results <- dplyr::rename_with(results, str_to_snakecase) |>
    dplyr::rename(level                       = bene_geo_lvl,
                  state                       = bene_state_abrvtn,
                  state_name                  = bene_state_desc,
                  county                      = bene_county_desc,
                  fips                        = bene_fips_cd,
                  bene_total                  = tot_benes,
                  bene_orig                   = orgnl_mdcr_benes,
                  bene_ma_oth                 = ma_and_oth_benes,
                  bene_aged_total             = aged_tot_benes,
                  bene_aged_esrd              = aged_esrd_benes,
                  bene_aged_no_esrd           = aged_no_esrd_benes,
                  bene_dsb_total              = dsbld_tot_benes,
                  bene_dsb_esrd_and_only_esrd = dsbld_esrd_and_esrd_only_benes,
                  bene_dsb_no_esrd            = dsbld_no_esrd_benes,
                  bene_ab_total               = a_b_tot_benes,
                  bene_ab_orig                = a_b_orgnl_mdcr_benes,
                  bene_ab_ma_oth              = a_b_ma_and_oth_benes,
                  bene_rx_total               = prscrptn_drug_tot_benes,
                  bene_rx_pdp                 = prscrptn_drug_pdp_benes,
                  bene_rx_mapd                = prscrptn_drug_mapd_benes,
                  bene_rx_elig = prscrptn_drug_deemed_eligible_full_lis_benes,
                  bene_rx_full = prscrptn_drug_full_lis_benes,
                  bene_rx_part = prscrptn_drug_partial_lis_benes,
                  bene_rx_none = prscrptn_drug_no_lis_benes) |>
    dplyr::mutate(fips = dplyr::na_if(fips, "")) |>
    dplyr::filter(state != "UK") |>
    dplyr::filter(county != "Unknown") |>
    dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "*"))) |>
    dplyr::mutate(dplyr::across(dplyr::contains("bene"), as.integer))

    # if (!is.null(year) && level == "County") {
    # if (!is.null(year) && level == "County" && (is.null(month) || month == "Year")) {

    #   results <- results |>
    #     dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "*"))) |>
    #     dplyr::mutate(dplyr::across(dplyr::contains("bene"), as.integer))
    #
    # } else {

      # results <- results |>
      #   dplyr::mutate(dplyr::across(dplyr::contains("bene"), as.integer))
    # }
  }
  return(results)
}
