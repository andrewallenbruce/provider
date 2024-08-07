#' Provider Utilization & Demographics by Year
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [utilization()] allows access to information on services and
#' procedures provided to Original Medicare (fee-for-service) Part B
#' beneficiaries by physicians and other healthcare professionals; aggregated
#' by provider, service and geography.
#'
#' @section By Provider:
#' __type =__`"Provider"`:
#'
#' The __Provider__ dataset allows the user access to data such as
#' services and procedures performed; charges submitted and payment received;
#' and beneficiary demographic and health characteristics for providers
#' treating Original Medicare (fee-for-service) Part B beneficiaries,
#' aggregated by year.
#'
#' @section By Provider and Service:
#' __type =__`"Service"`:
#'
#' The __Provider and Service__ dataset is aggregated by:
#'
#'    1. Rendering provider's NPI
#'    2. Healthcare Common Procedure Coding System (HCPCS) code
#'    3. Place of Service (Facility or Non-facility)
#'
#' There can be multiple records for a given NPI based on the number of
#' distinct HCPCS codes that were billed and where the services were
#' provided. Data have been aggregated based on the place of service
#' because separate fee schedules apply depending on whether the place
#' of service submitted on the claim is facility or non-facility.
#'
#' @section By Geography and Service:
#' __type =__`"Geography"`:
#'
#' The __Geography and Service__ dataset contains information on utilization,
#' allowed amount, Medicare payment, and submitted charges organized nationally
#' and state-wide by HCPCS code and place of service.
#'
#' @section Links:
#' + [Medicare Physician & Other Practitioners: by Provider API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)
#' + [Medicare Physician & Other Practitioners: by Provider and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
#' + [Medicare Physician & Other Practitioners: by Geography and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service)
#'
#' *Update Frequency:* **Annually**
#'
#' @examplesIf interactive()
#' utilization(year = 2020,
#'             type = 'Provider',
#'             npi = 1003000423)
#'
#' utilization(year = 2019,
#'             type = 'Service',
#'             npi = 1003000126)
#'
#' utilization(year = 2020,
#'             type = 'Geography',
#'             hcpcs = '0002A')
#'
#' # Use the years helper function to
#' # retrieve results for every year:
#' util_years() |>
#' map(\(x) utilization(year = x,
#'                      type = 'Provider',
#'                      npi = 1043477615)) |>
#' list_rbind()
#'
#' # Parallelized version
#' utilization_(type = 'Provider',
#'              npi = 1043477615)
#'
#' utilization_(type = 'Service',
#'              npi = 1043477615)
#'
#' utilization_(type = 'Geography',
#'              hcpcs = '0002A')
#'
#' @name utilization
NULL

