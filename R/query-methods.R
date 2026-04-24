#' @noRd
arg_cms <- S7::new_class("arg_cms", S7::class_list, NULL)

#' @noRd
arg_prov <- S7::new_class("arg_prov", S7::class_list, NULL)

S7::method(build, arg_cms) <- function(x) {
  S7::S7_data(x) |>
    purrr::imap(\(x, n) query_cms(x, n)) |>
    flatten_query()
}

S7::method(build, arg_prov) <- function(x) {
  S7::S7_data(x) |>
    purrr::imap(\(x, n) query_pro(x, n)) |>
    flatten_query()
}

#' @noRd
flatten_query <- function(x) {
  unname(x) |>
    purrr::imap_chr(\(x, i) {
      paste0(sub_idx(x, i - 1L), collapse = "&")
    }) |>
    (\(x) paste0(x, collapse = "&"))()
}

#' @noRd
params <- function(...) {
  purrr::compact(rlang::list2(...))
}

#' @noRd
param_prov <- function(...) {
  arg_prov(params(...))
}

#' @noRd
param_cms <- function(...) {
  arg_cms(params(...))
}
