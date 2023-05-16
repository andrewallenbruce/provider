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
#' @param year Year in YYYY format.  Run the helper function `years_pbg()` to
#'    return a vector of currently available years.
#' @param level Identifies the level of geography by which the data in the
#'    row has been aggregated. A value of 'State' indicates the data in the
#'    row is aggregated to a single state identified in the Rendering Provider
#'    State column for a given HCPCS Code Level. A value of 'National'
#'    indicates the data in the row is aggregated across all states for a
#'    given HCPCS Code Level.
#' @param sublevel The state name where the provider is located, as reported
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
#' @param hcpcs_drug Flag that identifies whether the HCPCS code for the specific
#'    service furnished by the provider is a HCPCS listed on the Medicare Part
#'    B Drug Average Sales Price (ASP) File.
#' @param pos Identifies whether the place of service submitted on the claims
#'    is a facility (value of `F`) or non-facility (value of `O`). Non-facility
#'    is generally an office setting; however other entities are included
#'    in non-facility.
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' physician_by_geography(hcpcs_code = "0002A", year = 2020)
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
#' @autoglobal
#' @export
physician_by_geography <- function(year,
                                   level       = NULL,
                                   sublevel    = NULL,
                                   fips        = NULL,
                                   hcpcs_code  = NULL,
                                   hcpcs_desc  = NULL,
                                   hcpcs_drug  = NULL,
                                   pos         = NULL,
                                   tidy        = TRUE) {

  # match args ----------------------------------------------------
  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = cms_update("Medicare Physician & Other Practitioners - by Geography and Service", "years"))

  # update distribution ids -------------------------------------------------
  id <- cms_update(api = "Medicare Physician & Other Practitioners - by Geography and Service",
                   check = "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                                ~x,            ~y,
            "Rndrng_Prvdr_Geo_Lvl",         level,
           "Rndrng_Prvdr_Geo_Desc",      sublevel,
             "Rndrng_Prvdr_Geo_Cd",          fips,
                        "HCPCS_Cd",    hcpcs_code,
                      "HCPCS_Desc",    hcpcs_desc,
                  "HCPCS_Drug_Ind",    hcpcs_drug,
                   "Place_Of_Srvc",           pos)


  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (httr2::resp_header(response, "content-length") == "0") {

    cli_args <- tibble::tribble(
      ~x,             ~y,
      "year",         as.character(year),
      "level",        level,
      "sublevel",     sublevel,
      "fips",         as.character(fips),
      "hcpcs_code",   as.character(hcpcs_code),
      "hcpcs_desc",   hcpcs_desc,
      "hcpcs_drug",   as.character(hcpcs_drug),
      "pos",          pos) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
    return(invisible(NULL))
  }

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
             check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {

    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(year = as.integer(year)) |>
      dplyr::select(year,
                    level        = rndrng_prvdr_geo_lvl,
                    sublevel     = rndrng_prvdr_geo_desc,
                    fips         = rndrng_prvdr_geo_cd,
                    hcpcs        = hcpcs_cd,
                    hcpcs_desc,
                    hcpcs_drug   = hcpcs_drug_ind,
                    place_of_srvc,
                    tot_provs    = tot_rndrng_prvdrs,
                    tot_benes,
                    tot_srvcs,
                    tot_day      = tot_bene_day_srvcs,
                    avg_charge   = avg_sbmtd_chrg,
                    avg_allowed  = avg_mdcr_alowd_amt,
                    avg_payment  = avg_mdcr_pymt_amt,
                    avg_std_pymt = avg_mdcr_stdzd_amt) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    hcpcs_drug = yn_logical(hcpcs_drug),
                    place_of_srvc = pos_char(place_of_srvc),
                    dplyr::across(dplyr::contains("tot"), as.integer),
                    dplyr::across(dplyr::contains("avg"), ~round(., digits = 2)))

  }
  return(results)
}

#' Check the current years available for the Physician & Other Practitioners by Geography and Service API
#' @autoglobal
#' @noRd
years_pbg <- function() {
  cms_update("Medicare Physician & Other Practitioners - by Geography and Service", "years") |>
    as.integer()
}
