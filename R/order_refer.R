#' Order and Referral Eligibility
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
#'
#' @param npi `<int>` 10-digit Individual National Provider Identifier
#' @param first,last `<chr>` Individual provider's first/last name
#' @param part_b,dme,hha,pmd,hospice `<lgl>` Whether a provider is eligible to
#' order and refer to:
#' + `partb`: Medicare Part B
#' + `dme`: Durable Medical Equipment
#' + `hha`: Home Health Agency
#' + `pmd`: Power Mobility Devices
#' + `hospice`: Hospice
#'
#' @returns A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**   |**Description**                                   |
#' |:-----------|:-------------------------------------------------|
#' |`npi`       |National Provider Identifier                      |
#' |`first`     |Order and Referring Provider's First Name         |
#' |`last`      |Order and Referring Provider's Last Name          |
#' |`eligible`  |Services An Eligible Provider Can Order/Refer To  |
#'
#' @examples
#' order_refer()
#'
#' order_refer(npi = 100)
#'
#' order_refer(npi = 1003026055)
#'
#' order_refer(first = "Jennifer", last = "Smith")
#'
#' order_refer(
#'   part_b = TRUE,
#'   dme = TRUE,
#'   hha = FALSE,
#'   pmd = TRUE,
#'   hospice = FALSE
#'  )
#'
#' @autoglobal
#' @export
order_refer <- function(
  npi = NULL,
  first = NULL,
  last = NULL,
  part_b = NULL,
  dme = NULL,
  hha = NULL,
  pmd = NULL,
  hospice = NULL
) {
  args <- parameters(
    NPI = npi,
    FIRST_NAME = first,
    LAST_NAME = last,
    PARTB = convert_lgl(part_b),
    DME = convert_lgl(dme),
    HHA = convert_lgl(hha),
    PMD = convert_lgl(pmd),
    HOSPICE = convert_lgl(hospice)
  )

  BASE <- base_url("order_refer")
  LIMIT <- limit("order_refer")

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(args)) {
    cli_no_query()

    url <- flatten_url(paste0(BASE, "?"), set_opts(size = 10, offset = 0))

    res <- request_bare(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_order_refer()

    return(res)
  }

  # Valid Query: Flatten & Request Result Count =====================

  url <- flatten_url(
    paste0(BASE, "/stats?"),
    set_opts(size = LIMIT, offset = 0),
    flatten_query2(args)
  )

  N <- request_bare(url, "found_rows")

  # Query Returned Nothing: Alert & Exit =====================
  if (N == 0L) {
    cli_no_results()
    return(invisible(NULL))
  }

  # Count is Within API Limit: Request & Return Results
  if (N <= LIMIT) {
    cli_results(N)

    url <- flatten_url(
      paste0(BASE, "?"),
      set_opts(size = LIMIT, offset = 0),
      flatten_query2(args)
    )

    res <- request_bare(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_order_refer()

    return(res)
  }

  # Count Above API Limit: Alert & Return Results =====================
  cli_pages(N, offset(N, LIMIT))

  url <- flatten_url(
    paste0(BASE, "?"),
    set_opts(offset = "<<i>>", size = LIMIT),
    flatten_query2(args)
  )

  urls <- offset(N, LIMIT, "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = url, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })

  parallel_request(urls) |>
    fastplyr::as_tbl() |>
    map_na_if() |>
    rename_order_refer()
}

#' @autoglobal
#' @noRd
rename_order_refer <- function(x) {
  NM <- c(
    NPI = "npi",
    FIRST_NAME = "first",
    LAST_NAME = "last",
    PARTB = "part_b",
    DME = "dme",
    HHA = "hha",
    PMD = "pmd",
    HOSPICE = "hospice"
  )

  collapse::setrename(x, NM, .nse = FALSE)

  collapse::gv(x, unlist_(NM))
}

#' @autoglobal
#' @noRd
convert_lgl <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }

  cheapr::val_match(
    x,
    TRUE ~ "Y",
    FALSE ~ "N"
  )
}
