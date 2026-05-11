#' @noRd
add_class <- function(x, endpoint) {
  `class<-`(cheapr::as_df(x), c(endpoint, "tbl_df", "tbl", "data.frame"))
  # structure(x, class = c(endpoint, "tbl_df", "tbl", "data.frame"))
}

#' @noRd
column_rex <- function(x) {
  paste0(paste0("^", unlist_(x), "$"), collapse = "|")
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
combine_columns <- function(
  x,
  main,
  other,
  prefix = NULL,
  sep = ", ",
  arg = caller_arg(other),
  call = caller_env()
) {
  if (rlang::is_null(x[[other]])) {
    cli::cli_abort(
      "Column {.val {other}} does not exist in {.var x}.",
      arg = arg,
      call = call
    )
  }

  i <- cheapr::which_not_na(x[[other]])

  if (rlang::is_empty(i)) {
    collapse::gv(x, other) <- NULL
    return(x)
  }

  COL <- paste0(prefix, paste(x[i, other, drop = TRUE], sep = sep))

  collapse::gv(x[i, ], main) <- COL
  collapse::gv(x, other) <- NULL
  return(x)
}

#' @noRd
rc_address <- function(x, main = "address", other = "add_2") {
  combine_columns(x, main = main, other = other, sep = ", ")
}

#' @noRd
rc_other <- function(x, stub) {
  combine_columns(
    x,
    main = paste0(stub, "_type"),
    other = paste0(stub, "_otxt"),
    prefix = "OTHER: ",
    sep = ""
  )
}

#' @noRd
bin_col <- function(x) {
  cheapr::case(
    x %in_% c("Y", "Yes") ~ 1L,
    x %in_% c("N", "No") ~ 0L,
    .default = NA_integer_
  )
}

#' @noRd
as_integer_supp <- function(x, ...) {
  suppressWarnings(as.integer(x, ...))
}

#' @noRd
as_date_ymd <- function(x, ...) {
  as.Date(x, ..., format = "%Y-%m-%d")
}

#' @noRd
as_date_ymd2 <- function(x, ...) {
  as.Date(x, ..., format = "%Y%m%d")
}

#' @noRd
as_date_mdy <- function(x, ...) {
  as.Date(x, ..., format = "%m/%d/%Y")
}
