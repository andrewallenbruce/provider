#' Providers Opted Out of Medicare
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' `opt_out()` allows the user to access information on providers who have
#' decided not to participate in Medicare.
#'
#' @references
#' + [Medicare Opt Out Affidavits API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
#'
#' @section Opting Out:
#'
#' Providers who do not wish to enroll in the Medicare program may “opt-out”,
#' meaning neither they nor the beneficiary can bill Medicare for services rendered.
#'
#' Instead, a private contract between provider and beneficiary is signed,
#' neither party is reimbursed by Medicare and the beneficiary pays
#' the provider out-of-pocket.
#'
#' To opt out, a provider must:
#'
#' + Be of an *eligible specialty* type
#' + Submit an *opt-out affidavit* to Medicare
#' + Enter into a *private contract* with their Medicare patients, reflecting
#'   the agreement that they will pay out-of-pocket and that no one will submit
#'   the bill to Medicare for reimbursement
#'
#' @section Opt-Out Periods:
#'
#' Opt-out periods last for two years and cannot be terminated early unless the
#' provider is opting out for the very first time and terminates the opt-out no
#' later than 90 days after the opt-out period's effective date.
#'
#' Opt-out statuses are also effective for two years and automatically renew.
#' Providers that do not want to extend their opt-out status at the end of an
#' opt-out period may cancel by notifying all MACs an affidavit was filed at
#' least 30 days prior to the start of the next opt-out period.
#'
#' If a provider retires, surrenders their license, or no longer wants to
#' participate in the Medicare program, they must officially withdraw within 90
#' days. DMEPOS suppliers must withdraw within 30 days.
#'
#' Providers may *NOT* opt-out if they intend to be a Medicare Advantage
#' (Part C) provider or furnish services covered by traditional Medicare
#' fee-for-service (Part B).
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi < `integer` > 10-digit Opt-out National Provider Identifier
#' @param first,last < `character` > Opt-out provider's name
#' @param specialty < `character` > Opt-out provider's specialty
#' @param address < `character` > Opt-out provider's address
#' @param city < `character` > Opt-out provider's city
#' @param state < `character` > Opt-out provider's state abbreviation
#' @param zip < `character` > Opt-out provider's zip code
#' @param order_refer < `boolean` > Indicates order and refer eligibility
#' @param tidy < `boolean` > // __default:__ `TRUE` Tidy output
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**           |**Description**                               |
#' |:-------------------|:---------------------------------------------|
#' |`npi`               |10-digit NPI                                  |
#' |`first`             |Opt-out provider's first name                 |
#' |`last`              |Opt-out provider's last name                  |
#' |`specialty`         |Opt-out provider's specialty                  |
#' |`order_refer`       |Indicates if the provider can order and refer |
#' |`optout_start_date` |Date that provider's Opt-Out period begins    |
#' |`optout_end_date`   |Date that provider's Opt-Out period ends      |
#' |`last_updated`      |Date information was last updated             |
#' |`address`           |Opt-out provider's street address             |
#' |`city`              |Opt-out provider's city                       |
#' |`state`             |Opt-out provider's state                      |
#' |`zip`               |Opt-out provider's zip code                   |
#'
#' @examplesIf  interactive()
#' opt_out(npi = 1043522824)
#'
#' # For opt-out providers eligible
#' # to order and refer, use [order_refer()]
#' # to look up their eligibility status:
#'
#' opt_out(npi = 1043522824) |>
#'         pull(npi) |>
#'         map(\(x) order_refer(npi = x)) |>
#'         list_rbind()
#' @autoglobal
#' @export
opt_out <- function(npi = NULL,
                    first = NULL,
                    last = NULL,
                    specialty = NULL,
                    address = NULL,
                    city = NULL,
                    state = NULL,
                    zip = NULL,
                    order_refer = NULL,
                    tidy = TRUE) {

  npi         <- npi %nn% validate_npi(npi)
  order_refer <- order_refer %nn% tf_2_yn(order_refer)
  zip         <- zip %nn% as.character(zip)

  args <- dplyr::tribble(
    ~param,                         ~arg,
    "NPI",                           npi,
    "First Name",                    first,
    "Last Name",                     last,
    "Specialty",                     specialty,
    "First Line Street Address",     address,
    "City Name",                     city,
    "State Code",                    state,
    "Zip code",                      zip,
    "Eligible to Order and Refer",   order_refer)

  response <- httr2::request(build_url("opt", args)) |>
    httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "first",         first,
      "last",          last,
      "specialty",     specialty,
      "address",       address,
      "city",          city,
      "state",         state,
      "zip",           zip,
      "order_refer",   order_refer) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))

  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results,
                      dtype = 'mdy',
                      yn = 'eligible',
                      chr = 'npi') |>
      combine(address, c('first_line_street_address',
                         'second_line_street_address')) |>
      dplyr::mutate(state_code = fct_stabb(state_code)) |>
      cols_opt()
    }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_opt <- function(df) {

  cols <- c('npi',
            'first'             = 'first_name',
            'last'              = 'last_name',
            'specialty',
            'order_refer'       = 'eligible_to_order_and_refer',
            'optout_start_date' = 'optout_effective_date',
            'optout_end_date',
            'last_updated',
            'address',
            'city'              = 'city_name',
            'state'             = 'state_code',
            'zip'               = 'zip_code')

  df |> dplyr::select(dplyr::any_of(cols))
}
