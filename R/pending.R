#' Pending Medicare Applications
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
#' | __Update Frequency__ |
#' |:--------------------:|
#' |      QUARTERLY       |
#'
#' @param type < *character* > // __default:__ `"p"` Physician (`p`) or Non-physician (`n`)
#' @param npi < *integer* > 10-digit National Provider Identifier
#' @param first,last < *character* > Provider's name
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field** |**Description**         |
#' |:---------|:-----------------------|
#' |`npi`     |10-digit individual NPI |
#' |`first`   |Provider's first name   |
#' |`last`    |Provider's last name    |
#' |`type`    |Type of Provider        |
#'
#' @examplesIf interactive()
#' pending(type = "p", first = "John")
#' pending(type = "n", last = "Smith")
#'
#' @autoglobal
#' @export
pending <- function(type = "p",
                    npi = NULL,
                    first = NULL,
                    last = NULL,
                    tidy = TRUE) {

  type <- rlang::arg_match(type, c("p", "n"))
  if (!is.null(npi)) {npi <- check_npi(npi)}

  args <- dplyr::tribble(
    ~param,       ~arg,
    "NPI",        npi,
    "LAST_NAME",  last,
    "FIRST_NAME", first)

  if (type == "n") {
    response <- httr2::req_perform(httr2::request(build_url("npe", args)))}
  if (type == "p") {
    response <- httr2::req_perform(httr2::request(build_url("ppe", args)))}

  if (vctrs::vec_is_empty(response$body)) {

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
      dplyr::mutate(type = dplyr::if_else(type == "p",
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
