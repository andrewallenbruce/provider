#' @noRd
cv_lgl <- function(x = NULL) {
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

  VAR <- rlang::as_string(
    rlang::call_args(
      rlang::call_match()
    )[[1]]
  )

  ENUM <- enum_map(VAR)

  x <- rlang::arg_match(
    arg = x,
    values = rlang::names2(ENUM),
    multiple = TRUE,
    error_arg = VAR
  )

  unlist_(ENUM[x])
}

#' @noRd
enum_map <- function(arg) {
  switch(
    arg,
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
    certification = list(
      compliance = 1,
      waiver = 2,
      accreditation = 3,
      ppm = 4,
      registration = 9
    ),
    cli::cli_abort("{.arg arg} {.val {arg}} invalid.")
  )
}
