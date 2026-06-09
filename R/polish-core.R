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
set_rename <- function(x) {
  collapse::setrename(x, RE_NAME[[class(x)[1]]], .nse = FALSE)
  replace_nz(x)
}

#' @noRd
get_columns <- function(x) {
  collapse::gv(x, unlist_(RE_NAME[[class(x)[1]]]))
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

  x <- collapse::get_elem(
    x,
    switch(
      y,
      "2017" = as.character(2017:2021),
      "2022" = "2022",
      "2023" = as.character(2023:2024)
    ),
    keep.tree = TRUE
  ) |>
    rowbind2("year", fill = TRUE)

  collapse::setrename(x, RE_NAME[["quality"]][[y]], .nse = FALSE)
  replace_nz(x)

  x <- collapse::gv(x, unlist_(RE_NAME[["quality"]][[y]])) |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    pivot_quality()

  if (y == "2017") {
    x <- collapse::av(
      x,
      cred = vec_na(x),
      dual_ratio = vec_na(x, "double"),
      small_bonus = vec_na(x, "integer"),
      report_opt = vec_na(x),
      mvp_title = vec_na(x),
      ci_score = vec_na(x, "double")
    )
  }

  if (y == "2022") {
    x <- collapse::av(
      x,
      report_opt = vec_na(x),
      mvp_title = vec_na(x),
      ci_score = vec_na(x, "double")
    )
  }

  return(x)
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
