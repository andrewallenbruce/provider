#' Reassignment of Benefits
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [reassignments()] returns information about:
#' + Individual providers who are reassigning benefits or are an employee of
#' + Organizational/Group providers who are receiving reassignment of benefits
#' from or are the employer of the individual provider
#'
#' It provides information regarding the physician and the group practice they
#' reassign their billing to, including individual employer association counts.
#'
#' @section Links:
#' + [Medicare Revalidation Reassignment List API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi < *integer* > __Individual__ 10-digit National Provider Identifier
#' @param pac < *integer* > __Individual__ 10-digit PECOS Associate Control ID
#' @param enid < *character* > __Individual__ 15-digit Medicare Enrollment ID
#' @param first,last < *character* > __Individual__ Provider's name
#' @param state < *character* > __Individual__ Enrollment state abbreviation
#' @param specialty < *character* > __Individual__ Enrollment specialty
#' @param organization < *character* > __Organizational__ Legal business name
#' @param pac_org < *integer* > __Organizational__ 10-digit PECOS Associate Control ID
#' @param enid_org < *character* > __Organizational__ 15-digit Medicare Enrollment ID
#' @param state_org < *character* > __Organizational__ Enrollment state abbreviation
#' @param entry < *character* > Entry type, reassignment (`"R"`) or employment (`"E"`)
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**       |**Description**                                                    |
#' |:---------------|:------------------------------------------------------------------|
#' |`npi`           |_Individual_ National Provider Identifier                          |
#' |`pac`           |_Individual_ PECOS Associate Control ID                            |
#' |`enid`          |_Individual_ Medicare Enrollment ID                                |
#' |`first`         |_Individual_ Provider's First Name                                 |
#' |`last`          |_Individual_ Provider's Last Name                                  |
#' |`associations`  |Number of Organizations _Individual_ Reassigns Benefits To         |
#' |`pac_org`       |_Organization's_ PECOS Associate Control ID                        |
#' |`enid_org`      |_Organization's_ Medicare Enrollment ID                            |
#' |`state_org`     |State _Organization_ Enrolled in Medicare                          |
#' |`reassignments` |Number of Individuals the _Organization_ Accepts Reassignment From |
#' |`entry`         |Whether Entry is for _Reassignment_ or _Employment_                |
#'
#' @examplesIf interactive()
#' reassignments(enid = "I20200929003184")
#'
#' reassignments(pac = 9830437441)
#'
#' reassignments(pac_org = 3173525888)
#'
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
                          entry = NULL,
                          tidy = TRUE,
                          na.rm = TRUE) {

  npi      <- npi %nn% validate_npi(npi)
  pac      <- pac %nn% check_pac(pac)
  pac_org  <- pac_org %nn% check_pac(pac_org)
  enid     <- enid %nn% check_enid(enid)
  enid_org <- enid_org %nn% check_enid(enid_org)

  if (!is.null(entry)) {
    entry <- rlang::arg_match(entry, c("E", "R"))
    entry <- dplyr::case_match(entry, "E" ~ "Physician Assistant",
                                      "R" ~ "Reassignment")
    }

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
    "Record Type",                      entry)

  response <- httr2::request(build_url("ras", args)) |>
    httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

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
      "entry",                  entry) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy)  {
    results <- tidyup(results,
                      int = 'ass',
                      up  = 'name') |>
      dplyr::mutate(individual_state_code = fct_stabb(individual_state_code),
                    group_state_code      = fct_stabb(group_state_code),
                    record_type           = fct_record(record_type)) |>
      cols_reas()

  if (na.rm) results <- narm(results)
    }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_reas <- function(df) {

  cols <- c('npi'                     = 'individual_npi',
            'pac'                     = 'individual_pac_id',
            'enid'                    = 'individual_enrollment_id',
            # 'state_ind'             = 'individual_state_code',
            # 'specialty_description' = 'individual_specialty_description',
            'first'                   = 'individual_first_name',
            'last'                    = 'individual_last_name',
            'associations'            = 'individual_total_employer_associations',
            'organization'            = 'group_legal_business_name',
            'pac_org'                 = 'group_pac_id',
            'enid_org'                = 'group_enrollment_id',
            'state_org'               = 'group_state_code',
            'reassignments'           = 'group_reassignments_and_physician_assistants',
            # 'due_date_ind'          = 'individual_due_date',
            # 'due_date_org'          = 'group_due_date',
            'entry'                   = 'record_type')

  df |> dplyr::select(dplyr::any_of(cols))
}

#' @param x vector
#' @autoglobal
#' @noRd
fct_record <- function(x) {
  factor(x,
         levels = c("Physician Assistant", "Reassignment"),
         labels = c("Employment", "Reassignment"))
}

#' @autoglobal
#' @noRd
# nocov start
georgia_reassignments <- function() {
  pins::board_url(github_raw("andrewallenbruce/provider/main/pkgdown/assets/pins-board/")) |>
    pins::pin_read("georgia_reassignments")
}
# nocov end
