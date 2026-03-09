#' Provider Enrollment in Medicare
#'
#' @description
#' Enrollment data on individual and organizational providers that are
#'    actively approved to bill Medicare.
#'
#' @section Links:
#'    * [Provider Enrollment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
#'    * [Provider Enrollment Data Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)
#'
#' @param npi `<int>` 10-digit Individual National Provider Identifier
#' @param pac `<chr>` 10-digit PECOS Associate Control ID
#' @param enid `<chr>` 15-digit Medicare Enrollment ID
#' @param first,middle,last `<chr>` Individual provider's name
#' @param spec_code `<chr>` Enrollment specialty code
#' @param spec_desc `<chr>` Enrollment specialty description
#' @param state `<chr>` Enrollment state, full or abbreviation
#' @param org_name `<chr>` Organization name
#' @param multi `<chr>` Provider has multiple NPIs
#'
#' @returns A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**   |**Description**                        |
#' |:-----------|:--------------------------------------|
#' |`npi`       |10-digit NPI                           |
#' |`pac`       |10-digit PAC ID                        |
#' |`enid`      |15-digit provider enrollment ID        |
#' |`spec_code` |Enrollment primary specialty type code |
#' |`spec_desc` |Enrollment specialty type description  |
#' |`first`     |Individual provider's first name       |
#' |`middle`    |Individual provider's middle name      |
#' |`last`      |Individual provider's last name        |
#' |`state`     |Enrollment state                       |
#' |`org_name`  |Organizational provider's name         |
#'
#' @examples
#' providers()
#'
#' providers(spec_code = "14")
#'
#' providers(enid = "I20040309000221")
#'
#' providers(npi = 1417918293)
#'
#' providers(pac = 2860305554)
#'
#' providers(state = "AK")
#'
#' @autoglobal
#'
#' @export
providers <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  spec_code = NULL,
  spec_desc = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL
) {
  args <- params(
    NPI = npi,
    MULTIPLE_NPI_FLAG = convert_lgl(multi),
    PECOS_ASCT_CNTL_ID = pac,
    ENRLMT_ID = enid,
    PROVIDER_TYPE_CD = spec_code,
    PROVIDER_TYPE_DESC = spec_desc,
    STATE_CD = state,
    LAST_NAME = last,
    FIRST_NAME = first,
    MDL_NAME = middle,
    ORG_NAME = org_name
  )

  BASE <- base_url("providers")
  LIMIT <- limit("providers")

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(args)) {
    cli_no_query()

    url <- url_(paste0(BASE, "?"), opts(size = 10))

    res <- request_bare(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_providers()

    return(res)
  }

  # Valid Query: Flatten & Request Result Count =====================

  url <- url_(
    paste0(BASE, "/stats?"),
    opts(size = LIMIT),
    query2(args)
  )

  N <- request_rows(url)

  # Query Returned Nothing: Alert & Exit =====================
  if (N == 0L) {
    cli_no_results()
    return(invisible(NULL))
  }

  # Count is Within API Limit: Request & Return Results
  if (N <= LIMIT) {
    cli_results(N)

    url <- url_(
      paste0(BASE, "?"),
      opts(size = LIMIT),
      query2(args)
    )

    res <- request_bare(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_providers()

    return(res)
  }

  # Count Above API Limit: Alert & Return Results =====================
  cli_pages(N, offset(N, LIMIT))

  url <- url_(
    paste0(BASE, "?"),
    opts(size = LIMIT, offset = "<<i>>"),
    query2(args)
  )

  urls <- offset(N, LIMIT, "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = url, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })

  parallel_request(urls) |>
    fastplyr::as_tbl() |>
    map_na_if() |>
    rename_providers()
}

#' @autoglobal
#' @noRd
rename_providers <- function(x) {
  NM <- c(
    NPI = "npi",
    MULTIPLE_NPI_FLAG = "multi",
    PECOS_ASCT_CNTL_ID = "pac",
    ENRLMT_ID = "enid",
    PROVIDER_TYPE_CD = "spec_code",
    PROVIDER_TYPE_DESC = "spec_desc",
    STATE_CD = "state",
    LAST_NAME = "last",
    FIRST_NAME = "first",
    MDL_NAME = "middle",
    ORG_NAME = "org_name"
  )

  collapse::setrename(x, NM, .nse = FALSE)

  collapse::gv(x, unlist_(NM))
}
