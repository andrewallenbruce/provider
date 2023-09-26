#' Search the Medicare Revalidation Reassignment List API
#'
#' @description Reassignments of Providers who are due for Revalidation.
#'
#' @details The Revalidation Reassignment List dataset provides information on
#'    reassignments of providers who are due for revalidation.
#'
#' Links:
#' * [Medicare Revalidation Reassignment List API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi < *integer* > 10-digit national provider identifier of individual provider reassigning benefits or an employee
#' @param pac_ind < *integer* > 10-digit provider associate level variable of individual provider reassigning benefits or an employee
#' @param enroll_id_ind < *character* > 15-digit enrollment ID of individual provider reassigning benefits or an employee
#' @param first,last < *character* > First/last name of individual provider reassigning benefits or an employee
#' @param state_ind < *character* > Enrollment state of individual provider reassigning benefits or an employee
#' @param specialty_description < *character* > Enrollment specialty of individual provider reassigning benefits or an employee
#' @param organization < *character* > Legal business name of organizational provider receiving reassignment or is the employer
#' @param pac_org < *integer* > 10-digit provider associate level variable of organizational provider receiving reassignment or is the employer
#' @param enroll_id_org Enrollment ID of organizational provider receiving reassignment or is the employer
#' @param state_org < *character* > Enrollment state of organizational provider receiving reassignment or is the employer
#' @param record_type < *character* > Identifies whether the record is for a reassignment
#'    (`"Reassignment"`) or employment (`"Physician Assistant"`)
#' @param tidy < *boolean* > Tidy output; default is `TRUE`.
#' @param na.rm < *boolean* > Remove empty rows and columns; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' revalidation_reassign(enroll_id_ind = "I20200929003184")
#' revalidation_reassign(pac_ind = 9830437441)
#' revalidation_reassign(pac_org = 3173525888)
#' @autoglobal
#' @export
revalidation_reassign <- function(npi = NULL,
                                  pac_ind = NULL,
                                  enroll_id_ind = NULL,
                                  first = NULL,
                                  last = NULL,
                                  state_ind = NULL,
                                  specialty_description = NULL,
                                  organization = NULL,
                                  pac_org = NULL,
                                  enroll_id_org = NULL,
                                  state_org = NULL,
                                  record_type = NULL,
                                  tidy = TRUE,
                                  na.rm = TRUE) {

  if (!is.null(npi)) {npi <- npi_check(npi)}
  if (!is.null(pac_ind)) {pac_ind <- pac_check(pac_ind)}
  if (!is.null(pac_org)) {pac_org <- pac_check(pac_org)}

  if (!is.null(enroll_id_ind)) {
    enroll_check(enroll_id_ind)
    enroll_ind_check(enroll_id_ind)}

  # if (!is.null(enroll_id_org)) {
  #   enroll_check(enroll_id_org)
  #   enroll_org_check(enroll_id_org)}

  if (!is.null(record_type)) {
    rlang::arg_match(record_type, c("Physician Assistant", "Reassignment"))}

  args <- dplyr::tribble(
    ~param,                            ~arg,
    "Individual NPI",                   npi,
    "Individual PAC ID",                pac_ind,
    "Individual Enrollment ID",         enroll_id_ind,
    "Individual First Name",            first,
    "Individual Last Name",             last,
    "Individual State Code",            state_ind,
    "Individual Specialty Description", specialty_description,
    "Group PAC ID",                     pac_org,
    "Group Enrollment ID",              enroll_id_org,
    "Group Legal Business Name",        organization,
    "Group State Code",                 state_org,
    "Record Type",                      record_type)

  response <- httr2::request(build_url("ras", args)) |>
    httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                       ~y,
      "npi",                    npi,
      "pac_id_ind",             pac_ind,
      "enroll_id_ind",          enroll_id_ind,
      "first",                  first,
      "last",                   last,
      "state_ind",              state_ind,
      "specialty_description",  specialty_description,
      "pac_id_org",             pac_org,
      "enroll_id_org",          enroll_id_org,
      "state_org",              state_org,
      "business_name",          organization,
      "record_type",            record_type) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(dplyr::across(dplyr::everything(), as.character),
                    dplyr::across(dplyr::contains("ass"), as.integer),
                    dplyr::across(dplyr::contains("date"), anytime::anydate),
                    dplyr::across(dplyr::contains("name"), toupper)) |>
      rass_cols()

    if (na.rm) {
      results <- janitor::remove_empty(results, which = c("rows", "cols"))}

    }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
rass_cols <- function(df) {

  cols <- c('npi' = 'individual_npi',
            'pac_ind' = 'individual_pac_id',
            'enroll_id_ind' = 'individual_enrollment_id',
            'first' = 'individual_first_name',
            'last' = 'individual_last_name',
            'state_ind' = 'individual_state_code',
            'specialty_description' = 'individual_specialty_description',
            'reassignments_ind' = 'individual_total_employer_associations',
            'organization' = 'group_legal_business_name',
            'pac_org' = 'group_pac_id',
            'enroll_id_org' = 'group_enrollment_id',
            'state_org' = 'group_state_code',
            'reassignments_org' = 'group_reassignments_and_physician_assistants',
            'record_type',
            'due_date_ind' = 'individual_due_date',
            'due_date_org' = 'group_due_date')

  df |> dplyr::select(dplyr::all_of(cols))

}
