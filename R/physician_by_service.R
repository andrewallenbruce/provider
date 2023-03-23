#' Search the Medicare Physician & Other Practitioners API
#'    by **Provider and Service**
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
#' ## Links
#' * [Medicare Physician & Other Practitioners: by Provider and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Annually**
#'
#' @param npi National Provider Identifier (NPI) for the rendering provider
#'    on the claim. The provider NPI is the numeric identifier registered in
#'    NPPES.
#' @param last_org Last name/Organization name of the provider. When the
#'    provider is registered in NPPES as an individual (entity type code=’I’),
#'    this is the provider’s last name. When the provider is registered as an
#'    organization (entity type code = ‘O’), this is the organization name.
#' @param first An individual provider's (entity type code=’I’) first name.
#'    An organization's (entity type code = ‘O’) will be blank.
#' @param cred An individual provider's (entity type code=’I’) credentials.
#'    An organization's will be blank.
#' @param gender An individual provider's gender.
#'    An organization's will be blank.
#' @param type Type of entity reported in NPPES. An entity code of ‘I’
#'    identifies providers registered as individuals while an entity type
#'    code of ‘O’ identifies providers registered as organizations.
#' @param city The city where the provider is located, as reported in NPPES.
#' @param state The state where the provider is located, as reported
#'    in NPPES.
#' @param fips FIPS code for the rendering provider's state.
#' @param zip The provider’s zip code, as reported in NPPES.
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
#' @param par_ind Identifies whether the provider participates in Medicare
#'    and/or accepts assignment of Medicare allowed amounts. The value will
#'    be ‘Y’ for any provider that had at least one claim identifying the
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
#' @param hcpcs_drug Identifies whether the HCPCS code for the specific service
#'    furnished by the provider is a HCPCS listed on the Medicare Part B Drug
#'    Average Sales Price (ASP) File. Please visit the ASP drug pricing page
#'    for additional information.
#' @param pos Identifies whether the place of service submitted on the claims
#'    is a facility (value of ‘F’) or non-facility (value of ‘O’). Non-facility
#'    is generally an office setting; however other entities are included
#'    in non-facility.
#' @param year Year in YYYY format, between 2013-2020; default is 2020
#' @param clean_names Convert column names to snakecase; default is `TRUE`.
#' @param nest Nest related columns together; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' # Search by NPI
#' physician_by_service(npi = 1003000126)
#'
#' # Search by Last Name for 2019
#' physician_by_service(last_org = "Enkeshafi", year = 2019)
#'
#' # Multiple NPIs
#' npis <- c(1003026055,
#'           1316405939,
#'           1720392988,
#'           1518184605,
#'           1922056829,
#'           1083879860)
#'
#' npis |> purrr::map_dfr(physician_by_service)
#'
#' # Retrieve All Provider Data, 2013-2020
#' purrr::map_dfr(as.character(2013:2020),
#' ~physician_by_service(npi = 1003000126, year = .x))
#' }
#' @autoglobal
#' @export

physician_by_service <- function(npi         = NULL,
                                 last_org    = NULL,
                                 first       = NULL,
                                 cred        = NULL,
                                 gender      = NULL,
                                 type        = NULL,
                                 city        = NULL,
                                 state       = NULL,
                                 fips        = NULL,
                                 zip         = NULL,
                                 ruca        = NULL,
                                 country     = NULL,
                                 specialty   = NULL,
                                 par_ind     = NULL,
                                 hcpcs_code  = NULL,
                                 hcpcs_drug  = NULL,
                                 pos         = NULL,
                                 year        = 2020,
                                 clean_names = TRUE,
                                 nest        = TRUE) {

  # update distribution ids -------------------------------------------------
  ids <- cms_update_ids(api = "Medicare Physician & Other Practitioners - by Provider and Service")

  # dataset version ids by year ----------------------------------------------
  id <- dplyr::case_when(year == 2020 ~ ids$distribution[2],
                         year == 2019 ~ ids$distribution[3],
                         year == 2018 ~ ids$distribution[4],
                         year == 2017 ~ ids$distribution[5],
                         year == 2016 ~ ids$distribution[6],
                         year == 2015 ~ ids$distribution[7],
                         year == 2014 ~ ids$distribution[8],
                         year == 2013 ~ ids$distribution[9])

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                               ~x,         ~y,
                     "Rndrng_NPI",        npi,
     "Rndrng_Prvdr_Last_Org_Name",   last_org,
        "Rndrng_Prvdr_First_Name",      first,
           "Rndrng_Prvdr_Crdntls",       cred,
              "Rndrng_Prvdr_Gndr",     gender,
            "Rndrng_Prvdr_Ent_Cd",       type,
              "Rndrng_Prvdr_City",       city,
      "Rndrng_Prvdr_State_Abrvtn",      state,
        "Rndrng_Prvdr_State_FIPS",       fips,
              "Rndrng_Prvdr_Zip5",        zip,
              "Rndrng_Prvdr_RUCA",       ruca,
             "Rndrng_Prvdr_Cntry",    country,
              "Rndrng_Prvdr_Type",  specialty,
  "Rndrng_Prvdr_Mdcr_Prtcptg_Ind",    par_ind,
                       "HCPCS_Cd", hcpcs_code,
                 "HCPCS_Drug_Ind", hcpcs_drug,
                  "Place_Of_Srvc",        pos)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  res <- tibble::tibble(httr2::resp_body_json(resp,
             check_type = FALSE, simplifyVector = TRUE)) |>
             dplyr::mutate(Year = year) |> dplyr::relocate(Year)

  results <- res |>
    dplyr::mutate(dplyr::across(c(Tot_Benes,
                                  Tot_Srvcs,
                                  Tot_Bene_Day_Srvcs), ~as.integer(.)),
    dplyr::across(dplyr::ends_with(c("Amt", "Chrg")), ~as.double(.)),
    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")))

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- dplyr::rename_with(results, str_to_snakecase)}
  # nest columns ------------------------------------------------------------
  if (isTRUE(nest)) {
    results <- results |>
      tidyr::nest(rndrng_prvdr = dplyr::contains("rndrng_prvdr"),
                  totals_srvcs = dplyr::starts_with("tot_"),
                  hcpcs = c(hcpcs_cd, hcpcs_desc, hcpcs_drug_ind, place_of_srvc),
                  averages = dplyr::starts_with("avg_"))
    }
  return(results)
}