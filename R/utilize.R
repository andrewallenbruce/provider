#' Provider Utilization & Demographics
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' These functions allow the user access to information on services and
#' procedures provided to Original Medicare (fee-for-service) Part B
#' beneficiaries by physicians and other healthcare professionals; aggregated
#' by provider, service and geography.
#'
#' @section `"provider"`:
#'
#' The **Provider** dataset allows the user access to data such as
#' services and procedures performed; charges submitted and payment received;
#' and beneficiary demographic and health characteristics for providers
#' treating Original Medicare (fee-for-service) Part B beneficiaries,
#' aggregated by year.
#'
#' @section `"services"`:
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
#' @section `"geography"`:
#'
#' The **Geography and Service** dataset contains information on utilization,
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
#' utilization(year = 2020, type = "provider", npi = 1003000423)
#'
#' utilization(year = 2019, type = "services", npi = 1003000126)
#'
#' utilization(year = 2020, type = "geography", hcpcs_code = "0002A")
#'
#' # Use the years helper function to retrieve results for every year:
#' pop_years() |>
#' map(\(x) utilization(year = x, type = "provider", npi = 1043477615)) |>
#' list_rbind()
#'
#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run [pop_years()] to return a vector of the years currently available.
#' @param type < *character* > // **required** dataset to query, `"provider"`, `"service"`, `"geography"`
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
#' @param hcpcs_code < *character* > HCPCS code used to identify the specific
#' medical service furnished by the provider
#' @param drug < *boolean* > Identifies whether the HCPCS code is listed in the
#' Medicare Part B Drug Average Sales Price (ASP) File
#' @param pos < *character* > Identifies whether the Place of Service (POS)
#' submitted on the claims is a:
#'    + Facility (`"F"`): Hospital, Skilled Nursing Facility, etc.
#'    + Non-facility (`"O"`): Office, Home, etc.
#' @param level < *character* > Geographic level by which the data will be
#' aggregated:
#' + `"State"`: Data is aggregated for each state
#' + `National`: Data is aggregated across all states for a given HCPCS Code
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param rbcs < *boolean* > // __default:__ `TRUE` Add Restructured BETOS
#' Classifications to HCPCS codes
#' @param nest < *boolean* > // __default:__ `TRUE` Nest `demographics` and `conditions`
#' @param detailed < *boolean* > // __default:__ `FALSE` Include `detailed` column
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#' @autoglobal
#' @export
utilization <- function(year,
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
                        par = NULL,
                        level = NULL,
                        hcpcs_code = NULL,
                        drug = NULL,
                        pos = NULL,
                        tidy = TRUE,
                        nest = TRUE,
                        detailed = FALSE,
                        rbcs = TRUE,
                        na.rm = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  year <- rlang::arg_match(year, as.character(pop_years()))
  type <- rlang::arg_match(type, c("provider", "service", "geography"))

  if (type != "provider") {
    nest       <- FALSE
    detailed   <- FALSE
  }

  if (type == "provider") {
    rbcs       <- FALSE
    hcpcs_code <- NULL
    pos        <- NULL
    drug       <- NULL
  }

  if (type != "geography") level <- NULL

  if (type == "geography") {
    level        <- level %nn% rlang::arg_match(level, c("National", "State"))
    npi          <- NULL
    first        <- NULL
    last         <- NULL
    organization <- NULL
    credential   <- NULL
    gender       <- NULL
    entype       <- NULL
    city         <- NULL
    zip          <- NULL
    ruca         <- NULL
    country      <- NULL
    specialty    <- NULL
    par          <- NULL
    if (!is.null(state) && (state %in% state.abb)) state <- abb2full(state)
  }

  npi        <- npi %nn% check_npi(npi)
  zip        <- zip %nn% as.character(zip)
  fips       <- fips %nn% as.character(fips)
  ruca       <- ruca %nn% as.character(ruca)
  par        <- par %nn% tf_2_yn(par)
  hcpcs_code <- hcpcs_code %nn% as.character(hcpcs_code)
  drug       <- drug %nn% tf_2_yn(drug)

  if (!is.null(pos)) {
    rlang::arg_match(pos, c("F", "O"))
    pos <- pos_char(pos)
  }

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
    "Rndrng_Prvdr_Mdcr_Prtcptg_Ind",  par,
    "HCPCS_Cd",                       hcpcs_code,
    "HCPCS_Drug_Ind",                 drug,
    "Place_Of_Srvc",                  pos,
    "Rndrng_Prvdr_Geo_Lvl",           level,
    "Rndrng_Prvdr_Geo_Desc",          state,
    "Rndrng_Prvdr_Geo_Cd",            fips)

  if (type == "provider")   yr <- api_years("prv")
  if (type == "services")   yr <- api_years("srv")
  if (type == "geography")  yr <- api_years("geo")

  id <- dplyr::filter(yr, year == {{ year }}) |> dplyr::pull(distro)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

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
    results$year <- year
    if (type == "provider")  results <- tidyup.provider(results, nest = nest, detailed = detailed)
    if (type == "services")  results <- tidyup.services(results, rbcs = rbcs)
    if (type == "geography") results <- tidyup.geography(results, rbcs = rbcs)
    if (na.rm)               results <- narm(results)
  }
  return(results)
}

