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
#' @param memberships,members `<int>` Enrollment specialty
#' @param org_name `<chr>` Legal business name
#' @param org_pac `<chr>` PECOS Associate Control ID
#' @param org_enid `<chr>` Medicare Enrollment ID
#' @param org_state `<chr>` Enrollment state abbreviation
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' reassignments(count = TRUE)
#' reassignments(org_enid = starts("I"), members = greater(50, equal = TRUE))
#' @export
reassignments <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  last = NULL,
  state = NULL,
  specialty = NULL,
  memberships = NULL,
  members = NULL,
  org_name = NULL,
  org_pac = NULL,
  org_enid = NULL,
  org_state = NULL,
  count = FALSE
) {
  x <- end_cms(
    count = count,
    set = FALSE,
    `Individual NPI` = npi,
    `Individual PAC ID` = pac,
    `Individual Enrollment ID` = enid,
    `Individual First Name` = first,
    `Individual Last Name` = last,
    `Individual State Code` = state,
    `Individual Specialty Description` = specialty,
    `Individual Total Employer Associations` = memberships,
    `Group Legal Business Name` = org_name,
    `Group Reassignments and Physician Assistants` = members,
    `Group PAC ID` = org_pac,
    `Group Enrollment ID` = org_enid,
    `Group State Code` = org_state
  )

  x <- execute(x)

  polish(x)
}
