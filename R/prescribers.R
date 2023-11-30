#' Prescriber Utilization & Demographics by Year
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [prescribers()] allows access to information on prescription drugs provided
#' to Medicare beneficiaries enrolled in Part D (Prescription Drug Coverage),
#' by physicians and other health care providers; aggregated by provider, drug
#' and geography.
#'
#' @section By Provider:
#' __type =__`"provider"`:
#'
#' The **Provider** dataset allows the user access to data such as
#' services and procedures performed; charges submitted and payment received;
#' and beneficiary demographic and health characteristics for providers
#' treating Original Medicare (fee-for-service) Part B beneficiaries,
#' aggregated by year.
#'
#' @section By Provider and Drug:
#' __type =__`"service"`:
#'
#' The **Provider and Drug** dataset is aggregated by:
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
#' @section By Geography and Drug:
#' __type =__`"geography"`:
#'
#' The **Geography and Drug** dataset contains information on utilization,
#' allowed amount, Medicare payment, and submitted charges organized nationally
#' and state-wide by HCPCS code and place of service.
#'
#' @section Links:
#' + [Medicare Part D Prescribers: by Provider](https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-provider)
#' + [Medicare Part D Prescribers: by Provider and Drug](https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-provider-and-drug)
#' + [Medicare Part D Prescribers: by Geography and Drug](https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-geography-and-drug)
#'
#' *Update Frequency:* **Annually**
#'
#' @examplesIf interactive()
#' prescribers(year = 2020, type = 'provider', npi = 1003000423)
#' prescribers(year = 2021, type = 'provider', npi = 1003000126)
#' prescribers(year = 2019, type = 'drug', npi = 1003000126)
#'
#' # Use the years helper function to retrieve results for every year:
#' rx_years() |>
#' map(\(x) prescribers(year = x, type = 'provider', npi = 1043477615)) |>
#' list_rbind()
#'
#' # Parallelized version
#' prescribers_(type = 'provider', npi = 1043477615)
#' prescribers_(type = 'drug', npi = 1003000423)
#'
#' @name prescribers
NULL

#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run [rx_years()] to return a vector of the years currently available.
#' @param type < *character* > // **required** dataset to query, `"provider"`, `"drug"`, `"geography"`
#' @param npi < *integer* > 10-digit national provider identifier
#' @param first,last,organization < *character* > Individual/Organizational
#' prescriber's name
#' @param credential < *character* > Individual prescriber's credentials
#' @param gender < *character* > Individual prescriber's gender; `"F"` (Female),
#' `"M"` (Male)
#' @param entype < *character* > Prescriber entity type; `"I"` (Individual),
#' `"O"` (Organization)
#' @param city < *character* > City where prescriber is located
#' @param state < *character* > State where prescriber is located
#' @param fips < *character* > Prescriber's state's FIPS code
#' @param zip < *character* > Prescriber’s zip code
#' @param ruca < *character* > Prescriber’s RUCA code
#' @param country < *character* > Country where prescriber is located
#' @param specialty < *character* > Prescriber specialty code reported on the
#' largest number of claims submitted
#' @param brand < *character* > Brand name (trademarked name) of the drug filled
#' @param generic < *character* > USAN generic name of the drug filled (short
#' version); A term referring to the chemical ingredient of a drug rather than
#' the trademarked brand name under which the drug is sold
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#' @param ... For future use.
#' @rdname prescribers
#' @autoglobal
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
                        brand = NULL,
                        generic = NULL,
                        tidy = TRUE,
                        na.rm = TRUE,
                        ...) {

  rlang::check_required(year)
  year <- as.character(year)
  year <- rlang::arg_match(year, as.character(rx_years()))

  npi  <- npi %nn% validate_npi(npi)
  zip   <- zip %nn% as.character(zip)
  fips  <- fips %nn% as.character(fips)
  ruca  <- ruca %nn% as.character(ruca)

  type <- rlang::arg_match(type, c('provider', 'drug', 'geography'))

  if (type == 'provider') {
    param_npi <- 'PRSCRBR_NPI'
    brand     <- NULL
    generic   <- NULL
  }

  if (type == 'drug') {
    param_npi  <- 'Prscrbr_NPI'
    credential <- NULL
    gender     <- NULL
    entype     <- NULL
    fips       <- NULL
    zip        <- NULL
    ruca       <- NULL
    country    <- NULL
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
    'Prscrbr_State_Abrvtn',  state,
    'Prscrbr_State_FIPS',    fips,
    'Prscrbr_zip5',          zip,
    'Prscrbr_RUCA',          ruca,
    'Prscrbr_Cntry',         country,
    'Prscrbr_Type',          specialty,
    'Brnd_Name',             brand,
    'Gnrc_Name',             generic)

  yr <- switch(type,
               "provider"  = api_years("rxp"),
               "drug"      = api_years("rxd"),
               "geography" = api_years("rxg"))

  id <- dplyr::filter(yr, year == {{ year }}) |> dplyr::pull(distro)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      'year',         year,
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
      'brand',        brand,
      'generic',      generic) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (!tidy) results <- df2chr(results)

  if (tidy) {

    results$year <- year

    results <- switch(type,
            'provider' = tidyup_provider.rx(results),
            'drug' = tidyup_drug.rx(results))

    if (na.rm) results <- narm(results)

  }
  return(results)
}

