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
#' @inheritParams provider_common_params
#' @param npi `<int>` National Provider Identifier
#' @param first,last `<chr>` Provider's name
#' @param specialty `<chr>` Provider's specialty
#' @param start_year `<int>` Opt-out effective date year
#' @param address,city,state,zip `<chr>` Provider's address, city, state, zip
#' @param order_refer `<lgl>` Indicates order and refer eligibility
#' @examplesIf httr2::is_online()
#' opt_out(count = TRUE)
#'
#' opt_out(state = "GA", specialty = contains("Psych"))
#'
#' @export
opt_out <- function(
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
  rlang::check_number_whole(
    start_year,
    allow_null = TRUE,
    min = 1998,
    max = this_year()
  )

  # TODO better implementation
  if (!is.null(start_year)) {
    start_year <- ends(start_year)
  }

  x <- cms(
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
    return(x)
  }

  if (!is.null(order_refer) && !order_refer) {
    collapse::gv(x, "order_refer") <- NA_character_
    return(x)
  }

  fn_order_refer <- rlang::as_function(~ order_refer(npi = .x))

  chain(x, fn_order_refer)
}
