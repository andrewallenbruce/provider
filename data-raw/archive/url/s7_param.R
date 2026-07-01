arg_cms <- S7::new_class("arg_cms", S7::class_list)

S7::method(build, arg_cms) <- function(x) {
  S7::S7_data(x) |>
    purrr::imap(\(x, n) query_cms(x, n)) |>
    unname() |>
    purrr::imap_chr(
      \(x, idx) {
        paste0(
          sub_idx(x, idx - 1L),
          collapse = "&"
        )
      }
    ) |>
    (\(x) paste0(x, collapse = "&"))()
}

as_params <- function(...) {
  param_cms(params(...))
}


proto <- function(
  npi = NULL,
  ccn = NULL,
  org_name = NULL,
  state = NULL
) {
  as_params(NPI = npi, CCN = ccn, `ORGANIZATION NAME` = org_name, STATE = state)
}


args <- proto(npi = 10000123456, state = "GA", org_name = "HOSPITAL")
build(args)
