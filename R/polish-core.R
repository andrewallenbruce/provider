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

#' @noRd
#' @autoglobal
recode_opt_out <- function(x) {
  collapse::mtt(
    x,
    npi = as.integer(npi),
    start_date = as_date(start_date, fmt = "%m/%d/%Y"),
    end_date = as_date(end_date, fmt = "%m/%d/%Y"),
    updated = as_date(updated, fmt = "%m/%d/%Y"),
    address = combine_(add_1, add_2),
    order_refer = bin_(order_refer),
    add_1 = NULL,
    add_2 = NULL
  )
}

#' @noRd
#' @autoglobal
recode_clinicians <- function(x) {
  collapse::mtt(
    x,
    npi = as.integer(npi),
    grad_year = as.integer(grad_year),
    specialty = combine_(specialty, spec_other),
    org_add = combine_(add_1, add_2),
    spec_other = NULL,
    add_1 = NULL,
    add_2 = NULL,
    ind = NULL,
    org = NULL,
    tlh = NULL
  )
}

#' @noRd
#' @autoglobal
recode_order_refer <- function(x) {
  collapse::mtt(
    x,
    npi = as.integer(npi),
    part_b = bin_(part_b),
    dme = bin_(dme),
    hha = bin_(hha),
    pmd = bin_(pmd),
    hospice = bin_(hospice)
  )
}

#' @noRd
#' @autoglobal
recode_transparency <- function(x) {
  collapse::mtt(
    x,
    id = as.integer(id),
    action_date = as_date(action_date)
  )
}
