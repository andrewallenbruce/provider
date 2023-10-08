#' Utilization Statistics for Medicare Part B Providers
#'
#' @description
#' These functions allow the user access to information on services and
#' procedures provided to Original Medicare (fee-for-service) Part B
#' beneficiaries by physicians and other healthcare professionals; aggregated
#' by provider, service and geography.
#'
#' @section `by_provider()`:
#'
#' The **Provider** dataset allows the user access to data such as
#' services and procedures performed; charges submitted and payment received;
#' and beneficiary demographic and health characteristics for providers
#' treating Original Medicare (fee-for-service) Part B beneficiaries,
#' aggregated by year.
#'
#' @section `by_service()`:
#'
#' The **Provider and Service** dataset is aggregated by:
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
#' @section `by_geography()`:
#'
#' The **Geography and Service** dataset contains information on utilization,
#' allowed amount, Medicare payment, and submitted charges organized nationally
#' and state-wide by HCPCS code and place of service.
#'
#' @section Rural-Urban Commuting Area Codes (RUCA):
#'
#' + **Metro Area Core**
#'   + `"1"`: Primary flow within Urbanized Area (UA)
#'   + `"1.1"`: Secondary flow 30-50% to larger UA
#' + **Metro Area High Commuting**
#'   + `"2"`: Primary flow 30% or more to UA
#'   + `"2.1"`: Secondary flow 30-50% to larger UA
#' + **Metro Area Low Commuting**
#'   + `"3"`: Primary flow 10-30% to UA
#' + **Micro Area Core**
#'   + `"4"`: Primary flow within large Urban Cluster (10k - 49k)
#'   + `"4.1"`: Secondary flow 30-50% to UA
#' + **Micro High Commuting**
#'   + `"5"`: Primary flow 30% or more to large UC
#'   + `"5.1"`: Secondary flow 30-50% to UA
#' + **Micro Low Commuting**
#'   + `"6"`: Primary flow 10-30% to large UC
#' + **Small Town Core**
#'   + `"7"`: Primary flow within small UC (2.5k - 9.9k)
#'   + `"7.1"`: Secondary flow 30-50% to UA
#'   + `"7.2"`: Secondary flow 30-50% to large UC
#' + **Small Town High Commuting**
#'   + `"8"`: Primary flow 30% or more to small UC
#'   + `"8.1"`: Secondary flow 30-50% to UA
#'   + `"8.2"`: Secondary flow 30-50% to large UC
#' + **Small Town Low Commuting**
#'   + `"9"`: Primary flow 10-30% to small UC
#' + **Rural Areas**
#'   + `"10"`: Primary flow to tract outside a UA or UC
#'   + `"10.1"`: Secondary flow 30-50% to UA
#'   + `"10.2"`: Secondary flow 30-50% to large UC
#'   + `"10.3"`: Secondary flow 30-50% to small UC
#' + `"99"`: Zero population and no rural-urban identifier information
#'
#' @section Links:
#'
#'   - [Medicare Physician & Other Practitioners: by Provider API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)
#'   - [Medicare Physician & Other Practitioners: by Provider and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
#'   - [Medicare Physician & Other Practitioners: by Geography and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service)
#'
#' *Update Frequency:* **Annually**
#'
#' @examplesIf interactive()
#' by_provider(year = 2020, npi = 1003000423)
#'
#' by_service(year = 2019, npi = 1003000126)
#'
#' by_geography(year = 2020, hcpcs_code = "0002A")
#'
#' # Use the years helper function to retrieve results for every year:
#' prac_years() |>
#' map(\(x) by_provider(year = x, npi = 1043477615)) |>
#' list_rbind()
#'
#' @returns
#' `by_provider()` returns a [tibble][tibble::tibble-package] with the columns:
#' |**Field**        |**Description**                                                                                         |
#' |:----------------|:-------------------------------------------------------------------------------------------------------|
#' |`year`           |Year data was reported                                                                                  |
#' |`npi`            |10-digit national provider identifier                                                                   |
#' |`entity_type`    |Provider's entity/enumeration type                                                                      |
#' |`first`          |Individual provider's first name                                                                        |
#' |`middle`         |Individual provider's middle name                                                                       |
#' |`last`           |Individual provider's last name/Organization's name                                                     |
#' |`gender`         |Individual provider's gender                                                                            |
#' |`credential`     |Individual provider's credential                                                                        |
#' |`specialty`      |Provider's specialty                                                                                    |
#' |`address`        |Provider's street address                                                                               |
#' |`city`           |Provider's city                                                                                         |
#' |`state`          |Provider's state                                                                                        |
#' |`zip`            |Provider's zip code                                                                                     |
#' |`fips`           |Provider's state's FIPS code                                                                            |
#' |`ruca`           |Provider's RUCA code                                                                                    |
#' |`country`        |Provider's country                                                                                      |
#' |`par`            |Indicates if provider participates in and/or accepts Medicare assignment                                |
#' |`tot_hcpcs`      |Total number of *unique* HCPCS codes submitted                                                          |
#' |`tot_benes`      |Total Medicare beneficiaries receiving services from the provider                                       |
#' |`tot_srvcs`      |Total services provided to beneficiaries by the provider                                                |
#' |`tot_charges`    |Total charges that the provider submitted for all services                                              |
#' |`tot_allowed`    |Total allowed amount for all services; the sum of Medicare reimbursement, deductible, coinsurance, etc. |
#' |`tot_payment`    |Total amount Medicare paid, less any deductible and coinsurance                                         |
#' |`tot_std_pymt`   |Total amount Medicare paid, standardized to account for geographic differences                          |
#' |`hcc_risk_avg`   |Average Hierarchical Condition Category (HCC) risk score of beneficiaries                               |
#' |`hcpcs_detailed` |Nested list columns `drug` & `medical`, offering further detail about the HCPCS codes submitted         |
#' |`demographics`   |Nested list column containing demographic data about the beneficiaries seen by the provider             |
#' |`conditions`     |Nested list column containing data about beneficiaries' chronic conditions                              |
#'
#' `by_service()` returns a [tibble][tibble::tibble-package] with the columns:
#' |**Field**        |**Description**                                                                                  |
#' |:----------------|:------------------------------------------------------------------------------------------------|
#' |`year`           |Year data was reported                                                                           |
#' |`npi`            |10-digit national provider identifier                                                            |
#' |`level`          |Data aggregation level, will always be "Provider" here                                           |
#' |`entity_type`    |Provider's entity/enumeration type                                                               |
#' |`first`          |Individual provider's first name                                                                 |
#' |`middle`         |Individual provider's middle name                                                                |
#' |`last`           |Individual provider's last name/Organization's name                                              |
#' |`gender`         |Individual provider's gender                                                                     |
#' |`credential`     |Individual provider's credential                                                                 |
#' |`specialty`      |Provider's specialty                                                                             |
#' |`address`        |Provider's street address                                                                        |
#' |`city`           |Provider's city                                                                                  |
#' |`state`          |Provider's state                                                                                 |
#' |`zip`            |Provider's zip code                                                                              |
#' |`fips`           |Provider's state's FIPS code                                                                     |
#' |`ruca`           |Provider's RUCA code                                                                             |
#' |`country`        |Provider's country                                                                               |
#' |`par`            |Indicates if the provider participates in and/or accepts Medicare assignment                     |
#' |`hcpcs_code`     |HCPCS code used to identify the specific medical service furnished by the provider               |
#' |`hcpcs_desc`     |Consumer Friendly Description of the HCPCS code                                                  |
#' |`category`       |Restructured BETOS Classification System Category                                                |
#' |`subcategory`    |Restructured BETOS Classification System Subcategory                                             |
#' |`family`         |Restructured BETOS Classification System Family                                                  |
#' |`procedure`      |Restructured BETOS Classification System Major Procedure Indicator                               |
#' |`drug`           |Indicates if the HCPCS code is listed in the Medicare Part B Drug Average Sales Price (ASP) File |
#' |`pos`            |Identifies the Place of Service (POS) submitted on the claim                                     |
#' |`tot_benes`      |Distinct number of Medicare beneficiaries for each HCPCS code/POS combination                    |
#' |`tot_srvcs`      |Number of services provided for each HCPCS code/POS combination                                  |
#' |`tot_day`        |Number of distinct Medicare beneficiary/per day services for each HCPCS code/POS combination     |
#' |`avg_charge`     |Average charge that the provider submitted for the service                                       |
#' |`avg_allowed`    |Average of the Medicare allowed amount for the service                                           |
#' |`avg_payment`    |Average amount Medicare paid, less any deductible and coinsurance                                |
#' |`avg_std_pymt`   |Average amount Medicare paid, standardized to account for geographic differences                 |
#'
#' `by_geography()` returns a [tibble][tibble::tibble-package] with the columns:
#' |**Field**        |**Description**                                                                                  |
#' |:----------------|:------------------------------------------------------------------------------------------------|
#' |`year`           |Year data was reported                                                                           |
#' |`level`          |Data aggregation level, either "National" or "State"                                             |
#' |`state`          |Provider's state                                                                                 |
#' |`fips`           |Provider's state's FIPS code                                                                     |
#' |`hcpcs_code`     |HCPCS code used to identify the specific medical service furnished                               |
#' |`hcpcs_desc`     |Consumer Friendly Description of the HCPCS code                                                  |
#' |`category`       |Restructured BETOS Classification System Category                                                |
#' |`subcategory`    |Restructured BETOS Classification System Subcategory                                             |
#' |`family`         |Restructured BETOS Classification System Family                                                  |
#' |`procedure`      |Restructured BETOS Classification System Major Procedure Indicator                               |
#' |`drug`           |Indicates if the HCPCS code is listed in the Medicare Part B Drug Average Sales Price (ASP) File |
#' |`pos`            |Identifies the Place of Service (POS) submitted on the claim                                     |
#' |`tot_provs`      |Number of providers that submitted each HCPCS code/POS combination                               |
#' |`tot_benes`      |Distinct number of Medicare beneficiaries for each HCPCS code/POS combination                    |
#' |`tot_srvcs`      |Number of services provided for each HCPCS code/POS combination                                  |
#' |`tot_day`        |Number of distinct Medicare beneficiary/per day services for each HCPCS code/POS combination     |
#' |`avg_charge`     |Average charge submitted for the service                                                         |
#' |`avg_allowed`    |Average of the Medicare allowed amount for the service                                           |
#' |`avg_payment`    |Average amount Medicare paid, less any deductible and coinsurance                                |
#' |`avg_std_pymt`   |Average amount Medicare paid, standardized to account for geographic differences                 |
#'
#' @name utilization
NULL

