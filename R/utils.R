#' Returns a tidytable of summary stats
#' @description Returns a tidy table of summary stats
#' @param df data frame
#' @param condition filter condition, i.e. `patient == "new"`
#' @param group_vars variables to group by, i.e. `c(specialty, state, hcpcs, cost)`
#' @param summary_vars variables to summarise, i.e. `c(min, max, mode, range)`
#' @param arr column to arrange data by, i.e. `cost`
#' @return A `tibble` containing the summary stats
#' @examplesIf interactive()
#' summary_stats(condition = patient == "new",
#'               group_vars = c(specialty, state, hcpcs, cost),
#'               summary_vars = c(min, max, mode, range),
#'               arr = cost)
#' @autoglobal
#' @noRd
summary_stats <- function(df,
                          condition = NULL,
                          group_vars = NULL,
                          summary_vars = NULL,
                          arr = NULL) {

  results <- df |>
    dplyr::filter({{ condition }}) |>
    dplyr::summarise(
      dplyr::across({{ summary_vars }},
       list(median = \(x) stats::median(x, na.rm = TRUE),
            mean = \(x) mean(x, na.rm = TRUE)),
       .names = "{.fn}_{.col}"),
       n = dplyr::n(),
       .by = ({{ group_vars }}) ) |>
    dplyr::arrange(dplyr::desc({{ arr }}))

  return(results)
}

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

#' param_format
#' @param param API parameter
#' @param arg API function arg
#' @return formatted API filters
#' @autoglobal
#' @noRd
param_format <- function(param, arg) {

  if (is.null(arg)) {
    param <- NULL
  } else {
      paste0("filter[", param, "]=", arg, "&")
    }
  }

#' param_space
#' Some API parameters have spaces, these must be converted to "%20".
#' @param param parameter with a space
#' @return parameter formatted with "%20" in lieu of a space
#' @autoglobal
#' @noRd
param_space <- function(param) {

  gsub(" ", "%20", param)

}

#' param_brackets
#' Some API parameters have spaces, these must be converted to "%20".
#' @param param parameter with a space
#' @return parameter formatted with "%20" in lieu of a space
#' @autoglobal
#' @noRd
param_brackets <- function(param) {

  param <- gsub(" ", "%20", param)
  param <- gsub("[", "%5B", param, fixed = TRUE)
  param <- gsub("*", "%2A", param, fixed = TRUE)
  param <- gsub("]", "%5D", param, fixed = TRUE)

  return(param)
}

#' sql_format
#' @param param API parameter
#' @param arg API function arg
#' @return formatted API filters
#' @autoglobal
#' @noRd
sql_format <- function(param,
                       arg) {

  if (is.null(arg)) {

    param <- NULL

    } else {

      paste0("[WHERE ", param, " = ", "%22", arg, "%22", "]")
    }
  }

#' str_to_snakecase
#' @param string string
#' @return string formatted to snakecase
#' @autoglobal
#' @noRd
str_to_snakecase <- function(string) {

  string |>
    purrr::map_chr(function(string) {
      string |> stringr::str_to_lower() |>
                stringr::str_c(collapse = "_")}) |>
    stringr::str_remove("^_") |>
    stringr::str_replace_all(c(" " = "_",
                               "/" = "_",
                               "-" = "_",
                               "__" = "_",
                               ":" = ""))
}

#' Convert True/False char values to logical
#' @param x vector
#' @autoglobal
#' @noRd
tf_logical <- function(x) {

  ## TO DO Convert to case_match()

  # dplyr::case_match(
  #   x,
  #   c("I", "i", "Ind", "ind", "1") ~ "NPI-1",
  #   c("O", "o", "Org", "org", "2") ~ "NPI-2",
  #   .default = NULL
  # )

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

#' Convert I/O char values to logical
#' @param x vector
#' @autoglobal
#' @noRd
entype_char <- function(x) {

  dplyr::case_match(x,
    c("NPI-1", "I") ~ "Individual",
    c("NPI-2", "O") ~ "Organization",
    .default = x
    )
}

#' Convert I/O char values to logical
#' @param x vector
#' @autoglobal
#' @noRd
entype_arg <- function(x) {

  x <- if (is.numeric(x)) as.character(x)

  dplyr::case_match(
    x,
    c("I", "i", "Ind", "ind", "1") ~ "NPI-1",
    c("O", "o", "Org", "org", "2") ~ "NPI-2",
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

