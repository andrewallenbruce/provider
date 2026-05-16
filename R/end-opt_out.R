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
#'
#' opt_out(npi = 1043522824) |> str()
#'
#' opt_out(state = "GA", specialty = contains("Psych"))
#'
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
  check_bool_(order_refer)

  x <- cms(
    count = count,
    set = set,
    NPI = npi,
    `First Name` = first,
    `Last Name` = last,
    Specialty = specialty,
    `First Line Street Address` = address,
    `City Name` = city,
    `State Code` = state,
    `Zip code` = zip,
    `Eligible to Order and Refer` = convert_bool(order_refer)
  )

  x <- execute(x)
  x <- polish(x)

  if (count) {
    return(invisible(x))
  }

  if (set) {
    return(x)
  }

  NPI <- collapse::ss(x, x[["order_refer"]] %==% 1L, c("npi")) |>
    unlist_() |>
    collapse::funique()

  if (collapse::fnobs(NPI) == 0L) {
    return(x)
  }

  BLOCK <- cheapr::seq_size(1L, collapse::fnobs(NPI), 150L)

  if (BLOCK == 1L) {
    y <- order_refer(npi = NPI)

    if (collapse::fnrow(y) == 0L) {
      return(x)
    }
    x <- join2(x, collapse::ss(y, j = 3:8), on = "npi")
    return(pivot_order_refer(x))
  }

  GRP <- cheapr::rep_each_(cheapr::seq_(1L, BLOCK), 150L)[seq_along(NPI)]
  NPI <- vctrs::vec_split(NPI, GRP)$val

  y <- purrr::map(NPI, \(x) order_refer(npi = x)) |>
    rowbind2(nm = NULL)

  if (collapse::fnrow(y) == 0L) {
    return(x)
  }
  x <- join2(x, collapse::ss(y, j = 3:8), on = "npi")
  pivot_order_refer(x)
}
