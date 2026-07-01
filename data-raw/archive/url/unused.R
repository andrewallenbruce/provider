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

# base_request <- function(url, query = NULL) {
#   httr2::request(url) |>
#     httr2::req_perform() |>
#     parse_string(query = query)
# }

# parallel_request <- function(x, query = NULL) {
#   purrr::map(x, httr2::request) |>
#     httr2::req_perform_parallel(on_error = "continue") |>
#     httr2::resps_successes() |>
#     httr2::resps_data(function(resp) parse_string(resp, query = query))
# }

# base_parallel <- function(url, n, limit, query = NULL) {
#   offset2(url, n, limit) |>
#     parallel_request(query = query)
# }

# multi_count <- function(url, nm, query = NULL) {
#   purrr::map_int(url, base_request, query = query) |>
#     set_names2(nm)
# }
