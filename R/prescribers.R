#' Prescriber Utilization & Demographics by Year
#'
#' @description
#' Access information on prescription drugs provided
#' to Medicare beneficiaries enrolled in Part D (Prescription Drug Coverage),
#' by physicians and other health care providers; aggregated by provider, drug
#' and geography.
#'
#' The Medicare Part D Prescribers Datasets contain information on prescription
#' drug events (PDEs) incurred by Medicare beneficiaries with a Part D
#' prescription drug plan. The Part D Prescribers Datasets are organized by
#' National Provider Identifier (NPI) and drug name and contains information
#' on drug utilization (claim counts and day supply) and total drug costs.
#'
#' @section By Provider:
#' __type =__`"Provider"`:
#'
#' The Medicare Part D Prescribers by __Provider__ dataset summarizes for each
#' prescriber the total number of prescriptions that were dispensed, which
#' include original prescriptions and any refills, and the total drug cost.
#'
#' @section By Provider and Drug:
#' __type =__`"Drug"`:
#'
#' The Medicare Part D Prescribers by __Provider and Drug__ dataset contains
#' the total number of prescription fills that were dispensed and the total
#' drug cost paid organized by prescribing National Provider Identifier (NPI),
#' drug brand name (if applicable) and drug generic name.
#'
#' @section By Geography and Drug:
#' __type =__`"Geography"`:
#'
#' For each drug, the __Geography and Drug__ dataset includes the total number
#' of prescriptions that were dispensed, which include original prescriptions
#' and any refills, and the total drug cost.
#'
#' The total drug cost includes the ingredient cost of the medication,
#' dispensing fees, sales tax, and any applicable administration fees and is
#' based on the amount paid by the Part D plan, Medicare beneficiary, government
#' subsidies, and any other third-party payers.
#'
#' @section Links:
#' + [Medicare Part D Prescribers: by Provider](https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-provider)
#' + [Medicare Part D Prescribers: by Provider and Drug](https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-provider-and-drug)
#' + [Medicare Part D Prescribers: by Geography and Drug](https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-geography-and-drug)
#' + [Medicare Part D Prescribers Technical Specifications](https://data.cms.gov/sites/default/files/2021-08/mup_dpr_ry21_20210819_technical_specifications.pdf)
#'
#' *Update Frequency:* **Annually**
#'
#' @examplesIf interactive()
#' prescribers(year = 2020,
#'             type = 'Provider',
#'             npi = 1003000423)
#'
#' prescribers(year = 2019,
#'             type = 'Drug',
#'             npi = 1003000126)
#'
#' prescribers(year = 2021,
#'             type = 'Geography',
#'             brand_name = 'Clotrimazole-Betamethasone')
#'
#' prescribers(year = 2017,
#'             type = 'Geography',
#'             level = 'National',
#'             brand_name = 'Paroxetine Hcl')
#'
#' prescribers(year = 2017,
#'             type = 'Geography',
#'             opioid = TRUE)
#'
#' # Use the years helper function to
#' # retrieve results for every year:
#' rx_years() |>
#' map(\(x) prescribers(year = x,
#'                      type = 'Provider',
#'                      npi = 1043477615)) |>
#' list_rbind()
#'
#' # Parallelized version
#' prescribers_(type = 'Provider',
#'              npi = 1043477615)
#'
#' prescribers_(type = 'Drug',
#'              npi = 1003000423)
#'
#' prescribers_(type = 'Geography',
#'              level = 'National',
#'              generic_name = 'Mirabegron')
#'
#' @name prescribers
NULL