#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run helper function `prac_years()` to return a vector of the years
#' currently available.
#' @param npi < *integer* > 10-digit national provider identifier
#' @param first,last,organization < *character* > Individual/Organizational
#' provider's name
#' @param credential < *character* > Individual provider's credentials
#' @param gender < *character* > Individual provider's gender; `"F"` (Female),
#' `"M"` (Male)
#' @param entype < *character* > Provider entity type; `"I"` (Individual),
#' `"O"` (Organization)
#' @param city < *character* > City where provider is located
#' @param state < *character* > State where provider is located
#' @param fips < *character* > Provider's state's FIPS code
#' @param zip < *character* > Provider’s zip code
#' @param ruca < *character* > Provider’s RUCA code
#' @param country < *character* > Country where provider is located
#' @param specialty < *character* > Provider specialty code reported on the
#' largest number of claims submitted
#' @param par < *boolean* > Identifies whether the provider participates in
#' Medicare and/or accepts assignment of Medicare allowed amounts
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param nest < *boolean* > // __default:__ `TRUE` Nest `hcpcs_detailed`,
#' `demographics` and `conditions` columns
#' @rdname utilization
#' @autoglobal
#' @export
by_provider <- function(year,
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
                        par = NULL,
                        tidy = TRUE,
                        nest = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  year <- rlang::arg_match(year, as.character(prac_years()))

  if (!is.null(npi))  {npi  <- npi_check(npi)}
  if (!is.null(zip))  {zip  <- as.character(zip)}
  if (!is.null(fips)) {fips <- as.character(fips)}
  if (!is.null(ruca)) {ruca <- as.character(ruca)}
  if (!is.null(par))  {par  <- tf_2_yn(par)}

  id <- api_years("prv") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

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
    "Rndrng_Prvdr_State_Abrvtn",      state,
    "Rndrng_Prvdr_State_FIPS",        fips,
    "Rndrng_Prvdr_Zip5",              zip,
    "Rndrng_Prvdr_RUCA",              ruca,
    "Rndrng_Prvdr_Cntry",             country,
    "Rndrng_Prvdr_Type",              specialty,
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

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(year = as.integer(year),
                    rndrng_prvdr_crdntls = clean_credentials(rndrng_prvdr_crdntls),
                    rndrng_prvdr_mdcr_prtcptg_ind = yn_logical(rndrng_prvdr_mdcr_prtcptg_ind),
                    rndrng_prvdr_ent_cd = entype_char(rndrng_prvdr_ent_cd),
                    dplyr::across(dplyr::ends_with(c("_hcpcs_cds", "_benes", "_srvcs", "_cnt")), as.integer),
                    dplyr::across(dplyr::ends_with(c("amt", "chrg", "pct")), as.double)) |>
      tidyr::unite("address",
                   dplyr::any_of(c("rndrng_prvdr_st1", "rndrng_prvdr_st2")),
                   remove = TRUE,
                   na.rm = TRUE,
                   sep = " ") |>
      prov_cols()

    if (nest) {
      results <- results |>
        tidyr::nest(medical = dplyr::starts_with("med_"),
                    drug = dplyr::starts_with("drug_"),
                    demographics = dplyr::starts_with("bene_"),
                    conditions = dplyr::starts_with("cc_")) |>
        tidyr::nest(hcpcs_detailed = c(medical, drug))
        }

  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
prov_cols <- function(df) {

  cols <- c("year",
            "npi"            = "rndrng_npi",
            "entity_type"    = "rndrng_prvdr_ent_cd",
            "first"          = "rndrng_prvdr_first_name",
            "middle"         = "rndrng_prvdr_mi",
            "last"           = "rndrng_prvdr_last_org_name",
            "gender"         = "rndrng_prvdr_gndr",
            "credential"     = "rndrng_prvdr_crdntls",
            "specialty"      = "rndrng_prvdr_type",
            "address",
            "city"           = "rndrng_prvdr_city",
            "state"          = "rndrng_prvdr_state_abrvtn",
            "zip"            = "rndrng_prvdr_zip5",
            "fips"           = "rndrng_prvdr_state_fips",
            "ruca"           = "rndrng_prvdr_ruca",
            # "ruca_desc"    = "rndrng_prvdr_ruca_desc",
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
            "bene_female"    = "bene_feml_cnt",
            "bene_male"      = "bene_male_cnt",
            "bene_race_wht"  = "bene_race_wht_cnt",
            "bene_race_blk"  = "bene_race_black_cnt",
            "bene_race_api"  = "bene_race_api_cnt",
            "bene_race_span" = "bene_race_hspnc_cnt",
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

  df |> dplyr::select(dplyr::all_of(cols))

}

#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run helper function `prac_years()` to return a vector of the years
#' currently available.
#' @param npi < *integer* > 10-digit national provider identifier
#' @param first,last,organization < *character* > Individual/Organizational
#' provider's name
#' @param credential < *character* > Individual provider's credentials
#' @param gender < *character* > Individual provider's gender; `"F"` (Female),
#' `"M"` (Male)
#' @param entype < *character* > Provider entity type; `"I"` (Individual),
#' `"O"` (Organization)
#' @param city < *character* > City where provider is located
#' @param state < *character* > State where provider is located
#' @param fips < *character* > Provider's state FIPS code
#' @param zip < *character* > Provider’s zip code
#' @param ruca < *character* > Provider’s RUCA code
#' @param country < *character* > Country where provider is located
#' @param specialty < *character* > Provider specialty code reported on the
#' largest number of claims submitted
#' @param par < *boolean* > Identifies whether the provider participates in
#' Medicare and/or accepts assignment of Medicare allowed amounts
#' @param hcpcs_code < *character* > HCPCS code used to identify the specific
#' medical service furnished by the provider
#' @param drug < *boolean* > Identifies whether the HCPCS code is listed in the
#' Medicare Part B Drug Average Sales Price (ASP) File
#' @param pos < *character* > Identifies whether the Place of Service (POS)
#' submitted on the claims is a:
#'    + Facility (`"F"`): Hospital, Skilled Nursing Facility, etc.
#'    + Non-facility (`"O"`): Office, Home, etc.
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param rbcs < *boolean* > // __default:__ `TRUE` Add Restructured BETOS
#' Classifications to HCPCS codes
#' @rdname utilization
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
                       tidy = TRUE,
                       rbcs = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, as.character(prac_years()))

  if (!is.null(npi))        {npi        <- npi_check(npi)}
  if (!is.null(hcpcs_code)) {hcpcs_code <- as.character(hcpcs_code)}
  if (!is.null(pos))        {pos        <- pos_char(pos)}
  if (!is.null(zip))        {zip        <- as.character(zip)}
  if (!is.null(fips))       {fips       <- as.character(fips)}
  if (!is.null(ruca))       {ruca       <- as.character(ruca)}
  if (!is.null(par))        {par        <- tf_2_yn(par)}
  if (!is.null(drug))       {drug       <- tf_2_yn(drug)}

  id <- api_years("srv") |>
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

    if (rbcs) {
      rbcs <- results |>
        dplyr::distinct(hcpcs_code) |>
        dplyr::pull(hcpcs_code) |>
        purrr::map(\(x) betos(hcpcs_code = x)) |>
        purrr::list_rbind()

      if (isTRUE(vctrs::vec_is_empty(rbcs))) {

        results

      } else {

        rbcs <- dplyr::select(rbcs,
                              hcpcs_code,
                              category,
                              subcategory,
                              family,
                              procedure)

        results <- dplyr::full_join(results, rbcs,
                   by = dplyr::join_by(hcpcs_code)) |>
          serv_cols2()
      }
    }
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
            'entity_type' = 'rndrng_prvdr_ent_cd',
            'first' = 'rndrng_prvdr_first_name',
            'middle' = 'rndrng_prvdr_mi',
            'last' = 'rndrng_prvdr_last_org_name',
            'gender' = 'rndrng_prvdr_gndr',
            'credential' = 'rndrng_prvdr_crdntls',
            'specialty' = 'rndrng_prvdr_type',
            'address',
            'city' = 'rndrng_prvdr_city',
            'state' = 'rndrng_prvdr_state_abrvtn',
            'zip' = 'rndrng_prvdr_zip5',
            'fips' = 'rndrng_prvdr_state_fips',
            'ruca' = 'rndrng_prvdr_ruca',
            # 'ruca_desc' = 'rndrng_prvdr_ruca_desc',
            'country' = 'rndrng_prvdr_cntry',
            'par' = 'rndrng_prvdr_mdcr_prtcptg_ind',
            'hcpcs_code' = 'hcpcs_cd',
            'hcpcs_desc',
            'category',
            'subcategory',
            'family',
            'procedure',
            'drug' = 'hcpcs_drug_ind',
            'pos' = 'place_of_srvc',
            'tot_benes',
            'tot_srvcs',
            'tot_day' = 'tot_bene_day_srvcs',
            'avg_charge' = 'avg_sbmtd_chrg',
            'avg_allowed' = 'avg_mdcr_alowd_amt',
            'avg_payment' = 'avg_mdcr_pymt_amt',
            'avg_std_pymt' = 'avg_mdcr_stdzd_amt')

  df |> dplyr::select(dplyr::any_of(cols))

}

