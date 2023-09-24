#' Search the Medicare Physician & Other Practitioners API by **Provider and Service**
#'
#' @description Information on services and procedures provided to
#'    Original Medicare (fee-for-service) Part B (Medical Insurance)
#'    beneficiaries by physicians and other healthcare professionals;
#'    aggregated by provider and service.
#'
#' @details The **Provider and Service** dataset provides information on
#'    services and procedures provided to Medicare (fee-for-service) Part B
#'    beneficiaries by physicians and other healthcare professionals.
#'
#'    The data is based on information gathered from CMS administrative claims
#'    data for Part B beneficiaries available from the CMS Chronic Conditions
#'    Data Warehouse.
#'
#'    The spending and utilization data in the Physician and Other
#'    Practitioners by Provider and Service Dataset are aggregated
#'    to the following:
#'
#'    1. the NPI for the performing provider,
#'    2. the Healthcare Common Procedure Coding System (HCPCS) code, and
#'    3. the place of service (either facility or non-facility).
#'
#'    There can be multiple records for a given NPI based on the number of
#'    distinct HCPCS codes that were billed and where the services were
#'    provided. Data have been aggregated based on the place of service
#'    because separate fee schedules apply depending on whether the place
#'    of service submitted on the claim is facility or non-facility.
#'
#' ### Links
#'   - [Medicare Physician & Other Practitioners: by Provider and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
#'
#' *Update Frequency:* **Annually**
#'
#' @param year integer (*required*); Year in `YYYY` format. Run helper function
#'    `prac_years()` to return a vector of the years
#'    currently available.
#' @param npi National Provider Identifier for the rendering provider on the claim
#' @param first,last Individual provider's name
#' @param organization Organization name
#' @param credential Individual provider's credentials
#' @param gender Individual provider's gender; `"F"` (Female), `"M"` (Male)
#' @param entype Provider entity type; `"I"` (Individual), `"O"` (Organization)
#' @param city City where provider is located
#' @param state State where provider is located
#' @param fips Provider's state FIPS code
#' @param zip Provider’s zip code
#' @param ruca Rural-Urban Commuting Area Code (RUCA). Choices are:
#'    * __Metro Area Core__
#'       * `"1"`: Primary flow within Urbanized Area (UA)
#'       * `"1.1"`: Secondary flow 30-50% to larger UA
#'    * __Metro Area High Commuting__
#'        - `"2"`: Primary flow 30% or more to UA
#'        - `"2.1"`: Secondary flow 30-50% to larger UA
#'     - **Metro Area Low Commuting**
#'        - `3`: Primary flow 10-30% to UA
#'     - **Micro Area Core**
#'        - `4`: Primary flow within large Urban Cluster (10k - 49k)
#'        - `4.1`: Secondary flow 30-50% to UA
#'     - **Micro High Commuting**
#'        - `5`: Primary flow 30% or more to large UC
#'        - `5.1`: Secondary flow 30-50% to UA
#'     - **Micro Low Commuting**
#'        - `6`: Primary flow 10-30% to large UC
#'     - **Small Town Core**
#'        - `7`: Primary flow within small UC (2.5k - 9.9k)
#'        - `7.1`: Secondary flow 30-50% to UA
#'        - `7.2`: Secondary flow 30-50% to large UC
#'     - **Small Town High Commuting**
#'        - `8`: Primary flow 30% or more to small UC
#'        - `8.1`: Secondary flow 30-50% to UA
#'        - `8.2`: Secondary flow 30-50% to large UC
#'     - **Small Town Low Commuting**
#'        - `9`: Primary flow 10-30% to small UC
#'     - **Rural Areas**
#'        - `10`: Primary flow to tract outside a UA or UC
#'        - `10.1`: Secondary flow 30-50% to UA
#'        - `10.2`: Secondary flow 30-50% to large UC
#'        - `10.3`: Secondary flow 30-50% to small UC
#'     - `99`: Zero population and no rural-urban identifier information
#' @param country Country where provider is located.
#' @param specialty Provider specialty code reported on the largest number of
#'    claims submitted.
#' @param par Identifies whether the provider participates in Medicare
#'    and/or accepts assignment of Medicare allowed amounts. The value will
#'    be `Y` for any provider that had at least one claim identifying the
#'    provider as participating in Medicare or accepting assignment of
#'    Medicare allowed amounts within HCPCS code and place of service. A
#'    non-participating provider may elect to accept Medicare allowed amounts
#'    for some services and not accept Medicare allowed amounts for other
#'    services.
#' @param hcpcs_code HCPCS code used to identify the specific medical service
#'    furnished by the provider. HCPCS codes include two levels. Level I codes
#'    are the Current Procedural Terminology (CPT) codes that are maintained
#'    by the American Medical Association and Level II codes are created by
#'    CMS to identify products, supplies and services not covered by the CPT
#'    codes (such as ambulance services).
#' @param drug Identifies whether the HCPCS code for the specific service
#'    furnished by the provider is a HCPCS listed on the Medicare Part B Drug
#'    Average Sales Price (ASP) File.
#' @param pos Identifies whether the place of service submitted on the claims
#'    is a facility (`"F"`) or non-facility (`"O"`). Non-facility is generally an
#'    office setting; however other entities are included in non-facility.
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' by_service(year = 2019, npi = 1003000126)
#' @autoglobal
#' @export
by_service <- function(year,
                       npi = NULL,
                       first = NULL,
                       last = NULL,
                       organization = NULL,
                       credential = NULL,
                       gender = NULL,
                       entype = NULL,
                       city = NULL,
                       state = NULL,
                       zip = NULL,
                       fips = NULL,
                       ruca = NULL,
                       country = NULL,
                       specialty = NULL,
                       par = NULL,
                       hcpcs_code = NULL,
                       drug = NULL,
                       pos = NULL,
                       tidy = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, as.character(prac_years()))

  if (!is.null(npi))        {npi <- npi_check(npi)}
  if (!is.null(hcpcs_code)) {hcpcs_code <- as.character(hcpcs_code)}
  if (!is.null(pos))        {pos <- pos_char(pos)}
  if (!is.null(zip))        {zip <- as.character(zip)}
  if (!is.null(fips))       {fips <- as.character(fips)}
  if (!is.null(ruca))       {ruca <- as.character(ruca)}
  if (!is.null(par))        {par <- tf_2_yn(par)}
  if (!is.null(drug))       {drug <- tf_2_yn(drug)}

  id <- cms_update("Medicare Physician & Other Practitioners - by Provider and Service",
                   "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  args <- dplyr::tribble(
                           ~param,  ~arg,
                     "Rndrng_NPI",   npi,
        "Rndrng_Prvdr_First_Name",   first,
     "Rndrng_Prvdr_Last_Org_Name",   last,
     "Rndrng_Prvdr_Last_Org_Name",   organization,
           "Rndrng_Prvdr_Crdntls",   credential,
              "Rndrng_Prvdr_Gndr",   gender,
            "Rndrng_Prvdr_Ent_Cd",   entype,
              "Rndrng_Prvdr_City",   city,
      "Rndrng_Prvdr_State_Abrvtn",   state,
        "Rndrng_Prvdr_State_FIPS",   fips,
              "Rndrng_Prvdr_Zip5",   zip,
              "Rndrng_Prvdr_RUCA",   ruca,
             "Rndrng_Prvdr_Cntry",   country,
              "Rndrng_Prvdr_Type",   specialty,
  "Rndrng_Prvdr_Mdcr_Prtcptg_Ind",   par,
                       "HCPCS_Cd",   hcpcs_code,
                 "HCPCS_Drug_Ind",   drug,
                  "Place_Of_Srvc",   pos)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "year",         year,
      "npi",          npi,
      "last",         last,
      "first",        first,
      "organization", organization,
      "credential",   credential,
      "gender",       gender,
      "entype",       entype,
      "city",         city,
      "state",        state,
      "fips",         fips,
      "zip",          zip,
      "ruca",         ruca,
      "country",      country,
      "specialty",    specialty,
      "par",          par,
      "hcpcs_code",   hcpcs_code,
      "drug",         drug,
      "pos",          pos) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(year = as.integer(year),
                    level = "Provider",
                    dplyr::across(dplyr::starts_with("tot_"), as.integer),
                    dplyr::across(dplyr::starts_with("avg_"), as.double),
                    rndrng_prvdr_crdntls = clean_credentials(rndrng_prvdr_crdntls),
                    rndrng_prvdr_ent_cd = entype_char(rndrng_prvdr_ent_cd),
                    place_of_srvc = pos_char(place_of_srvc),
                    rndrng_prvdr_mdcr_prtcptg_ind = yn_logical(rndrng_prvdr_mdcr_prtcptg_ind),
                    hcpcs_drug_ind = yn_logical(hcpcs_drug_ind)) |>
      tidyr::unite("address",
                   dplyr::any_of(c("rndrng_prvdr_st1", "rndrng_prvdr_st2")),
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      serv_cols()
    }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
