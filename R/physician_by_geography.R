#' Search the Medicare Physician & Other Practitioners API
#'    by **Geography and Service**
#'
#' @description Information on services and procedures provided to
#'    Original Medicare (fee-for-service) Part B (Medical Insurance)
#'    beneficiaries by physicians and other healthcare professionals;
#'    aggregated by geography and service.
#'
#' @details The **Geography and Service** dataset contains information on
#'    utilization, payment (allowed amount and Medicare payment), and
#'    submitted charges organized by HCPCS and place of service in the
#'    national table and organized by provider state, HCPCS and place of
#'    service in the state table. The national and state tables also include
#'    a HCPCS drug indicator to identify whether the HCPCS product/service is
#'    a drug as defined from the Medicare Part B Drug ASP list.
#'
#' ## Links
#' * [Medicare Physician & Other Practitioners: by Geography and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Annually**
#'
#' @param geo_level Identifies the level of geography by which the data in the
#'    row has been aggregated. A value of 'State' indicates the data in the
#'    row is aggregated to a single state identified in the Rendering Provider
#'    State column for a given HCPCS Code Level. A value of 'National'
#'    indicates the data in the row is aggregated across all states for a
#'    given HCPCS Code Level.
#' @param geo_desc The state name where the provider is located, as reported
#'    in NPPES. The values include the 50 United States, District of Columbia,
#'    U.S. territories, Armed Forces areas, Unknown and Foreign Country. Data
#'    aggregated at the National level are identified by the word 'National'.
#' @param fips FIPS code of the referring provider state. This variable is
#'    blank when reported at the national level.
#' @param hcpcs_code HCPCS code used to identify the specific medical service
#'    furnished by the provider.
#' @param hcpcs_desc Description of the HCPCS code for the specific medical
#'    service furnished by the provider. HCPCS descriptions associated with
#'    CPT codes are consumer friendly descriptions provided by the AMA. CPT
#'    Consumer Friendly Descriptors are lay synonyms for CPT descriptors that
#'    are intended to help healthcare consumers who are not medical
#'    professionals understand clinical procedures on bills and patient
#'    portals. CPT Consumer Friendly Descriptors should not be used for
#'    clinical coding or documentation. All other descriptions are CMS Level
#'    II descriptions provided in long form. Due to variable length
#'    restrictions, the CMS Level II descriptions have been truncated to
#'    256 bytes. As a result, the same HCPCS description can be associated
#'    with more than one HCPCS code.
#' @param hcpcs_drug Identifies whether the HCPCS code for the specific
#'    service furnished by the provider is a HCPCS listed on the Medicare Part
#'    B Drug Average Sales Price (ASP) File.
#' @param pos Identifies whether the place of service submitted on the claims
#'    is a facility (value of ‘F’) or non-facility (value of ‘O’). Non-facility
#'    is generally an office setting; however other entities are included
#'    in non-facility.
#' @param year Year in YYYY format, between 2013-2020; default is 2020
#' @param clean_names Convert column names to snakecase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' physician_by_geography(hcpcs_code = "0002A",
#'                        year = 2020)
#' \dontrun{
#' service <- purrr::map_dfr(as.character(2013:2020),
#'            ~physician_by_service(npi = 1003000126, year = .x))
#'
#' procedures <- service |>
#'               dplyr::distinct(hcpcs_cd) |>
#'               tibble::deframe()
#'
#' arg_cross <- purrr::cross_df(list(
#'              x = as.character(2013:2020),
#'              y = procedures))
#'
#' # National Level
#' purrr::map2_dfr(arg_cross$x, arg_cross$y,
#' ~physician_by_geography(geo_level = "National", year = .x, hcpcs_code = .y))
#'
#' # State Level
#' purrr::map2_dfr(arg_cross$x, arg_cross$y,
#' ~physician_by_geography(geo_level = "Georgia", year = .x, hcpcs_code = .y))
#' }
#' @autoglobal
#' @export

physician_by_geography <- function(geo_level   = NULL,
                                   fips        = NULL,
                                   geo_desc    = NULL,
                                   hcpcs_code  = NULL,
                                   hcpcs_desc  = NULL,
                                   hcpcs_drug  = NULL,
                                   pos         = NULL,
                                   year        = 2020,
                                   clean_names = TRUE) {

  # update distribution ids -------------------------------------------------
  ids <- cms_update_ids(api = "Medicare Physician & Other Practitioners - by Geography and Service")

  # dataset version ids by year ----------------------------------------------
  id <- dplyr::case_when(year == 2020 ~ ids$distribution[2],
                         year == 2019 ~ ids$distribution[3],
                         year == 2018 ~ ids$distribution[4],
                         year == 2017 ~ ids$distribution[5],
                         year == 2016 ~ ids$distribution[6],
                         year == 2015 ~ ids$distribution[7],
                         year == 2014 ~ ids$distribution[8],
                         year == 2013 ~ ids$distribution[9])

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                           ~x,                 ~y,
            "Rndrng_Prvdr_Geo_Lvl",     geo_level,
             "Rndrng_Prvdr_Geo_Cd",          fips,
           "Rndrng_Prvdr_Geo_Desc",      geo_desc,
                        "HCPCS_Cd",    hcpcs_code,
                      "HCPCS_Desc",    hcpcs_desc,
                  "HCPCS_Drug_Ind",    hcpcs_drug,
                   "Place_Of_Srvc",           pos)


  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(resp,
             check_type = FALSE, simplifyVector = TRUE)) |>
    dplyr::mutate(Year = year) |> dplyr::relocate(Year)

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- dplyr::rename_with(results, str_to_snakecase)}

  return(results)
}
