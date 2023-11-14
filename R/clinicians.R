#' Clinicians Enrolled in Medicare
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [clinicians()] allows you to access information about providers enrolled in
#' Medicare, including the medical school that they attended and the year they graduated
#'
#' *Update Frequency:* **Monthly**
#'
#' @section Links:
#' + [National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
#' + [Provider Data Catalog (PDC) Data Dictionary](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)
#'
#'
#' @param npi < *integer* > 10-digit Individual National Provider Identifier
#' @param pac < *integer* > 10-digit Individual PECOS Associate Control ID
#' @param enid < *character* > 15-digit Individual Medicare Enrollment ID
#' @param first,middle,last < *character* > Individual provider's name
#' @param gender < *character* > Individual provider's gender; `"F"` (Female)
#' or `"M"` (Male)
#' @param credential Individual provider’s credential
#' @param school < *character* > Individual provider’s medical school
#' @param grad_year < *integer* > Individual provider’s graduation year
#' @param specialty < *character* > Individual provider’s primary medical
#' specialty reported in the selected enrollment
#' @param facility_name < *character* > Name of facility associated with the
#' individual provider
#' @param pac_org < *integer* > 10-digit Organizational PECOS
#' Associate Control ID
#' @param city < *character* > Provider's city
#' @param state < *character* > Provider's state
#' @param zip < *character* > Provider's ZIP code
#' @param offset < *integer* > // __default:__ `0L` API pagination
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**       |**Description**                                       |
#' |:---------------|:-----------------------------------------------------|
#' |`npi`           |10-digit individual NPI                               |
#' |`pac`           |10-digit individual PAC ID                            |
#' |`enid`          |15-digit individual enrollment ID                     |
#' |`first`         |Provider's first name                                 |
#' |`middle`        |Provider's middle name                                |
#' |`last`          |Provider's last name                                  |
#' |`suffix`        |Provider's name suffix                                |
#' |`gender`        |Provider's gender                                     |
#' |`credential`    |Provider's credential                                 |
#' |`school`        |Provider's medical school                             |
#' |`grad_year`     |Provider's graduation year                            |
#' |`specialty`     |Provider's primary specialty                          |
#' |`specialty_sec` |Provider's secondary specialty                        |
#' |`facility_name` |Facility associated with provider                     |
#' |`pac_org`       |Facility's 10-digit PAC ID                            |
#' |`members`       |Number of providers associated with facility's PAC ID |
#' |`address`       |Provider's street address                             |
#' |`city`          |Provider's city                                       |
#' |`state`         |Provider's state                                      |
#' |`zip`           |Provider's zip code                                   |
#' |`phone`         |Provider's phone number                               |
#' |`telehealth`    |Indicates if provider offers telehealth services      |
#' |`assign_ind`    |Indicates if provider accepts Medicare assignment     |
#' |`assign_org`    |Indicates if facility accepts Medicare assignment     |
#'
#' @examplesIf interactive()
#' clinicians(enid = "I20081002000549") # enid not working
#' clinicians(school = "NEW YORK UNIVERSITY SCHOOL OF MEDICINE")
#' @autoglobal
#' @export
clinicians <- function(npi = NULL,
                       pac = NULL,
                       enid = NULL,
                       first = NULL,
                       middle = NULL,
                       last = NULL,
                       gender = NULL,
                       credential = NULL,
                       school = NULL,
                       grad_year = NULL,
                       specialty = NULL,
                       facility_name = NULL,
                       pac_org = NULL,
                       city = NULL,
                       state = NULL,
                       zip = NULL,
                       offset = 0L,
                       tidy = TRUE,
                       na.rm = TRUE) {

  npi       <- npi %nn% validate_npi(npi)
  pac       <- pac %nn% check_pac(pac)
  pac_org   <- pac_org %nn% check_pac(pac_org)
  enid      <- enid %nn% check_enid(enid)
  grad_year <- grad_year %nn% as.character(grad_year)
  zip       <- zip %nn% as.character(zip)
  gender    <- gender %nn% rlang::arg_match(gender, c("F", "M"))

  args <- dplyr::tribble(
    ~param,                 ~arg,
    "npi",                  npi,
    "ind_pac_id",           pac,
    "ind_enrl_id",          enid,
    "provider_first_name",  first,
    "provider_middle_name", middle,
    "provider_last_name",   last,
    "gndr",                 gender,
    "cred",                 credential,
    "med_sch",              school,
    "grd_yr",               grad_year,
    "pri_spec",             specialty,
    "facility_name",        facility_name,
    "org_pac_id",           pac_org,
    "citytown",             city,
    "state",                state,
    "zip_code",             zip)

  error_body <- function(response) httr2::resp_body_json(response)$message

  response <- httr2::request(file_url("c", args, offset)) |>
    httr2::req_error(body = error_body) |>
    httr2::req_perform()

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (vctrs::vec_is_empty(results)) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "pac",           pac,
      "enid",          enid,
      "first",         first,
      "middle",        middle,
      "last",          last,
      "gender",        gender,
      "credential",    credential,
      "school",        school,
      "grad_year",     grad_year,
      "specialty",     specialty,
      "facility_name", facility_name,
      "pac_org",       pac_org,
      "city",          city,
      "state",         state,
      "zip",           zip) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  if (tidy) {
    results <- tidyup(results,
                      yn = 'telehlth',
                      int = c('num_org_mem', 'grd_yr')) |>
      combine(address, c('adr_ln_1', 'adr_ln_2')) |>
      dplyr::mutate(gndr = fct_gen(gndr),
                    state = fct_stabb(state)) |>
      cols_clin()

    if (na.rm) results <- narm(results)
    }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_clin <- function(df) {

  cols <- c('npi',
            'pac'           = 'ind_pac_id',
            'enid'          = 'ind_enrl_id',
            'first'         = 'provider_first_name',
            'middle'        = 'provider_middle_name',
            'last'          = 'provider_last_name',
            'suffix'        = 'suff',
            'gender'        = 'gndr',
            'credential'    = 'cred',
            'school'        = 'med_sch',
            'grad_year'     = 'grd_yr',
            'specialty'     = 'pri_spec',
            'specialty_sec' = 'sec_spec_all',
            'facility_name',
            'pac_org'       = 'org_pac_id',
            'members_org'   = 'num_org_mem',
            'address_org'   = 'address',
            'city_org'      = 'citytown',
            'state_org'     = 'state',
            'zip_org'       = 'zip_code',
            'phone_org'     = 'telephone_number')

  df |> dplyr::select(dplyr::any_of(cols))
}
