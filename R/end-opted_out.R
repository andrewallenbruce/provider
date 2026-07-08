#' Opt-Out Providers
#'
#' @description
#' Information on providers who have decided not to participate in Medicare.
#'
#' @references
#'    * [Medicare Opt Out Affidavits API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
#'
#' @section Opting Out:
#' Providers who do not wish to enroll in the Medicare program may "opt-out",
#' meaning neither they nor the beneficiary can bill Medicare for services rendered.
#'
#' Instead, a private contract between provider and beneficiary is signed,
#' neither party is reimbursed by Medicare and the beneficiary pays
#' the provider out-of-pocket.
#'
#' To opt out, a provider must:
#'    * Be of an __eligible specialty__ type
#'    * Submit an __opt-out affidavit__ to Medicare
#'    * Enter into a __private contract__ with their Medicare patients
#'
#' @section Opt-Out Periods:
#' Opt-out periods last for two years and cannot be terminated early unless the
#' provider is opting out for the very first time and terminates the opt-out no
#' later than 90 days after the opt-out period's effective date. Opt-out
#' statuses are effective for two years and automatically renew.
#'
#' Providers may __NOT__ opt-out if they intend to be a Medicare Advantage
#' (Part C) provider or furnish services covered by traditional Medicare
#' fee-for-service (Part B).
#'
#' @param npi `<int>` National Provider Identifier
#' @param first,last `<chr>` Provider's name
#' @param specialty `<chr>` Provider's specialty
#' @param start_year `<int>` Opt-out effective date year
#' @param address,city,state,zip `<chr>` Provider's address, city, state, zip
#' @param order_refer `<lgl>` Indicates order and refer eligibility
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' opted_out(count = TRUE)
#'
#' opted_out(state = "GA", specialty = contains("Psych"))
#'
#' @export
opted_out <- function(
  npi = NULL,
  first = NULL,
  last = NULL,
  specialty = NULL,
  start_year = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  order_refer = NULL,
  count = FALSE
) {
  check_bool_(order_refer)
  check_numeric(start_year)

  # TODO better implementation
  if (!is.null(start_year)) {
    start_year <- ends(start_year)
  }

  x <- end_cms(
    count = count,
    set = FALSE,
    NPI = npi,
    `First Name` = first,
    `Last Name` = last,
    Specialty = specialty,
    `Optout Effective Date` = start_year,
    `First Line Street Address` = address,
    `City Name` = city,
    `State Code` = state,
    `Zip code` = zip,
    `Eligible to Order and Refer` = tag_bool(order_refer)
  )

  x <- execute(x)
  x <- polish(x)

  if (count) {
    return(invisible(x))
  }

  if (!is.null(order_refer) && !order_refer) {
    collapse::gv(x, "order_refer") <- NA_character_
    return(x)
  }

  x <- as_keyframe(x, "npi", 150L)

  chain(x, KeyChain$order_refer)
}

#' Order and Refer Eligibility
#'
#' @description
#' Eligibility to order and refer within Medicare
#'
#' @section Criteria:
#'    - *Individual* NPI
#'    - Medicare enrollment with *Approved* or *Opt-Out* status
#'    - Eligible *specialty* type
#'
#' @section Types:
#'    - *Ordering*: can order non-physician services for patients.
#'    - *Referring/Certifying*: can request items/services Medicare may reimburse.
#'    - *Opt-Out*: can enroll solely to order and refer.
#'
#' @section Services:
#'    - *Medicare Part B*: Clinical Labs, Imaging
#'    - *Medicare Part A*: Home Health
#'    - *DMEPOS*: Durable medical equipment, prosthetics, orthotics, & supplies
#'
#' @references
#'    - [API: Medicare Order and Referring](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)
#'    - [CMS: Ordering & Certifying](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/chain-ownership-system-pecos/ordering-certifying)
#'
#' @param npi `<int>` National Provider Identifier
#' @param first,last `<chr>` Individual provider's first/last name
#' @param ptb,dme,hha,pmd,hospice `<lgl>` Eligibility for:
#'    - `ptb`: Medicare Part B
#'    - `dme`: Durable Medical Equipment
#'    - `hha`: Home Health Agency
#'    - `pmd`: Power Mobility Devices
#'    - `hospice`: Hospice
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' order_refer(count = TRUE)
#'
#' order_refer(first = "Jennifer", last = "Smith")
#'
#' @export
order_refer <- function(
  npi = NULL,
  first = NULL,
  last = NULL,
  ptb = NULL,
  dme = NULL,
  hha = NULL,
  pmd = NULL,
  hospice = NULL,
  count = FALSE
) {
  check_bool_(ptb)
  check_bool_(dme)
  check_bool_(hha)
  check_bool_(pmd)
  check_bool_(hospice)

  x <- end_cms(
    count = count,
    set = FALSE,
    NPI = npi,
    FIRST_NAME = first,
    LAST_NAME = last,
    PARTB = tag_bool(ptb),
    DME = tag_bool(dme),
    HHA = tag_bool(hha),
    PMD = tag_bool(pmd),
    HOSPICE = tag_bool(hospice)
  )

  x <- execute(x)

  polish(x)
}
