#' @noRd
bool_ <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }
  cheapr::val_match(x, TRUE ~ "Y", FALSE ~ "N")
}

#' @noRd
enum_ <- function(x = NULL, call = caller_env()) {
  if (is.null(x)) {
    return(NULL)
  }

  VAR <- as_string(call_args(call_match())$x)

  ENUM <- enumerations(VAR)

  x <- arg_match(
    arg = x,
    values = names2(ENUM),
    multiple = TRUE,
    error_arg = VAR,
    error_call = call
  )

  unlist_(ENUM[x])
}

#' @noRd
enumerations <- function(x, arg = caller_arg(x), call = caller_env()) {
  switch(
    x,
    # <clia>
    accreditation = list(
      a2la = "A2LA_ACRDTD_Y_MATCH_SW",
      aabb = "AABB_ACRDTD_Y_MATCH_SW",
      aoa = "AOA_ACRDTD_Y_MATCH_SW",
      ashi = "ASHI_ACRDTD_Y_MATCH_SW",
      cap = "CAP_ACRDTD_Y_MATCH_SW",
      cola = "COLA_ACRDTD_Y_MATCH_SW",
      jcaho = "JCAHO_ACRDTD_Y_MATCH_SW"
    ),
    # <transparency>
    action = list(
      met = "Met Requirements",
      admin = "Administrative Closure",
      warn = "Warning Notice",
      cap = "CAP Request",
      closure = "Closure Notice",
      cmp = "CMP Notice",
      appeal = "Appealed"
    ),
    # <clia>
    certificate = list(
      compliance = 1,
      waiver = 2,
      accreditation = 3,
      ppm = 4,
      registration = 9
    ),
    # <affiliations>
    facility_type = list(
      hospital = "Hospital",
      ltch = "Long-term care hospital",
      nurse = "Nursing home",
      irf = "Inpatient rehabilitation facility",
      hha = "Home health agency",
      snf = "Skilled nursing facility",
      hospice = "Hospice",
      esrd = "Dialysis facility"
    ),
    # <hospitals>
    prov_type = list(
      hospital = "00-09",
      reh = "00-24",
      cah = "00-85"
    ),
    # TODO: rename `location`
    # <hospitals>
    loc_type = list(
      other = "OTHER HOSPITAL PRACTICE LOCATION",
      main = "MAIN/PRIMARY HOSPITAL LOCATION",
      psych = "HOSPITAL PSYCHIATRIC UNIT",
      rehab = "HOSPITAL REHABILITATION UNIT",
      swing = "HOSPITAL SWING-BED UNIT",
      ext = "OPT EXTENSION SITE"
    ),
    # TODO: rename `structure`
    # <hospitals>
    # <rhc_enroll>
    org_type = list(
      corp = "CORPORATION",
      other = "OTHER",
      llc = "LLC",
      part = "PARTNERSHIP",
      sole = "SOLE PROPRIETOR"
    ),
    cli::cli_abort(
      "{.val {arg}} is not an {.cls enum}",
      arg = arg,
      call = call
    )
  )
}
