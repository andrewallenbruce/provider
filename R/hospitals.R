#' Hospitals Enrolled in Medicare
#'
#' @description
#' Hospitals currently enrolled in Medicare. Data includes the hospital's
#' sub-group types, legal business name, doing-business-as name, organization
#' type and address.
#'
#' @references
#'    * [Hospital Enrollments API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' @param npi `<int>` National Provider Identifier
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid `<chr>` Medicare Enrollment ID
#' @param enid_state `<chr>` Enrollment State
#' @param ccn `<int>` CMS Certification Number
#' @param org_name `<chr>` Legal Business Name
#' @param dba_name `<chr>` Doing-Business-As Name
#' @param city `<chr>` Practice Location City
#' @param state `<chr>` Practice Location State
#' @param zip `<chr>` Practice Location Zip Code
#' @param designation `<chr>` IRS designation; `"Proprietor"`/`"Non-Profit"`
#' @param multi `<lgl>` Hospital has more than one NPI
#' @param reh `<lgl>` Former Hospital/CAH now a Rural Emergency Hospital
#' @param specialty `<chr>` Part A Provider Specialty:
#'
#'    - `"00-09"`: Hospital
#'    - `"00-24"`: REH (Rural Emergency Hospital)
#'    - `"00-85"`: CAH (Critical Access Hospital)
#'
#' @param subgroup `<list>` Hospital’s subgroup/unit:
#'
#'    - `acute`: Acute Care
#'    - `drug`: Alcohol/Drug Treatment
#'    - `child`: Children's Hospital
#'    - `general`: General Hospital
#'    - `long`: Long-Term Care
#'    - `short`: Short-Term Care
#'    - `psych`: Psychiatric
#'    - `rehab`: Rehabilitation
#'    - `swing`: Swing-Bed Approved
#'    - `psych_unit`: Psychiatric Unit
#'    - `rehab_unit`: Rehabilitation Unit
#'    - `specialty`: Specialty Hospital
#'    - `other`: Unlisted on CMS form
#'
#' @returns A [tibble][tibble::tibble-package]
#' @examples
#' hospitals()
#' hospitals(pac = 6103733050)
#' hospitals(state = "GA", reh = TRUE)
#' hospitals(city = "Atlanta", state = "GA", subgroup = list(acute = FALSE))
#' hospitals(state = "GA", subgroup = list(psych = TRUE))
#' @autoglobal
#' @export
hospitals <- function(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  enid_state = NULL,
  specialty = NULL,
  org_name = NULL,
  dba_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  designation = NULL,
  multi = NULL,
  reh = NULL,
  subgroup = list(
    acute = NULL,
    drug = NULL,
    child = NULL,
    general = NULL,
    long = NULL,
    short = NULL,
    psych = NULL,
    rehab = NULL,
    swing = NULL,
    psych_unit = NULL,
    rehab_unit = NULL,
    specialty = NULL,
    other = NULL
  )
) {

  G <- purrr::map(subgroup, convert_lgl)

  args <- params(
    NPI = npi,
    CCN = ccn,
    `ENROLLMENT ID` = enid,
    `ENROLLMENT STATE` = enid_state,
    `PROVIDER TYPE CODE` = specialty,
    `ASSOCIATE ID` = pac,
    `ORGANIZATION NAME` = org_name,
    `DOING BUSINESS AS NAME` = dba_name,
    CITY = city,
    STATE = state,
    `ZIP CODE` = zip,
    PROPRIETARY_NONPROFIT = designation,
    `MULTIPLE NPI FLAG` = convert_lgl(multi),
    `REH CONVERSION FLAG` = convert_lgl(reh),
    `SUBGROUP %2D GENERAL` = G$general,
    `SUBGROUP %2D ACUTE CARE` = G$acute,
    `SUBGROUP %2D ALCOHOL DRUG` = G$drug,
    `SUBGROUP %2D CHILDRENS` = G$child,
    `SUBGROUP %2D LONG-TERM` = G$long,
    `SUBGROUP %2D PSYCHIATRIC` = G$psych,
    `SUBGROUP %2D REHABILITATION` = G$rehab,
    `SUBGROUP %2D SHORT-TERM` = G$short,
    `SUBGROUP %2D SWING-BED APPROVED` = G$swing,
    `SUBGROUP %2D PSYCHIATRIC UNIT` = G$psych_unit,
    `SUBGROUP %2D REHABILITATION UNIT` = G$rehab_unit,
    `SUBGROUP %2D SPECIALTY HOSPITAL` = G$specialty,
    `SUBGROUP %2D OTHER` = G$other
  )

  .c(BASE, LIMIT, NM) %=% constants("hospitals")

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(args)) {
    cli_no_query()

    url <- url_(paste0(BASE, "?"), opts(size = 10))

    res <- request_bare(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_(NM)

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
      rename_(NM)

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
    rename_(NM)
}
