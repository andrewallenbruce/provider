#' @noRd
add_class <- function(x, endpoint = NULL) {
  `class<-`(
    cheapr::as_df(x),
    c(
      if (!is.null(endpoint)) endpoint,
      "tbl_df",
      "tbl",
      "data.frame"
    )
  )
}

#' @noRd
add_class2 <- function(x, endpoint) {
  `class<-`(x, c(endpoint, class(x)))
}

#' @noRd
set_rename <- function(x) {
  collapse::setrename(x, RE_NAME[[class(x)[1]]], .nse = FALSE)
  replace_nz(x)
}

#' @noRd
get_columns <- function(x) {
  collapse::gv(x, unlist_(RE_NAME[[class(x)[1]]]))
}

#' @noRd
set_nz <- function(x) {
  collapse::setv(x, "", NA_character_)
}

#' @noRd
replace_nz <- function(x) {
  collapse::settfmv(x, is.character, set_nz)
}

#' @noRd
rc_trim <- function(x) {
  purrr::modify_if(x, is.character, trimws)
}

#' @noRd
recoder <- function(.f) {
  function(x, v) {
    collapse::tfmv(.data = x, vars = v, FUN = .f)
  }
}

#' @noRd
rc_bin <- recoder(bin_col)

#' @noRd
rc_ymd <- recoder(as_date_ymd)

#' @noRd
rc_ymd2 <- recoder(as_date_ymd2)

#' @noRd
rc_mdy <- recoder(as_date_mdy)

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

#' @noRd
bin_col <- function(x) {
  cheapr::case(
    x %in_% c("YES", "Y", "Yes", "True") ~ 1L,
    x %in_% c("NO", "N", "No", "False") ~ 0L,
    .default = NA_integer_
  )
}

#' @noRd
as_date_ymd <- function(x, ...) {
  as.Date.character(x, format = "%Y-%m-%d", ...)
}

#' @noRd
as_date_ymd2 <- function(x, ...) {
  as.Date.character(x, format = "%Y%m%d", ...)
}

#' @noRd
as_date_mdy <- function(x, ...) {
  as.Date.character(x, format = "%m/%d/%Y", ...)
}