#' @param year `<int>` // **required** Year data was reported, in `YYYY` format.
#'   Run [rx_years()] to return a vector of the years currently available.
#'
#' @param type `<chr>` // **required** dataset to query, `"Provider"`, `"Drug"`,
#'   `"Geography"`
#'
#' @param npi `<int>` 10-digit national provider identifier
#'
#' @param first,last,organization `<chr>` Individual/Organizational prescriber's
#'   name
#'
#' @param credential `<chr>` Individual prescriber's credentials
#'
#' @param gender `<chr>` Individual prescriber's gender; `"F"` (Female), `"M"`
#'   (Male)
#'
#' @param entype `<chr>` Prescriber entity type; `"I"` (Individual), `"O"`
#'   (Organization)
#'
#' @param city `<chr>` City where prescriber is located
#'
#' @param state `<chr>` State where prescriber is located
#'
#' @param fips `<chr>` Prescriber's state's FIPS code
#'
#' @param zip `<chr>` Prescriber’s zip code
#'
#' @param ruca `<chr>` Prescriber’s RUCA code
#'
#' @param country `<chr>` Country where prescriber is located
#'
#' @param specialty `<chr>` Prescriber specialty code reported on the largest
#'   number of claims submitted
#'
#' @param brand_name `<chr>` Brand name (trademarked name) of the drug
#' filled, derived by linking the National Drug Codes (NDCs) from PDEs to a
#' drug information database.
#'
#' @param generic_name `<chr>` USAN generic name of the drug filled (short
#' version); A term referring to the chemical ingredient of a drug rather than
#' the trademarked brand name under which the drug is sold, derived by linking
#' the National Drug Codes (NDCs) from PDEs to a drug information database.
#'
#' @param level `<chr>` Geographic level by which the data will be aggregated:
#'
#'    + `"State"`: Data is aggregated for each state
#'    + `"National"`: Data is aggregated across all states for a given HCPCS Code
#'
#' @param opioid `<lgl>` _type = 'Geography'_, `TRUE` returns Opioid drugs
#'
#' @param opioidLA `<lgl>` _type = 'Geography'_, `TRUE` returns Long-acting Opioids
#'
#' @param antibiotic `<lgl>` _type = 'Geography'_, `TRUE` returns antibiotics
#'
#' @param antipsychotic `<lgl>` _type = 'Geography'_, `TRUE` returns antipsychotics
#'
#' @param tidy `<lgl>` // __default:__ `TRUE` Tidy output
#'
#' @param nest `<lgl>` // __default:__ `TRUE` Nest output
#'
#' @param na.rm `<lgl>` // __default:__ `TRUE` Remove empty rows and columns
#'
#' @param ... Empty dots.
#'
#' @rdname prescribers
#'
#' @autoglobal
#'
#' @export
prescribers <- function(year,
                        type,
                        npi = NULL,
                        first = NULL,
                        last = NULL,
                        organization = NULL,
                        credential  = NULL,
                        gender = NULL,
                        entype = NULL,
                        city = NULL,
                        state = NULL,
                        zip = NULL,
                        fips = NULL,
                        ruca = NULL,
                        country = NULL,
                        specialty = NULL,
                        brand_name = NULL,
                        generic_name = NULL,
                        level = NULL,
                        opioid = NULL,
                        opioidLA = NULL,
                        antibiotic = NULL,
                        antipsychotic = NULL,
                        tidy = TRUE,
                        nest = TRUE,
                        na.rm = TRUE,
                        ...) {

  rlang::check_required(year)
  year <- as.character(year)
  year <- rlang::arg_match0(year, as.character(rx_years()))

  npi   <- npi %nn% validate_npi(npi)
  zip   <- zip %nn% as.character(zip)
  fips  <- fips %nn% as.character(fips)
  ruca  <- ruca %nn% as.character(ruca)

  rlang::check_required(type)
  type <- rlang::arg_match0(type, c('Provider', 'Drug', 'Geography'))

  if (type == 'Provider') {
    param_npi <- 'Prscrbr_NPI'
    param_state <- 'Prscrbr_State_Abrvtn'
    param_fips <- 'Prscrbr_State_FIPS'
    brand_name <- NULL
    generic_name <- NULL
    level <- NULL
  }

  if (type == 'Drug') {
    param_npi  <- 'Prscrbr_NPI'
    param_state <- 'Prscrbr_State_Abrvtn'
    param_fips <- 'Prscrbr_State_FIPS'
    credential <- NULL
    gender <- NULL
    entype <- NULL
    fips <- NULL
    zip <- NULL
    ruca <- NULL
    country <- NULL
    level <- NULL
  }

  if (type == 'Geography') {
    param_npi  <- 'Prscrbr_NPI'
    param_state <- 'Prscrbr_Geo_Desc'
    param_fips <- 'Prscrbr_Geo_Cd'
    npi <- NULL
    first <- NULL
    last <- NULL
    specialty <- NULL
    organization <- NULL
    credential <- NULL
    gender <- NULL
    entype <- NULL
    zip <- NULL
    ruca <- NULL
    country <- NULL
    level <- level %nn% rlang::arg_match0(level, c('National', 'State'))
    if (!is.null(state) && (state %in% state.abb)) state <- abb2full(state)
    opioid <- opioid %nn% tf_2_yn(opioid)
    opioidLA <- opioidLA %nn% tf_2_yn(opioidLA)
    antibiotic <- antibiotic %nn% tf_2_yn(antibiotic)
    antipsychotic <- antipsychotic %nn% tf_2_yn(antipsychotic)
  }

  args <- dplyr::tribble(
    ~param,                 ~arg,
    param_npi,               npi,
    'Prscrbr_First_Name',    first,
    'Prscrbr_Last_Org_Name', last,
    'Prscrbr_Crdntls',       credential,
    'Prscrbr_Gndr',          gender,
    'Prscrbr_Ent_Cd',        entype,
    'Prscrbr_City',          city,
    param_state,             state,
    param_fips,              fips,
    'Prscrbr_zip5',          zip,
    'Prscrbr_RUCA',          ruca,
    'Prscrbr_Cntry',         country,
    'Prscrbr_Type',          specialty,
    'Brnd_Name',             brand_name,
    'Gnrc_Name',             generic_name,
    'Prscrbr_Geo_Lvl',       level,
    'Opioid_Drug_Flag',      opioid,
    'Opioid_LA_Drug_Flag',   opioidLA,
    'Antbtc_Drug_Flag',      antibiotic,
    'Antpsyct_Drug_Flag',    antipsychotic)

  id <- switch(
    type,
    "Provider"  = api_years("rxp", year = as.integer(year))[["distro"]],
    "Drug"      = api_years("rxd", year = as.integer(year))[["distro"]],
    "Geography" = api_years("rxg", year = as.integer(year))[["distro"]])

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/", id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      'year',         year,
      'npi',          npi,
      'first',        first,
      'last',         last,
      'organization', organization,
      'credential',   credential,
      'gender',       gender,
      'entype',       entype,
      'city',         city,
      'state',        state,
      'fips',         fips,
      'zip',          zip,
      'ruca',         ruca,
      'country',      country,
      'specialty',    specialty,
      'brand_name',   brand_name,
      'generic_name', generic_name,
      'level',        level) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(
    response,
    simplifyVector = TRUE)

  if (!tidy) results <- df2chr(results)

  if (tidy) {

    results$year <- year

    results <- switch(
      type,
      'Provider'  = tidyup_provider.rx(results, nest = nest),
      'Drug'      = tidyup_drug.rx(results, nest = nest),
      'Geography' = tidyup_geography.rx(results))

    if (na.rm) results <- narm(results)
  }
  return(results)
}