#' @param results data frame from [utilization(type = "provider")]
#' @param nest < *boolean* > Nest `demographics` and `conditions`
#' @param detailed < *boolean* > Include `detailed` column
#' @autoglobal
#' @noRd
tidyup.provider <- function(results, nest, detailed) {

  results <- janitor::clean_names(results) |>
    cols_util("provider") |>
    tidyup(yn = "par",
           int = c("year", "_hcpcs", "bene", "_srvcs"),
           dbl = c("pay", "pymt", "charges", "allowed", "cc_", "hcc"),
           cred = "credential",
           ent = "entity_type",
           yr = 'year') |>
    combine(address, c('rndrng_prvdr_st1', 'rndrng_prvdr_st2')) |>
    dplyr::mutate(specialty = correct_specialty(specialty))

  if (nest) {
    results <- tidyr::nest(
      results,
      demographics   = dplyr::starts_with("bene_"),
      conditions     = dplyr::starts_with("cc_"))
  }
  if (detailed) {
    results <- tidyr::nest(
      results,
      medical = dplyr::starts_with("med_"),
      drug = dplyr::starts_with("drug_")) |>
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

#' @param results data frame from [utilization(type = "services")]
#' @param rbcs < *boolean* > Add Restructured BETOS Classifications to HCPCS codes
#' @autoglobal
#' @noRd
tidyup.services <- function(results, rbcs) {

  results$level <- "Provider"

  results <- tidyup(results,
                    yn = "_ind",
                    int = c("year", "tot_"),
                    dbl = "avg_",
                    yr = 'year') |>
    combine(address, c('rndrng_prvdr_st1', 'rndrng_prvdr_st2')) |>
    cols_util("services") |>
    dplyr::mutate(specialty = correct_specialty(specialty))

  if (rbcs) results <- rbcs_util(results)

  class(results) <- c("utilization_services", class(results))
  return(results)
}

#' @param results data frame from [utilization(type = "geography")]
#' @param rbcs < *boolean* > Add Restructured BETOS Classifications to HCPCS codes
#' @autoglobal
#' @noRd
tidyup.geography <- function(results, rbcs) {

  results <- tidyup(results,
                    yn = "_ind",
                    int = c("year", "tot_"),
                    dbl = "avg_",
                    yr = 'year') |>
    dplyr::mutate(place_of_srvc  = pos_char(place_of_srvc)) |>
    cols_util("geography")

  if (rbcs) results <- rbcs_util(results)

  class(results) <- c("utilization_geography", class(results))
  return(results)
}

#' @param df data frame
#' @param type 'provider', 'services', 'geography' or 'rbcs'
#' @autoglobal
#' @noRd
cols_util <- function(df,
                      type = c("provider",
                               "services",
                               "geography",
                               "rbcs")) {

  if (type == "geography") {

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
  }

  if (type == "services") {

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
              'hcpcs_code'   = 'hcpcs_cd',
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

  if (type == "provider") {

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
              'hcpcs_code',
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
#' @autoglobal
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
