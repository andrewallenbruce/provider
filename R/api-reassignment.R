#' Reassignment of Benefits
#'
#' @description
#' Returns information about:
#'    * Individual providers who are reassigning benefits or are an employee of
#'    * Organizational/Group providers who are receiving reassignment of benefits from or are the employer of the individual provider
#'
#' It provides information regarding the physician and the group practice they
#' reassign their billing to, including individual employer association counts.
#'
#' @references
#'    - [API: Medicare Revalidation Reassignment List](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)
#'
#' @param npi `<int>` National Provider Identifier
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid `<chr>` Medicare Enrollment ID
#' @param first,last `<chr>` Provider's name
#' @param state `<chr>` Enrollment state abbreviation
#' @param specialty `<chr>` Enrollment specialty
#' @param employers,employees `<int>` Enrollment specialty
#' @param org_name `<chr>` Legal business name
#' @param org_pac `<chr>` PECOS Associate Control ID
#' @param org_enid `<chr>` Medicare Enrollment ID
#' @param org_state `<chr>` Enrollment state abbreviation
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' reassignments(count = TRUE)
#'
#' reassignments(
#'   count = TRUE,
#'   employers = greater(50, equal = TRUE))
#'
#' reassignments(org_enid = "I20070209000135")
#'
#' reassignments(pac = 9830437441)
#'
#' reassignments(org_pac = 3173525888)
#'
#' @autoglobal
#' @export
reassignments <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  last = NULL,
  state = NULL,
  specialty = NULL,
  employers = NULL,
  employees = NULL,
  org_name = NULL,
  org_pac = NULL,
  org_enid = NULL,
  org_state = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  execute(
    base_cms(
      end = "reassignments",
      count = count,
      set = set,
      arg = param_cms(
        `Individual NPI` = npi,
        `Individual PAC ID` = pac,
        `Individual Enrollment ID` = enid,
        `Individual First Name` = first,
        `Individual Last Name` = last,
        `Individual State Code` = state,
        `Individual Specialty Description` = specialty,
        `Individual Total Employer Associations` = employers,
        `Group Legal Business Name` = org_name,
        `Group Reassignments and Physician Assistants` = employees,
        `Group PAC ID` = org_pac,
        `Group Enrollment ID` = org_enid,
        `Group State Code` = org_state
      )
    )
  )
}
