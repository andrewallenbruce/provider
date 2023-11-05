#' Provider Enrollment in Medicare
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' `providers()` allows you to access enrollment level data on individual and
#' organizational providers that are actively approved to bill Medicare.
#'
#' @section Links:
#' + [Provider Enrollment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
#' + [Provider Enrollment Data Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)
#'
#' *Update Frequency:* **Quarterly**
#'
#' @param npi < *integer* > 10-digit Individual National Provider Identifier
#' @param pac < *integer* > 10-digit PECOS Associate Control ID
#' @param enid < *character* > 15-digit Medicare Enrollment ID
#' @param specialty_code < *character* > Enrollment specialty code
#' @param specialty_description < *character* > Enrollment specialty description
#' @param state < *character* > Enrollment state, full or abbreviation
#' @param first,middle,last < *character* > Individual provider's name
#' @param organization < *character* > Organizational provider's name
#' @param gender < *character* > Individual provider's gender: `"F"` (Female),
#' `"M"` (Male), `"9"` (Unknown/Organization)
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @return [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**               |**Description**                        |
#' |:-----------------------|:--------------------------------------|
#' |`npi`                   |10-digit NPI                           |
#' |`pac`                   |10-digit PAC ID                        |
#' |`enid`                  |15-digit provider enrollment ID        |
#' |`specialty_code`        |Enrollment primary specialty type code |
#' |`specialty_description` |Enrollment specialty type description  |
#' |`first`                 |Individual provider's first name       |
#' |`middle`                |Individual provider's middle name      |
#' |`last`                  |Individual provider's last name        |
#' |`organization`          |Organizational provider's name         |
#' |`state`                 |Enrollment state                       |
#' |`gender`                |Individual provider's gender           |
#'
#' @examplesIf interactive()
#' providers(npi = 1417918293, specialty_code = "14-41")
#' providers(pac = 2860305554, gender = "9")
#' @autoglobal
#' @export
providers <- function(npi = NULL,
                      pac = NULL,
                      enid = NULL,
                      specialty_code = NULL,
                      specialty_description = NULL,
                      first = NULL,
                      middle = NULL,
                      last = NULL,
                      organization = NULL,
                      state = NULL,
                      gender = NULL,
                      tidy = TRUE,
                      na.rm = TRUE) {

  npi    <- npi %nn% validate_npi(npi)
  pac    <- pac %nn% check_pac(pac)
  enid   <- enid %nn% check_enid(enid)
  gender <- gender %nn% rlang::arg_match(gender, c("F", "M", "9"))

  args <- dplyr::tribble(
                        ~param,  ~arg,
                          "NPI", npi,
           "PECOS_ASCT_CNTL_ID", pac,
                    "ENRLMT_ID", enid,
             "PROVIDER_TYPE_CD", specialty_code,
           "PROVIDER_TYPE_DESC", specialty_description,
                     "STATE_CD", state,
                   "FIRST_NAME", first,
                     "MDL_NAME", middle,
                    "LAST_NAME", last,
                     "ORG_NAME", organization,
                      "GNDR_SW", gender)

  response <- httr2::request(build_url("pro", args)) |>
    httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,                      ~y,
      "npi",                   npi,
      "pac",                   pac,
      "enid",                  enid,
      "specialty_code",        specialty_code,
      "specialty_description", specialty_description,
      "state",                 state,
      "first",                 first,
      "middle",                middle,
      "last",                  last,
      "organization",          organization,
      "gender",                gender) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }
  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy)  results <- cols_pros(tidyup(results))
  if (na.rm) results <- narm(results)
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_pros <- function(df) {

  cols <- c('npi',
            'pac'                   = 'pecos_asct_cntl_id',
            'enid'                  = 'enrlmt_id',
            'specialty_code'        = 'provider_type_cd',
            'specialty_description' = 'provider_type_desc',
            'state'                 = 'state_cd',
            'organization'          = 'org_name',
            'first'                 = 'first_name',
            'middle'                = 'mdl_name',
            'last'                  = 'last_name',
            'gender'                = 'gndr_sw')

  df |> dplyr::select(dplyr::any_of(cols))
}