#' @param year `<int>` // **required** Year data was reported, in `YYYY` format.
#'   Run [util_years()] to return a vector of the years currently available.
#'
#' @param type `<chr>` // **required** dataset to query, `"Provider"`,
#'   `"Service"`, `"Geography"`
#'
#' @param npi `<int>` 10-digit national provider identifier
#'
#' @param first,last,organization `<chr>` Individual/Organizational provider's
#'   name
#'
#' @param credential `<chr>` Individual provider's credentials
#'
#' @param gender `<chr>` Individual provider's gender; `"F"` (Female), `"M"`
#'   (Male)
#'
#' @param entype `<chr>` Provider entity type; `"I"` (Individual), `"O"`
#'   (Organization)
#'
#' @param city `<chr>` City where provider is located
#'
#' @param state `<chr>` State where provider is located
#'
#' @param fips `<chr>` Provider's state's FIPS code
#'
#' @param zip `<chr>` Provider’s zip code
#'
#' @param ruca `<chr>` Provider’s RUCA code
#'
#' @param country `<chr>` Country where provider is located
#'
#' @param specialty `<chr>` Provider specialty code reported on the largest
#'   number of claims submitted
#'
#' @param par `<lgl>` Identifies whether the provider participates in Medicare
#'   and/or accepts assignment of Medicare allowed amounts
#'
#' @param hcpcs `<chr>` HCPCS code used to identify the specific medical service
#'   furnished by the provider
#'
#' @param drug `<lgl>` Identifies whether the HCPCS code is listed in the
#'   Medicare Part B Drug Average Sales Price (ASP) File
#'
#' @param pos `<chr>` Identifies whether the Place of Service (POS) submitted on
#'   the claims is a:
#'
#'    + Facility (`"F"`): Hospital, Skilled Nursing Facility, etc.
#'    + Non-facility (`"O"`): Office, Home, etc.
#'
#' @param level `<chr>` Geographic level by which the data will be aggregated:
#'
#'    + `"State"`: Data is aggregated for each state
#'    + `"National"`: Data is aggregated across all states for a given HCPCS Code
#'
#' @param tidy `<lgl>` // __default:__ `TRUE` Tidy output
#'
#' @param rbcs `<lgl>` // __default:__ `TRUE` Add Restructured BETOS
#'   Classifications to HCPCS codes
#'
#' @param nest `<lgl>` // __default:__ `TRUE` Nest `performance`, `demographics`
#'   and `conditions` columns
#'
#' @param detailed `<lgl>` // __default:__ `FALSE` Include nested `medical` and
#'   `drug` columns
#'
#' @param na.rm `<lgl>` // __default:__ `TRUE` Remove empty rows and columns
#'
#' @param ... Empty dots
#'
#' @rdname utilization
#'
#' @autoglobal
#'
#' @export
utilization <- function(year,
                        type,
                        npi          = NULL,
                        first        = NULL,
                        last         = NULL,
                        organization = NULL,
                        credential   = NULL,
                        gender       = NULL,
                        entype       = NULL,
                        city         = NULL,
                        state        = NULL,
                        zip          = NULL,
                        fips         = NULL,
                        ruca         = NULL,
                        country      = NULL,
                        specialty    = NULL,
                        par          = NULL,
                        level        = NULL,
                        hcpcs        = NULL,
                        drug         = NULL,
                        pos          = NULL,
                        tidy         = TRUE,
                        nest         = TRUE,
                        detailed     = FALSE,
                        rbcs         = TRUE,
                        na.rm        = TRUE,
                        ...) {

  rlang::check_required(year)
  year <- as.character(year)
  year <- rlang::arg_match0(year, as.character(util_years()))
  type <- rlang::arg_match0(type, c('Provider', 'Service', 'Geography'))

  if (type != 'Provider') c(nest, detailed) %<-% c(FALSE, FALSE)
  if (type == 'Provider') c(rbcs, hcpcs = NULL, pos = NULL, drug = NULL) %<-% c(FALSE) # nolint
  if (type != 'Geography') {
    param_state <- 'Rndrng_Prvdr_State_Abrvtn'
    param_fips  <- 'Rndrng_Prvdr_State_FIPS'
    level       <- NULL
  }

  if (type == 'Geography') {
    param_state <- 'Rndrng_Prvdr_Geo_Desc'
    param_fips <- 'Rndrng_Prvdr_Geo_Cd'
    npi <- NULL
    first <- NULL
    last <- NULL
    organization <- NULL
    credential <- NULL
    gender <- NULL
    entype <- NULL
    city <- NULL
    zip <- NULL
    ruca <- NULL
    country <- NULL
    specialty <- NULL
    par <- NULL # nolint
    level <- level %nn% rlang::arg_match0(level, c('National', 'State'))
    if (!is.null(state) && (state %in% state.abb)) state <- abb2full(state)
  }

  npi   <- npi %nn% validate_npi(npi)
  zip   <- zip %nn% as.character(zip)
  fips  <- fips %nn% as.character(fips)
  ruca  <- ruca %nn% as.character(ruca)
  par   <- par %nn% tf_2_yn(par)              # nolint
  hcpcs <- hcpcs %nn% as.character(hcpcs)
  drug  <- drug %nn% tf_2_yn(drug)
  pos   <- pos %nn% rlang::arg_match0(pos, c("F", "O"))

  args <- dplyr::tribble(
    ~param,                           ~arg,
    "Rndrng_NPI",                     npi,
    "Rndrng_Prvdr_First_Name",        first,
    "Rndrng_Prvdr_Last_Org_Name",     last,
    "Rndrng_Prvdr_Last_Org_Name",     organization,
    "Rndrng_Prvdr_Crdntls",           credential,
    "Rndrng_Prvdr_Gndr",              gender,
    "Rndrng_Prvdr_Ent_Cd",            entype,
    "Rndrng_Prvdr_City",              city,
    param_state,                      state,
    param_fips,                       fips,
    "Rndrng_Prvdr_Zip5",              zip,
    "Rndrng_Prvdr_RUCA",              ruca,
    "Rndrng_Prvdr_Cntry",             country,
    "Rndrng_Prvdr_Type",              specialty,
    "Rndrng_Prvdr_Mdcr_Prtcptg_Ind",  par,      # nolint
    "HCPCS_Cd",                       hcpcs,
    "HCPCS_Drug_Ind",                 drug,
    "Place_Of_Srvc",                  pos,
    "Rndrng_Prvdr_Geo_Lvl",           level)

  yr <- switch(type,
    'Provider'   = api_years('prv'),
    'Service'    = api_years('srv'),
    'Geography'  = api_years('geo'))

  id <- dplyr::filter(
    yr,
    year == {{ year }}
    ) |>
    dplyr::pull(distro)

  url <- paste0(
    "https://data.cms.gov/data-api/v1/dataset/",
    id,
    "/data.json?",

    encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "year",         year,
      "level",        level,
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
      "par",          par,        # nolint
      "hcpcs",        hcpcs,
      "drug",         drug,
      "pos",          pos) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (!tidy) results <- df2chr(results)

  if (tidy) {

    results$year <- year

    results <- switch(type,
      "Provider"  = tidyup_provider.util(results, nest = nest, detailed = detailed),
      "Service"   = tidyup_service.util(results, rbcs = rbcs),
      "Geography" = tidyup_geography.util(results, rbcs = rbcs))

    if (na.rm) results <- narm(results)
  }
  return(results)
}

