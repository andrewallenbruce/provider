#' Format US ZIP codes
#'
#' @param zip Nine-digit US ZIP code
#'
#' @return ZIP code, hyphenated for ZIP+4 or 5-digit ZIP.
#'
#' @examples
#' format_zipcode(123456789)
#'
#' format_zipcode(12345)
#'
#' @autoglobal
#' @keyword internal
#' @export

format_zipcode <- function(zip) {

  zip <- as.character(zip)

  if (stringr::str_detect(zip, "^[[:digit:]]{9}$") == TRUE) {

    zip <- paste0(stringr::str_sub(zip, 1, 5), "-", stringr::str_sub(zip, 6, 9))

    return(zip)

  } else {

    return(zip)

  }
}
