#' Provider Enrollment in Medicare
#'
#' @description `providers()` allows you to access enrollment level
#'    data on individual and organizational providers that are actively approved
#'    to bill Medicare.
#'
#' ### Links
#' - [Provider Enrollment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
#' - [Provider Enrollment Data Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)
#'
#' *Update Frequency:* **Quarterly**
#'
#' @param npi < *integer* > 10-digit national provider identifier
#' @param pac_id < *integer* > 10-digit provider associate level variable. Links
#' all entity-level information and may be associated with multiple enrollment
#' IDs if the individual or organization enrolled multiple times.
#' @param enroll_id < *character* > 15-digit provider enrollment ID. Assigned to
#' each new provider enrollment application. Links all enrollment-level
#' information (enrollment type, state, reassignment of benefits).
#' @param specialty_code < *character* > Enrollment primary specialty type code
#' @param specialty < *character* > Enrollment specialty type description
#' @param state < *character* > Enrollment state abbreviation/full name.
#' Providers enroll at the state level, so a PAC ID can be associated with
#' multiple enrollment IDs and states.
#' @param first,middle,last < *character* > Individual provider's first/middle/last name
#' @param organization < *character* > Organizational provider's name
#' @param gender < *character* > Individual provider gender. Options are:
#'    * `"F"`: Female
#'    * `"M"`: Male
#'    * `"9"`: Unknown (or Organizational provider)
#' @param tidy < *boolean* > Tidy output; default is `TRUE`.
#' @param na.rm < *boolean* > Remove empty rows and columns; default is `TRUE`.
#'
#' @return [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**        |**Description**                        |
#' |:----------------|:--------------------------------------|
#' |`npi`            |10-digit NPI                           |
#' |`pac_id`         |10-digit PAC ID                        |
#' |`enroll_id`      |15-digit provider enrollment ID        |
#' |`specialty_code` |Enrollment primary specialty type code |
#' |`specialty`      |Enrollment specialty type description  |
#' |`state`          |Enrollment state                       |
#' |`first`          |Individual provider's first name       |
#' |`middle`         |Individual provider's middle name      |
#' |`last`           |Individual provider's last name        |
#' |`gender`         |Individual provider's gender           |
#' |`organization`   |Organizational provider's name         |
#'
#' @seealso [order_refer()], [opt_out()], [pending()]
#'
#' @examplesIf interactive()
#' providers(npi = 1417918293, specialty_code = "14-41")
#' providers(pac_id = 2860305554, gender = "9")
#' @autoglobal
#' @export
providers <- function(npi = NULL,
                      pac_id = NULL,
                      enroll_id = NULL,
                      specialty_code = NULL,
                      specialty = NULL,
                      state = NULL,
                      first = NULL,
                      middle = NULL,
                      last = NULL,
                      organization = NULL,
                      gender = NULL,
                      tidy = TRUE,
                      na.rm = TRUE) {

  if (!is.null(npi))       {npi    <- npi_check(npi)}
  if (!is.null(pac_id))    {pac_id <- pac_check(pac_id)}
  if (!is.null(enroll_id)) {enroll_check(enroll_id)}
  if (!is.null(gender))    {rlang::arg_match(gender, c("F", "M", "9"))}

  args <- dplyr::tribble(
                        ~param,  ~arg,
                          "NPI", npi,
           "PECOS_ASCT_CNTL_ID", pac_id,
                    "ENRLMT_ID", enroll_id,
             "PROVIDER_TYPE_CD", specialty_code,
           "PROVIDER_TYPE_DESC", specialty,
                     "STATE_CD", state,
                   "FIRST_NAME", first,
                     "MDL_NAME", middle,
                    "LAST_NAME", last,
                     "ORG_NAME", organization,
                      "GNDR_SW", gender)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
         cms_update("Medicare Fee-For-Service  Public Provider Enrollment",
                    "id")$distro[1], "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                 ~y,
      "npi",               npi,
      "pac_id",            pac_id,
      "enroll_id",         enroll_id,
      "specialty_code",    specialty_code,
      "specialty",         specialty,
      "state",             state,
      "first",             first,
      "middle",            middle,
      "last",              last,
      "organization",      organization,
      "gender",            gender) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))

  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::select(npi,
                    pac_id = pecos_asct_cntl_id,
                    enroll_id = enrlmt_id,
                    specialty_code = provider_type_cd,
                    specialty = provider_type_desc,
                    state = state_cd,
                    organization = org_name,
                    first = first_name,
                    middle = mdl_name,
                    last = last_name,
                    gender = gndr_sw,
                    dplyr::everything())

    if (na.rm) {
      results <- janitor::remove_empty(results, which = c("rows", "cols"))
    }
  }
  return(results)
}
