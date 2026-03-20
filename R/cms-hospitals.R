#' Hospitals Enrolled in Medicare
#'
#' @description
#' Hospitals currently enrolled in Medicare. Data includes the hospital's
#' sub-group types, legal business name, doing-business-as name, organization
#' type and address.
#'
#' @source
#'    - [API: Hospital Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' @param npi `<int>` National Provider Identifier
#' @param ccn `<int>` CMS Certification Number
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid,enid_state `<chr>` Medicare Enrollment ID, Enrollment state
#' @param org_name `<chr>` Legal business name
#' @param dba_name `<chr>` Doing-business-as name
#' @param city,state,zip `<chr>` Location city, state, zip
#' @param multi `<lgl>` Does hospital have more than one NPI?
#' @param org_status `<enum>` Organization status
#'    - `P` = Proprietary
#'    - `N` = Non-Profit
#'    - `D` = Unknown
#' @param org_type `<enum>` Organization structure type
#' @param provider_type `<enum>` Provider type;
#'    - `hospital` = Part A Hospital
#'    - `reh` = Rural Emergency Hospital
#'    - `cah` = Critical Access Hospital
#' @param location_type `<enum>` Practice location type
#'    - `main` = Main/Primary Hospital Location
#'    - `psych` = Hospital Psychiatric Unit
#'    - `rehab` = Hospital Rehabilitation Unit
#'    - `ext` = Opt Extension Site
#'    - `other` = Other Hospital Practice Location
#' @param subgroup `<subgroups>` Hospital’s subgroup/unit. See [subgroups()].
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' hospitals(count = TRUE)
#' hospitals(state = "GA", provider_type = "reh")
#' hospitals(
#'   city = "Atlanta",
#'   state = "GA",
#'   subgroup = subgroups(
#'     acute = FALSE,
#'     psych = TRUE
#'   )
#' )
#' @autoglobal
#' @export
hospitals <- function(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  enid_state = NULL,
  org_name = NULL,
  dba_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  org_status = NULL,
  org_type = NULL,
  provider_type = NULL,
  location_type = NULL,
  subgroup = subgroups(),
  count = FALSE
) {
  check_subgroups(subgroup)
  check_bool(multi, allow_null = TRUE)
  check_character(provider_type, allow_null = TRUE)
  check_character(org_status, allow_null = TRUE)

  exec_cms(
    END = call_name(call_match()),
    COUNT = count,
    ARG = params(
      NPI = npi,
      CCN = ccn,
      `ASSOCIATE ID` = pac,
      `ENROLLMENT ID` = enid,
      `ENROLLMENT STATE` = enid_state,
      `ORGANIZATION NAME` = org_name,
      `DOING BUSINESS AS NAME` = dba_name,
      CITY = city,
      STATE = state,
      `ZIP CODE` = zip,
      `MULTIPLE NPI FLAG` = bool_(multi),
      PROPRIETARY_NONPROFIT = org_status,
      `ORGANIZATION TYPE STRUCTURE` = enum_(org_type),
      `PROVIDER TYPE CODE` = enum_(provider_type),
      `PRACTICE LOCATION TYPE` = enum_(location_type),
      !!!subgroup
    )
  )
}

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
#' @rdname hospitals
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
    bool_
  )
  structure(params(!!!x), class = "subgroups")
}

#' @noRd
is_subgroups <- function(x) {
  inherits(x, "subgroups")
}
