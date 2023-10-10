#' Reassignment of Benefits
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [reassignments()] returns information about:
#' + Individual providers who are reassigning benefits or are an employee of
#' + Organizational/Group providers who are receiving reassignment of benefits from or are the employer of the individual provider
#'
#' Links:
#' * [Medicare Revalidation Reassignment List API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi < *integer* > Individual provider's 10-digit National Provider Identifier
#' @param pac < *integer* > Individual provider's 10-digit PECOS Associate Control ID
#' @param enid < *character* > Individual provider's 15-digit Medicare Enrollment ID
#' @param first,last < *character* > Individual provider's name
#' @param state < *character* > Individual provider's enrollment state
#' @param specialty < *character* > Individual provider's enrollment specialty
#' @param organization < *character* > Organizational provider's legal business name
#' @param pac_org < *integer* > Organizational provider's 10-digit PECOS Associate Control ID
#' @param enid_org < *character* > Organizational provider's 15-digit Medicare Enrollment ID
#' @param state_org < *character* > Organizational provider's enrollment state
#' @param record < *character* > Identifies whether the record is for reassignment (`"R"`) or employment (`"E"`)
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' reassignments(enid = "I20200929003184")
#' reassignments(pac = 9830437441)
#' reassignments(pac_org = 3173525888)
#' @autoglobal
#' @export
reassignments <- function(npi = NULL,
                          pac = NULL,
                          enid = NULL,
                          first = NULL,
                          last = NULL,
                          state = NULL,
                          specialty = NULL,
                          organization = NULL,
                          pac_org = NULL,
                          enid_org = NULL,
                          state_org = NULL,
                          record = NULL,
                          tidy = TRUE,
                          na.rm = TRUE) {

  if (!is.null(npi))      {npi <- npi_check(npi)}
  if (!is.null(pac))      {pac <- pac_check(pac)}
  if (!is.null(pac_org))  {pac_org <- pac_check(pac_org)}
  if (!is.null(enid))     {enroll_check(enid)}
  if (!is.null(enid_org)) {enroll_check(enid_org)}

  if (!is.null(record)) {
    rlang::arg_match(record, c("E", "R"))
    dplyr::case_match(record,
                      "E" ~ "Physician Assistant",
                      "R" ~ "Reassignment")}

  args <- dplyr::tribble(
    ~param,                            ~arg,
    "Individual NPI",                   npi,
    "Individual PAC ID",                pac,
    "Individual Enrollment ID",         enid,
    "Individual First Name",            first,
    "Individual Last Name",             last,
    "Individual State Code",            state,
    "Individual Specialty Description", specialty,
    "Group Legal Business Name",        organization,
    "Group PAC ID",                     pac_org,
    "Group Enrollment ID",              enid_org,
    "Group State Code",                 state_org,
    "Record Type",                      record)

  response <- httr2::request(build_url("ras", args)) |>
    httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                       ~y,
      "npi",                    npi,
      "pac_id_ind",             pac,
      "enroll_id_ind",          enid,
      "first",                  first,
      "last",                   last,
      "state_ind",              state,
      "specialty_description",  specialty,
      "business_name",          organization,
      "pac_id_org",             pac_org,
      "enroll_id_org",          enid_org,
      "state_org",              state_org,
      "record",                 record) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(dplyr::across(dplyr::everything(), as.character),
                    dplyr::across(dplyr::contains("ass"), as.integer),
                    dplyr::across(dplyr::contains("name"), toupper)) |>
      cols_reas()

    if (na.rm) {
      results <- janitor::remove_empty(results, which = c("rows", "cols"))}
    }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_reas <- function(df) {

  cols <- c('npi' = 'individual_npi',
            'pac' = 'individual_pac_id',
            'enid' = 'individual_enrollment_id',
            'first' = 'individual_first_name',
            'last' = 'individual_last_name',
            'associations' = 'individual_total_employer_associations',
            'organization' = 'group_legal_business_name',
            'pac_org' = 'group_pac_id',
            'enid_org' = 'group_enrollment_id',
            'state_org' = 'group_state_code',
            'reassignments' = 'group_reassignments_and_physician_assistants',
            # 'state_ind' = 'individual_state_code',
            # 'specialty_description' = 'individual_specialty_description',
            # 'due_date_ind' = 'individual_due_date',
            # 'due_date_org' = 'group_due_date',
            'record' = 'record_type')

  df |> dplyr::select(dplyr::any_of(cols))

}