#' Parallelized [utilization()]
#'
#' @param year `<int>` // **required** Year data was reported, in `YYYY` format.
#'   Run [util_years()] to return a vector of the years currently available.
#'
#' @param ... Pass arguments to [utilization()].
#'
#' @rdname utilization
#'
#' @autoglobal
#'
#' @export
utilization_ <- function(year = util_years(),
                         ...) {
  furrr::future_map_dfr(
    year,
    utilization,
    ...,
    .options = furrr::furrr_options(seed = NULL))
}

#' @param results data frame from [utilization(type = "Provider")]
#'
#' @param nest `<lgl>` Nest `demographics` and `conditions`
#'
#' @param detailed `<lgl>` Include `detailed` column
#'
#' @autoglobal
#'
#' @noRd
tidyup_provider.util <- function(results, nest, detailed) {

  results <- janitor::clean_names(results) |>
    cols_util("Provider") |>
    tidyup(
      yn = "par",
      int = c("year", "_hcpcs", "bene", "_srvcs"),
      dbl = c("pay", "pymt", "charges", "allowed", "cc_", "hcc"),
      cred = "credential",
      zip = 'rndrng_prvdr_zip5') |>
    combine(
      address,
      c('rndrng_prvdr_st1', 'rndrng_prvdr_st2')
      ) |>
    dplyr::mutate(
      specialty       = correct_specialty(specialty),
      .copay_deduct   = tot_allowed - tot_payment,
      .srvcs_per_bene = tot_srvcs   / tot_benes,
      .pymt_per_bene  = tot_payment / tot_benes,
      .pymt_per_srvc  = tot_payment / tot_srvcs,
      entity_type     = fct_ent(entity_type),
      gender          = fct_gen(gender),
      state           = fct_stabb(state)
      ) |>
    dplyr::mutate(
      bene_race_nonwht = tot_benes - bene_race_wht,
      .after = bene_race_wht)

  if (nest) {
    race_cols <- c(
      'bene_race_blk',
      'bene_race_api',
      'bene_race_hisp',
      'bene_race_nat',
      'bene_race_oth')

    results <- tidyr::nest(
      results,
      bene_race_detailed = dplyr::any_of(race_cols))

    results <- tidyr::nest(
      results,
      performance = c(dplyr::starts_with("tot_"), dplyr::starts_with(".")),
      demographics = c(dplyr::starts_with("bene_"), bene_race_detailed),
      conditions = c(hcc_risk_avg, dplyr::starts_with("cc_")))
  }
  if (detailed) {
    results <- tidyr::nest(
      results,
      medical = dplyr::starts_with("med_"),
      drug = dplyr::starts_with("drug_")
      ) |>
      tidyr::nest(
        results,
        detailed = c(medical, drug))
  } else {
    results <- dplyr::select(
      results,
      -dplyr::starts_with("med_"),
      -dplyr::starts_with("drug_"))
  }

  class(results) <- c("utilization_provider", class(results))

  return(results)
}

