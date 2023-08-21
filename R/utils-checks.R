#' NPI Validation Check
#'
#' @description checks validity of NPI input against CMS requirements.
#'
#' ## Links
#'  * [The Luhn Algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm)
#'  * [CMS NPI Standard](https://www.cms.gov/Regulations-and-Guidance/Administrative-Simplification/NationalProvIdentStand/Downloads/NPIcheckdigit.pdf)
#'
#' @param npi 10-digit National Provider Identifier (NPI).
#' @return boolean, `TRUE` or `FALSE`
#' @examplesIf interactive()
#' # Valid:
#' npi_check(1528060837)
#' npi_check("1528060837")
#'
#' # Invalid:
#' npi_check(1234567891)
#' npi_check(123456789)
#' npi_check("152806O837")
#' @autoglobal
#' @noRd
npi_check <- function(npi,
                      arg = rlang::caller_arg(npi),
                      call = rlang::caller_env()) {

  # Return FALSE if not a number
  if (grepl("^[[:digit:]]+$", npi) == FALSE) {
    cli::cli_abort(c(
      "An {.strong NPI} must be {.emph numeric}.",
      "x" = "{.val {npi}} contains {.emph non-numeric} characters."), call = call)
  }

  # Must be 10 char length
  if (nchar(npi) != 10L) {
    cli::cli_abort(c(
      "An {.strong NPI} must be {.emph 10 digits long}.",
      "x" = "{.val {npi}} contains {.val {nchar(npi)}} digit{?s}."), call = call)
  }

  # Strip whitespace
  npi_luhn <- gsub(pattern = " ", replacement = "", npi)

  # Paste 80840 to each NPI number, per CMS documentation
  npi_luhn <- paste0("80840", npi_luhn)

  # Split string, Convert to list and reverse
  npi_luhn <- unlist(strsplit(npi_luhn, ""))
  npi_luhn <- npi_luhn[length(npi_luhn):1]
  to_replace <- seq(2, length(npi_luhn), 2)
  npi_luhn[to_replace] <- as.numeric(npi_luhn[to_replace]) * 2

  # Convert to numeric
  npi_luhn <- as.numeric(npi_luhn)

  # Must be a single digit, any that are > 9, subtract 9
  npi_luhn <- ifelse(npi_luhn > 9, npi_luhn - 9, npi_luhn)

  # Check if the sum divides by 10
  if ((sum(npi_luhn) %% 10) != 0) {
    cli::cli_abort(c(
      "An {.strong NPI} must pass {.emph Luhn algorithm}.",
      "x" = "{.val {npi}} {.emph fails} Luhn check."), call = call)
  }
}

#' PAC ID Validation Check
#'
#' @description checks validity of Provider associate level variable (PAC ID)
#'    input against CMS requirements.
#'
#' @details A PAC ID is a 10-digit unique numeric identifier that is assigned
#'    to each individual or organization in PECOS. All entity-level information
#'    (e.g., tax identification numbers and organizational names) is linked
#'    through the PAC ID. A PAC ID may be associated with multiple Enrollment
#'    IDs if the individual or organization enrolled multiple times under
#'    different circumstances.
#'
#' @param pac_id 10-digit unique numeric identifier
#' @return boolean, `TRUE` or `FALSE`
#' @examplesIf interactive()
#' # Valid:
#' pac_check(1528060837)
#' pac_check("1528060837")
#'
#' # Invalid:
#' pac_check(1234567891)
#' pac_check(123456789)
#' pac_check("152806O837")
#' @autoglobal
#' @noRd
pac_check <- function(pac_id,
                      arg = rlang::caller_arg(pac_id),
                      call = rlang::caller_env()) {

  # Return FALSE if not a number
  if (grepl("^[[:digit:]]+$", pac_id) == FALSE) {
    cli::cli_abort(c(
      "A {.strong PAC ID} must be {.emph numeric}.",
      "x" = "{.val {pac_id}} contains {.emph non-numeric} characters."), call = call)
  }

  # Must be 10 char length
  if (nchar(pac_id) != 10L) {
    cli::cli_abort(c(
      "A {.strong PAC ID} must be {.emph 10 digits long}.",
      "x" = "{.val {pac_id}} contains {.val {nchar(pac_id)}} digit{?s}."), call = call)
  }
}

#' Enrollment ID Validation Check
#'
#' @description checks validity of Provider enrollment ID input against CMS
#'    requirements.
#'
#' @details An Enrollment ID is a 15-digit unique alphanumeric identifier that
#'    is assigned to each new provider enrollment application. All
#'    enrollment-level information (e.g., enrollment type, enrollment state,
#'    provider specialty and reassignment of benefits) is linked through the
#'    Enrollment ID.
#'
#' @param enroll_id 15-digit unique alphanumeric identifier
#' @return boolean, `TRUE` or `FALSE`
#' @examplesIf interactive()
#' # Valid:
#' enroll_check(1528060837)
#' enroll_check("1528060837")
#'
#' # Invalid:
#' enroll_check(1234567891)
#' enroll_check(123456789)
#' enroll_check("152806O837")
#' @autoglobal
#' @noRd
enroll_check <- function(enroll_id,
                         arg = rlang::caller_arg(enroll_id),
                         call = rlang::caller_env()) {

  # Abort if numeric
  if (is.numeric(enroll_id) == TRUE) {
    cli::cli_abort(c(
      "An {.strong Enrollment ID} must be a {.emph character} vector.",
      "x" = "{.val {enroll_id}} is a {.cls {class(enroll_id)}} vector."), call = call)
  }

  # Must be 15 char length
  if (nchar(enroll_id) != 15L) {
    cli::cli_abort(c(
      "An {.strong Enrollment ID} must be {.emph 15 characters long}.",
      "x" = "{.val {enroll_id}} contains {.val {nchar(enroll_id)}} character{?s}."), call = call)
  }

  first <- unlist(strsplit(enroll_id, ""))[1]

  if ((first %in% c("I", "O")) != TRUE) {

    cli::cli_abort(c(
      "An {.strong Enrollment ID} must begin with a {.emph capital} {.strong `I`} or {.strong `O`}.",
      "x" = "{.val {enroll_id}} begins with {.val {first}}."), call = call)

  }
}

