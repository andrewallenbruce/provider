#' Hospitals Enrolled in Medicare
#'
#' @description Hospitals currently enrolled in Medicare. Data includes the
#'   hospital's sub-group types, legal business name, doing-business-as name,
#'   organization type and address.
#'
#' @source
#'    - [API: Hospital Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' @inheritParams provider_common_params
#' @param npi `<int>` National Provider Identifier
#' @param ccn `<int>` CMS Certification Number
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid `<chr>` Medicare Enrollment ID
#' @param org_name `<chr>` Legal business name
#' @param org_dba `<chr>` Doing-business-as name
#' @param city,state,zip `<chr>` Location city, state, zip
#' @param multi `<lgl>` Does hospital have more than one NPI?
#' @param status `<enum>` Organization status
#'    - `P` = Proprietary
#'    - `N` = Non-Profit
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
#' @examplesIf httr2::is_online()
#' hospitals(
#'   prov_type = "cah",
#'   state = "GA"
#'  )
#'
#' hospitals(
#'   city = "Atlanta",
#'   state = "GA",
#'   subgroup = subgroups(
#'     acute = FALSE
#'    )
#'  )
#'
#' hospitals(ccn = hospitals2()$ccn)
#'
#' @export
hospitals <- function(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
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
  check_subgroups(subgroup)
  check_bool_(multi)
  check_char_(status)
  check_char_(org_type)
  check_char_(loc_type)
  check_char_(prov_type)

  x <- cms(
    count = count,
    set = set,
    NPI = npi,
    CCN = ccn,
    `ASSOCIATE ID` = pac,
    `ENROLLMENT ID` = enid,
    `ORGANIZATION NAME` = org_name,
    `DOING BUSINESS AS NAME` = org_dba,
    CITY = city,
    STATE = state,
    `ZIP CODE` = zip,
    `MULTIPLE NPI FLAG` = tag_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type),
    `PROVIDER TYPE CODE` = tag_enum(prov_type),
    `PRACTICE LOCATION TYPE` = tag_enum(loc_type),
    !!!S7::S7_data(subgroup)
  )

  x <- execute(x)
  x <- polish(x)

  if (count) {
    return(invisible(x))
  }

  chain(x, fn_hospitals2)
}

#' @noRd
Subgroups <- S7::new_class(
  "Subgroups",
  S7::class_list,
  package = NULL
)

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
#' @returns A `<Subgroups>` object
#'
#' @examples
#' subgroups(acute = TRUE, rehab = FALSE)
#'
#' subgroups()
#'
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
    tag_bool
  )

  Subgroups(params(!!!x))
}

#' @noRd
is_subgroups <- function(x) {
  S7::S7_inherits(x, Subgroups)
}

#' @noRd
check_subgroups <- function(x) {
  if (!is_subgroups(x)) {
    cli::cli_abort(c(
      "{.arg subgroup} must be a {.cls Subgroups} object, not a {.cls {class(x)}}",
      "i" = "Use the {.fn subgroups} helper function"
    ))
  }
}

#' @noRd
S7::method(print, Subgroups) <- function(x, ...) {
  x <- S7::S7_data(x)
  n <- cheapr::unlisted_length(x)

  cli::cli_text(cli::col_cyan("<Subgroups[{n}]>"))
  if (length(x)) {
    cli::cat_bullet(
      paste0(
        cli::col_yellow(left(names(x))),
        cli::col_silver(" : "),
        left(mark(unname(x)))
      ),
      bullet_col = "silver"
    )
  }
  invisible(x)
}
