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
#'
#' @param npi National Provider Identifier (NPI) for the rendering provider
#'    on the claim. The provider NPI is the numeric identifier registered in
#'    NPPES.
#' @param last_org Last name/Organization name of the provider. When the
#'    provider is registered in NPPES as an individual (entity type code `I`),
#'    this is the provider’s last name. When the provider is registered as an
#'    organization (entity type code `O`), this is the organization name.
#' @param first An individual provider's (entity type code `I`) first name.
#'    An organization's (entity type code `O`) will be blank.
#' @param cred An individual provider's (entity type code `I`) credentials.
#'    An organization's will be blank.
#' @param gender An individual provider's gender.
#'    An organization's will be blank.
#' @param type Type of entity reported in NPPES. An entity code of `I`
#'    identifies providers registered as individuals while an entity type
#'    code of `O` identifies providers registered as organizations.
#' @param city The city where the provider is located, as reported in NPPES.
#' @param state The state where the provider is located, as reported in NPPES.
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
#'    be `Y` for any provider that had at least one claim identifying the
#'    provider as participating in Medicare or accepting assignment of
#'    Medicare allowed amounts within HCPCS code and place of service. A
#'    non-participating provider may elect to accept Medicare allowed amounts
#'    for some services and not accept Medicare allowed amounts for other
#'    services.
#' @param year Year in YYYY format, between 2013-2020; default is 2020
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
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
#' \dontrun{
#' provider <- purrr::map_dfr(as.character(2013:2020),
#'            ~physician_by_provider(npi = 1003000126, year = .x))
#' }
#' @autoglobal
#' @export

physician_by_provider <- function(npi         = NULL,
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
                                  year        = 2020,
                                  clean_names = TRUE,
                                  lowercase   = TRUE) {

  # dataset version ids by year ----------------------------------------------
  id <- dplyr::case_when(year == 2020 ~ "8889d81e-2ee7-448f-8713-f071038289b5",
                         year == 2019 ~ "a399e5c1-1cd1-4cbe-957f-d2cc8fe5d897",
                         year == 2018 ~ "a5cfcc24-eaf7-472c-8831-7f396c77a890",
                         year == 2017 ~ "bed1a455-2dad-4359-9cec-ec59cf251a14",
                         year == 2016 ~ "9301285e-f2ff-4035-9b59-48eaa09a0572",
                         year == 2015 ~ "acba6dc6-3e76-4176-9564-84ab5ea4c8aa",
                         year == 2014 ~ "d3d74823-9909-4177-946d-cdaa268b90ab",
                         year == 2013 ~ "bbec6d8a-3b0d-49bb-98be-3170639d3ab5")

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
 "Rndrng_Prvdr_Mdcr_Prtcptg_Ind",    par_ind)


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
  results <- tibble::tibble(httr2::resp_body_json(resp,
             check_type = FALSE, simplifyVector = TRUE)) |>
             dplyr::mutate(Year = year) |> dplyr::relocate(Year)

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