#' Organizational/Group Enrollment ID Validation Check
#'
#' @description checks validity of Organizational/Group provider enrollment ID
#'    input against CMS requirements.
#'
#' @details An Enrollment ID is a 15-digit unique alphanumeric identifier that
#'    is assigned to each new provider enrollment application. All
#'    enrollment-level information (e.g., enrollment type, enrollment state,
#'    provider specialty and reassignment of benefits) is linked through the
#'    Enrollment ID.
#'
#' @param enroll_id 15-digit unique alphanumeric identifier
#' @return boolean, `TRUE` or `FALSE`
#' @examplesIf interactive()
#' # Valid:
#' enroll_check(1528060837)
#' enroll_check("1528060837")
#'
#' # Invalid:
#' enroll_check(1234567891)
#' enroll_check(123456789)
#' enroll_check("152806O837")
#' @autoglobal
#' @noRd
enroll_org_check <- function(enroll_id,
                             arg = rlang::caller_arg(enroll_id),
                             call = rlang::caller_env()) {

  first <- unlist(strsplit(enroll_id, ""))[1]

  if ((first %in% c("O")) != TRUE) {

    cli::cli_abort(c(
      "An {.emph organizational/group} {.strong Enrollment ID} must begin with a {.emph capital} {.strong `O`}.",
      "x" = "{.val {enroll_id}} begins with {.val {first}}."), call = call)

  }
}

#' Individual Enrollment ID Validation Check
#'
#' @description checks validity of Individual provider enrollment ID
#'    input against CMS requirements.
#'
#' @details An Enrollment ID is a 15-digit unique alphanumeric identifier that
#'    is assigned to each new provider enrollment application. All
#'    enrollment-level information (e.g., enrollment type, enrollment state,
#'    provider specialty and reassignment of benefits) is linked through the
#'    Enrollment ID.
#'
#' @param enroll_id 15-digit unique alphanumeric identifier
#' @return boolean, `TRUE` or `FALSE`
#' @examplesIf interactive()
#' # Valid:
#' enroll_check(1528060837)
#' enroll_check("1528060837")
#'
#' # Invalid:
#' enroll_check(1234567891)
#' enroll_check(123456789)
#' enroll_check("152806O837")
#' @autoglobal
#' @noRd
enroll_ind_check <- function(enroll_id,
                             arg = rlang::caller_arg(enroll_id),
                             call = rlang::caller_env()) {

  first <- unlist(strsplit(enroll_id, ""))[1]

  if ((first %in% c("I")) != TRUE) {

    cli::cli_abort(c(
      "An {.emph individual} {.strong Enrollment ID} must begin with a {.emph capital} {.strong `I`}.",
      "x" = "{.val {enroll_id}} begins with {.val {first}}."), call = call)

  }
}

#' Facility CCN Validation Check
#'
#' @description checks validity of CMS Certification Number (CCN) input against
#'    CMS requirements.
#'
#' @details Effective in 2007, the CCN replaced the term Medicare Provider
#'    Number, Medicare Identification Number or OSCAR Number.  The CCN is used
#'    to verify Medicare/Medicaid certification for survey and certification,
#'    assessment-related activities and communications. Additionally, CMS data
#'    systems use the CCN to identify each individual provider or supplier that
#'    has or currently does participate in Medicare and/or Medicaid.
#'
#' @param facility_ccn 6-digit unique alphanumeric identifier
#' @return boolean, `TRUE` or `FALSE`
#' @examplesIf interactive()
#' facility_ccn_check(facility_ccn = "11T122")
#' @autoglobal
#' @noRd
facility_ccn_check <- function(facility_ccn,
                               arg = rlang::caller_arg(facility_ccn),
                               call = rlang::caller_env()) {

  # Abort if numeric
  # if (grepl("^[[:digit:]]+$", enroll_id) == TRUE) {
  #   cli::cli_abort(c(
  #     "{.strong Enrollment ID} must be {.emph alpha-numeric}.",
  #     "x" = "{.val {enroll_id}} is numeric."), call = call)
  # }

  # Must be 10 char length
  if (nchar(enroll_id) != 15L) {
    cli::cli_abort(c(
      "{.strong Enrollment ID} must be {.emph 15 characters long}.",
      "x" = "{.val {enroll_id}} contains {.val {nchar(enroll_id)}} character{?s}."), call = call)
  }

  first <- unlist(strsplit(enroll_id, ""))[1]

  if ((first %in% c("I", "O")) != TRUE) {

    cli::cli_abort(c(
      "{.strong Enrollment ID} must begin with a {.emph capital} {.strong `I`} or {.strong `O`}.",
      "x" = "{.val {enroll_id}} begins with {.val {first}}."), call = call)

  }
}
