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
#' @param address `<chr>` Provider's address
#' @param city `<chr>` Provider's city
#' @param state `<chr>` Provider's state abbreviation
#' @param zip `<chr>` Provider's zip code
#' @param order_refer `<lgl>` Indicates order and refer eligibility
#' @param count `<lgl>` Return the dataset's total row count
#' @param set `<lgl>` Return the entire dataset
#' @return A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' opt_out(count = TRUE)
#' opt_out(npi = 1043522824)
#' opt_out(state = "AK")
#' opt_out(specialty = "Psychiatry", order_refer = FALSE)
#' @autoglobal
#' @export
opt_out <- function(
  npi = NULL,
  first = NULL,
  last = NULL,
  specialty = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  order_refer = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_bool_(order_refer)
  execute(
    base_cms(
      end = "opt_out",
      count = count,
      set = set,
      arg = param_cms(
        NPI = npi,
        `First Name` = first,
        `Last Name` = last,
        Specialty = specialty,
        `First Line Street Address` = address,
        `City Name` = city,
        `State Code` = state,
        `Zip code` = zip,
        `Eligible to Order and Refer` = bool_(order_refer)
      )
    )
  )
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
#' @param count `<lgl>` Return the dataset's total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' order_refer(count = TRUE)
#'
#' order_refer(npi = 1003026055)
#'
#' order_refer(first = "Jennifer", last = "Smith")
#'
#' order_refer(ptb = TRUE, dme = TRUE, hha = FALSE, pmd = TRUE, hospice = FALSE)
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
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_bool_(ptb)
  check_bool_(dme)
  check_bool_(hha)
  check_bool_(pmd)
  check_bool_(hospice)
  execute(
    base_cms(
      end = "order_refer",
      count = count,
      set = set,
      arg = param_cms(
        NPI = npi,
        FIRST_NAME = first,
        LAST_NAME = last,
        PARTB = bool_(ptb),
        DME = bool_(dme),
        HHA = bool_(hha),
        PMD = bool_(pmd),
        HOSPICE = bool_(hospice)
      )
    )
  )
}