#' @param results data frame from [utilization(type = "Service")]
#'
#' @param rbcs `<lgl>` Add Restructured BETOS Classifications to HCPCS codes
#'
#' @autoglobal
#'
#' @noRd
tidyup_service.util <- function(results, rbcs) {

  results$level <- "Provider"

  results <- tidyup(results,
                    yn  = "_ind",
                    int = c("year", "tot_"),
                    dbl = "avg_",
                    cred = "credential",
                    zip = 'rndrng_prvdr_zip5') |>
    combine(address, c('rndrng_prvdr_st1',
                       'rndrng_prvdr_st2')) |>
    cols_util("Service") |>
    dplyr::mutate(specialty = correct_specialty(specialty),
                  gender    = fct_gen(gender),
                  state     = fct_stabb(state),
                  pos       = fct_pos(pos),
                  level     = fct_level(level))

  if (rbcs) results <- rbcs_util(results)

  class(results) <- c("utilization_service", class(results))
  return(results)
}

#' @param results data frame from [utilization(type = "Geography")]
#'
#' @param rbcs `<lgl>` Add Restructured BETOS Classifications to HCPCS codes
#'
#' @autoglobal
#'
#' @noRd
tidyup_geography.util <- function(results, rbcs) {

  results <- tidyup(results,
                    yn           = "_ind",
                    int          = c("year", "tot_"),
                    dbl          = "avg_") |>
    dplyr::mutate(rndrng_prvdr_geo_desc = fct_stname(rndrng_prvdr_geo_desc),
                  place_of_srvc         = fct_pos(place_of_srvc),
                  rndrng_prvdr_geo_lvl  = fct_level(rndrng_prvdr_geo_lvl)) |>
    cols_util("Geography")

  if (rbcs) results <- rbcs_util(results)

  class(results) <- c("utilization_geography", class(results))

  return(results)
}

