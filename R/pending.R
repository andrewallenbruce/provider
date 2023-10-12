#' Pending Medicare Enrollment Applications
#'
#' @description
#' `r lifecycle::badge("questioning")`
#'
#' `pending()` allows the user to search for providers with pending Medicare
#' enrollment applications.
#'
#' @references APIs:
#' + [Medicare Pending Initial Logging and Tracking Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)
#' + [Medicare Pending Initial Logging and Tracking Non-Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)
#'
#' *Update Frequency:* **Weekly**
#'
#' @param type < *character* > // __required__ Physician ("`P`") or
#' Non-physician ("`N`")
#' @param npi < *integer* > 10-digit National Provider Identifier
#' @param first,last < *character* > Provider's name
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' pending(type = "N", last = "Smith")
#'
#' pending(type = "P", first = "John")
#'
#' @autoglobal
#' @export
pending <- function(type,
                    npi = NULL,
                    first = NULL,
                    last = NULL,
                    tidy = TRUE) {

  type <- rlang::arg_match(type, c("P", "N"))
  if (!is.null(npi)) {npi <- check_npi(npi)}

  args <- dplyr::tribble(
    ~param,       ~arg,
    "NPI",        npi,
    "LAST_NAME",  last,
    "FIRST_NAME", first)

  if (type == "P") {
    response <- httr2::req_perform(httr2::request(build_url("ppe", args)))}
  if (type == "N") {
    response <- httr2::req_perform(httr2::request(build_url("npe", args)))}

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,      ~y,
      "type",  type,
      "npi",   npi,
      "first", first,
      "last",  last) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(type = dplyr::if_else(type == "P",
                                          "Physician",
                                          "Non-Physician")) |>
      cols_pen()
    }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_pen <- function(df) {
  cols <- c('npi', 'first' = 'first_name', 'last' = 'last_name', 'type')
  df |> dplyr::select(dplyr::any_of(cols))
}
