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
#'    - `llc` = LLC
#'    - `other` = Other
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
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' hospital(count = TRUE)
#'
#' hospital(prov_type = "cah", state = "GA")
#'
#' hospital(
#'   city = "Atlanta",
#'   state = "GA",
#'   subgroup = subgroups(acute = FALSE)
#' )
#'
#' @export
hospital <- function(
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
  count = FALSE
) {
  check_subgroups(subgroup)
  check_bool_(multi)
  check_char_(status)
  check_char_(org_type)
  check_char_(loc_type)
  check_char_(prov_type)

  x <- end_cms(
    count = count,
    set = FALSE,
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

  x <- as_keyframe(x, "ccn", 200L)

  chain(x, KeyChain$hospital2)
}

#' Hospital General Information
#'
#' @description A list of all hospitals that have been registered with Medicare.
#'   The list includes addresses, phone numbers, hospital type, and overall
#'   hospital rating.
#'
#' @source
#'    * [API: Hospital General Information](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'    * [API: Data Dictionary](https://data.cms.gov/provider-data/dataset/xubh-q36u#data-dictionary)
#'
#' @param county `<chr>` Location county
#' @param hosp_type `<enum>` Provider type:
#'    - `acute` = Acute Care
#'    - `cah` = Critical Access Hospital
#'    - `child` = Childrens' Hospital
#'    - `dod` = Acute Care - Department of Defense
#'    - `ltc` = Long-term
#'    - `psych` = Psychiatric
#'    - `reh` = Rural Emergency Hospital
#'    - `vha` = Acute Care - Veterans Administration
#' @param own_type `<enum>` Ownership type:
#'    - `private` = Voluntary non-profit - Private
#'    - `other` = Voluntary non-profit - Other
#'    - `church` = Voluntary non-profit - Church
#'    - `district` = Government - Hospital District or Authority
#'    - `local` = Government - Local
#'    - `federal` = Government - Federal
#'    - `state` = Government - State
#'    - `dod` = Department of Defense
#'    - `profit` = Proprietary
#'    - `physician` = Physician
#'    - `tribal` = Tribal
#'    - `vha` = Veterans Health Administration
#' @param rating `<int>` Hospital rating; 1-5 or "Not Available"
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @keywords internal
#' @export
hospital2 <- function(
  ccn = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  hosp_type = NULL,
  own_type = NULL,
  rating = NULL,
  count = FALSE
) {
  x <- end_pdc(
    count = count,
    set = FALSE,
    facility_id = ccn,
    facility_name = org_name,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county,
    hospital_type = tag_enum(hosp_type),
    hospital_ownership = tag_enum(own_type),
    hospital_overall_rating = rating
  )

  x <- execute(x)

  polish(x)
}

#' @noRd
Subgroups <- S7::new_class(
  name = "Subgroups",
  parent = S7::class_list,
  package = NULL
)

#' @noRd
is_subgroups <- function(x) {
  S7::S7_inherits(x, Subgroups)
}

#' @noRd
check_subgroups <- function(
  x,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (is_subgroups(x)) {
    return(invisible(NULL))
  }
  cli::cli_abort(
    c(
      "{.arg {arg}} must be a {.cls Subgroups} object, not a {.obj_type_friendly {x}}",
      "i" = "Use {.fn provider::subgroups} to create one"
    ),
    arg = arg,
    call = call
  )
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
#' @returns An S7 `<Subgroups>` object
#' @examples
#' subgroups(acute = TRUE, rehab = FALSE)
#' subgroups()
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
    tag_bool
  )

  Subgroups(params(!!!x))
}
