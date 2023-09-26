#' Provider Enrollment in Medicare
#'
#' @description
#'
#' `providers()` allows you to access enrollment level data on individual and
#' organizational providers that are actively approved to bill Medicare.
#'
#' Links:
#' - [Provider Enrollment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
#' - [Provider Enrollment Data Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)
#'
#' *Update Frequency:* **Quarterly**
#'
#' @param npi < *integer* > 10-digit national provider identifier
#' @param pac < *integer* > 10-digit provider associate level variable. Links
#' all entity-level information and may be associated with multiple enrollment
#' IDs if the individual or organization enrolled multiple times.
#' @param enroll_id < *character* > 15-digit provider enrollment ID. Assigned to
#' each new provider enrollment application. Links all enrollment-level
#' information (enrollment type, state, reassignment of benefits).
#' @param specialty_code < *character* > Enrollment primary specialty type code
#' @param specialty_description < *character* > Enrollment specialty type description
#' @param state < *character* > Enrollment state abbreviation/full name.
#' Providers enroll at the state level, so a PAC ID can be associated with
#' multiple enrollment IDs and states.
#' @param first,middle,last < *character* > Individual provider's first/middle/last name
#' @param organization < *character* > Organizational provider's name
#' @param gender < *character* > Individual provider's gender. Options are:
#'    * `"F"`: Female
#'    * `"M"`: Male
#'    * `"9"`: Unknown (or Organizational provider)
#' @param tidy < *boolean* > Tidy output; default is `TRUE`.
#' @param na.rm < *boolean* > Remove empty rows and columns; default is `TRUE`.
#'
#' @return [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**               |**Description**                        |
#' |:-----------------------|:--------------------------------------|
#' |`npi`                   |10-digit NPI                           |
#' |`pac_id`                |10-digit PAC ID                        |
#' |`enroll_id`             |15-digit provider enrollment ID        |
#' |`specialty_code`        |Enrollment primary specialty type code |
#' |`specialty_description` |Enrollment specialty type description  |
#' |`first`                 |Individual provider's first name       |
#' |`middle`                |Individual provider's middle name      |
#' |`last`                  |Individual provider's last name        |
#' |`organization`          |Organizational provider's name         |
#' |`state`                 |Enrollment state                       |
#' |`gender`                |Individual provider's gender           |
#'
#' @seealso [order_refer()], [opt_out()], [pending()]
#'
#' @examplesIf interactive()
#' providers(npi = 1417918293, specialty_code = "14-41")
#' providers(pac = 2860305554, gender = "9")
#' @autoglobal
#' @export
providers <- function(npi = NULL,
                      pac = NULL,
                      enroll_id = NULL,
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

  if (!is.null(npi))       {npi    <- npi_check(npi)}
  if (!is.null(pac))       {pac_id <- pac_check(pac)}
  if (!is.null(enroll_id)) {enroll_check(enroll_id)}
  if (!is.null(gender))    {rlang::arg_match(gender, c("F", "M", "9"))}

  args <- dplyr::tribble(
                        ~param,  ~arg,
                          "NPI", npi,
           "PECOS_ASCT_CNTL_ID", pac,
                    "ENRLMT_ID", enroll_id,
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

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                      ~y,
      "npi",                   npi,
      "pac",                   pac,
      "enroll_id",             enroll_id,
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

  if (tidy) {
    results <- tidyup(results) |> pros_cols()

    if (na.rm) {
      results <- janitor::remove_empty(results, which = c("rows", "cols"))
    }
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
pros_cols <- function(df) {

  cols <- c('npi',
            'pac'                   = 'pecos_asct_cntl_id',
            'enroll_id'             = 'enrlmt_id',
            'specialty_code'        = 'provider_type_cd',
            'specialty_description' = 'provider_type_desc',
            'state'                 = 'state_cd',
            'organization'          = 'org_name',
            'first'                 = 'first_name',
            'middle'                = 'mdl_name',
            'last'                  = 'last_name',
            'gender'                = 'gndr_sw')

  df |> dplyr::select(dplyr::all_of(cols))

}

#' @param npi description
#' @param pac description
#' @param enroll_id description
#' @autoglobal
#' @noRd
individuals <- function(npi = NULL,
                        pac = NULL,
                        enroll_id = NULL) {

  p <- providers(npi = npi, pac = pac, enroll_id = enroll_id)

  if (!is.null(pac)) {unique(pac$enroll_id)}

  d <- revalidation_date(npi = npi, enroll_id = enroll_id)
  d$specialty_description <- NULL

  r <- revalidation_reassign(npi = npi, pac_ind = pac, enroll_id_ind = enroll_id)
  r$state_ind    <- NULL
  r$due_date_ind <- NULL
  r$due_date_org <- NULL

  dplyr::full_join(p, d) |> dplyr::full_join(r)

}
