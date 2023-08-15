#' Search the Medicare Opt Out Affidavits API
#'
#' @description A list of practitioners who are currently opted out
#'    of Medicare.
#'
#' @details The Opt Out Affidavits dataset provides information on providers
#'    who have decided not to participate in Medicare. It contains the
#'    provider's NPI, specialty, address, and effective dates.
#'
#' ## Links
#' * [Medicare Opt Out Affidavits API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#' @param first_name First Name of the Opt Out Provider
#' @param last_name Last Name of the Opt Out Provider
#' @param npi National Provider Identifier (NPI) number of the Opt Out Provider
#' @param specialty Specialty of the Opt Out Provider
#' @param address Provider's Street Address
#' @param city Provider's City
#' @param state Provider's State Abbreviation
#' @param zip Provider's Zip Code
#' @param order_and_refer Flag indicating whether the Provider is eligible to
#'    Order and Refer
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' opt_out(specialty = "Psychiatry", zipcode = "07626")
#' opt_out(first = "David", last = "Smith")
#' opt_out(npi = 1114974490)
#' opt_out(city = "Los Angeles", address = "9201 W SUNSET BLVD")
#' opt_out(state = "NY", order_and_refer = FALSE)
#' opt_out(npi = 1326011057)
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
                    order_and_refer = NULL,
                    tidy            = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}

  # args tribble ------------------------------------------------------------
  if (!is.null(order_and_refer)) {
    order_and_refer <- dplyr::case_when(
      order_and_refer == TRUE ~ "Y",
      order_and_refer == FALSE ~ "N",
      .default = NULL)
    }
  args <- tibble::tribble(
                                ~x,           ~y,
                             "NPI",          npi,
                      "First Name",   first_name,
                       "Last Name",    last_name,
                       "Specialty",    specialty,
       "First Line Street Address",      address,
                       "City Name",         city,
                      "State Code",        state,
                        "Zip code",          zip,
     "Eligible to Order and Refer",     order_and_refer)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # update distribution id -------------------------------------------------
  id <- cms_update("Opt Out Affidavits", "id") |>
    dplyr::slice_head() |>
    dplyr::pull(distro)

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- tibble::tribble(
      ~x,              ~y,
      "npi",           as.character(npi),
      "first_name",    first_name,
      "last_name",     last_name,
      "specialty",     specialty,
      "address",       address,
      "city",          city,
      "state",         state,
      "zip",           as.character(zip),
      "eligible",      as.character(order_and_refer)) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)

    return(invisible(NULL))

  }

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
            check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(npi = as.character(npi),
                    dplyr::across(dplyr::contains("eligible"), yn_logical),
                    dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                    dplyr::across(dplyr::contains("date"), ~lubridate::ymd(.)),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      tidyr::unite("address",
                   dplyr::any_of(c("first_line_street_address",
                                   "second_line_street_address")),
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      dplyr::select(npi,
                    first_name,
                    last_name,
                    specialty,
                    optout_start_date = optout_effective_date,
                    optout_end_date,
                    last_updated,
                    order_and_refer = eligible_to_order_and_refer,
                    address,
                    city = city_name,
                    state = state_code,
                    zip = zip_code)
    }
  return(results)
}
