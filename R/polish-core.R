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
set_rename <- function(x, endpoint) {
  collapse::setrename(x, RE_NAME[[endpoint]], .nse = FALSE)
  replace_nz(x)
}

#' @noRd
get_columns <- function(x, endpoint) {
  collapse::gv(x, unlist_(RE_NAME[[endpoint]]))
}

#' @noRd
quality_has <- function(x, y) {
  y <- match.arg(as.character(y), c("2017", "2022", "2023"))

  collapse::has_elem(
    x,
    switch(
      y,
      "2017" = as.character(2017:2021),
      "2022" = "2022",
      "2023" = as.character(2023:2024)
    )
  )
}

#' @noRd
quality_get <- function(x, y) {
  y <- match.arg(as.character(y), c("2017", "2022", "2023"))
  z <- if (y == "2017") as.character(2017:2021) else y

  x <- collapse::get_elem(x, z, keep.tree = TRUE) |>
    rowbind2("year")

  collapse::setrename(x, RE_NAME[["quality"]][[y]], .nse = FALSE)
  replace_nz(x)

  x <- collapse::gv(x, unlist_(RE_NAME[["quality"]][[y]])) |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    pivot_quality()

  if (y %in% c("2022", "2023")) {
    collapse::settfmv(x, "dual_ratio", as.double)
    collapse::settfmv(x, "small_bonus", as.integer)
  }
  if (y %in% c("2023")) {
    collapse::settfmv(x, "ci_score", as.double)
  }
  return(x)
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
rc_other <- function(x, stub, call = caller_env()) {
  main <- paste0(stub, "_type")
  otxt <- paste0(stub, "_otxt")

  if (is.null(x[[otxt]])) {
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

  collapse::gv(x[i, ], main) <- paste0(
    "Other: ",
    x[i, otxt, drop = TRUE]
  )

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
  if (is.null(x[[add2]])) {
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

  COL <- paste(
    x[i, add1, drop = TRUE],
    x[i, add2, drop = TRUE],
    sep = ", "
  )

  collapse::gv(x[i, ], add1) <- COL
  collapse::gv(x, add2) <- NULL

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
