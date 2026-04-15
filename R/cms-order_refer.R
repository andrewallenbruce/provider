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
#' @param part_b,dme,hha,pmd,hospice `<lgl>` Eligibility for:
#'    - `part_b`: Medicare Part B
#'    - `dme`: Durable Medical Equipment
#'    - `hha`: Home Health Agency
#'    - `pmd`: Power Mobility Devices
#'    - `hospice`: Hospice
#' @param count `<lgl>` Return the dataset's total row count
#' @param set `<lgl>` Return the entire dataset
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' order_refer(count = TRUE)
#' order_refer(npi = 1003026055)
#' order_refer(first = "Jennifer", last = "Smith")
#' order_refer(
#'   part_b = TRUE,
#'   dme = TRUE,
#'   hha = FALSE,
#'   pmd = TRUE,
#'   hospice = FALSE)
#' @autoglobal
#' @export
order_refer <- function(
  npi = NULL,
  first = NULL,
  last = NULL,
  part_b = NULL,
  dme = NULL,
  hha = NULL,
  pmd = NULL,
  hospice = NULL,
  count = FALSE,
  set = FALSE
) {
  check_bool(part_b, allow_null = TRUE)
  check_bool(dme, allow_null = TRUE)
  check_bool(hha, allow_null = TRUE)
  check_bool(pmd, allow_null = TRUE)
  check_bool(hospice, allow_null = TRUE)

  exec_cms(
    END = call_name(call_match()),
    COUNT = count,
    SET = set,
    ARG = param_cms(
      NPI = npi,
      FIRST_NAME = first,
      LAST_NAME = last,
      PARTB = bool_(part_b),
      DME = bool_(dme),
      HHA = bool_(hha),
      PMD = bool_(pmd),
      HOSPICE = bool_(hospice)
    )
  )
}