#' @param results data frame from [prescribers(type = "Geography")]
#' @autoglobal
#' @noRd
tidyup_geography.rx <- function(results) {

  results <- cols_rx(results, 'Geography') |>
    tidyup(cma = 'tot_',
           int  = c('year',
                    'tot_prescribers',
                    'tot_claims',
                    'tot_benes'),
           dbl  = c('tot_fills',
                    'tot_cost'),
           yn = c('opioid',
                  'opioid_la',
                  'antibiotic',
                  'antipsychotic')) |>
    dplyr::mutate(state = fct_stname(state),
                  level = fct_level(level))

  results <- dplyr::mutate(
    results,
    dplyr::across(
      dplyr::contains('suppress_'),
      suppress_flag)
    )

  return(results)
}

#' @param results data frame from [prescribers(type = "Drug")]
#' @autoglobal
#' @noRd
tidyup_drug.rx <- function(results, nest = TRUE) {

  results <- cols_rx(results, 'Drug') |>
    tidyup(int  = c('year',
                    'tot_claims',
                    'tot_supply',
                    'tot_benes'),
           dbl  = c('tot_fills',
                    'tot_cost')) |>
    dplyr::mutate(level = 'Provider',
                  # source = fct_src(source), # nolint
                  state = fct_stabb(state),
                  level = fct_level(level))

  results <- dplyr::mutate(
    results,
    dplyr::across(
      dplyr::contains('suppress_'),
      suppress_flag)
  )

  if (nest) {
    results <- results |>
      tidyr::nest(
        gte_65 = dplyr::any_of(
          c(
            'tot_claims_ge65',
            'tot_fills_ge65',
            'tot_cost_ge65',
            'tot_supply_ge65',
            'tot_benes_ge65',
            'suppress_ge65',
            'suppress_bene_ge65'
            )
          )
        )
  }
  return(results)
}