serv_cols <- function(df) {

  cols <- c('year',
            'npi' = 'rndrng_npi',
            'level',
            'entype' = 'rndrng_prvdr_ent_cd',
            'first' = 'rndrng_prvdr_first_name',
            'middle' = 'rndrng_prvdr_mi',
            'last' = 'rndrng_prvdr_last_org_name',
            'credential' = 'rndrng_prvdr_crdntls',
            'gender' = 'rndrng_prvdr_gndr',
            'specialty' = 'rndrng_prvdr_type',
            'address',
            'city' = 'rndrng_prvdr_city',
            'state' = 'rndrng_prvdr_state_abrvtn',
            'fips' = 'rndrng_prvdr_state_fips',
            'zip' = 'rndrng_prvdr_zip5',
            'ruca' = 'rndrng_prvdr_ruca',
            # 'ruca_desc' = 'rndrng_prvdr_ruca_desc',
            'country' = 'rndrng_prvdr_cntry',
            'par' = 'rndrng_prvdr_mdcr_prtcptg_ind',
            'hcpcs_code' = 'hcpcs_cd',
            'hcpcs_desc',
            'drug' = 'hcpcs_drug_ind',
            'pos' = 'place_of_srvc',
            'tot_benes',
            'tot_srvcs',
            'tot_day' = 'tot_bene_day_srvcs',
            'avg_charge' = 'avg_sbmtd_chrg',
            'avg_allowed' = 'avg_mdcr_alowd_amt',
            'avg_payment' = 'avg_mdcr_pymt_amt',
            'avg_std_pymt' = 'avg_mdcr_stdzd_amt')

  df |> dplyr::select(dplyr::all_of(cols))

}