#' @param df data frame
#'
#' @param type 'Provider', 'Service', 'Geography' or 'rbcs'
#'
#' @autoglobal
#'
#' @noRd
cols_util <- function(df, type) {

  if (type == "Geography") {

    cols <- c("year",
              "level"        = "rndrng_prvdr_geo_lvl",
              "state"        = "rndrng_prvdr_geo_desc",
              "fips"         = "rndrng_prvdr_geo_cd",
              "hcpcs"        = "hcpcs_cd",
              "hcpcs_desc",
              "drug"         = "hcpcs_drug_ind",
              "pos"          = "place_of_srvc",
              "tot_provs"    = "tot_rndrng_prvdrs",
              "tot_benes",
              "tot_srvcs",
              "tot_day"      = "tot_bene_day_srvcs",
              "avg_charge"   = "avg_sbmtd_chrg",
              "avg_allowed"  = "avg_mdcr_alowd_amt",
              "avg_payment"  = "avg_mdcr_pymt_amt",
              "avg_std_pymt" = "avg_mdcr_stdzd_amt")
  }

  if (type == "Service") {

    cols <- c('year',
              'npi'          = 'rndrng_npi',
              'level',
              'entity_type'  = 'rndrng_prvdr_ent_cd',
              'first'        = 'rndrng_prvdr_first_name',
              'middle'       = 'rndrng_prvdr_mi',
              'last'         = 'rndrng_prvdr_last_org_name',
              'gender'       = 'rndrng_prvdr_gndr',
              'credential'   = 'rndrng_prvdr_crdntls',
              'specialty'    = 'rndrng_prvdr_type',
              'address',
              'city'         = 'rndrng_prvdr_city',
              'state'        = 'rndrng_prvdr_state_abrvtn',
              'zip'          = 'rndrng_prvdr_zip5',
              'fips'         = 'rndrng_prvdr_state_fips',
              'ruca'         = 'rndrng_prvdr_ruca',
              # 'ruca_desc'  = 'rndrng_prvdr_ruca_desc',
              'country'      = 'rndrng_prvdr_cntry',
              'par'          = 'rndrng_prvdr_mdcr_prtcptg_ind',
              'hcpcs'        = 'hcpcs_cd',
              'hcpcs_desc',
              'category',
              'subcategory',
              'family',
              'procedure',
              'drug'         = 'hcpcs_drug_ind',
              'pos'          = 'place_of_srvc',
              'tot_benes',
              'tot_srvcs',
              'tot_day'      = 'tot_bene_day_srvcs',
              'avg_charge'   = 'avg_sbmtd_chrg',
              'avg_allowed'  = 'avg_mdcr_alowd_amt',
              'avg_payment'  = 'avg_mdcr_pymt_amt',
              'avg_std_pymt' = 'avg_mdcr_stdzd_amt')

  }

  if (type == "Provider") {

    cols <- c("year",
              "npi"            = "rndrng_npi",
              "entity_type"    = "rndrng_prvdr_ent_cd",
              "first"          = "rndrng_prvdr_first_name",
              "middle"         = "rndrng_prvdr_mi",
              "last"           = "rndrng_prvdr_last_org_name",
              "gender"         = "rndrng_prvdr_gndr",
              "credential"     = "rndrng_prvdr_crdntls",
              "specialty"      = "rndrng_prvdr_type",
              'rndrng_prvdr_st1',
              'rndrng_prvdr_st2',
              "city"           = "rndrng_prvdr_city",
              "state"          = "rndrng_prvdr_state_abrvtn",
              "zip"            = "rndrng_prvdr_zip5",
              "fips"           = "rndrng_prvdr_state_fips",
              "ruca"           = "rndrng_prvdr_ruca",
              "country"        = "rndrng_prvdr_cntry",
              "par"            = "rndrng_prvdr_mdcr_prtcptg_ind",
              "tot_hcpcs"      = "tot_hcpcs_cds",
              "tot_benes",
              "tot_srvcs",
              "tot_charges"    = "tot_sbmtd_chrg",
              "tot_allowed"    = "tot_mdcr_alowd_amt",
              "tot_payment"    = "tot_mdcr_pymt_amt",
              "tot_std_pymt"   = "tot_mdcr_stdzd_amt",
              "drug_hcpcs"     = "drug_tot_hcpcs_cds",
              "drug_benes"     = "drug_tot_benes",
              "drug_srvcs"     = "drug_tot_srvcs",
              "drug_charges"   = "drug_sbmtd_chrg",
              "drug_allowed"   = "drug_mdcr_alowd_amt",
              "drug_payment"   = "drug_mdcr_pymt_amt",
              "drug_std_pymt"  = "drug_mdcr_stdzd_amt",
              "med_hcpcs"      = "med_tot_hcpcs_cds",
              "med_benes"      = "med_tot_benes",
              "med_srvcs"      = "med_tot_srvcs",
              "med_charges"    = "med_sbmtd_chrg",
              "med_allowed"    = "med_mdcr_alowd_amt",
              "med_payment"    = "med_mdcr_pymt_amt",
              "med_std_pymt"   = "med_mdcr_stdzd_amt",
              "bene_age_avg"   = "bene_avg_age",
              "bene_age_lt65"  = "bene_age_lt_65_cnt",
              "bene_age_65_74" = "bene_age_65_74_cnt",
              "bene_age_75_84" = "bene_age_75_84_cnt",
              "bene_age_gt84"  = "bene_age_gt_84_cnt",
              "bene_gen_female"    = "bene_feml_cnt",
              "bene_gen_male"      = "bene_male_cnt",
              "bene_race_wht"  = "bene_race_wht_cnt",
              "bene_race_blk"  = "bene_race_black_cnt",
              "bene_race_api"  = "bene_race_api_cnt",
              "bene_race_hisp" = "bene_race_hspnc_cnt",
              "bene_race_nat"  = "bene_race_nat_ind_cnt",
              "bene_race_oth"  = "bene_race_othr_cnt",
              "bene_dual"      = "bene_dual_cnt",
              "bene_ndual"     = "bene_ndual_cnt",
              "cc_af"          = "bene_cc_af_pct",
              "cc_alz"         = "bene_cc_alzhmr_pct",
              "cc_asth"        = "bene_cc_asthma_pct",
              "cc_canc"        = "bene_cc_cncr_pct",
              "cc_chf"         = "bene_cc_chf_pct",
              "cc_ckd"         = "bene_cc_ckd_pct",
              "cc_copd"        = "bene_cc_copd_pct",
              "cc_dep"         = "bene_cc_dprssn_pct",
              "cc_diab"        = "bene_cc_dbts_pct",
              "cc_hplip"       = "bene_cc_hyplpdma_pct",
              "cc_hpten"       = "bene_cc_hyprtnsn_pct",
              "cc_ihd"         = "bene_cc_ihd_pct",
              "cc_opo"         = "bene_cc_opo_pct",
              "cc_raoa"        = "bene_cc_raoa_pct",
              "cc_sz"          = "bene_cc_sz_pct",
              "cc_strk"        = "bene_cc_strok_pct",
              "hcc_risk_avg"   = "bene_avg_risk_scre")
  }

  if (type == "rbcs") {

    cols <- c('year',
              'npi',
              'level',
              'entype',
              'first',
              'middle',
              'last',
              'gender',
              'credential',
              'specialty',
              'address',
              'city',
              'state',
              'zip',
              'fips',
              'ruca',
              'country',
              'par',
              'hcpcs',
              'hcpcs_desc',
              'category',
              'subcategory',
              'family',
              'procedure',
              'drug',
              'pos',
              'tot_provs',
              'tot_benes',
              'tot_srvcs',
              'tot_day',
              'avg_charge',
              'avg_allowed',
              'avg_payment',
              'avg_std_pymt')
  }

  df |> dplyr::select(dplyr::any_of(cols))
}

#' @param x vector
#'
#' @autoglobal
#'
#' @noRd
correct_specialty <- function(x) {
  dplyr::case_match(x,
    "Allergy/ Immunology" ~ "Allergy/Immunology",
    "Obstetrics & Gynecology" ~ "Obstetrics/Gynecology",
    "Hematology-Oncology" ~ "Hematology/Oncology",
    "Independent Diagnostic Testing Facility (IDTF)" ~ "Independent Diagnostic Testing Facility",
    "Mass Immunizer Roster Biller" ~ "Mass Immunization Roster Biller",
    "Anesthesiologist Assistants" ~ "Anesthesiology Assistant",
    "Occupational therapist" ~ "Occupational Therapist",
    "Psychologist, Clinical" ~ "Clinical Psychologist",
    .default = x)
}