#' @param df data frame
#' @autoglobal
#' @noRd
serv_cols2 <- function(df) {

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
            # 'ruca_desc',
            'country',
            'par',
            'hcpcs_code',
            'hcpcs_desc',
            'category',
            'subcategory',
            'family',
            'procedure',
            'drug',
            'pos',
            'tot_benes',
            'tot_srvcs',
            'tot_day',
            'avg_charge',
            'avg_allowed',
            'avg_payment',
            'avg_std_pymt')

  df |> dplyr::select(dplyr::any_of(cols))

}

#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run helper function `prac_years()` to return a vector of the years
#' currently available.
#' @param level < *character* > Geographic level by which the data will be
#' aggregated:
#'    + `"State"`: Data is aggregated for each state
#'    + `National`: Data is aggregated across all states for a given HCPCS Code
#' @param state < *character* > State where provider is located
#' @param fips < *character* > Provider's state FIPS code
#' @param hcpcs_code < *character* > HCPCS code used to identify the specific
#' medical service furnished by the provider
#' @param drug < *boolean* > Identifies whether the HCPCS code is listed in the
#' Medicare Part B Drug Average Sales Price (ASP) File
#' @param pos < *character* > Identifies whether the Place of Service (POS)
#' submitted on the claims is a:
#'    + Facility (`"F"`): Hospital, Skilled Nursing Facility, etc.
#'    + Non-facility (`"O"`): Office, Home, etc.
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param rbcs < *boolean* > // __default:__ `TRUE` Add Restructured BETOS
#' Classifications to HCPCS codes
#' @rdname utilization
#' @autoglobal
#' @export
by_geography <- function(year,
                         state = NULL,
                         hcpcs_code = NULL,
                         pos = NULL,
                         level = NULL,
                         fips = NULL,
                         drug = NULL,
                         tidy = TRUE,
                         rbcs = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, as.character(prac_years()))

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

  id <- api_years("geo") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  args <- dplyr::tribble(
    ~param,                  ~arg,
    "Rndrng_Prvdr_Geo_Lvl",  level,
    "Rndrng_Prvdr_Geo_Desc", state,
    "Rndrng_Prvdr_Geo_Cd",   fips,
    "HCPCS_Cd",              hcpcs_code,
    "HCPCS_Drug_Ind",        drug,
    "Place_Of_Srvc",         pos)


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

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(year = as.integer(year),
                    hcpcs_drug_ind = yn_logical(hcpcs_drug_ind),
                    place_of_srvc  = pos_char(place_of_srvc),
                    dplyr::across(dplyr::starts_with("tot_"), as.integer),
                    dplyr::across(dplyr::starts_with("avg_"), as.double)) |>
      geo_cols()

    if (rbcs) {
      rbcs <- results |>
        dplyr::distinct(hcpcs_code) |>
        dplyr::pull(hcpcs_code) |>
        purrr::map(\(x) betos(hcpcs_code = x)) |>
        purrr::list_rbind()

      if (isTRUE(vctrs::vec_is_empty(rbcs))) {

        results

      } else {

        rbcs <- dplyr::select(rbcs,
                              hcpcs_code,
                              category,
                              subcategory,
                              family,
                              procedure)

        results <- dplyr::full_join(results, rbcs,
                   by = dplyr::join_by(hcpcs_code)) |>
          geo_cols2()
      }
    }
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
geo_cols <- function(df) {

  cols <- c("year",
            "level"        = "rndrng_prvdr_geo_lvl",
            "state"        = "rndrng_prvdr_geo_desc",
            "fips"         = "rndrng_prvdr_geo_cd",
            "hcpcs_code"   = "hcpcs_cd",
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

  df |> dplyr::select(dplyr::any_of(cols))

}

#' @param df data frame
#' @autoglobal
#' @noRd
geo_cols2 <- function(df) {

  cols <- c("year",
            "level",
            "state",
            "fips",
            "hcpcs_code",
            "hcpcs_desc",
            'category',
            'subcategory',
            'family',
            'procedure',
            "drug",
            "pos",
            "tot_provs",
            "tot_benes",
            "tot_srvcs",
            "tot_day",
            "avg_charge",
            "avg_allowed",
            "avg_payment",
            "avg_std_pymt")

  df |> dplyr::select(dplyr::any_of(cols))

}
