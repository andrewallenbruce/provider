#' @noRd
tag_bool <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }
  if (x) "Y" else "N"
}

#' @noRd
tag_enum <- function(x = NULL, call = rlang::caller_env()) {
  if (is.null(x)) {
    return(NULL)
  }

  VAR <- rlang::as_string(rlang::call_args(rlang::call_match())$x)

  ENUM <- enumerations(VAR)

  x <- rlang::arg_match(
    arg = x,
    values = rlang::names2(ENUM),
    multiple = TRUE,
    error_arg = VAR,
    error_call = call
  )

  unlist_(ENUM[x])
}

#' @noRd
enumerations <- function(
  x,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  switch(
    x,
    # <clia>
    acr_org = list(
      a2la = "A2LA_ACRDTD_Y_MATCH_SW",
      aabb = "AABB_ACRDTD_Y_MATCH_SW",
      aoa = "AOA_ACRDTD_Y_MATCH_SW",
      ashi = "ASHI_ACRDTD_Y_MATCH_SW",
      cap = "CAP_ACRDTD_Y_MATCH_SW",
      cola = "COLA_ACRDTD_Y_MATCH_SW",
      jcaho = "JCAHO_ACRDTD_Y_MATCH_SW"
    ),
    cert_type = list(
      cmp = 1,
      wav = 2,
      acr = 3,
      ppm = 4,
      reg = 9
    ),
    multi = list(
      applied = "MLT_SITE_EXCPTN_SW",
      campus = "HOSP_LAB_EXCPTN_SW",
      non = "NON_PRFT_EXCPTN_SW",
      temp = "LAB_TEMP_TSTG_SITE_SW"
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
    # <hospitals>
    loc_type = list(
      other = "OTHER HOSPITAL PRACTICE LOCATION",
      main = "MAIN/PRIMARY HOSPITAL LOCATION",
      psych = "HOSPITAL PSYCHIATRIC UNIT",
      rehab = "HOSPITAL REHABILITATION UNIT",
      swing = "HOSPITAL SWING-BED UNIT",
      ext = "OPT EXTENSION SITE"
    ),
    # <hospitals>
    # <facility>
    org_type = list(
      corp = "CORPORATION",
      other = "OTHER",
      llc = "LLC",
      part = "PARTNERSHIP",
      sole = "SOLE PROPRIETOR"
    ),
    # <hospitals2>
    own_type = list(
      dod = "Department of Defense",
      profit = "Proprietary",
      physician = "Physician",
      tribal = "Tribal",
      private = "Voluntary non-profit - Private",
      other = "Voluntary non-profit - Other",
      church = "Voluntary non-profit - Church",
      district = "Government - Hospital District or Authority",
      local = "Government - Local",
      federal = "Government - Federal",
      state = "Government - State",
      vha = "Veterans Health Administration"
    ),
    hosp_type = list(
      acute = "Acute Care Hospitals",
      cah = "Critical Access Hospitals",
      child = "Childrens",
      dod = "Acute Care - Department of Defense",
      ltc = "Long-term",
      psych = "Psychiatric",
      reh = "Rural Emergency Hospital",
      vha = "Acute Care - Veterans Administration"
    ),
    cli::cli_abort(
      "{.val {arg}} is not an {.cls enum}",
      arg = arg,
      call = call
    )
  )
}
