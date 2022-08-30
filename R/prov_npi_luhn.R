#' Checks NPI number for compliance with the Luhn algorithm
#'
#' @inheritParams prov_npi_nppes
#'
#' @return boolean, TRUE or FALSE
#' @export
#'
#' @examples
#' prov_npi_luhn(1528060837)

prov_npi_luhn <- function(npi) {

  # must have at least 2 digits
  if (nchar(npi) <= 2) {
    return(FALSE)
  }

  # strip spaces
  npi <- gsub(pattern = " ", replacement = "", npi)

  # Paste 80840 to each NPI number
  npi <- paste0("80840", npi)

  # Return FALSE if not a number
  if (!grepl("^[[:digit:]]+$", npi)) {
    return(FALSE)
  }

  # split string, convert to a list, reverse it
  digits <- unlist(strsplit(npi, ""))
  digits <- digits[length(digits):1]

  to_replace <- seq(2, length(digits), 2)
  digits[to_replace] <- as.numeric(digits[to_replace]) * 2

  # convert to numeric
  digits <- as.numeric(digits)

  # a digit cannot be two digits, so any that are greater than 9, subtract 9
  digits <- ifelse(digits > 9, digits - 9, digits)

  # checks if the sum divides by 10
  ((sum(digits) %% 10) == 0)
}
