#' Search the Medicare Provider of Services File - Clinical Laboratories API
#'
#' @description [provider_clia()] allows access to a dataset that
#'    provides information on clinical laboratories including
#'    demographics and the type of testing services the facility
#'    provides.
#'
#' # Medicare Provider of Services File - Clinical Laboratories API
#'
#' The Provider of Services (POS) Clinical Laboratories (CLIA) data
#' provides information on CLIA demographics and types of testing
#' services the facility provides. In this file you will find provider
#' number, name, address and characteristics of the participating
#' institution providers. This data is gathered as part of the CMS
#' Provider Certification process and is updated each time a provider
#' is recertified.
#'
#' ## Data Update Frequency
#' Quarterly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#'  * [Medicare Provider of Services File - Clinical Laboratories API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)
#'  * [Data Dictionary](https://data.cms.gov/sites/default/files/2020-12/POS_CLIA_LAYOUT_SEP20.pdf)
#'
#' @param name Name of the provider certified to participate in the Medicare
#'    and/or Medicaid programs.
#' @param city City in which the provider is physically located.
#' @param state Two-character state abbreviation.
#' @param year Year between 2010-2022, in YYYY format
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examples
#' \dontrun{
#' provider_clia(name = "carbon hill", year = "2022")
#'
#' provider_clia(city = "alabaster")
#'
#' }
#' @autoglobal
#' @export

provider_clia <- function(name = NULL,
                          city = NULL,
                          state = NULL,
                          year = 2022,
                          clean_names = TRUE) {

  # dataset version ids by year ---------------------------------------------
  id <- dplyr::case_when(year == 2022 ~ "d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16",
                         year == 2021 ~ "0a1e9e1d-ca8a-4fde-bfb8-1436973f18c4",
                         year == 2020 ~ "0ac881d5-3742-4d71-85c0-b94cacf2c3f7",
                         year == 2019 ~ "cf000286-6a42-4031-81dd-aaa4fc8446fc",
                         year == 2018 ~ "4428eca4-3d4a-44e8-b146-df4e4cdba812",
                         year == 2017 ~ "97285b4b-ccce-4834-bbe1-05050665e498",
                         year == 2016 ~ "f68318d3-d74f-4e81-9b46-2d696ac599bb",
                         year == 2015 ~ "3e4c89ea-3e3f-4e29-959b-00f257c4893f",
                         year == 2014 ~ "cd7be382-7736-4411-a224-f01728cddae1",
                         year == 2013 ~ "3d21bf00-189b-4d5b-9cf7-75f88b849f71",
                         year == 2012 ~ "d5f8f520-824a-4ccb-bb99-25f83bba13f4",
                         year == 2011 ~ "c7f8619d-945f-4d8b-9747-f1b3f2e56c84",
                         year == 2010 ~ "3b635cea-fa5e-42de-ba61-4ba2f88e032f")

  # param_format ------------------------------------------------------------
  param_format <- function(param, arg) {
    if (is.null(arg)) {param <- NULL} else {
      paste0("filter[", param, "]=", arg, "&")}}

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
    "Rndrng_Prvdr_State_Abrvtn",  state_abb,
    "Rndrng_Prvdr_State_FIPS",       fips,
    "Rndrng_Prvdr_Zip5",        zip,
    "Rndrng_Prvdr_RUCA",       ruca,
    "Rndrng_Prvdr_Cntry",    country,
    "Rndrng_Prvdr_Type",  specialty,
    "Rndrng_Prvdr_Mdcr_Prtcptg_Ind",    par_ind,
    "HCPCS_Cd", hcpcs_code,
    "HCPCS_Drug_Ind",   drug_ind,
    "Place_Of_Srvc",        pos)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "")

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # create request ----------------------------------------------------------
  req <- httr2::request(url)

  # send response -----------------------------------------------------------
  resp <- req |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- resp |>
    httr2::resp_body_json(check_type = FALSE, simplifyVector = TRUE) |>
    tibble::tibble() |>
    dplyr::mutate(Year = year) |>
    dplyr::relocate(Year)

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
