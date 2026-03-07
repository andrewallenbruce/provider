#' Provider Enrollment in Medicare
#'
#' @description
#' Access enrollment level data on individual and organizational providers that are actively approved to bill Medicare.
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
#' providers(enid = "I20040309000221")
#'
#' providers(npi = 1417918293)
#'
#' providers(pac = 2860305554)
#'
#' # providers(state = "AK")
#' # providers(spec_code = "14-41")
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
  args <- parameters(
    NPI = npi,
    MULTIPLE_NPI_FLAG = multi,
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

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(args)) {
    cli_no_query()

    url <- flatten_url(
      base_url("providers"),
      opts = set_opts(
        `?size` = 10,
        offset = 0
      )
    )

    res <- bare_request(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_providers()

    return(res)
  }

  # Valid Query: Flatten & Request Result Count =====================

  url <- flatten_url(
    paste0(base_url("providers"), "/stats?"),
    set_opts(size = limit("providers"), offset = 0),
    flatten_query2(args)
  )

  N <- bare_request(url, "found_rows")

  # Query Returned Nothing: Alert & Exit =====================
  if (N == 0L) {
    cli::cli_alert_danger("Query returned {N} results.")
    return(invisible(NULL))
  }

  # Count is Within API Limit: Request & Return Results
  if (N <= limit("providers")) {
    cli::cli_alert_success("Query returned {N} result{?s}.")

    url <- flatten_url(
      paste0(base_url("providers"), "?"),
      set_opts(offset = 0, size = limit("providers")),
      flatten_query2(args)
    )

    res <- bare_request(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_providers()

    return(res)
  }

  # Count Above API Limit: Alert & Return Results =====================
  cli::cli_alert_success("Query returned {format(N, big.mark = ',')} results.")
  cli::cli_alert_info("Retrieving {offset(N, limit('providers'))} page{?s}...")

  url <- flatten_url(
    paste0(base_url("providers"), "?"),
    set_opts(offset = "<<i>>", size = limit("providers")),
    flatten_query2(args)
  )

  urls <- offset(N, limit("providers"), "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = url, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })

  parallel_request(urls) |>
    collapse::rowbind() |>
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
    ORG_NAME = "org"
  )

  collapse::setrename(x, NM, .nse = FALSE)

  collapse::gv(x, unlist_(NM))
}
