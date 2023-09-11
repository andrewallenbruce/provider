#' Ordering and Referring Eligibility for Medicare
#'
#' @description
#' `order_refer()` allows you to search for physicians and non-physician
#' practitioners who are of a type/specialty that is legally eligible to order
#' and refer to Part B (clinical laboratory and imaging), DME and Part A HHA
#' claims in the Medicare program.
#'
#' ## Ordering and Referring (or Certifying) Providers
#' **Ordering providers** can order non-physician services for patients.
#' **Referring providers** can request items or services Medicare may reimburse
#' on behalf of Medicare beneficiaries.
#'
#' To qualify as an ordering and referring/certifying provider, a provider must:
#'
#'   - have an *individual* NPI
#'   - be enrolled in Medicare in either an *approved* or *opt-out* status
#'   - be of an *eligible specialty* type
#'
#' Providers currently enrolled in Medicare Part B can order and refer. A
#' provider that does not want to bill Medicare for their services can still
#' order and refer by opting out of Medicare or enrolling solely to order and
#' refer. Medicare coverage will then apply when ordering or referring:
#'
#'   - Durable Medical Equipment, Prosthetics, Orthotics, and Supplies (DMEPOS)
#'   - Clinical Laboratory Services
#'   - Imaging Services
#'   - Home Health Services
#'
#' ### Links:
#'   - [Medicare Order and Referring API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)
#'   - [CMS.gov: Ordering & Certifying](https://www.cms.gov/medicare/provider-enrollment-and-certification/ordering-and-certifying)
#'   - [Order and Referring Methodology](https://data.cms.gov/resources/order-and-referring-methodology)
#'
#' *Update Frequency:* **Twice Weekly**
#'
#' @param npi 10-digit National Provider Identifier
#' @param first,last Provider's first/last name
#' @param partb boolean; eligibility to order & refer to Medicare Part B
#' @param dme boolean; eligibility to order Durable Medical Equipment
#' @param hha boolean; eligibility to refer to a Home Health Agency
#' @param pmd boolean; eligibility to order Power Mobility Devices
#' @param tidy boolean; Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] object containing the search results.
#'
#' @seealso [providers()], [opt_out()], [pending()]
#'
#' @examplesIf interactive()
#' # Search by NPI
#' order_refer(npi = 1003026055)
#'
#' # Search by name and/or filter for certain privileges
#' order_refer(last = "Smith", partb = FALSE, hha = TRUE)
#' @autoglobal
#' @export
order_refer <- function(npi = NULL,
                        first = NULL,
                        last = NULL,
                        partb = NULL,
                        dme = NULL,
                        hha = NULL,
                        pmd = NULL,
                        tidy = TRUE) {

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
