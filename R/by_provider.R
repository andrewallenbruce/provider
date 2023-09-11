#' Yearly Utilization Statistics on Medicare Part B Providers
#'
#' @description `by_provider()` allows you to access data such as
#' services and procedures performed; charges submitted and payment received;
#' and beneficiary demographic and health characteristics for providers treating
#' Original Medicare (fee-for-service) Part B beneficiaries, aggregated by year.
#'
#' ### Links:
#' - [Medicare Physician & Other Practitioners: by Provider API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)
#'
#' *Update Frequency:* **Annually**
#'
#' @param year integer (*required*); Year in `YYYY` format. Run helper function
#'    `by_provider_years()` to return a vector of the years currently available.
#' @param npi National Provider Identifier for the rendering provider on the claim.
#' @param first,last Individual provider's first and/or last name
#' @param organization Organization name.
#' @param credential Individual provider's credentials.
#' @param gender Individual provider's gender.
#' @param entype Provider entity type.
#' @param city City where provider is located.
#' @param state State where provider is located.
#' @param fips Provider's state FIPS code.
#' @param zip Provider’s zip code.
#' @param ruca Rural-Urban Commuting Area Code (RUCA); a Census tract-based
#'    classification scheme that utilizes the standard Bureau of Census
#'    Urbanized Area and Urban Cluster definitions in combination with work
#'    commuting information to characterize all of the nation's Census tracts
#'    regarding their rural and urban status and relationships. The Referring
#'    Provider ZIP code was cross walked to the United States Department of
#'    Agriculture (USDA) 2010 Rural-Urban Commuting Area Codes.
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
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' by_provider(year = 2020, npi = 1003000423)
#'
#' # Use the years helper function to retrieve results for every year:
#' by_provider_years() |>
#' map(\(x) by_provider(year = x, npi = 1043477615)) |>
#' list_rbind()
#' @autoglobal
#' @export
by_provider <- function(year,
                        npi         = NULL,
                        first  = NULL,
                        last   = NULL,
                        organization = NULL,
                        credential  = NULL,
                        gender      = NULL,
                        entype      = NULL,
                        city        = NULL,
                        state       = NULL,
                        zip         = NULL,
                        fips        = NULL,
                        ruca        = NULL,
                        country     = NULL,
                        specialty   = NULL,
                        par         = NULL,
                        tidy        = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  year <- rlang::arg_match(year, as.character(by_provider_years()))

  if (!is.null(npi))  {npi <- npi_check(npi)}
  if (!is.null(zip))  {zip <- as.character(zip)}
  if (!is.null(fips)) {fips <- as.character(fips)}
  if (!is.null(ruca)) {ruca <- as.character(ruca)}
  if (!is.null(par))  {par <- tf_2_yn(par)}

  id <- cms_update("Medicare Physician & Other Practitioners - by Provider",
                   "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  args <- dplyr::tribble(
                          ~param, ~arg,
                    "Rndrng_NPI",  npi,
       "Rndrng_Prvdr_First_Name",  first,
    "Rndrng_Prvdr_Last_Org_Name",  last,
    "Rndrng_Prvdr_Last_Org_Name",  organization,
          "Rndrng_Prvdr_Crdntls",  credential,
             "Rndrng_Prvdr_Gndr",  gender,
           "Rndrng_Prvdr_Ent_Cd",  entype,
             "Rndrng_Prvdr_City",  city,
     "Rndrng_Prvdr_State_Abrvtn",  state,
       "Rndrng_Prvdr_State_FIPS",  fips,
             "Rndrng_Prvdr_Zip5",  zip,
             "Rndrng_Prvdr_RUCA",  ruca,
            "Rndrng_Prvdr_Cntry",  country,
             "Rndrng_Prvdr_Type",  specialty,
 "Rndrng_Prvdr_Mdcr_Prtcptg_Ind",  par)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "year",         year,
      "npi",          npi,
      "first",        first,
      "last",         last,
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
      "par",          par) |>
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
                    rndrng_prvdr_crdntls = clean_credentials(rndrng_prvdr_crdntls),
                    rndrng_prvdr_mdcr_prtcptg_ind = yn_logical(rndrng_prvdr_mdcr_prtcptg_ind),
                    dplyr::across(dplyr::ends_with(c("_hcpcs_cds", "_benes", "_srvcs", "_cnt")), ~as.integer(.)),
                    dplyr::across(dplyr::ends_with(c("amt", "chrg", "pct")), ~as.double(.))) |>
      tidyr::unite("address",
                   dplyr::any_of(c("rndrng_prvdr_st1", "rndrng_prvdr_st2")),
                   remove = TRUE,
                   na.rm = TRUE,
                   sep = " ") |>
      dplyr::select(year,
                    npi            = rndrng_npi,
                    first     = rndrng_prvdr_first_name,
                    middle    = rndrng_prvdr_mi,
                    last      = rndrng_prvdr_last_org_name,
                    credential     = rndrng_prvdr_crdntls,
                    gender         = rndrng_prvdr_gndr,
                    entity_type    = rndrng_prvdr_ent_cd,
                    address,
                    city           = rndrng_prvdr_city,
                    state          = rndrng_prvdr_state_abrvtn,
                    fips           = rndrng_prvdr_state_fips,
                    zip            = rndrng_prvdr_zip5,
                    ruca           = rndrng_prvdr_ruca,
                    # ruca_desc     = rndrng_prvdr_ruca_desc,
                    country        = rndrng_prvdr_cntry,
                    specialty      = rndrng_prvdr_type,
                    par            = rndrng_prvdr_mdcr_prtcptg_ind,
                    tot_hcpcs      = tot_hcpcs_cds,
                    tot_benes,
                    tot_srvcs,
                    tot_charges    = tot_sbmtd_chrg,
                    tot_allowed    = tot_mdcr_alowd_amt,
                    tot_payment    = tot_mdcr_pymt_amt,
                    tot_std_pymt   = tot_mdcr_stdzd_amt,
                    drug_hcpcs     = drug_tot_hcpcs_cds,
                    drug_benes     = drug_tot_benes,
                    drug_srvcs     = drug_tot_srvcs,
                    drug_charges   = drug_sbmtd_chrg,
                    drug_allowed   = drug_mdcr_alowd_amt,
                    drug_payment   = drug_mdcr_pymt_amt,
                    drug_std_pymt  = drug_mdcr_stdzd_amt,
                    med_hcpcs      = med_tot_hcpcs_cds,
                    med_benes      = med_tot_benes,
                    med_srvcs      = med_tot_srvcs,
                    med_charges    = med_sbmtd_chrg,
                    med_allowed    = med_mdcr_alowd_amt,
                    med_payment    = med_mdcr_pymt_amt,
                    med_std_pymt   = med_mdcr_stdzd_amt,
                    bene_age_avg   = bene_avg_age,
                    bene_age_lt65  = bene_age_lt_65_cnt,
                    bene_age_65_74 = bene_age_65_74_cnt,
                    bene_age_75_84 = bene_age_75_84_cnt,
                    bene_age_gt84  = bene_age_gt_84_cnt,
                    bene_female    = bene_feml_cnt,
                    bene_male      = bene_male_cnt,
                    bene_race_wht  = bene_race_wht_cnt,
                    bene_race_blk  = bene_race_black_cnt,
                    bene_race_api  = bene_race_api_cnt,
                    bene_race_span = bene_race_hspnc_cnt,
                    bene_race_nat  = bene_race_nat_ind_cnt,
                    bene_race_oth  = bene_race_othr_cnt,
                    bene_dual      = bene_dual_cnt,
                    bene_ndual     = bene_ndual_cnt,
                    cc_af     = bene_cc_af_pct,
                    cc_alz    = bene_cc_alzhmr_pct,
                    cc_asth   = bene_cc_asthma_pct,
                    cc_canc   = bene_cc_cncr_pct,
                    cc_chf    = bene_cc_chf_pct,
                    cc_ckd    = bene_cc_ckd_pct,
                    cc_copd   = bene_cc_copd_pct,
                    cc_dep    = bene_cc_dprssn_pct,
                    cc_diab   = bene_cc_dbts_pct,
                    cc_hplip  = bene_cc_hyplpdma_pct,
                    cc_hpten  = bene_cc_hyprtnsn_pct,
                    cc_ihd    = bene_cc_ihd_pct,
                    cc_opo    = bene_cc_opo_pct,
                    cc_raoa   = bene_cc_raoa_pct,
                    cc_sz     = bene_cc_sz_pct,
                    cc_strk   = bene_cc_strok_pct,
                    hcc_risk_avg  = bene_avg_risk_scre) |>
      dplyr::mutate(credential = clean_credentials(credential),
                    entity_type = entype_char(entity_type)) |>
      tidyr::nest(medical = dplyr::starts_with("med_"),
                  drug = dplyr::starts_with("drug_"),
                  demographics = dplyr::starts_with("bene_"),
                  conditions = dplyr::starts_with("cc_"))

    # if (results$entity_type == "Organization") {results <- dplyr::mutate(results, organization_name = last_name, .before = entity_type) |> dplyr::mutate(last_name = NA)}
    # if (results$entity_type == "Individual") {results <- dplyr::mutate(results, organization_name = NA, .before = entity_type)}

    }
  return(results)
}

#' Current years available for the Provider API
#' @return integer vector of years available
#' @examples
#' by_provider_years()
#' @autoglobal
#' @export
#' @rdname years
by_provider_years <- function() {
  cms_update("Medicare Physician & Other Practitioners - by Provider", "years") |>
    as.integer()
}
