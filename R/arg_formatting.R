#' Encode API parameters as a URL
#'
#' "%22" url encoding for double quote (")
#'
#' @param x tibble with two columns: `param` and `args`
#'
#' @param fmt format type, `filter`, `sql`, default is `filter`
#'
#' @returns formatted URL string
#'
#' @autoglobal
#'
#' @noRd
format_api_params <- function(x, fmt = "filter") {

  x <- purrr::discard(params, is_null)

  fmt <- match.arg(fmt, c("filter", "sql"))

  x <- switch(
    fmt,
    filter = paste0(
      paste0("filter[", names(x), "]=", x), collapse = "&"),
    sql = paste0(
      paste0("[WHERE ", names(x), " = %22", x, "%22]" ), collapse = ""))

  x <- gsub(" ", "%20", x)
  x <- gsub("[", "%5B", x, fixed = TRUE)
  x <- gsub("*", "%2A", x, fixed = TRUE)
  x <- gsub("]", "%5D", x, fixed = TRUE)
  x <- gsub("<", "%3C", x, fixed = TRUE)
  x <- gsub("+", "%2B", x, fixed = TRUE)

  return(x)
}
