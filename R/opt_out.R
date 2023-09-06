#' Providers That Have Opted Out of Medicare
#'
#' @description
#' `opt_out()` allows you to search for information on providers who have
#' decided not to participate in Medicare.
#'
#' ## Opting Out
#' Providers who do not wish to enroll in the Medicare program may “opt-out” of Medicare. This means that neither the physician,
#' nor the beneficiary submits the bill to Medicare for services rendered.
#' Instead, the beneficiary pays the physician out-of-pocket and neither party
#' is reimbursed by Medicare. A private contract is signed between the physician
#' and the beneficiary that states that neither one can receive payment from
#' Medicare for the services that were performed.
#'
#' To opt out, a provider must:
#'
#'   - Be of an *eligible specialty* type
#'   - Submit an *opt-out affidavit* to Medicare
#'   - Enter into a *private contract* with their Medicare patients, reflecting
#'   the agreement that they will pay out-of-pocket for services, and that no
#'   one will submit the bill to Medicare for reimbursement
#'   - Contact their Medicare Administrative Contractor (MAC) for
#'   *instruction on information* that should be included in their opt-out
#'   affidavit and private contract
#'
#' ## Opt-Out Periods
#' Opt-out periods last for two years and cannot be terminated early unless the
#' provider is opting out for the very first time and terminates the opt-out no
#' later than 90 days after the opt-out period's effective date.
#'
#' Opt-out statuses are effective for two years and automatically renew every
#' two years. Providers that do not want to extend their opt-out status at the
#' end of an opt-out period may cancel by notifying all Medicare contractors an
#' affidavit was filed with at least 30 days prior to the start of the next
#' opt-out period.
#'
#' If a provider retires, surrenders their license, or no longer wants to
#' participate in the Medicare program, they must officially withdraw within 90
#' days. DMEPOS suppliers must withdraw within 30 days.
#'
#' Providers may *NOT* opt-out if they intend to be a Medicare Advantage
#' (Part C) provider or furnish services covered by traditional Medicare
#' fee-for-service (Part B).
#'
#' @section Links:
#' - [Medicare Opt Out Affidavits API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
#'
#' @section Update Frequency: **Monthly**
#'
#' @param npi 10-digit National Provider Identifier
#' @param first_name Provider's first name
#' @param last_name Provider's last name
#' @param specialty Provider's specialty
#' @param address Provider's address
#' @param city Provider's city
#' @param state Provider's state abbreviation
#' @param zip Provider's zip code
#' @param order_refer boolean indicating whether the provider is eligible
#'    to order and refer
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @seealso [order_refer()]
#'
#' @examples
#' opt_out(last_name = "Smith",
#'         first_name = "James",
#'         specialty = "Nurse Practitioner",
#'         order_refer = TRUE)
#' @examplesIf  interactive()
#' # For providers that have opted out, but are eligible to order and refer,
#' # use `order_refer()` to look up their specific eligibility statuses
#' opt_out(last_name = "Smith",
#'         first_name = "James",
#'         specialty = "Nurse Practitioner",
#'         order_refer = TRUE) |>
#'         pull(npi) |>
#'         map(\(x) order_refer(npi = x)) |>
#'         list_rbind()
#' @autoglobal
#' @export
opt_out <- function(npi             = NULL,
                    first_name      = NULL,
                    last_name       = NULL,
                    specialty       = NULL,
                    address         = NULL,
                    city            = NULL,
                    state           = NULL,
                    zip             = NULL,
                    order_refer     = NULL,
                    tidy            = TRUE) {

  if (!is.null(npi))         {npi         <- npi_check(npi)}
  if (!is.null(order_refer)) {order_refer <- tf_2_yn(order_refer)}
  if (!is.null(zip))         {zip         <- as.character(zip)}

  args <- dplyr::tribble(
    ~param,                         ~arg,
    "NPI",                           npi,
    "First Name",                    first_name,
    "Last Name",                     last_name,
    "Specialty",                     specialty,
    "First Line Street Address",     address,
    "City Name",                     city,
    "State Code",                    state,
    "Zip code",                      zip,
    "Eligible to Order and Refer",   order_refer)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                 cms_update("Opt Out Affidavits", "id")$distro[1],
                 "/data.json?",
                 encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "first_name",    first_name,
      "last_name",     last_name,
      "specialty",     specialty,
      "address",       address,
      "city",          city,
      "state",         state,
      "zip",           zip,
      "order_refer",   order_refer) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)

    return(invisible(NULL))

  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::tibble() |>
      dplyr::mutate(npi = as.character(npi),
                    dplyr::across(dplyr::contains("eligible"), yn_logical),
                    dplyr::across(dplyr::contains("date"), ~anytime::anydate(.)),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      tidyr::unite("address",
                   dplyr::any_of(c("first_line_street_address",
                                   "second_line_street_address")),
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      dplyr::select(npi,
                    first_name,
                    last_name,
                    specialty,
                    order_refer       = eligible_to_order_and_refer,
                    optout_start_date = optout_effective_date,
                    optout_end_date,
                    last_updated,
                    address,
                    city              = city_name,
                    state             = state_code,
                    zip               = zip_code)
    }
  return(results)
}
