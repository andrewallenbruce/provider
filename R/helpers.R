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
sf_detect <- \(s, p) stringfish::sf_grepl(s, p, nthreads = 4L)

#' Detect Opposite by Regex
#'
#' @param s `<chr>` vector
#'
#' @param p `<chr>` regex pattern
#'
#' @returns `<lgl>` vector
#'
#' @autoglobal
#'
#' @noRd
sf_ndetect <- \(s, p) !stringfish::sf_grepl(s, p, nthreads = 4L)

#' Extract by Regex
#'
#' @param s `<chr>` vector
#'
#' @param p `<chr>` regex pattern
#'
#' @returns `<chr>` vector
#'
#' @autoglobal
#'
#' @noRd
sf_extract <- \(s, p) s[sf_detect(s, p)]

#' Extract Negation of Regex
#'
#' @param s `<chr>` vector
#'
#' @param p `<chr>` regex pattern
#'
#' @returns `<chr>` vector
#'
#' @autoglobal
#'
#' @noRd
sf_nextract <- \(s, p) s[sf_ndetect(s, p)]

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
sf_remove <- \(s, p, fix = FALSE) stringfish::sf_gsub(s, p, "", nthreads = 4L, fixed = fix)

#' Count characters in vector
#'
#' @param x `<chr>` vector
#'
#' @returns `<int>` vector of character counts
#'
#' @autoglobal
#'
#' @noRd
sf_nchar <- \(x) stringfish::sf_nchar(x, nthreads = 4L)

#' Convert character vector to stringfish vector
#'
#' @param x `<chr>` vector
#'
#' @returns `<int>` vector of class `sf_string`
#'
#' @autoglobal
#'
#' @noRd
sf_conv <- \(x) stringfish::sf_convert(x)

#' Concatenate Vectors
#'
#' @param ... Any number of vectors, coerced to `<chr>` vector, if necessary
#'
#' @returns concatenated `<chr>` vector
#'
#' @autoglobal
#'
#' @noRd
sf_c <- \(...) stringfish::sfc(...)

#' Collapse Vector
#'
#' @param x `<chr>` vector
#'
#' @param sep `<chr>` separator; default is `""`
#'
#' @returns collapsed `<chr>` vector
#'
#' @autoglobal
#'
#' @noRd
sf_smush <- \(x, sep = "") stringfish::sf_collapse(x, collapse = sep)

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
iif_else <- \(x, yes, no) kit::iif(test = x, yes = yes, no = no, nThread = 4L)

#' Unlist with no names
#'
#' @param x Named or unnamed `<list>`
#'
#' @returns Unnamed `<chr>` vector
#'
#' @autoglobal
#'
#' @noRd
delist <- \(x) unlist(x, use.names = FALSE)
