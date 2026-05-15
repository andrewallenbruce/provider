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

  if (count || set) {
    return(x)
  }

  npis <- collapse::ss(x, collapse::whichv(x[["order_refer"]], 1L), c("npi"))
  npis <- collapse::funique(unlist_(npis))

  if (collapse::fnobs(npis) == 0L) {
    return(x)
  }

  blocks <- cheapr::seq_size(1L, collapse::fnobs(npis), 150L)

  if (blocks == 1L) {
    o <- order_refer(npi = npis)

    if (nrow(o) == 0L) {
      return(x)
    }

    return(join2(
      x,
      collapse::ss(o, j = c("npi", "ptb", "dme", "hha", "hospice")),
      on = "npi"
    ))
  }

  groups <- cheapr::rep_each_(cheapr::seq_(1L, blocks), 150L)[seq_along(npis)]
  npis <- vctrs::vec_split(npis, groups)$val

  o <- purrr::map(npis, \(x) order_refer(npi = x)) |>
    collapse::rowbind(return = 4L) |>
    collapse::ss(j = c("npi", "ptb", "dme", "hha", "hospice"))

  join2(x, o, on = "npi")
}
