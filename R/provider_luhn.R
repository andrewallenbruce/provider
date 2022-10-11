#' Checks NPI number for compliance with the Luhn algorithm
#'
#' @description `provider_luhn()` checks NPIs against the Luhn algorithm for
#' compliance with the CMS requirements stated in the linked PDF below.
#'
#' # Requirements for NPI Check Digit
#'
#' The National Provider Identifier (NPI) check digit is calculated using
#' the Luhn formula for computing the modulus 10 “double-add-double” check
#' digit. This algorithm is recognized as an ISO standard and is the specified
#' check digit algorithm to be used for the card issuer identifier on a
#' standard health identification card.
#'
#' When an NPI is used as a card issuer identifier on a standard health
#' identification card, it is preceded by the prefix `80840`, in which `80`
#' indicates health applications and `840` indicates the United States.
#'
#' The prefix is required only when the NPI is used as a card issuer
#' identifier. However, in order that any NPI could be used as a card issuer
#' identifier on a standard health identification card, the check digit will
#' always be calculated as if the prefix is present. This is accomplished by
#' adding the constant `24` in step 2 of the check digit calculation (as shown
#' in the second example below) when the NPI is used without the prefix.
#'
#' ## Example NPI Check Digit Calculation (Card Issuer Identifier)
#'
#' Assume that the NPI is `123456789`.
#'
#' If used as a card issuer identifier on a standard health identification
#' card, the full number would be `80840123456789`. Using the Luhn formula
#' on the identifier portion, the check digit is calculated as follows:
#'
#' Card issuer identifier without check digit: `80840123456789`
#'
#' *Step 1*: Double the value of alternate digits,
#' beginning with the rightmost digit:
#'
#' `0 8 2 6 10 14 18`
#'
#' *Step 2*: Add the individual digits of products
#' of doubling, plus unaffected digits:
#'
#' `8 + 0 + 8 + 8 + 0 + 2 + 2 + 6 + 4 + 1 + 0 + 6 + 1 + 4 + 8 + 1 + 8 = 67`
#'
#' *Step 3*: Subtract from next higher number ending in zero.
#'
#' `70 – 67 = 3`
#'
#' The check digit equals 3, thus the card issuer identifier
#' with check digit is **80840**123456789**3**.
#'
#' ## Example NPI Check Digit Calculation (without Prefix)
#'
#' Assume that the NPI is `123456789`.
#'
#' Using the Luhn formula on the identifier portion, the check
#' digit is calculated as follows:
#'
#' NPI without check digit: `123456789`
#'
#' *Step 1*: Double the value of alternate digits,
#' beginning with the rightmost digit:
#'
#' `2 6 10 14 18`
#'
#' *Step 2*: Add constant `24`, to account for the `80840`
#' prefix that would be present on a card issuer identifier,
#' plus the individual digits of products of doubling,
#' plus unaffected digits:
#'
#' `24 + 2 + 2 + 6 + 4 + 1 + 0 + 6 + 1 + 4 + 8 + 1 + 8 = 67`
#'
#' *Step 3*: Subtract from next higher number ending in zero.
#'
#' `70 – 67 = 3`
#'
#' The check digit equals **3**, thus the NPI with check digit is 123456789**3**.
#'
#' ## Links
#'  * [The Luhn Algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm)
#'  * [CMS NPI Standard](https://www.cms.gov/Regulations-and-Guidance/Administrative-Simplification/NationalProvIdentStand/Downloads/NPIcheckdigit.pdf)
#'
#' @param npi 10-digit National Provider Identifier (NPI).
#'
#' @return boolean, `TRUE` or `FALSE`
#'
#' @examples
#' # Valid NPI:
#' provider_luhn(npi = 1528060837)
#'
#' # Quoted NPIs are valid:
#' provider_luhn(npi = "1528060837")
#'
#' # Invalid NPI (per Luhn algorithm):
#' provider_luhn(npi = 1234567891)
#'
#' \dontrun{
#' # NPIs with less than 10 digits throw an error:
#' provider_luhn(npi = 123456789)
#'
#' # Inputting letters will throw an error, quoted or not:
#' provider_luhn(npi = abcdefghij)
#' provider_luhn(npi = "abcdefghij")
#'}
#' @export

provider_luhn <- function(npi = NULL) {

  # Number of digits should be 10
  attempt::stop_if_not(nchar(npi) == 10,
    msg = c("NPIs must have 10 digits.
    Provided NPI has ", nchar(npi), " digits."))

  # Return FALSE if not a number
  if (!grepl("^[[:digit:]]+$", npi)) {return(FALSE)}

  # Strip whitespace
  npi <- gsub(pattern = " ", replacement = "", npi)

  # Paste 80840 to each NPI number, per CMS documentation
  npi <- paste0("80840", npi)

  # split string, convert to a list, reverse it
  npi <- unlist(strsplit(npi, ""))
  npi <- npi[length(npi):1]

  to_replace <- seq(2, length(npi), 2)
  npi[to_replace] <- as.numeric(npi[to_replace]) * 2

  # convert to numeric
  npi <- as.numeric(npi)

  # Must be a single digit, any that are > 9, subtract 9
  npi <- ifelse(npi > 9, npi - 9, npi)

  # checks if the sum divides by 10
  ((sum(npi) %% 10) == 0)
}
