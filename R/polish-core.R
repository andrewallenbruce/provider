#' @noRd
polish <- function(x, n) {
  replace_nz(x) |>
    rename_with(nm = n) |>
    data_frame()
}

#' @noRd
replace_nz <- function(i) {
  purrr::modify_if(i, is.character, function(x) {
    vctrs::vec_assign(
      x,
      i = vctrs::vec_in(x, haystack = ""),
      value = NA_character_,
      slice_value = TRUE
    )
  })
}

#' @noRd
rename_with <- function(x, nm) {
  if (is.null(nm)) {
    return(x)
  }
  collapse::setrename(x, nm, .nse = FALSE)
  collapse::gv(x, unlist_(nm))
}

#' @noRd
recode_with <- function(x, endpoint) {
  if (is.null(endpoint)) {
    return(x)
  }
  switch(
    endpoint,
    clinicians = RC_clinicians(x),
    opt_out = RC_opt_out(x),
    order_refer = RC_order_refer(x),
    pending = RC_pending(x),
    providers = RC_providers(x),
    transparency = RC_transparency(x),
    cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
  )
}

#' @noRd
data_frame <- function(x, call = rlang::caller_call()) {
  check_data_frame(x, call = call)
  structure(x, class = c("tbl", "data.frame"))
}

#' @noRd
df_tbl_ <- function(x) {
  `class<-`(cheapr::as_df(x), c("tbl_df", "tbl", "data.frame"))
}

#' @noRd
combine_ <- function(e1, e2, sep = ", ") {
  cheapr::if_else_(cheapr::is_na(e2), e1, cheapr::paste_(e1, e2, sep = sep))
}

#' @noRd
bin_ <- function(x) {
  cheapr::val_match(
    x,
    "Y" ~ 1L,
    "N" ~ 0L,
    .default = NA_integer_
  )
}

#' @noRd
as_date <- function(x, ..., fmt = "%Y-%m-%d") {
  as.Date(x, ..., format = fmt)
}
