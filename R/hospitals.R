#' Hospitals Enrolled in Medicare
#'
#' @description
#' Hospitals currently enrolled in Medicare. Data includes the hospital's
#' sub-group types, legal business name, doing-business-as name, organization
#' type and address.
#'
#' @references
#'    - [Hospital Enrollments API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
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
#' @param designation `<chr>` `"Proprietor"`/`"Non-Profit"`
#' @param multi `<lgl>` Hospital has more than one NPI
#' @param reh `<lgl>` Former Hospital/CAH now a Rural Emergency Hospital
#' @param specialty `<chr>`
#'    - `"00-09"`: Hospital
#'    - `"00-24"`: Rural Emergency Hospital
#'    - `"00-85"`: Critical Access Hospital
#' @param subgroup `<subgroups>` Hospital’s subgroup/unit. See [subgroups()].
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examples
#' hospitals(count = TRUE)
#' hospitals(pac = 6103733050)
#' hospitals(state = "GA", reh = TRUE)
#' hospitals(city = "Atlanta", state = "GA", subgroup = subgroups(acute = FALSE))
#' hospitals(state = "GA", subgroup = subgroups(psych = TRUE))
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
  subgroup = subgroups(),
  count = FALSE
) {
  check_subgroups(subgroup)

  ARG <- params(
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
    !!!subgroup
  )

  .c(BASE, LIMIT, NM) %=% constants("hospitals")

  # Return Total Rows =====================
  if (count) {
    cli_results(request_rows(paste0(BASE, "/stats?")))
    return(invisible(NULL))
  }

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(ARG)) {
    cli_no_query()

    res <- request_bare(url_(paste0(BASE, "?"), opts(size = 10))) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_(NM)

    return(res)
  }

  # Valid Query: Flatten & Request Result Count =====================
  url <- url_(
    paste0(BASE, "/stats?"),
    opts(size = LIMIT),
    query2(ARG)
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
      query2(ARG)
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
    query2(ARG)
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

#' Subgroup Helper
#'
#' For use in [hospitals()] `subgroup` argument
#'
#' @param acute `<lgl>` Acute Care
#' @param drug `<lgl>` Alcohol/Drug Treatment
#' @param child `<lgl>` Children's Hospital
#' @param general `<lgl>` General Hospital
#' @param long `<lgl>` Long-Term Care
#' @param short `<lgl>` Short-Term Care
#' @param psych `<lgl>` Psychiatric
#' @param rehab `<lgl>` Rehabilitation
#' @param swing `<lgl>` Swing-Bed Approved
#' @param psych_unit `<lgl>` Psychiatric Unit
#' @param rehab_unit `<lgl>` Rehabilitation Unit
#' @param specialty `<lgl>` Specialty Hospital
#' @param other `<lgl>` Unlisted on CMS form
#' @returns A `<subgroups>` object
#' @examples
#' subgroups(acute = TRUE, rehab = TRUE)
#' @autoglobal
#' @keywords internal
#' @export
subgroups <- function(
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
) {
  x <- purrr::map(
    list(
      `SUBGROUP %2D GENERAL` = general,
      `SUBGROUP %2D ACUTE CARE` = acute,
      `SUBGROUP %2D ALCOHOL DRUG` = drug,
      `SUBGROUP %2D CHILDRENS` = child,
      `SUBGROUP %2D LONG-TERM` = long,
      `SUBGROUP %2D PSYCHIATRIC` = psych,
      `SUBGROUP %2D REHABILITATION` = rehab,
      `SUBGROUP %2D SHORT-TERM` = short,
      `SUBGROUP %2D SWING-BED APPROVED` = swing,
      `SUBGROUP %2D PSYCHIATRIC UNIT` = psych_unit,
      `SUBGROUP %2D REHABILITATION UNIT` = rehab_unit,
      `SUBGROUP %2D SPECIALTY HOSPITAL` = specialty,
      `SUBGROUP %2D OTHER` = other
    ),
    convert_lgl
  )

  structure(params(!!!x), class = "subgroups")
}

#' @noRd
is_subgroups <- function(x) {
  inherits(x, "subgroups")
}

#' @noRd
check_subgroups <- function(x) {
  if (!is_subgroups(x)) {
    cli::cli_abort(c(
      "{.arg subgroup} must be a {.cls subgroups} object, not a {.cls {class(x)}}",
      "i" = "Use the {.fn subgroups} helper function"
    ))
  }
}