#' @param results data frame from [prescribers(type = "Provider")]
#' @autoglobal
#' @noRd
tidyup_provider.rx <- function(results, nest = TRUE) {

  results <- cols_rx(results, 'Provider') |>
    tidyup(int  = c('year',
                    'tot_claims',
                    'tot_supply',
                    'tot_benes',
                    'bene_age_lt65',
                    'bene_age_65_74',
                    'bene_age_75_84',
                    'bene_age_gt84',
                    'bene_gen_female',
                    'bene_gen_male',
                    'bene_race_wht',
                    'bene_race_blk',
                    'bene_race_api',
                    'bene_race_hisp',
                    'bene_race_nat',
                    'bene_race_oth',
                    'bene_dual',
                    'bene_ndual'),
           dbl  = c('tot_fills',
                    'tot_cost',
                    'hcc_risk_avg',
                    'bene_age_avg',
                    'rx_rate_'),
           cred = 'credential',
           zip  = 'zip') |>
    combine(address, c('prscrbr_st1', 'prscrbr_st2')) |>
    dplyr::mutate(entity_type = fct_ent(entity_type),
                  # source = fct_src(source),              # nolint
                  gender = fct_gen(gender),
                  state = fct_stabb(state)) |>
    dplyr::mutate(bene_race_nonwht = tot_benes - bene_race_wht,
                  .after = bene_race_wht)

  results <- dplyr::mutate(
    results,
    dplyr::across(
      dplyr::contains('suppress_'),
      suppress_flag)
  )

  if (nest) {
    results <- results |>
      tidyr::nest(
        detailed = dplyr::any_of(
          c(
        'tot_claims_brand',
        'tot_cost_brand',
        'tot_claims_generic',
        'tot_cost_generic',
        'tot_claims_other',
        'tot_cost_other',
        'tot_claims_mapd',
        'tot_cost_mapd',
        'tot_claims_pdp',
        'tot_cost_pdp',
        'tot_claims_lis',
        'tot_cost_lis',
        'tot_claims_nlis',
        'tot_cost_nlis',
        'tot_claims_opioid',
        'tot_cost_opioid',
        'tot_supply_opioid',
        'tot_benes_opioid',
        'tot_claims_opioid_la',
        'tot_cost_opioid_la',
        'tot_supply_opioid_la',
        'tot_benes_opioid_la',
        'tot_claims_antibioc',
        'tot_cost_antibioc',
        'tot_benes_antibioc',
        'suppress_brand',
        'suppress_generic',
        'suppress_other',
        'suppress_mapd',
        'suppress_lis',
        'suppress_nlis',
        'suppress_pdp'
        )
      )
    ) |>
      tidyr::nest(
        demographics = dplyr::any_of(
          c(
        'bene_age_avg',
        'bene_age_lt65',
        'bene_age_65_74',
        'bene_age_75_84',
        'bene_age_gt84',
        'bene_gen_female',
        'bene_gen_male',
        'bene_race_wht',
        'bene_race_nonwht',
        'bene_race_api',
        'bene_race_nat',
        'bene_race_oth',
        'bene_dual',
        'bene_ndual'
        )
      )
    ) |>
      tidyr::nest(
        gte_65 = dplyr::any_of(
          c(
        'tot_claims_ge65',
        'tot_fills_ge65',
        'tot_cost_ge65',
        'tot_supply_ge65',
        'tot_benes_ge65',
        'tot_claims_antipsych_ge65',
        'tot_cost_antipsych_ge65',
        'tot_benes_antipsych_ge65'
        )
      )
    )
  }
  return(results)
}

#' Parallelized [prescribers()]
#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run [rx_years()] to return a vector of the years currently available.
#' @param ... Pass arguments to [prescribers()].
#' @rdname prescribers
#' @autoglobal
#' @export
prescribers_ <- function(year = rx_years(),
                         ...) {
  furrr::future_map_dfr(
    year,
    prescribers,
    ...,
    .options = furrr::furrr_options(seed = NULL))
}

#' Convert specialty source to unordered labelled factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_src <- function(x) {
  factor(
    x,
    levels = c("S", "T"),
    labels = c("Medicare Specialty Code",
               "Taxonomy Code Classification"))
}

