#' @noRd
polish <- function(x, n) {
  x |>
    replace_nz() |>
    rename_with(nm = n) |>
    df_tbl_()
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
recode_ <- function(x) {
  # collapse::settfmv(x, collapse::gv(npi, year), strtoi)
  #   npi = strtoi(npi),
  #   year = strtoi(year),
  #   org_mems = strtoi(org_mems),
  #   address = comb_(add_1, add_2),
  #   specialty = comb_(specialty, spec_other, sep = ", "),
  #   ind = bin_(ind),
  #   grp = bin_(grp),
  #   tele = bin_(tele),
  #   add_1 = NULL,
  #   add_2 = NULL,
  #   spec_other = NULL
  # )
}
