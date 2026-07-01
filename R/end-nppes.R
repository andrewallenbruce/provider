#' NPPES: National Registry of Health Care Providers
#'
#' @description Search the National Plan and Provider Enumeration System (NPPES)
#' NPI Registry, a free directory of all active NPI records.
#'
#' @section National Provider Identifier (NPI): Healthcare providers acquire
#'   their unique 10-digit NPIs to identify themselves in a standard way
#'   throughout their industry. Once CMS supplies an NPI, they publish the parts
#'   of the NPI record that have public relevance, including the provider’s
#'   name, taxonomy and practice address.
#'
#'   #### Entity Type: Two categories of health care providers exist for NPI
#'   enumeration purposes:
#'
#'    * __Type 1__: **Individual** providers may get an NPI as _Entity Type 1_.
#'
#'   _Sole Proprietorship_ A sole proprietor is one who does not conduct
#'   business as a corporation and, thus, __is not__ an incorporated individual.
#'
#'   An __incorporated individual__ is an individual provider who forms and
#'   conducts business under a corporation. This provider may have a Type 1 NPI
#'   while the corporation has its own Type 2 NPI.
#'
#'   A solo practitioner is not necessarily a sole proprietor, and vice-versa.
#'   The following factors do not affect whether a sole proprietor is a Type 1
#'   entity:
#'
#'   - Multiple office locations
#'   - Having employees
#'   - Having an EIN
#'
#'   * __Type 2__: **Organizational** providers are eligible for an _Entity Type 2_ NPI.
#'
#'   Organizational or Group providers may have a single employee or thousands
#'   of employees. An example is an __incorporated individual__ who is an
#'   organization's only employee.
#'
#'   Some organization health care providers are made up of parts that work
#'   somewhat independently from their parent organization. These parts may
#'   offer different types of health care or offer health care in separate
#'   physical locations. These parts and their physical locations aren't
#'   themselves legal entities but are part of the organization health care
#'   provider (which is a legal entity).
#'
#'   The NPI Final Rule refers to the parts and locations as sub-parts. An
#'   organization health care provider can get its sub-parts their own NPIs. If
#'   a sub-part conducts any HIPAA standard transactions on its own (separately
#'   from its parent), it must get its own NPI. Sub-part determination makes
#'   sure that entities within a covered organization are uniquely identified in
#'   HIPAA standard transactions they conduct with Medicare and other covered
#'   entities.
#'
#'   For example, a hospital offers acute care, laboratory, pharmacy, and
#'   rehabilitation services. Each of these sub-parts may need its own NPI
#'   because each sends its own standard transactions to one or more health
#'   plans. Sub-part delegation doesn't affect Entity Type 1 health care
#'   providers. As individuals, these health care providers can't choose
#'   sub-parts and are not sub-parts.
#'
#'   **Authorized Official**: An appointed official (e.g., chief executive officer,
#'   chief financial officer, general partner, chairman of the board, or direct
#'   owner) to whom the organization has granted the legal authority to enroll
#'   it in the Medicare program, to make changes or updates to the
#'   organization's status in the Medicare program, and to commit the
#'   organization to fully abide by the statutes, regulations, and program
#'   instructions of the Medicare program.
#'
#' @source
#'    - [NPPES NPI Registry API](https://npiregistry.cms.hhs.gov/api-page)
#'
#' @param npi `<int>` vector of National Provider Identifiers
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' x = c(
#'   1003826272, 1013647569, 1023473279, 1083295638, 1174270805,
#'   1225701881, 1235702796, 1255782751, 1255877502, 1275117269,
#'   1306500665, 1548743511, 1588817837, 1689182859, 1841008505,
#'   1841967825, 1851713903, 1861857013, 1891355863, 1891390084,
#'   1962116806, 1982059275, 1982296737, 1992338701
#' )
#'
#' nppes(x)
#'
#' nppes(npi = order_refer(first = "Jennifer", last = "Smith")$npi)
#'
#' nppes(uq(providers(pac = uq(clinicians(first = "Etan")$org_pac))$npi))
#'
#' @export
nppes <- function(npi) {
  check_numeric(npi)
  npi <- uq(npi)

  inform_search_nppes(npi)

  x <- purrr::map(npi, \(N) {
    httr2::request("https://npiregistry.cms.hhs.gov/api") |>
      httr2::req_url_query(version = "2.1", number = N)
  })

  x <- httr2::req_perform_parallel(x, on_error = "continue") |>
    purrr::map(\(x) parse_string(x, query = "results")) |>
    collapse::rowbind() |>
    add_class("nppes")

  inform_count_nppes(x)

  polish(x)
}

#' @noRd
inform_search_nppes <- function(x) {
  N <- length(x)
  E <- "nppes"

  msg <- cli::format_inline(
    "{.strong {E}} searching ",
    "{.strong {cli::col_yellow(mark(N))}} ",
    "{cli::qty(N)}NPI{?s}"
  )

  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg = msg)
    withr::defer_parent(cli::cli_progress_cleanup(), priority = "last")
  } else {
    cli::cli_alert_success(text = msg)
  }
}

#' @noRd
inform_count_nppes <- function(x) {
  N <- length(x[["number"]])
  E <- "nppes"

  msg <- cli::format_inline(
    "{.strong {E}} returned ",
    "{.strong {cli::col_yellow(mark(N))}} ",
    "{cli::qty(N)}result{?s}"
  )

  if (rlang::is_interactive()) {
    cli::cli_progress_step(msg = msg)
    withr::defer_parent(cli::cli_progress_cleanup(), priority = "last")
  } else {
    cli::cli_alert_success(text = msg)
  }
}
