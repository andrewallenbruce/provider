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
#' @return A [tibble][tibble::tibble-package]
#' @examples
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
  count = FALSE
) {
  args <- params(
    NPI = npi,
    `First Name` = first,
    `Last Name` = last,
    Specialty = specialty,
    `First Line Street Address` = address,
    `City Name` = city,
    `State Code` = state,
    `Zip code` = zip,
    `Eligible to Order and Refer` = convert_lgl(order_refer)
  )

  .c(BASE, LIMIT, NM) %=% constants("opt_out")

  # Return Total Rows =====================
  if (count) {
    cli_results(request_rows(paste0(BASE, "/stats?")))
    return(invisible(NULL))
  }

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(args)) {
    cli_no_query()

    url <- url_(paste0(BASE, "?"), opts(size = 10))

    res <- request_bare(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_(NM)

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
      rename_(NM)

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
    rename_(NM)
}