#' @param results data frame from [prescribers(type = "drug")]
#' @autoglobal
#' @noRd
tidyup_drug.rx <- function(results) {

  results <- cols_rx(results, 'drug') |>
    tidyup(int  = c('year',
                    'tot_claims',
                    'tot_supply',
                    'tot_benes'),
           dbl  = c('tot_fills',
                    'tot_cost')) |>
    dplyr::mutate(level = "Provider",
                  source = fct_src(source),
                  state = fct_stabb(state),
                  level = fct_level(level))

  results <- dplyr::mutate(results,
                           dplyr::across(
                             dplyr::contains('suppress_'),
                             suppress_flag))

  return(results)
}

#' @param results data frame from [prescribers(type = "provider")]
#' @autoglobal
#' @noRd
tidyup_provider.rx <- function(results) {

  results <- cols_rx(results, 'provider') |>
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
           cred = "credential",
           zip  = 'zip') |>
    combine(address, c('prscrbr_st1', 'prscrbr_st2')) |>
    dplyr::mutate(source = fct_src(source),
                  entity_type = fct_ent(entity_type),
                  gender = fct_gen(gender),
                  state = fct_stabb(state)) |>
    dplyr::mutate(bene_race_nonwht = tot_benes - bene_race_wht,
                  .after = bene_race_wht)

  results <- dplyr::mutate(results,
                           dplyr::across(
                             dplyr::contains('suppress_'),
                             suppress_flag))
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
  furrr::future_map_dfr(year, prescribers, ...,
                        .options = furrr::furrr_options(seed = NULL))

}

#' Convert specialty source to unordered labelled factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_src <- function(x) {
  factor(x,
         levels = c("S", "T"),
         labels = c("Medicare Specialty Code", "Taxonomy Code Classification"))
}

#' @param df data frame
#' @param type 'provider', 'drug', 'geography'
#' @autoglobal
#' @noRd
cols_rx <- function(df, type) {

  if (type == "provider") {
    cols <- c('year',
              'npi' = 'PRSCRBR_NPI',
              'entity_type' = 'Prscrbr_Ent_Cd',
              'first' = 'Prscrbr_First_Name',
              'middle' = 'Prscrbr_MI',
              'last' = 'Prscrbr_Last_Org_Name',
              'gender' = 'Prscrbr_Gndr',
              'credential' = 'Prscrbr_Crdntls',
              'specialty' = 'Prscrbr_Type',
              'source' = 'Prscrbr_Type_src',
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

  if (type == 'drug') {
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

  df |> dplyr::select(dplyr::any_of(cols))
}

#' @param x vector
#' @autoglobal
#' @noRd
suppress_flag <- function(x) {
  dplyr::case_match(x, c("*", "#") ~ TRUE, .default = NA)
}
