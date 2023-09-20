#' Order and Referral Eligibility
#'
#' @description
#'
#' `order_refer()` returns a provider's eligibility status concerning ordering
#' and referring within Medicare to:
#'
#' - **Part B**: Clinical Laboratory Services, Imaging Services
#' - **DME**: Durable Medical Equipment, Prosthetics, Orthotics, and Supplies (DMEPOS)
#' - **Part A**: Home Health Services
#'
#'
#' To be eligible, a provider must:
#'
#' - have an *Individual* NPI
#' - be enrolled in Medicare in either an *Approved* or *Opt-Out* status
#' - be of an *Eligible Specialty* type
#'
#'
#' **Ordering Providers** can order non-physician services for patients.
#'
#'
#' **Referring (or Certifying) Providers** can request items or services that
#' Medicare may reimburse on behalf of its beneficiaries.
#'
#'
#' **Opt-Out Providers**: Providers who have opted out of Medicare may still
#' order and refer. They can also enroll solely to order and refer.
#'
#'
#' Links:
#'
#'   - [Medicare Order and Referring API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)
#'   - [CMS.gov: Ordering & Certifying](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/chain-ownership-system-pecos/ordering-certifying)
#'   - [Order and Referring Methodology](https://data.cms.gov/resources/order-and-referring-methodology)
#'
#' *Update Frequency:* **Twice Weekly**
#'
#' @param npi < *integer* > 10-digit National Provider Identifier
#' @param first,last < *character* > Provider's first/last name
#' @param partb,dme,hha,pmd < *boolean* > `TRUE` or `FALSE`. Whether a provider
#' is eligible to order and refer to:
#' - `partb`: Medicare Part B
#' - `dme`: Durable Medical Equipment
#' - `hha`: Home Health Agency
#' - `pmd`: Power Mobility Devices
#' @param tidy < *boolean* > Tidy output; default is `TRUE`.
#'
#'
#' @return A [tibble][tibble::tibble-package] with the following columns:
#'
#' |**Field**  |**Description**                                   |
#' |:----------|:-------------------------------------------------|
#' |`npi`      |National Provider Identifier                      |
#' |`first`    |Order and Referring Provider's First Name         |
#' |`last`     |Order and Referring Provider's Last Name          |
#' |`service`  |Services An Eligible Provider Can Order/Refer To  |
#' |`eligible` |Indicates Provider's Eligibility                  |
#'
#' @seealso [providers()], [opt_out()], [pending()]
#'
#'
#' @examples
#' order_refer(npi = 1003026055)
#'
#' ## Filter for certain privileges
#' order_refer(last = "Smith", partb = FALSE, hha = TRUE)
#' @autoglobal
#' @export
order_refer <- function(npi   = NULL,
                        first = NULL,
                        last  = NULL,
                        partb = NULL,
                        dme   = NULL,
                        hha   = NULL,
                        pmd   = NULL,
                        tidy  = TRUE) {

  if (!is.null(npi))   {npi   <- npi_check(npi)}
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

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                cms_update("Order and Referring", "id")$distro[1],
                "/data.json?",
                encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

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
      dplyr::mutate(partb = yn_logical(partb),
                    hha   = yn_logical(hha),
                    dme   = yn_logical(dme),
                    pmd   = yn_logical(pmd)) |>
      dplyr::select(npi,
                    first = first_name,
                    last = last_name,
                    "Medicare Part B"                 = partb,
                    "Home Health Agency (HHA)"        = hha,
                    "Durable Medical Equipment (DME)" = dme,
                    "Power Mobility Device (PMD)"     = pmd) |>
      tidyr::pivot_longer(cols = !c(npi, first, last),
                          names_to = "service",
                          values_to = "eligible")
    }
  return(results)
}
