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
#' @section Links:
#'   - [Medicare Order and Referring API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)
#'   - [CMS.gov: Ordering & Certifying](https://www.cms.gov/medicare/provider-enrollment-and-certification/ordering-and-certifying)
#'   - [Order and Referring Methodology](https://data.cms.gov/resources/order-and-referring-methodology)
#'
#' @section Update Frequency: **Twice Weekly**
#'
#' @param npi 10-digit National Provider Identifier
#' @param first_name Provider's first name
#' @param last_name Provider's last name
#' @param partb boolean; eligibility to order & refer to Medicare Part B
#' @param dme boolean; eligibility to order Durable Medical Equipment
#' @param hha boolean; eligibility to refer to a Home Health Agency
#' @param pmd boolean; eligibility to order Power Mobility Devices
#' @param tidy boolean; Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] object containing the search results.
#'
#' @seealso [providers()], [opt_out()], [pending_applications()]
#'
#' @examplesIf interactive()
#' # Search by NPI
#' order_refer(npi = 1003026055)
#'
#' # Search by name and/or filter for certain privileges
#' order_refer(last_name = "Smith", partb = FALSE, hha = TRUE)
#'
#' @autoglobal
#' @export
order_refer <- function(npi          = NULL,
                        first_name   = NULL,
                        last_name    = NULL,
                        partb        = NULL,
                        dme          = NULL,
                        hha          = NULL,
                        pmd          = NULL,
                        tidy         = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}

  if (!is.null(partb)) {partb <- dplyr::case_when(
    partb == TRUE ~ "Y", partb == FALSE ~ "N", .default = NULL)}

  if (!is.null(dme)) {dme <- dplyr::case_when(
    dme == TRUE ~ "Y", dme == FALSE ~ "N", .default = NULL)}

  if (!is.null(hha)) {hha <- dplyr::case_when(
    hha == TRUE ~ "Y", hha == FALSE ~ "N", .default = NULL)}

  if (!is.null(pmd)) {pmd <- dplyr::case_when(
    pmd == TRUE ~ "Y", pmd == FALSE ~ "N", .default = NULL)}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,           ~y,
    "NPI",        npi,
    "FIRST_NAME", first_name,
    "LAST_NAME",  last_name,
    "PARTB",      partb,
    "DME",        dme,
    "HHA",        hha,
    "PMD",        pmd)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # update distribution id -------------------------------------------------
  id <- cms_update("Order and Referring", "id") |>
    dplyr::slice_head() |>
    dplyr::pull(distro)

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns NULL
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- tibble::tribble(
      ~x,              ~y,
      "npi",           as.character(npi),
      "first_name",    first_name,
      "last_name",     last_name,
      "partb",         as.character(partb),
      "dme",           as.character(dme),
      "hha",           as.character(hha),
      "pmd",           as.character(pmd)) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
    return(invisible(NULL))

  }

  # parse response
  results <- tibble::tibble(httr2::resp_body_json(response,
             check_type = FALSE, simplifyVector = TRUE))

  # tidy output
  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::mutate(partb = yn_logical(partb),
                    hha = yn_logical(hha),
                    dme = yn_logical(dme),
                    pmd = yn_logical(pmd)) |>
      dplyr::select(npi,
                    first_name,
                    last_name,
                    "Medicare Part B" = partb,
                    "Home Health Agency (HHA)" = hha,
                    "Durable Medical Equipment (DME)" = dme,
                    "Power Mobility Device (PMD)" = pmd) |>
      tidyr::pivot_longer(cols = !c(npi,
                                    dplyr::contains("name")),
                          names_to = "service",
                          values_to = "eligible")
    }
  return(results)
}
