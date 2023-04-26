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
#' @param geo_level Geographic level of data; options are `National`, `State`,
#'    and `County`
#' @param state_abb Two-letter state abbreviation of beneficiary residence
#' @param state_name Full state name of beneficiary residence
#' @param county County of beneficiary residence
#' @param fips FIPS code of beneficiary residence
#' @param clean_names Convert column names to snake case; default is `TRUE`.
#'
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' beneficiary_enrollment(month = "Year",
#'                        geo_level = "County",
#'                        state_abb = "AL",
#'                        county = "Autauga")
#'
#' beneficiary_enrollment(year = 2021,
#'                        geo_level = "County",
#'                        fips = "01001")
#'
#' beneficiary_enrollment(year = 2022,
#'                        month = "July",
#'                        geo_level = "State",
#'                        state_name = "Georgia")
#'
#' beneficiary_enrollment(geo_level = "State",
#'                        fips = "10")
#' @autoglobal
#' @export

beneficiary_enrollment <- function(year        = 2021,
                                   month       = "Year",
                                   geo_level   = c("National", "State", "County"),
                                   state_abb   = NULL,
                                   state_name  = NULL,
                                   county      = NULL,
                                   fips        = NULL,
                                   clean_names = TRUE) {

  # match args ----------------------------------------------------
  #month <- rlang::arg_match(month, values = c("Year", month.name))
  geo_level <- rlang::arg_match(geo_level)
  #state_abb <- rlang::arg_match(state_abb, values = state.abb)

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                     ~x,        ~y,
                 "YEAR",      year,
                "MONTH",     month,
         "BENE_GEO_LVL", geo_level,
    "BENE_STATE_ABRVTN", state_abb,
      "BENE_STATE_DESC",state_name,
     "BENE_COUNTY_DESC",    county,
         "BENE_FIPS_CD",      fips)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "30fe2d89-c56c-4a48-8e3a-3d07ad995c0b"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # create request ----------------------------------------------------------
  request <- httr2::request(url)

  # send request ------------------------------------------------------------
  response <- request |> httr2::req_perform()

  # check response status ---------------------------------------------------
  httr2::resp_check_status(response)

  # no search results returns empty tibble ----------------------------------
  if (as.numeric(httr2::resp_header(response, "content-length")) == 0) {
    return(tibble::tibble())
  } else {

    results <- tibble::tibble(httr2::resp_body_json(
      response,
      check_type = FALSE,
      simplifyVector = TRUE))

  }
  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {
    results <- dplyr::rename_with(results, str_to_snakecase)}
  return(results)
}
