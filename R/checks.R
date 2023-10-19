#' NPI Validation Check
#'
#' @description checks validity of NPI input against CMS requirements.
#'
#' @section National Provider Identifier (NPI):
#' + [The Luhn Algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm)
#' + [CMS NPI Standard](https://www.cms.gov/Regulations-and-Guidance/Administrative-Simplification/NationalProvIdentStand/Downloads/NPIcheckdigit.pdf)
#'
#' @param x 10-digit National Provider Identifier (NPI)
#' @return character vector
#' @examplesIf interactive()
#' # Valid:
#' check_npi(1528060837)
#' check_npi("1528060837")
#'
#' # Invalid:
#' check_npi(1234567891)
#' check_npi(123456789)
#' check_npi("152806O837")
#' @autoglobal
#' @noRd
check_npi <- function(x,
                      arg = rlang::caller_arg(x),
                      call = rlang::caller_env()) {

  #------------------------------------------Must be numeric
  if (grepl("^[[:digit:]]+$", x) == FALSE) {
    cli::cli_abort(c(
      "An {.strong NPI} must be {.emph numeric}.",
      "x" = "{.val {x}} contains {.emph non-numeric} characters."),
      call = call)
  }

  #------------------------------------------Must be 10 char length
  if (nchar(x) != 10L) {
    cli::cli_abort(c(
      "An {.strong NPI} must be {.emph 10 digits long}.",
      "x" = "{.val {x}} contains {.val {nchar(x)}} digit{?s}."),
      call = call)
  }

  #------------------------------------------Must pass Luhn algorithm
  # 1. Strip whitespace and convert to character vector
  luhn <- gsub(pattern = " ", replacement = "", x)

  # 2. Paste 80840 to each NPI number, per CMS documentation
  luhn <- paste0("80840", luhn)

  # 3. Split and unlist string
  luhn <- unlist(strsplit(luhn, ""))

  # 4. Reverse order
  luhn <- luhn[length(luhn):1]
  replace <- seq(2, length(luhn), 2)
  luhn[replace] <- as.numeric(luhn[replace]) * 2

  # Convert to numeric
  luhn <- as.numeric(luhn)

  # Must be a single digit, any that are > 9, subtract 9
  luhn <- ifelse(luhn > 9, luhn - 9, luhn)

  # Check if the sum divides by 10
  if ((sum(luhn) %% 10) != 0) {
    cli::cli_abort(c(
      "An {.strong NPI} must pass {.emph Luhn algorithm}.",
      "x" = "{.val {x}} {.emph fails} Luhn check."),
      call = call)
  }
  return(as.character(x))
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
#' check_pac(1528060837)
#' check_pac("1528060837")
#'
#' # Invalid:
#' check_pac(1234567891)
#' check_pac(123456789)
#' check_pac("152806O837")
#' @autoglobal
#' @noRd
check_pac <- function(x,
                      arg = rlang::caller_arg(x),
                      call = rlang::caller_env()) {

  # Return FALSE if not a number
  if (grepl("^[[:digit:]]+$", x) == FALSE) {
    cli::cli_abort(c(
      "A {.strong PAC ID} must be {.emph numeric}.",
      "x" = "{.val {x}} contains {.emph non-numeric} characters."), call = call)
  }

  # Must be 10 char length
  if (nchar(x) != 10L) {
    cli::cli_abort(c(
      "A {.strong PAC ID} must be {.emph 10 digits long}.",
      "x" = "{.val {x}} contains {.val {nchar(x)}} digit{?s}."), call = call)
  }
  return(as.character(x))
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
#' @param x 15-digit unique alphanumeric identifier
#' @param arg description
#' @param call description
#' @param type `"ind"` or `"org"`
#' @return boolean, `TRUE` or `FALSE`
#' @examplesIf interactive()
#' # Valid:
#' check_enid(1528060837)
#' check_enid("1528060837")
#'
#' # Invalid:
#' check_enid(0123456789123456)
#' check_enid("0123456789123456")
#' check_enid("I123456789123456")
#' check_enid("152806O837")
#' @autoglobal
#' @noRd
check_enid <- function(x,
                       arg = rlang::caller_arg(x),
                       call = rlang::caller_env(),
                       type = NULL) {

  # Abort if not character vector
  if (is.character(x) != TRUE) {
    cli::cli_abort(c(
      "An {.strong Enrollment ID} must be a {.cls character} vector.",
      "x" = "{.val {x}} is a {.cls {class(x)}} vector."), call = call)
  }

  # Return TRUE if not a number
  if (grepl("^[[:digit:]]+$", x) == TRUE) {
    cli::cli_abort(c(
      "An {.strong Enrollment ID} must be {.emph numeric}.",
      "x" = "{.val {x}} contains {.emph non-numeric} characters."), call = call)
  }

  # Must be 15 char length
  if (nchar(x) != 15L) {
    cli::cli_abort(c(
      "An {.strong Enrollment ID} must be {.emph 15 characters long}.",
      "x" = "{.val {x}} contains {.val {nchar(x)}} character{?s}."), call = call)
  }

  first <- unlist(strsplit(x, ""))[1]

  if ((first %in% c("I", "O")) != TRUE) {

    cli::cli_abort(c(
      "An {.strong Enrollment ID} must begin with a {.emph capital} {.strong `I`} or {.strong `O`}.",
      "x" = "{.val {x}} begins with {.val {first}}."), call = call)

  }

  if (!is.null(type) && type %in% "ind") {
    first <- unlist(strsplit(x, ""))[1]
    if (first != "I") {
      cli::cli_abort(c(
        "An {.strong Individual Enrollment ID} must begin with a {.emph capital} {.strong `I`}.",
        "x" = "{.val {x}} begins with {.val {first}}."), call = call)
    }
  }

  if (!is.null(type) && type %in% "org") {
    first <- unlist(strsplit(x, ""))[1]
    if (first != "O") {
      cli::cli_abort(c(
        "An {.strong Organizational Enrollment ID} must begin with a {.emph capital} {.strong `O`}.",
        "x" = "{.val {x}} begins with {.val {first}}."), call = call)
    }
  }
}
