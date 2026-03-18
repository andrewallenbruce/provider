#' @noRd
bool_ <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }

  cheapr::val_match(
    x,
    TRUE ~ "Y",
    FALSE ~ "N"
  )
}

#' @noRd
enum_ <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }

  VAR <- as_string(call_args(call_match())$x)

  ENUM <- enumerations(VAR)

  x <- arg_match(
    arg = x,
    values = names2(ENUM),
    multiple = TRUE,
    error_arg = VAR
  )

  unlist_(ENUM[x])
}

#' @noRd
enumerations <- function(arg) {
  switch(
    arg,
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
    # <clia>
    certificate = list(
      cmp = 1,
      wav = 2,
      acc = 3,
      ppm = 4,
      reg = 9
    ),
    # <clia>
    status = list(
      cmp = "A",
      non = "B"
    ),
    # <hospitals>
    provider_type = list(
      hospital = "00-09",
      reh = "00-24",
      cah = "00-85"
    ),
    # <hospitals>
    location_type = list(
      other = "OTHER HOSPITAL PRACTICE LOCATION",
      primary = "MAIN/PRIMARY HOSPITAL LOCATION",
      psych_unit = "HOSPITAL PSYCHIATRIC UNIT",
      rehab_unit = "HOSPITAL REHABILITATION UNIT",
      extension = "OPT EXTENSION SITE"
    ),
    # <hospitals>
    org_type = list(
      corp = "CORPORATION",
      other = "OTHER",
      llc = "LLC",
      partner = "PARTNERSHIP",
      sole = "SOLE PROPRIETOR"
    ),
    cli::cli_abort("{.arg arg} {.val {arg}} invalid.")
  )
}
