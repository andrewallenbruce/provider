#' @noRd
add_class <- function(x, endpoint) {
  `class<-`(cheapr::as_df(x), c(endpoint, "tbl_df", "tbl", "data.frame"))
}

#' @noRd
rename_with <- function(x, endpoint) {
  if (rlang::is_null(RE_NAME[[endpoint]])) {
    return(x)
  }

  NM <- RE_NAME[[endpoint]]

  rlang::inject(
    collapse::recode_char(
      colnames(x),
      !!!NM,
      set = TRUE
    )
  )

  x <- rc_trim(x)
  replace_nz(x)

  collapse::gv(x, unlist_(NM))
}

#' @noRd
set_replace_nz <- function(x) {
  collapse::setv(x, "", NA_character_)
}

#' @noRd
replace_nz <- function(x) {
  collapse::settfmv(x, is.character, set_replace_nz)
}

#' @noRd
rc_trim <- function(x) {
  purrr::modify_if(x, is.character, trimws)
  # collapse::settfmv(x, is.character, trimws, apply = TRUE)
}


#' @noRd
recoder <- function(.f) {
  function(x, v) {
    collapse::tfmv(.data = x, vars = v, FUN = .f)
  }
}

#' @noRd
rc_integer <- recoder(as_integer_supp)

#' @noRd
rc_double <- recoder(as.double)

#' @noRd
rc_bin <- recoder(bin_col)

#' @noRd
rc_ymd <- recoder(as_date_ymd)

#' @noRd
rc_ymd2 <- recoder(as_date_ymd2)

#' @noRd
rc_mdy <- recoder(as_date_mdy)

#' @noRd
rc_other <- function(x, stub, call = caller_env()) {
  main <- paste0(stub, "_type")
  otxt <- paste0(stub, "_otxt")

  if (rlang::is_null(x[[otxt]])) {
    cli::cli_abort(
      "{.val {otxt}} is not a column in {.var x}.",
      call = call
    )
  }

  i <- cheapr::which_not_na(x[[otxt]])

  if (rlang::is_empty(i)) {
    collapse::gv(x, otxt) <- NULL
    return(x)
  }

  OTXT <- paste0("Other: ", x[i, otxt, drop = TRUE])

  collapse::gv(x[i, ], main) <- OTXT
  collapse::gv(x, otxt) <- NULL
  return(x)
}

#' @noRd
rc_address <- function(
  x,
  add1 = "address",
  add2 = "add_2",
  arg = caller_arg(add2),
  call = caller_env()
) {
  if (rlang::is_null(x[[add2]])) {
    cli::cli_abort(
      "{.val {arg}} is not a column in {.var x}.",
      arg = arg,
      call = call
    )
  }

  i <- cheapr::which_not_na(x[[add2]])

  if (rlang::is_empty(i)) {
    collapse::gv(x, add2) <- NULL
    return(x)
  }
  COL <- paste(x[i, add1, drop = TRUE], x[i, add2, drop = TRUE], sep = ", ")
  collapse::gv(x[i, ], add1) <- COL
  collapse::gv(x, add2) <- NULL
  return(x)
}

#' @noRd
bin_col <- function(x) {
  cheapr::case(
    x %in_% c("YES", "Y", "Yes") ~ 1L,
    x %in_% c("NO", "N", "No") ~ 0L,
    .default = NA_integer_
  )
}

#' @noRd
as_integer_supp <- function(x, ...) {
  suppressWarnings(as.integer(x, ...))
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
