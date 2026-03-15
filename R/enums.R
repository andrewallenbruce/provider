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

  VAR <- rlang::as_string(rlang::call_args(rlang::call_match())[[1]])

  ENUM <- enumerations(VAR)

  x <- rlang::arg_match(
    arg = x,
    values = rlang::names2(ENUM),
    multiple = TRUE,
    error_arg = VAR
  )

  unlist_(ENUM[x])
}

#' @noRd
enumerations <- function(arg) {
  switch(
    arg,
    # affiliations
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
    # clia
    certificate = list(
      cmp = 1,
      wav = 2,
      acc = 3,
      ppm = 4,
      reg = 9
    ),
    # clia
    status = list(
      cmp = "A",
      non = "B"
    ),
    specialty = list(
      hospital = "00-09",
      reh = "00-24",
      cah = "00-85"
    ),
    cli::cli_abort("{.arg arg} {.val {arg}} invalid.")
  )
}
