#' Outpatient Hospitals Enrolled in Medicare
#'
#' @note
#' State/FIP values are restricted to 49 of the United States and the District
#' of Columbia where hospitals are subjected to Medicare's Outpatient
#' Prospective Payment System (OPPS). Maryland and US territory hospitals are
#' excluded.
#'
#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run [out_years()] to return a vector of the years currently available.
#' @param ccn < *integer* > 6-digit CMS Certification Number
#' @param organization < *character* > Organization's name
#' @param street < *character* > Street where provider is located
#' @param city < *character* > City where provider is located
#' @param state < *character* > State where provider is located
#' @param fips < *character* > Provider's state FIPS code
#' @param zip < *character* > Provider’s zip code
#' @param ruca < *character* > Provider’s RUCA code
#' @param apc < *character* > comprehensive ambulatory payment classification code
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#' @examplesIf interactive()
#' outpatient(year = 2021, ccn = "110122")
#'
#' outpatient(year = 2021, state = "GA")
#'
#' @autoglobal
#' @export
# nocov start
outpatient <- function(year,
                       ccn = NULL,
                       organization = NULL,
                       street = NULL,
                       city = NULL,
                       state = NULL,
                       fips = NULL,
                       zip = NULL,
                       ruca = NULL,
                       apc = NULL,
                       tidy = TRUE,
                       na.rm = TRUE) {

  zip <- zip %nn% as.character(zip)
  ccn <- ccn %nn% as.character(ccn)
  apc <- apc %nn% as.character(apc)

  args <- dplyr::tribble(
    ~param,                      ~arg,
    'Rndrng_Prvdr_CCN',	         ccn,
    'Rndrng_Prvdr_Org_Name',	   organization,
    'Rndrng_Prvdr_St',	         street,
    'Rndrng_Prvdr_City',	       city,
    'Rndrng_Prvdr_State_Abrvtn', state,
    'Rndrng_Prvdr_State_FIPS',	 fips,
    'Rndrng_Prvdr_Zip5',	       zip,
    'Rndrng_Prvdr_RUCA',         ruca,
    'APC_Cd',                    apc)

  id <- dplyr::filter(api_years("outps"),
                      year == {{ year }}) |>
    dplyr::pull(distro)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,               ~y,
      'ccn',	        ccn,
      'organization',	organization,
      'street',	      street,
      'city',	        city,
      'state',	      state,
      'fips',	        fips,
      'zip',	        zip,
      'ruca',         ruca,
      'apc',          apc) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results$year <- year
    results <- tidyup(results,
                      int = c('year',
                              'bene_cnt',
                              'capc_srvcs',
                              'outlier_srvcs'),
                      dbl = c('avg_tot_sbmtd_chrgs',
                              'avg_mdcr_alowd_amt',
                              'avg_mdcr_pymt_amt',
                              'avg_mdcr_outlier_amt'),
                      yr = 'year') |>
      cols_out()
    if (na.rm) results <- narm(results)
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_out <- function(df) {

    cols <- c('year',
              'ccn'                 = 'rndrng_prvdr_ccn',
              'organization'        = 'rndrng_prvdr_org_name',
              'street'              = 'rndrng_prvdr_st',
              'city'                = 'rndrng_prvdr_city',
              'state'               = 'rndrng_prvdr_state_abrvtn',
              'fips'                = 'rndrng_prvdr_state_fips',
              'zip'                 = 'rndrng_prvdr_zip5',
              'ruca'                = 'rndrng_prvdr_ruca',
              # 'ruca_desc'         = 'rndrng_prvdr_ruca_desc',
              'apc'                 = 'apc_cd',
              'apc_desc',
              'tot_benes'           = 'bene_cnt',
              'comp_apc_srvcs'      = 'capc_srvcs',
              'avg_charges'         = 'avg_tot_sbmtd_chrgs',
              'avg_allowed'         = 'avg_mdcr_alowd_amt',
              'avg_payment'         = 'avg_mdcr_pymt_amt',
              'tot_outlier_srvcs'   = 'outlier_srvcs',
              'avg_outlier_payment' = 'avg_mdcr_outlier_amt')

    df |> dplyr::select(dplyr::any_of(cols))
}
# nocov end
