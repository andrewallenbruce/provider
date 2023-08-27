#' @title Search the Medicare Physician & Other Practitioners API
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
#' ### Links
#'   - [Medicare Physician & Other Practitioners: by Provider and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
#'
#' *Update Frequency:* **Annually**
#'
#' @param year integer (*required*); Year in `YYYY` format. Run helper function
#'    `by_service_years()` to return a vector of the years
#'    currently available.
#' @param npi National Provider Identifier for the rendering provider on the claim.
#' @param first_name Individual provider's first name.
#' @param last_name Individual provider's last name.
#' @param organization_name Organization name.
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
#' @param hcpcs_code HCPCS code used to identify the specific medical service
#'    furnished by the provider. HCPCS codes include two levels. Level I codes
#'    are the Current Procedural Terminology (CPT) codes that are maintained
#'    by the American Medical Association and Level II codes are created by
#'    CMS to identify products, supplies and services not covered by the CPT
#'    codes (such as ambulance services).
#' @param drug Identifies whether the HCPCS code for the specific service
#'    furnished by the provider is a HCPCS listed on the Medicare Part B Drug
#'    Average Sales Price (ASP) File. Please visit the ASP drug pricing page
#'    for additional information.
#' @param pos Identifies whether the place of service submitted on the claims
#'    is a facility (`F`) or non-facility (`O`). Non-facility is generally an
#'    office setting; however other entities are included in non-facility.
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' physician_by_service(npi = 1003000126)
#' physician_by_service(year = 2019, last_name = "Enkeshafi")
#' @autoglobal
#' @export
by_service <- function(year,
                       npi           = NULL,
                       last_name     = NULL,
                       first_name    = NULL,
                       organization_name = NULL,
                       credential    = NULL,
                       gender        = NULL,
                       entype        = NULL,
                       city          = NULL,
                       state         = NULL,
                       zip       = NULL,
                       fips          = NULL,
                       ruca          = NULL,
                       country       = NULL,
                       specialty     = NULL,
                       par           = NULL,
                       hcpcs_code    = NULL,
                       drug          = NULL,
                       pos           = NULL,
                       tidy          = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}

  if (!is.null(pos)) {pos <- pos_char(pos)}

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(by_service_years()))

  # update distribution ids -------------------------------------------------
  id <- cms_update(api = "Medicare Physician & Other Practitioners - by Provider and Service", check = "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                               ~x,   ~y,
                     "Rndrng_NPI",   npi,
        "Rndrng_Prvdr_First_Name",   first_name,
     "Rndrng_Prvdr_Last_Org_Name",   last_name,
     "Rndrng_Prvdr_Last_Org_Name",   organization_name,
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
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28) {

    cli_args <- tibble::tribble(
      ~x,             ~y,
      "year",         as.character(year),
      "npi",          as.character(npi),
      "last_name",    last_name,
      "first_name",   first_name,
      "organization_name", organization_name,
      "credential",   credential,
      "gender",       gender,
      "entype",       entype,
      "city",         city,
      "state",        state,
      "fips",         as.character(fips),
      "zip",          zip,
      "ruca",         ruca,
      "country",      country,
      "specialty",    specialty,
      "par",          par,
      "hcpcs_code",   as.character(hcpcs_code),
      "drug",         as.character(drug),
      "pos",          pos) |>
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
    check_type = FALSE,
    simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::mutate(year = as.integer(year),
                    dplyr::across(c(tot_benes,
                                    tot_srvcs,
                                    tot_bene_day_srvcs), ~as.integer(.)),
                    dplyr::across(dplyr::ends_with(c("amt", "chrg")), ~as.double(.)),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      tidyr::unite("street",
                   dplyr::any_of(c("rndrng_prvdr_st1", "rndrng_prvdr_st2")),
                   remove = TRUE,
                   na.rm = TRUE,
                   sep = " ") |>
      dplyr::select(year,
                    npi           = rndrng_npi,
                    entype        = rndrng_prvdr_ent_cd,
                    first_name    = rndrng_prvdr_first_name,
                    middle_name   = rndrng_prvdr_mi,
                    last_name     = rndrng_prvdr_last_org_name,
                    credential    = rndrng_prvdr_crdntls,
                    gender        = rndrng_prvdr_gndr,
                    specialty     = rndrng_prvdr_type,
                    street,
                    city          = rndrng_prvdr_city,
                    state         = rndrng_prvdr_state_abrvtn,
                    fips          = rndrng_prvdr_state_fips,
                    zip       = rndrng_prvdr_zip5,
                    ruca          = rndrng_prvdr_ruca,
                    #ruca_desc    = rndrng_prvdr_ruca_desc,
                    country       = rndrng_prvdr_cntry,
                    par           = rndrng_prvdr_mdcr_prtcptg_ind,
                    hcpcs_code    = hcpcs_cd,
                    hcpcs_desc,
                    drug    = hcpcs_drug_ind,
                    pos = place_of_srvc,
                    tot_benes,
                    tot_srvcs,
                    tot_day       = tot_bene_day_srvcs,
                    avg_charge   = avg_sbmtd_chrg,
                    avg_allowed   = avg_mdcr_alowd_amt,
                    avg_payment   = avg_mdcr_pymt_amt,
                    avg_std_pymt  = avg_mdcr_stdzd_amt) |>
      dplyr::mutate(credential    = clean_credentials(credential),
                    entype        = entype_char(entype),
                    pos = pos_char(pos),
                    par           = yn_logical(par))
    }
  return(results)
}

#' Check the current years available for the Physician & Other Practitioners by Provider and Service API
#' @return integer vector of years available
#' @examples
#' by_service_years()
#' @rdname years
#' @autoglobal
#' @export
by_service_years <- function() {
  cms_update("Medicare Physician & Other Practitioners - by Provider and Service", "years") |>
    as.integer()
}
