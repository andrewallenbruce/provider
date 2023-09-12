#' Format US ZIP codes
#' @param zip Nine-digit US ZIP code
#' @return ZIP code, hyphenated for ZIP+4 or 5-digit ZIP.
#' @examples
#' format_zipcode(123456789)
#' format_zipcode(12345)
#' @autoglobal
#' @noRd
format_zipcode <- function(zip) {
  zip <- as.character(zip)

  if (stringr::str_detect(zip, "^[[:digit:]]{9}$") == TRUE) {

    zip <- paste0(stringr::str_sub(zip, 1, 5), "-", stringr::str_sub(zip, 6, 9))

    return(zip)

    } else {
      return(zip)
    }
  }

#' Remove NULL elements from vector
#' @autoglobal
#' @noRd
remove_null <- function(x) {Filter(Negate(is.null), x)}

#' Clean up credentials
#' @param x Character vector of credentials
#' @return List of cleaned character vectors, with one list element per element
#'   of `x`
#' @autoglobal
#' @noRd
clean_credentials <- function(x) {

  if (!is.character(x)) {stop("x must be a character vector")}

  out <- gsub("\\.", "", x)

  return(out)
}

#' Convert True/False char values to logical
#' @param x vector
#' @autoglobal
#' @noRd
tf_logical <- function(x) {

  dplyr::case_when(
    x == "True" ~ as.logical(TRUE),
    x == "False" ~ as.logical(FALSE),
    .default = NA)
}

#' Convert Y/N char values to logical
#' @param x vector
#' @autoglobal
#' @noRd
yn_logical <- function(x) {

  dplyr::case_match(
    x,
    c("Y", "YES", "Yes", "yes", "y", "True") ~ TRUE,
    c("N", "NO", "No", "no", "n", "False") ~ FALSE,
    .default = NA
  )
}

#' Convert TRUE/FALSE values to Y/N
#' @param x vector
#' @autoglobal
#' @noRd
tf_2_yn <- function(x) {

  dplyr::case_match(
    x,
    c(TRUE) ~ "Y",
    c(FALSE) ~ "N",
    .default = NULL
  )
}



#' Convert Place of Service values
#' @param x vector
#' @autoglobal
#' @noRd
pos_char <- function(x) {

    dplyr::case_match(x,
      c("facility", "Facility", "F", "f") ~ "F",
      c("office", "Office", "O", "o") ~ "O",
      .default = NULL)
  }

#' display_long
#' @param df data frame
#' @autoglobal
#' @noRd
display_long <- function(df) {

  df |> dplyr::mutate(dplyr::across(dplyr::everything(),
                                    as.character)) |>
        tidyr::pivot_longer(dplyr::everything())
}

#' convert_breaks
#' @param x vector
#' @param decimal TRUE or FALSE
#' @autoglobal
#' @noRd
convert_breaks <- function(x, decimal = FALSE) {

  rx <- "(\\d{1,3}(?:,\\d{3})*(?:\\.\\d+)?)"

  p <- all(stringr::str_detect(x, "%"))

  if (length(unique(x)) == 1) {

    return(TRUE)

  } else if (all(stringr::str_detect(x, "\\d", negate = TRUE))) {

    return(factor(x, ordered = FALSE))

  }

  x <- stringr::str_replace(x, "\\sor\\s(fewer|lower)", "-")
  x <- stringr::str_replace(x, "\\sor\\s(more|higher)", "+")
  x <- stringr::str_replace(x, "\\sto\\s", " - ")
  x <- stringr::str_remove_all(x, "[^[\\+\\d\\s\\.-]]")
  x <- stringr::str_remove(x, "(?<=\\d)(\\.0)(?=\\D)")

  if (any(stringr::str_detect(x, sprintf("^%s$", rx)))) {

    x <- stringr::str_replace(x, paste0(rx, "(?:-$)"), "[0,\\1]")
    x <- stringr::str_replace(x, paste0(rx, "(?:\\+$)"), "[\\1, Inf)")
    x <- stringr::str_replace(x, sprintf("^%s$", rx), "[\\1,\\1]")

  } else if (p) {

    x <- stringr::str_replace(x, paste0(rx, "(?:-$)"), "[0,\\1)")
    x <- stringr::str_replace(x, paste0(rx, "(?:\\+$)"), "[\\1,100]")
    x <- stringr::str_replace(x, paste(rx, "-", rx), "[\\1,\\2)")

    if (decimal) {

      x <- stringr::str_replace_all(x, rx, function(p) as.numeric(p)/100)

    }

    n <- stringr::str_extract_all(x, "(\\d{1,3}(?:\\.\\d+)?)|Inf")

    if (length(n) >= 2) {

      d <- abs(diff(as.numeric(c(n[[2]][1], n[[1]][2]))))

      if (p & round(d, digits = 2) == 0.1) {

        x <- stringr::str_replace_all(string = x,
                                      pattern = paste0(rx, "(?=\\)$)"),
          replacement = function(n) as.numeric(n) + 0.1)
      }
    }
  } else if (any(stringr::str_detect(x, paste(rx, "-", rx)))) {

    x <- stringr::str_replace(x, paste0(rx, "(?:-$)"), "[0,\\1]")
    x <- stringr::str_replace(x, paste(rx, "(?:-|to)", rx), "[\\1,\\2]")
    x <- stringr::str_replace(x, paste0(rx, "(?:\\+$)"), "[\\1, Inf)")

  }

  z <- unique(x)
  a <- stringr::str_extract_all(z, "(\\d{1,3}(?:\\.\\d+)?)|Inf")
  a <- vapply(a, FUN = function(i) sum(as.numeric(i)), FUN.VALUE = double(1))
  a <- match(a, sort(a))
  factor(x, levels = z[order(sort(z)[a])], ordered = TRUE)

}

