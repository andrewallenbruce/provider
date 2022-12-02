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
#'    counts on a rolling 12 month basis and also provides
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
#' @param year Calendar year of Medicare enrollment
#' @param month Month of Medicare enrollment
#' @param geo_lvl Geographic level of data; options are "National", "State",
#'    and "County"
#' @param state_abb Two-letter state abbreviation of beneficiary residence
#' @param state Full state name of beneficiary residence
#' @param county County of beneficiary residence
#' @param fips FIPS code of beneficiary residence
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' beneficiary_enrollment(year      = 2018,
#'                        month     = "Year",
#'                        geo_lvl   = "County",
#'                        state_abb = "AL",
#'                        county    = "Autauga")
#'
#' beneficiary_enrollment(year    = 2021,
#'                        month   = "August",
#'                        geo_lvl = "County")
#' }
#' @autoglobal
#' @export

beneficiary_enrollment <- function(year        = 2021,
                                   month       = NULL,
                                   geo_lvl     = NULL,
                                   state_abb   = NULL,
                                   state       = NULL,
                                   county      = NULL,
                                   fips        = NULL,
                                   clean_names = TRUE,
                                   lowercase   = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                     ~x,        ~y,
                 "YEAR",      year,
                "MONTH",     month,
         "BENE_GEO_LVL",   geo_lvl,
    "BENE_STATE_ABRVTN", state_abb,
      "BENE_STATE_DESC",     state,
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
