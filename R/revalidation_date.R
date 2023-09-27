#' Search the Medicare Revalidation Due Date List API
#'
#' @description Information on revalidation due dates for Medicare providers.
#'    Medicare Providers must validate their enrollment record every three or
#'    five years. CMS sets every Provider’s Revalidation due date at the end
#'    of a month and posts the upcoming six to seven months of due dates
#'    online. A due date of ‘TBD’ means that CMS has not set the due date yet.
#'    These lists are refreshed every two months and two months’ worth of due
#'    dates are appended to the list
#'
#' @details The Revalidation Due Date List dataset contains revalidation due
#'    dates for Medicare providers who are due to revalidate in the following
#'    six months. If a provider's due date does not fall within the ensuing
#'    six months, the due date is marked 'TBD'. In addition the dataset also
#'    includes subfiles with reassignment information for a given provider
#'    as well as due date listings for clinics and group practices and
#'    their providers.
#'
#' Links:
#' * [Medicare Revalidation Due Date API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi < *integer* > 10-digit national provider identifier
#' @param enroll_id < *character* > 15-digit provider enrollment ID
#' @param first,last < *character* > Individual provider's first/last name
#' @param organization < *character* > Organizational provider's legal business name
#' @param state < *character* > Enrollment state
#' @param enrollment_type < *integer* > Provider enrollment type:
#'    * `1`: Part A
#'    * `2`: DME
#'    * `3`: Non-DME Part B
#' @param specialty_description < *character* > Enrollment specialty
#' @param tidy Tidy output; default is `TRUE`
#' @param na.rm < *boolean* > Remove empty rows and columns; default is `TRUE`
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' revalidation_date(enroll_id = "I20031110000070")
#' revalidation_date(enroll_id = "O20110620000324")
#' revalidation_date(state = "FL", enrollment_type = 3, specialty = "General Practice")
#' @autoglobal
#' @export
revalidation_date <- function(npi = NULL,
                              enroll_id = NULL,
                              first = NULL,
                              last = NULL,
                              organization = NULL,
                              state = NULL,
                              enrollment_type = NULL,
                              specialty_description = NULL,
                              tidy = TRUE,
                              na.rm = TRUE) {

  if (!is.null(npi))         {npi <- npi_check(npi)}
  if (!is.null(enroll_id))   {enroll_check(enroll_id)}

  if (!is.null(enrollment_type)) {
    enrollment_type <- as.character(enrollment_type)
    rlang::arg_match(enrollment_type, as.character(1:3))}

  args <- dplyr::tribble(
                            ~param,       ~arg,
    "National Provider Identifier",        npi,
                   "Enrollment ID",        enroll_id,
                      "First Name",        first,
                       "Last Name",        last,
               "Organization Name",        organization,
           "Enrollment State Code",        state,
                 "Enrollment Type",        enrollment_type,
            "Enrollment Specialty",        specialty_description)

  response <- httr2::request(build_url("rdt", args)) |>
    httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                       ~y,
      "npi",                    npi,
      "enroll_id",              enroll_id,
      "first",                  first,
      "last",                   last,
      "organization",           organization,
      "state",                  state,
      "enrollment_type",        enrollment_type,
      "specialty_description",  specialty_description) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(dplyr::across(dplyr::contains("eligible"), yn_logical),
                    dplyr::across(dplyr::contains("date"), anytime::anydate),
                    dplyr::across(dplyr::contains("name"), toupper)) |>
      rdate_cols()

    if (na.rm) {
      results <- janitor::remove_empty(results, which = c("rows", "cols"))}
    }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
rdate_cols <- function(df) {

  cols <- c('npi' = 'national_provider_identifier',
            'enroll_id' = 'enrollment_id',
            'first' = 'first_name',
            'last' = 'last_name',
            'organization' = 'organization_name',
            'state' = 'enrollment_state_code',
            'enrollment_type' = 'provider_type_text',
            # 'specialty_description' = 'enrollment_specialty',
            # 'due_date' = 'revalidation_due_date',
            # 'due_date_adj' = 'adjusted_due_date',
            'reassignments_org' = 'individual_total_reassign_to',
            'reassignments_ind' = 'receiving_benefits_reassignment')

  df |> dplyr::select(dplyr::all_of(cols))

}
