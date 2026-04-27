#' Hospitals Enrolled in Medicare
#'
#' @description Hospitals currently enrolled in Medicare. Data includes the
#'   hospital's sub-group types, legal business name, doing-business-as name,
#'   organization type and address.
#'
#' @source
#'    - [API: Hospital Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' @param npi `<int>` National Provider Identifier
#' @param ccn `<int>` CMS Certification Number
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid,enid_state `<chr>` Medicare Enrollment ID, Enrollment state
#' @param org_name `<chr>` Legal business name
#' @param org_dba `<chr>` Doing-business-as name
#' @param city,state,zip `<chr>` Location city, state, zip
#' @param multi `<lgl>` Does hospital have more than one NPI?
#' @param status `<enum>` Organization status
#'    - `P` = Proprietary
#'    - `N` = Non-Profit
#'    - `D` = Unknown
#' @param org_type `<enum>` Organization structure type
#'    - `corp` = Corporation
#'    - `other` = Other
#'    - `llc` = LLC
#'    - `part` = Partnership
#'    - `sole` = Sole Proprietor
#' @param prov_type `<enum>` Provider type:
#'    - `hospital` = Medicare Part A Hospital
#'    - `reh` = Rural Emergency Hospital
#'    - `cah` = Critical Access Hospital
#' @param loc_type `<enum>` Practice location type
#'    - `main` = Main/Primary Hospital Location
#'    - `psych` = Hospital Psychiatric Unit
#'    - `rehab` = Hospital Rehabilitation Unit
#'    - `swing` = Hospital Swing-Bed Unit
#'    - `ext` = Opt Extension Site
#'    - `other` = Other Hospital Practice Location
#' @param subgroup `<subgroups>` Hospital’s subgroup/unit. See [subgroups()].
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' hospitals(count = TRUE)
#'
#' hospitals2(count = TRUE)
#'
#' hospitals(prov_type = "reh", count = TRUE)
#' hospitals2(hosp_type = "reh", count = TRUE)
#'
#' x <- hospitals(
#'   city = "Atlanta",
#'   state = "GA",
#'   subgroup = subgroups(
#'     acute = FALSE,
#'     psych = TRUE))
#' x
#'
#' hospitals2(ccn = x$ccn)
#'
#' x <- hospitals2()
#' x
#'
#' hospitals(ccn = x$ccn)
#'
#' hospitals2(state = "GA", rating = 5) |> str()
#' @autoglobal
#' @export
hospitals <- function(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  enid_state = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  prov_type = NULL,
  loc_type = NULL,
  subgroup = subgroups(),
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_subgroups(subgroup)
  check_bool_(multi)
  check_char_(status)
  check_char_(org_type)
  check_char_(loc_type)
  check_char_(prov_type)

  execute(
    base_cms(
      end = "hospitals",
      count = count,
      set = set,
      arg = param_cms(
        NPI = npi,
        CCN = ccn,
        `ASSOCIATE ID` = pac,
        `ENROLLMENT ID` = enid,
        `ENROLLMENT STATE` = enid_state,
        `ORGANIZATION NAME` = org_name,
        `DOING BUSINESS AS NAME` = org_dba,
        CITY = city,
        STATE = state,
        `ZIP CODE` = zip,
        `MULTIPLE NPI FLAG` = bool_(multi),
        PROPRIETARY_NONPROFIT = status,
        `ORGANIZATION TYPE STRUCTURE` = enum_(org_type),
        `PROVIDER TYPE CODE` = enum_(prov_type),
        `PRACTICE LOCATION TYPE` = enum_(loc_type),
        !!!subgroup
      )
    )
  )
}

#' Hospital Subgroups
#'
#' @param acute `<lgl>` Acute/Short Term Care Hospital
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
#'
#' @returns A `<subgroups>` object
#'
#' @examples
#' subgroups(acute = TRUE, rehab = TRUE)
#'
#' subgroups()
#'
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
  check_bool_(general)
  check_bool_(acute)
  check_bool_(drug)
  check_bool_(child)
  check_bool_(long)
  check_bool_(psych)
  check_bool_(rehab)
  check_bool_(short)
  check_bool_(swing)
  check_bool_(psych_unit)
  check_bool_(rehab_unit)
  check_bool_(specialty)
  check_bool_(other)

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
    bool_
  )
  structure(params(!!!x), class = "subgroups")
}

#' @noRd
is_subgroups <- function(x) {
  inherits(x, "subgroups")
}

#' @export
print.subgroups <- function(x, ...) {
  v <- length(x)
  cli::cat_rule(
    cli::format_inline(cli::col_cyan("<subgroups[{v}]>")),
    width = 22,
    line = 2,
    line_col = "cyan"
  )
  if (v) {
    cli_apis(x)
  }
  invisible(x)
}
