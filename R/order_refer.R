#' Order and Referral Eligibility
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' `order_refer()` returns a provider's eligibility to order and refer within
#' Medicare to:
#'
#' + **Part B**: Clinical Laboratory Services, Imaging Services
#' + **DME**: Durable Medical Equipment, Prosthetics, Orthotics, & Supplies (DMEPOS)
#' + **Part A**: Home Health Services
#'
#' To be eligible, a provider must:
#'
#' + have an *Individual* NPI
#' + be enrolled in Medicare in either an *Approved* or *Opt-Out* status
#' + be of an *Eligible Specialty* type
#'
#' **Ordering Providers** can order non-physician services for patients.
#'
#' **Referring (or Certifying) Providers** can request items or services that
#' Medicare may reimburse on behalf of its beneficiaries.
#'
#' **Opt-Out Providers**: Providers who have opted out of Medicare may still
#' order and refer. They can also enroll solely to order and refer.
#'
#' @references links:
#' + [Medicare Order and Referring API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)
#' + [CMS.gov: Ordering & Certifying](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/chain-ownership-system-pecos/ordering-certifying)
#' + [Order and Referring Methodology](https://data.cms.gov/resources/order-and-referring-methodology)
#'
#' *Update Frequency:* **Twice Weekly**
#'
#' @param npi < *integer* > 10-digit national provider identifier
#' @param first,last < *character* > Individual provider's first/last name
#' @param partb,dme,hha,pmd < *boolean* > Whether a provider is eligible to
#' order and refer to:
#' + `partb`: Medicare Part B
#' + `dme`: Durable Medical Equipment
#' + `hha`: Home Health Agency
#' + `pmd`: Power Mobility Devices
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param pivot < *boolean* > // __default:__ `TRUE` Pivot output
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**  |**Description**                                   |
#' |:----------|:-------------------------------------------------|
#' |`npi`      |National Provider Identifier                      |
#' |`first`    |Order and Referring Provider's First Name         |
#' |`last`     |Order and Referring Provider's Last Name          |
#' |`service`  |Services An Eligible Provider Can Order/Refer To  |
#'
#' @seealso [providers()], [opt_out()], [pending()]
#' @examples
#' order_refer(npi = 1003026055)
#'
#' # Filter for certain privileges
#' order_refer(last = "Smith", partb = FALSE, hha = TRUE)
#'
#' @autoglobal
#' @export
order_refer <- function(npi   = NULL,
                        first = NULL,
                        last  = NULL,
                        partb = NULL,
                        dme   = NULL,
                        hha   = NULL,
                        pmd   = NULL,
                        tidy  = TRUE,
                        pivot = TRUE) {

  if (!is.null(npi))   {npi   <- validate_npi(npi)}
  if (!is.null(partb)) {partb <- tf_2_yn(partb)}
  if (!is.null(dme))   {dme   <- tf_2_yn(dme)}
  if (!is.null(hha))   {hha   <- tf_2_yn(hha)}
  if (!is.null(pmd))   {pmd   <- tf_2_yn(pmd)}

  args <- dplyr::tribble(
    ~param,      ~arg,
    "NPI",        npi,
    "FIRST_NAME", first,
    "LAST_NAME",  last,
    "PARTB",      partb,
    "DME",        dme,
    "HHA",        hha,
    "PMD",        pmd)

  response <- httr2::request(build_url("ord", args)) |>
    httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "first",         first,
      "last",          last,
      "partb",         partb,
      "dme",           dme,
      "hha",           hha,
      "pmd",           pmd) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))

  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results, yn = c("partb", "hha", "dme", "pmd"))

    if (pivot) {
      results <-  cols_ord(results) |>
        tidyr::pivot_longer(cols = !c(npi, first, last),
                          names_to = "service",
                          values_to = "status") |>
        dplyr::filter(status == TRUE) |>
        dplyr::mutate(status = NULL)
      }
    }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_ord <- function(df) {

  cols <- c('npi',
            'first'                     = 'first_name',
            'last'                      = 'last_name',
            "Medicare Part B"           = 'partb',
            "Home Health Agency"        = 'hha',
            "Durable Medical Equipment" = 'dme',
            "Power Mobility Devices"    = 'pmd')

  df |> dplyr::select(dplyr::any_of(cols))
}