#' @param df data frame
#' @param type 'Provider', 'Drug', 'Geography'
#' @autoglobal
#' @noRd
cols_rx <- function(df, type) {

  if (type == 'Provider') {
    cols <- c('year',
              'npi' = 'Prscrbr_NPI',
              'entity_type' = 'Prscrbr_Ent_Cd',
              'first' = 'Prscrbr_First_Name',
              'middle' = 'Prscrbr_MI',
              'last' = 'Prscrbr_Last_Org_Name',
              'gender' = 'Prscrbr_Gndr',
              'credential' = 'Prscrbr_Crdntls',
              'specialty' = 'Prscrbr_Type',
              'source' = 'Prscrbr_Type_Src',
              'Prscrbr_St1',
              'Prscrbr_St2',
              'city' = 'Prscrbr_City',
              'state' = 'Prscrbr_State_Abrvtn',
              'zip' = 'Prscrbr_zip5',
              'fips' = 'Prscrbr_State_FIPS',
              'ruca' = 'Prscrbr_RUCA',
              'country' = 'Prscrbr_Cntry',
              'tot_claims' = 'Tot_Clms',
              'tot_fills' = 'Tot_30day_Fills',
              'tot_cost' = 'Tot_Drug_Cst',
              'tot_supply' = 'Tot_Day_Suply',
              'tot_benes' = 'Tot_Benes',
              'suppress_ge65' = 'GE65_Sprsn_Flag',
              'tot_claims_ge65' = 'GE65_Tot_Clms',
              'tot_fills_ge65' = 'GE65_Tot_30day_Fills',
              'tot_cost_ge65' = 'GE65_Tot_Drug_Cst',
              'tot_supply_ge65' = 'GE65_Tot_Day_Suply',
              'suppress_bene_ge65' = 'GE65_Bene_Sprsn_Flag',
              'tot_benes_ge65' = 'GE65_Tot_Benes',
              'suppress_brand' = 'Brnd_Sprsn_Flag',
              'tot_claims_brand' = 'Brnd_Tot_Clms',
              'tot_cost_brand' = 'Brnd_Tot_Drug_Cst',
              'suppress_generic' = 'Gnrc_Sprsn_Flag',
              'tot_claims_generic' = 'Gnrc_Tot_Clms',
              'tot_cost_generic' = 'Gnrc_Tot_Drug_Cst',
              'suppress_other' = 'Othr_Sprsn_Flag',
              'tot_claims_other' = 'Othr_Tot_Clms',
              'tot_cost_other' = 'Othr_Tot_Drug_Cst',
              'suppress_mapd' = 'MAPD_Sprsn_Flag',
              'tot_claims_mapd' = 'MAPD_Tot_Clms',
              'tot_cost_mapd' = 'MAPD_Tot_Drug_Cst',
              'suppress_pdp' = 'PDP_Sprsn_Flag',
              'tot_claims_pdp' = 'PDP_Tot_Clms',
              'tot_cost_pdp' = 'PDP_Tot_Drug_Cst',
              'suppress_lis' = 'LIS_Sprsn_Flag',
              'tot_claims_lis' = 'LIS_Tot_Clms',
              'tot_cost_lis' = 'LIS_Drug_Cst',
              'suppress_nlis' = 'NonLIS_Sprsn_Flag',
              'tot_claims_nlis' = 'NonLIS_Tot_Clms',
              'tot_cost_nlis' = 'NonLIS_Drug_Cst',
              'tot_claims_opioid' = 'Opioid_Tot_Clms',
              'tot_cost_opioid' = 'Opioid_Tot_Drug_Cst',
              'tot_supply_opioid' = 'Opioid_Tot_Suply',
              'tot_benes_opioid' = 'Opioid_Tot_Benes',
              'rx_rate_opioid' = 'Opioid_Prscrbr_Rate',
              'tot_claims_opioid_la' = 'Opioid_LA_Tot_Clms',
              'tot_cost_opioid_la' = 'Opioid_LA_Tot_Drug_Cst',
              'tot_supply_opioid_la' = 'Opioid_LA_Tot_Suply',
              'tot_benes_opioid_la' = 'Opioid_LA_Tot_Benes',
              'rx_rate_opioid_la' = 'Opioid_LA_Prscrbr_Rate',
              'tot_claims_antibioc' = 'Antbtc_Tot_Clms',
              'tot_cost_antibioc' = 'Antbtc_Tot_Drug_Cst',
              'tot_benes_antibioc' = 'Antbtc_Tot_Benes',
              'suppress_antipsych_ge65' = 'Antpsyct_GE65_Sprsn_Flag',
              'tot_claims_antipsych_ge65' = 'Antpsyct_GE65_Tot_Clms',
              'tot_cost_antipsych_ge65' = 'Antpsyct_GE65_Tot_Drug_Cst',
              'suppress_bene_antipsych_ge65' = 'Antpsyct_GE65_Bene_Suprsn_Flag',
              'tot_benes_antipsych_ge65' = 'Antpsyct_GE65_Tot_Benes',
              'bene_age_avg' = 'Bene_Avg_Age',
              'bene_age_lt65' = 'Bene_Age_LT_65_Cnt',
              'bene_age_65_74' = 'Bene_Age_65_74_Cnt',
              'bene_age_75_84' = 'Bene_Age_75_84_Cnt',
              'bene_age_gt84' = 'Bene_Age_GT_84_Cnt',
              'bene_gen_female' = 'Bene_Feml_Cnt',
              'bene_gen_male' = 'Bene_Male_Cnt',
              'bene_race_wht' = 'Bene_Race_Wht_Cnt',
              'bene_race_blk' = 'Bene_Race_Black_Cnt',
              'bene_race_api'  = 'Bene_Race_Api_Cnt',
              'bene_race_hisp' = 'Bene_Race_Hspnc_Cnt',
              'bene_race_nat' = 'Bene_Race_Natind_Cnt',
              'bene_race_oth' = 'Bene_Race_Othr_Cnt',
              'bene_dual' = 'Bene_Dual_Cnt',
              'bene_ndual' = 'Bene_Ndual_Cnt',
              'hcc_risk_avg' = 'Bene_Avg_Risk_Scre')
  }

  if (type == 'Drug') {
    cols <- c(
      'year',
      'npi' = 'Prscrbr_NPI',
      'last' = 'Prscrbr_Last_Org_Name',
      'first' = 'Prscrbr_First_Name',
      'city' = 'Prscrbr_City',
      'state' = 'Prscrbr_State_Abrvtn',
      'fips' = 'Prscrbr_State_FIPS',
      'specialty' = 'Prscrbr_Type',
      'source' = 'Prscrbr_Type_Src',
      'brand_name' = 'Brnd_Name',
      'generic_name' = 'Gnrc_Name',
      'tot_claims' = 'Tot_Clms',
      'tot_fills' = 'Tot_30day_Fills',
      'tot_supply' = 'Tot_Day_Suply',
      'tot_cost' = 'Tot_Drug_Cst',
      'tot_benes' = 'Tot_Benes',
      'tot_claims_ge65' = 'GE65_Tot_Clms',
      'tot_fills_ge65' = 'GE65_Tot_30day_Fills',
      'tot_cost_ge65' = 'GE65_Tot_Drug_Cst',
      'tot_supply_ge65' = 'GE65_Tot_Day_Suply',
      'tot_benes_ge65' = 'GE65_Tot_Benes',
      'suppress_ge65' = 'GE65_Sprsn_Flag',
      'suppress_bene_ge65' = 'GE65_Bene_Sprsn_Flag'
    )
  }

  if (type == 'Geography') {
    cols <- c(
      'year',
      'level' = 'Prscrbr_Geo_Lvl',
      'state' = 'Prscrbr_Geo_Desc',
      'fips' = 'Prscrbr_Geo_Cd',
      'brand_name' = 'Brnd_Name',
      'generic_name' = 'Gnrc_Name',
      'tot_prescribers' = 'Tot_Prscrbrs',
      'tot_claims' = 'Tot_Clms',
      'tot_fills' = 'Tot_30day_Fills',
      'tot_cost' = 'Tot_Drug_Cst',
      'tot_benes' = 'Tot_Benes',
      'tot_claims_ge65' = 'GE65_Tot_Clms',
      'tot_fills_ge65' = 'GE65_Tot_30day_Fills',
      'tot_cost_ge65' = 'GE65_Tot_Drug_Cst',
      'tot_benes_ge65' = 'GE65_Tot_Benes',
      'suppress_ge65' = 'GE65_Sprsn_Flag',
      'suppress_bene_ge65' = 'GE65_Bene_Sprsn_Flag',
      'tot_cost_lis' = 'LIS_Bene_Cst_Shr',
      'tot_cost_nlis' = 'NonLIS_Bene_Cst_Shr',
      'opioid' = 'Opioid_Drug_Flag',
      'opioid_la' = 'Opioid_LA_Drug_Flag',
      'antibiotic' = 'Antbtc_Drug_Flag',
      'antipsychotic' = 'Antpsyct_Drug_Flag'
    )
  }

  df |> dplyr::select(dplyr::any_of(cols))
}

#' @param x vector
#' @autoglobal
#' @noRd
suppress_flag <- function(x) {
  dplyr::case_match(x, c("*", "#") ~ TRUE, .default = NA)
}
