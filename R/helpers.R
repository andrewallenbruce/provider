#' Years between two dates, rounded down to nearest whole number
#'
#' @param from `<date>` Start date
#'
#' @param to `<date>` End date
#'
#' @returns `<int>` vector; number of years between `from` and `to`, rounded
#'   down to nearest whole number
#'
#' @examples
#' years_floor(
#'    as.Date("2020-01-01"),
#'    as.Date("2020-01-01") + 2057)
#'
#' @autoglobal
#'
#' @noRd
years_floor <- \(from, to) {
  floor(
    as.integer(
      difftime(to, from, units = "weeks", tz = "UTC")
    ) / 52.17857)
}

#' Is `x` `NULL`?
#'
#' @param x vector
#'
#' @returns `<lgl>` `TRUE` if `x` is `NULL`, `FALSE` otherwise
#'
#' @autoglobal
#'
#' @noRd
null <- \(x) is.null(x)

#' Is `x` not `NULL`?
#'
#' @param x vector
#'
#' @returns `<lgl>` `FALSE` if `x` is `NULL`, `TRUE` otherwise
#'
#' @autoglobal
#'
#' @noRd
not_null <- \(x) !is.null(x)

#' Is `x` empty?
#'
#' @param x vector
#'
#' @returns `<lgl>`
#'
#' @autoglobal
#'
#' @noRd
empty <- \(x) vctrs::vec_is_empty(x)

#' Is `x` `NA`?
#'
#' @param x vector
#'
#' @returns `<lgl>`
#'
#' @autoglobal
#'
#' @noRd
na <- \(x) cheapr::is_na(x)

#' Is `x` not `NA`?
#'
#' @param x vector
#'
#' @returns `<lgl>`
#'
#' @autoglobal
#'
#' @noRd
not_na <- \(x) !na(x)

#' Detect by Regex
#'
#' @param s `<chr>` vector
#'
#' @param p `<chr>` regex pattern
#'
#' @returns `<lgl>` vector the same length as `s`
#'
#' @autoglobal
#'
#' @noRd
rdetect <- \(s, p) stringfish::sf_grepl(s, p, nthreads = 4L)

#' Remove by Regex
#'
#' @param s `<chr>` vector
#'
#' @param p `<chr>` regex pattern
#'
#' @param fix `<lgl>` fixed pattern matching
#'
#' @returns `<chr>` vector the same length as `s`
#'
#' @autoglobal
#'
#' @noRd
rremove <- \(s, p, fix = FALSE) stringfish::sf_gsub(s, p, "", nthreads = 4L, fixed = fix)

#' Count of characters in character vector
#'
#' @param x `<chr>` vector
#'
#' @returns `<int>` vector of character counts
#'
#' @autoglobal
#'
#' @noRd
rnchar <- \(x) stringfish::sf_nchar(x, nthreads = 4L)

#' Convert character vector to stringfish vector
#'
#' @param x `<chr>` vector
#'
#' @returns `<int>` vector of class `sf_string`
#'
#' @autoglobal
#'
#' @noRd
sfconv <- \(x) stringfish::sf_convert(x)

#' Concatenate Vectors
#'
#' @param ... Any number of vectors, coerced to `<character>` vector, if necessary
#'
#' @returns concatenated `<character>` vector
#'
#' @examples
#' sfcc(LETTERS, "A")
#'
#' @autoglobal
#'
#' @noRd
sfcc <- \(...) stringfish::sfc(...)

#' Fast ifelse wrapper
#'
#' @param x `<lgl>` vector
#'
#' @param yes,no Values to return depending on TRUE/FALSE element of `x`. Must
#'   be same type and be either length 1 or same length of `x`.
#'
#' @returns vector of same length as `x` and attributes as `yes`. Data values
#'          are taken from values of `yes` and `no`.
#'
#' @autoglobal
#'
#' @noRd
iifelse <- \(x, yes, no) kit::iif(test = x, yes = yes, no = no, nThread = 4L)
