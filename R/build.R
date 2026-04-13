#' @noRd
build <- S7::new_generic("build", "x")

#' @noRd
arg_cms <- S7::new_class("arg_cms", S7::class_list)

#' @noRd
arg_pro <- S7::new_class("arg_pro", S7::class_list)

S7::method(build, arg_cms) <- function(x) {
  S7::S7_data(x) |>
    purrr::imap(\(x, n) query_cms(x, n)) |>
    unname() |>
    purrr::imap_chr(\(x, i) paste0(sub_idx(x, i - 1L), collapse = "&")) |>
    (\(x) paste0(x, collapse = "&"))()
}

S7::method(build, arg_pro) <- function(x) {
  S7::S7_data(x) |>
    purrr::imap(\(x, n) query_pro(x, n)) |>
    unname() |>
    purrr::imap_chr(\(x, i) paste0(sub_idx(x, i - 1L), collapse = "&")) |>
    (\(x) paste0(x, collapse = "&"))()
}
