#' Medicare Part B Utilization Statistics by **Geography and Service**
#'
#' @description
#' `by_geography()` allows you to search for information on services and
#' procedures provided to Original Medicare (fee-for-service) Part B
#' beneficiaries by physicians and other healthcare professionals, aggregated by
#' geography and service.
#'
#' The **Geography and Service** subset contains information on utilization,
#' allowed amount, Medicare payment, and submitted charges organized nationally
#' and state-wide by HCPCS code and place of service.
#'
#' ### Links
#'    - [Physician & Other Practitioners: by Geography and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service)
#'
#' *Update Frequency:* **Annually**
#'
#' @param year int (*required*); Year in YYYY format. Run helper function
#'    `by_geography_years()` to return a vector of the years currently available.
#' @param level Level of geography by which the data will be aggregated. `State`
#'    indicates the data is aggregated to a single state identified in the Rendering Provider
#'    State column. `National` indicates the data is aggregated across all states for a
#'    given HCPCS Code Level.
#' @param state State where the provider is located, as reported
#'    in NPPES. Values include the 50 United States, District of Columbia,
#'    U.S. territories, Armed Forces areas, Unknown and Foreign Country. Data
#'    aggregated at the National level are identified by the word 'National'.
#' @param fips FIPS code of the referring provider state. This variable is
#'    blank when reported at the national level.
#' @param hcpcs_code HCPCS code used to identify the specific medical service
#'    furnished by the provider.
#' @param hcpcs_desc Description of the HCPCS code for the specific medical
#'    service furnished by the provider.
#' @param drug Flag that identifies whether the HCPCS code for the specific
#'    service furnished by the provider is a HCPCS listed on the Medicare Part
#'    B Drug Average Sales Price (ASP) File.
#' @param pos Identifies whether the place of service submitted on claims
#'    is a facility (`"F"`) or non-facility (`"O"`). Non-facility
#'    is generally an office setting.
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' by_geography(year = 2020, hcpcs_code = "0002A")
#' @autoglobal
#' @export
by_geography <- function(year,
                         state         = NULL,
                         hcpcs_code    = NULL,
                         pos           = NULL,
                         level         = NULL,
                         fips          = NULL,
                         hcpcs_desc    = NULL,
                         drug          = NULL,
                         tidy          = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, as.character(by_geography_years()))

  if (!is.null(level))      {rlang::arg_match(level, c("National", "State"))}
  if (!is.null(hcpcs_code)) {hcpcs_code <- as.character(hcpcs_code)}
  if (!is.null(fips))       {fips <- as.character(fips)}
  if (!is.null(drug))       {drug <- tf_2_yn(drug)}

  if (!is.null(pos)) {
    pos <- pos_char(pos)
    rlang::arg_match(pos, c("F", "O"))
    }


  if (!is.null(state) && (state %in% state.abb)) {
    state <- dplyr::tibble(x = state.abb,
                  y = state.name) |>
      dplyr::filter(x == state) |>
      dplyr::pull(y)
    }

  id <- cms_update("Medicare Physician & Other Practitioners - by Geography and Service",
                   "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  args <- dplyr::tribble(
                            ~param,      ~arg,
            "Rndrng_Prvdr_Geo_Lvl",       level,
           "Rndrng_Prvdr_Geo_Desc",       state,
             "Rndrng_Prvdr_Geo_Cd",       fips,
                        "HCPCS_Cd",       hcpcs_code,
                      "HCPCS_Desc",       hcpcs_desc,
                  "HCPCS_Drug_Ind",       drug,
                   "Place_Of_Srvc",       pos)


  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,               ~y,
      "year",           year,
      "level",          level,
      "state",          state,
      "fips",           fips,
      "hcpcs_code",     hcpcs_code,
      "hcpcs_desc",     hcpcs_desc,
      "drug",           drug,
      "pos",            pos) |>
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
      dplyr::mutate(year = as.integer(year),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    hcpcs_drug_ind = yn_logical(hcpcs_drug_ind),
                    place_of_srvc  = pos_char(place_of_srvc),
                    dplyr::across(dplyr::starts_with("tot_"), ~as.integer(.)),
                    dplyr::across(dplyr::starts_with("avg_"), ~as.double(.))) |>
      dplyr::select(year,
                    level          = rndrng_prvdr_geo_lvl,
                    state          = rndrng_prvdr_geo_desc,
                    fips           = rndrng_prvdr_geo_cd,
                    hcpcs_code     = hcpcs_cd,
                    hcpcs_desc,
                    drug           = hcpcs_drug_ind,
                    pos            = place_of_srvc,
                    tot_provs      = tot_rndrng_prvdrs,
                    tot_benes,
                    tot_srvcs,
                    tot_day        = tot_bene_day_srvcs,
                    avg_charge     = avg_sbmtd_chrg,
                    avg_allowed    = avg_mdcr_alowd_amt,
                    avg_payment    = avg_mdcr_pymt_amt,
                    avg_std_pymt   = avg_mdcr_stdzd_amt)

  }
  return(results)
}

#' Current years available for the Geography and Service API
#' @return integer vector of years available
#' @examples
#' by_geography_years()
#' @rdname years
#' @autoglobal
#' @export
by_geography_years <- function() {
  cms_update("Medicare Physician & Other Practitioners - by Geography and Service", "years") |>
    as.integer()
}
