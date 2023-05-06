#' Search the Medicare Physician & Other Practitioners API
#'    by **Provider**
#'
#' @description Information on services and procedures provided to
#'    Original Medicare (fee-for-service) Part B (Medical Insurance)
#'    beneficiaries by physicians and other healthcare professionals;
#'    aggregated by provider.
#'
#' @details The **Provider** dataset provides information on use, payments,
#'    submitted charges and beneficiary demographic and health characteristics
#'    organized by National Provider Identifier (NPI).
#'
#' ## Links
#' * [Medicare Physician & Other Practitioners: by Provider API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Annually**
#' @param npi National Provider Identifier (NPI) for the rendering provider
#'    on the claim. The provider NPI is the numeric identifier registered in
#'    NPPES.
#' @param last_name Last name/Organization name of the provider. When the
#'    provider is registered in NPPES as an individual (entity type code `I`),
#'    this is the provider’s last name. When the provider is registered as an
#'    organization (entity type code `O`), this is the organization name.
#' @param first_name An individual provider's (entity type code `I`) first name.
#'    An organization's (entity type code `O`) will be blank.
#' @param credential An individual provider's (entity type code `I`) credentials.
#'    An organization's will be blank.
#' @param gender An individual provider's gender.
#'    An organization's will be blank.
#' @param enum_type Type of entity reported in NPPES. An entity code of `I`
#'    identifies providers registered as individuals while an entity type
#'    code of `O` identifies providers registered as organizations.
#' @param city The city where the provider is located, as reported in NPPES.
#' @param state The state where the provider is located, as reported in NPPES.
#' @param fips FIPS code for the rendering provider's state.
#' @param zipcode The provider’s zip code, as reported in NPPES.
#' @param ruca Rural-Urban Commuting Area Code (RUCA); a Census tract-based
#'    classification scheme that utilizes the standard Bureau of Census
#'    Urbanized Area and Urban Cluster definitions in combination with work
#'    commuting information to characterize all of the nation's Census tracts
#'    regarding their rural and urban status and relationships. The Referring
#'    Provider ZIP code was cross walked to the United States Department of
#'    Agriculture (USDA) 2010 Rural-Urban Commuting Area Codes.
#' @param country The country where the provider is located, as reported
#'    in NPPES.
#' @param specialty Derived from the provider specialty code reported on the
#'    claim. For providers that reported more than one specialty code on their
#'    claims, this is the specialty code associated with the largest number
#'    of services.
#' @param par Identifies whether the provider participates in Medicare
#'    and/or accepts assignment of Medicare allowed amounts. The value will
#'    be `Y` for any provider that had at least one claim identifying the
#'    provider as participating in Medicare or accepting assignment of
#'    Medicare allowed amounts within HCPCS code and place of service. A
#'    non-participating provider may elect to accept Medicare allowed amounts
#'    for some services and not accept Medicare allowed amounts for other
#'    services.
#' @param year Year in YYYY format, between 2013-2020; default is 2020
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examples
#' \dontrun{
#' physician_by_provider(npi = 1003000423,
#'                       year = 2020)
#'
#' physician_by_provider(type = "I",
#'                       city = "Hershey",
#'                       state = "PA",
#'                       fips = 42,
#'                       ruca =1,
#'                       gender = "F",
#'                       cred = "M.D.",
#'                       specialty = "Anesthesiology")
#'
#' purrr::map_dfr(2013:2020, ~physician_by_provider(npi = 1003000126, year = .x))
#' }
#' @autoglobal
#' @export
physician_by_provider <- function(year,
                                  npi         = NULL,
                                  first_name  = NULL,
                                  last_name   = NULL,
                                  credential  = NULL,
                                  gender      = NULL,
                                  enum_type   = NULL,
                                  city        = NULL,
                                  state       = NULL,
                                  zipcode     = NULL,
                                  fips        = NULL,
                                  ruca        = NULL,
                                  country     = NULL,
                                  specialty   = NULL,
                                  par         = NULL,
                                  tidy        = TRUE) {

  # match args ----------------------------------------------------
  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = cms_update("Medicare Physician & Other Practitioners - by Provider", "years"))

  # update distribution ids -------------------------------------------------
  id <- cms_update(api = "Medicare Physician & Other Practitioners - by Provider", check = "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                              ~x,  ~y,
                    "Rndrng_NPI",  npi,
    "Rndrng_Prvdr_Last_Org_Name",  last_name,
       "Rndrng_Prvdr_First_Name",  first_name,
          "Rndrng_Prvdr_Crdntls",  credential,
             "Rndrng_Prvdr_Gndr",  gender,
           "Rndrng_Prvdr_Ent_Cd",  enum_type,
             "Rndrng_Prvdr_City",  city,
     "Rndrng_Prvdr_State_Abrvtn",  state,
       "Rndrng_Prvdr_State_FIPS",  fips,
             "Rndrng_Prvdr_Zip5",  zipcode,
             "Rndrng_Prvdr_RUCA",  ruca,
            "Rndrng_Prvdr_Cntry",  country,
             "Rndrng_Prvdr_Type",  specialty,
 "Rndrng_Prvdr_Mdcr_Prtcptg_Ind",  par)

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
      "npi",          npi,
      "last_name",    last_name,
      "first_name",   first_name,
      "credential",   credential,
      "gender",       gender,
      "enum_type",    enum_type,
      "city",         city,
      "state",        state,
      "fips",         as.character(fips),
      "zipcode",      zipcode,
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

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
             check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(year = as.integer(year),
                    rndrng_prvdr_crdntls = clean_credentials(rndrng_prvdr_crdntls),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::ends_with(c("_hcpcs_cds", "_benes", "_srvcs", "_cnt")), ~as.integer(.)),
                    dplyr::across(dplyr::ends_with(c("amt", "chrg", "pct")), ~as.double(.))) |>
      tidyr::unite("street",
                   dplyr::any_of(c("rndrng_prvdr_st1", "rndrng_prvdr_st2")),
                   remove = TRUE,
                   na.rm = TRUE,
                   sep = " ") |>
      dplyr::select(year,
                    npi = rndrng_npi,
                    first_name = rndrng_prvdr_first_name,
                    middle_name = rndrng_prvdr_mi,
                    last_name = rndrng_prvdr_last_org_name,
                    credential = rndrng_prvdr_crdntls,
                    gender = rndrng_prvdr_gndr,
                    enum_type = rndrng_prvdr_ent_cd,
                    street,
                    city = rndrng_prvdr_city,
                    state = rndrng_prvdr_state_abrvtn,
                    fips = rndrng_prvdr_state_fips,
                    zipcode = rndrng_prvdr_zip5,
                    ruca = rndrng_prvdr_ruca,
                    #ruca_desc = rndrng_prvdr_ruca_desc,
                    country = rndrng_prvdr_cntry,
                    specialty = rndrng_prvdr_type,
                    par = rndrng_prvdr_mdcr_prtcptg_ind,
                    tot_hcpcs = tot_hcpcs_cds,
                    tot_benes,
                    tot_srvcs,
                    tot_charges = tot_sbmtd_chrg,
                    tot_allowed = tot_mdcr_alowd_amt,
                    tot_payment = tot_mdcr_pymt_amt,
                    tot_std_pymt = tot_mdcr_stdzd_amt,
                    drug_supp = drug_sprsn_ind,
                    drug_hcpcs = drug_tot_hcpcs_cds,
                    drug_benes = drug_tot_benes,
                    drug_srvcs = drug_tot_srvcs,
                    drug_charges = drug_sbmtd_chrg,
                    drug_allowed = drug_mdcr_alowd_amt,
                    drug_payment = drug_mdcr_pymt_amt,
                    drug_std_pymt = drug_mdcr_stdzd_amt,
                    med_supp = med_sprsn_ind,
                    med_hcpcs = med_tot_hcpcs_cds,
                    med_benes = med_tot_benes,
                    med_srvcs = med_tot_srvcs,
                    med_charges = med_sbmtd_chrg,
                    med_allowed = med_mdcr_alowd_amt,
                    med_payment = med_mdcr_pymt_amt,
                    med_std_pymt = med_mdcr_stdzd_amt,
                    bene_age_avg = bene_avg_age,
                    bene_age_lt65 = bene_age_lt_65_cnt,
                    bene_age_65_74 = bene_age_65_74_cnt,
                    bene_age_75_84 = bene_age_75_84_cnt,
                    bene_age_gt84 = bene_age_gt_84_cnt,
                    bene_female = bene_feml_cnt,
                    bene_male = bene_male_cnt,
                    bene_race_wht = bene_race_wht_cnt,
                    bene_race_blk = bene_race_black_cnt,
                    bene_race_api = bene_race_api_cnt,
                    bene_race_span = bene_race_hspnc_cnt,
                    bene_race_nat = bene_race_natind_cnt,
                    bene_race_oth = bene_race_othr_cnt,
                    bene_dual = bene_dual_cnt,
                    bene_ndual = bene_ndual_cnt,
                    bene_cc_af = bene_cc_af_pct,
                    bene_cc_alz = bene_cc_alzhmr_pct,
                    bene_cc_asth = bene_cc_asthma_pct,
                    bene_cc_canc = bene_cc_cncr_pct,
                    bene_cc_chf = bene_cc_chf_pct,
                    bene_cc_ckd = bene_cc_ckd_pct,
                    bene_cc_copd = bene_cc_copd_pct,
                    bene_cc_dep = bene_cc_dprssn_pct,
                    bene_cc_diab = bene_cc_dbts_pct,
                    bene_cc_hplip = bene_cc_hyplpdma_pct,
                    bene_cc_hpten = bene_cc_hyprtnsn_pct,
                    bene_cc_ihd = bene_cc_ihd_pct,
                    bene_cc_opo = bene_cc_opo_pct,
                    bene_cc_raoa = bene_cc_raoa_pct,
                    bene_cc_sz = bene_cc_sz_pct,
                    bene_cc_strk = bene_cc_strok_pct,
                    bene_risk_avg = bene_avg_risk_scre)
    }
  return(results)
}
