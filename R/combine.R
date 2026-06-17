#' @noRd
rc_combine <- function(x, e1, e2) {
  if (e2 %!in_% colnames(x)) {
    cli::cli_abort(
      "{.arg {e2}} is not a column in {.var x}.",
      call = rlang::caller_env()
    )
  }

  idx <- collapse::whichNA(x[[e2]], invert = TRUE)

  if (rlang::is_empty(idx)) {
    collapse::gv(x, e2) <- NULL
    return(x)
  }

  collapse::gv(x[idx, ], e1) <- paste(
    unlist_(collapse::ss(x, idx, e1, check = FALSE)),
    unlist_(collapse::ss(x, idx, e2, check = FALSE)),
    sep = ", "
  )

  collapse::gv(x, e2) <- NULL

  return(x)
}

#' @noRd
rc_replace <- function(x, e1, e2) {
  if (e2 %!in_% colnames(x)) {
    cli::cli_abort(
      "{.arg {e2}} is not a column in {.var x}.",
      call = rlang::caller_env()
    )
  }

  idx <- collapse::whichNA(x[[e2]], invert = TRUE)

  if (rlang::is_empty(idx)) {
    collapse::gv(x, e2) <- NULL
    return(x)
  }

  collapse::gv(x[idx, ], e1) <- unlist_(collapse::ss(x, idx, e2, check = FALSE))

  collapse::gv(x, e2) <- NULL

  return(x)
}

#' @noRd
rc_other <- function(x, e1, e2) {
  if (e2 %!in_% colnames(x)) {
    cli::cli_abort(
      "{.arg {e2}} is not a column in {.var x}.",
      call = rlang::caller_env()
    )
  }

  idx <- collapse::whichNA(x[[e2]], invert = TRUE)

  if (rlang::is_empty(idx)) {
    collapse::gv(x, e2) <- NULL
    return(x)
  }

  collapse::gv(x[idx, ], e1) <- paste0(
    "Other: ",
    unlist_(collapse::ss(x, idx, e2, check = FALSE))
  )

  collapse::gv(x, e2) <- NULL

  return(x)
}

#' @noRd
rc_ptype <- function(x) {
  p <- !cheapr::is_na(x[["prov_type"]])

  if (rlang::is_empty(cheapr::which_(p))) {
    collapse::gv(x, "prov_type") <- NULL
    return(x)
  }

  i <- cheapr::which_(p & !cheapr::is_na(x[["sub_group"]]))

  if (!rlang::is_empty(i)) {
    collapse::gv(x[i, ], "sub_group") <- rc_combine(
      collapse::ss(x, i, c("prov_type", "sub_group")),
      "sub_group",
      "prov_type"
    )
  }

  i <- cheapr::which_(p & cheapr::is_na(x[["sub_group"]]))

  if (!rlang::is_empty(i)) {
    collapse::gv(x[i, ], "sub_group") <- unlist_(
      collapse::ss(x, i, "prov_type")
    )
  }

  collapse::gv(x, "prov_type") <- NULL

  return(x)
}

# rc_combine_na <- function(x, col_1, col_2) {
#   col1_is <- cheapr::is_na(x[[col_1]])
#   col1_no <- !cheapr::is_na(x[[col_1]])
#
#   col2_is <- cheapr::is_na(x[[col_2]])
#   col2_no <- !cheapr::is_na(x[[col_2]])
#
#   i <- cheapr::which_(col1_no)
#
#   if (rlang::is_empty(i)) {
#     collapse::gv(x, col_1) <- NULL
#     return(x)
#   }
#
#   i <- cheapr::which_(e1_not & !cheapr::is_na(x[[e2]]))
#
#   if (!rlang::is_empty(i)) {
#     collapse::gv(x[i, ], e2) <- rc_combine(
#       collapse::ss(
#         x,
#         i,
#         c(e1, e2)
#       ),
#       e2,
#       e1
#     )
#   }
#
#   i <- cheapr::which_(e1_not & cheapr::is_na(x[[e2]]))
#
#   if (!rlang::is_empty(i)) {
#     collapse::gv(x[i, ], e2) <- unlist_(
#       collapse::ss(x, i, e1)
#     )
#   }
#
#   collapse::gv(x, e1) <- NULL
#
#   return(x)
# }
