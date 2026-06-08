#' Wildcards
#'
#' @description
#' Trailing Wildcard Entries
#'
#' Arguments that allow trailing wildcard entries are denoted in the parameter
#' description with `<WC>`. Wildcard entries require at least two characters to
#' be entered, e.g. `"jo*"`
#'
#' @param x `<chr>` input
#' @returns A `<wildcard>` object
#' @examples
#' wildcard("Jo")
#' @rdname nppes
#' @export
wildcard <- function(x) {
  if (length(x) > 1L) {
    cli::cli_abort("Wildcards must be length 1.")
  }
  if (nchar(x) <= 1L) {
    cli::cli_abort(c("Wildcards must be more than 2 characters."))
  }

  structure(paste0(x, "*"), class = "wildcard")
}
