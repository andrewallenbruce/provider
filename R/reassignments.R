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
#'    * [Medicare Revalidation Reassignment List API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)
#'
#' @param npi `<chr>` 10-digit National Provider Identifier
#' @param pac `<chr>` 10-digit PECOS Associate Control ID
#' @param enid `<chr>` 15-digit Medicare Enrollment ID
#' @param first,last `<chr>` Provider's name
#' @param state `<chr>` Enrollment state abbreviation
#' @param specialty `<chr>` Enrollment specialty
#' @param org_name `<chr>` Legal business name
#' @param org_pac `<chr>` 10-digit PECOS Associate Control ID
#' @param org_enid `<chr>` 15-digit Medicare Enrollment ID
#' @param org_state `<chr>` Enrollment state abbreviation
#'
#' @returns A [tibble][tibble::tibble-package] with the columns:
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
#' @examples
#' reassignments()
#'
#' reassignments(enid = "I20200929003184")
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
  org_name = NULL,
  org_pac = NULL,
  org_enid = NULL,
  org_state = NULL
) {

  args <- params(
    `Individual NPI` = npi,
    `Individual PAC ID` = pac,
    `Individual Enrollment ID` = enid,
    `Individual First Name` = first,
    `Individual Last Name` = last,
    `Individual State Code` = state,
    `Individual Specialty Description` = specialty,
    `Group Legal Business Name` = org_name,
    `Group PAC ID` = org_pac,
    `Group Enrollment ID` = org_enid,
    `Group State Code` = org_state
  )

  BASE <- base_url("reassignments")
  LIMIT <- limit("reassignments")

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(args)) {
    cli_no_query()

    url <- url_(paste0(BASE, "?"), opts(size = 10))

    res <- request_bare(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_reassignments()

    return(res)
  }

  # Valid Query: Flatten & Request Result Count =====================

  url <- url_(
    paste0(BASE, "/stats?"),
    opts(size = LIMIT),
    query2(args)
  )

  N <- request_rows(url)

  # Query Returned Nothing: Alert & Exit =====================
  if (N == 0L) {
    cli_no_results()
    return(invisible(NULL))
  }

  # Count is Within API Limit: Request & Return Results
  if (N <= LIMIT) {
    cli_results(N)

    url <- url_(
      paste0(BASE, "?"),
      opts(size = LIMIT),
      query2(args)
    )

    res <- request_bare(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_reassignments()

    return(res)
  }

  # Count Above API Limit: Alert & Return Results =====================
  cli_pages(N, offset(N, LIMIT))

  url <- url_(
    paste0(BASE, "?"),
    opts(size = LIMIT, offset = "<<i>>"),
    query2(args)
  )

  urls <- offset(N, LIMIT, "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = url, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })

  parallel_request(urls) |>
    fastplyr::as_tbl() |>
    map_na_if() |>
    rename_reassignments()
}

#' @autoglobal
#' @noRd
rename_reassignments <- function(x) {
  NM <- c(
    `Individual NPI` = "npi",
    `Individual PAC ID` = "pac",
    `Individual Enrollment ID` = "enid",
    `Individual First Name` = "first",
    `Individual Last Name` = "last",
    `Individual State Code` = "state",
    `Individual Specialty Description` = "specialty",
    `Group Reassignments and Physician Assistants` = "reassignments",
    `Group Legal Business Name` = "org_name",
    `Group PAC ID` = "org_pac",
    `Group Enrollment ID` = "org_enid",
    `Group State Code` = "org_state",
    `Individual Total Employer Associations` = "associations",
    `Record Type` = "type"
  )

  collapse::setrename(x, NM, .nse = FALSE)

  collapse::gv(x, unlist_(NM))
}
