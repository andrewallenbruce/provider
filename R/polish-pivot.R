#' @noRd
column_rex <- function(x) {
  paste0(paste0("^", unlist_(x), "$"), collapse = "|")
}

#' @noRd
nrow0 <- function(x) {
  collapse::fnrow(x) == 0L
}

#' @noRd
all_unique <- function(x) {
  !collapse::any_duplicated(x)
}

#' @noRd
pivot2 <- function(x, rex, id, var, val = "ind") {
  x <- collapse::gvr(x, rex) |>
    collapse::pivot(
      ids = id,
      names = list(variable = var, value = val),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv(id[1])

  collapse::settfmv(x, var, as.character)

  return(x)
}

#' @noRd
vec_na <- function(x, type = "character") {
  cheapr::na_init(vector(mode = type), collapse::fnrow(x))
}

#' @noRd
collapse_rows <- function(x, key, var) {
  collapse::rsplit(x[[var]], x[[key]]) |>
    purrr::map(\(x) paste0(x, collapse = ", ")) |>
    collapse::unlist2d() |>
    rlang::set_names(c(key, var))
}

#' @noRd
pivot_order_refer <- function(x) {
  y <- pivot2(x, "^npi$|_ind$", "npi", "order_refer")

  collapse::gvr(x, "^order_refer$|_ind$") <- NULL

  y <- collapse::ss(y, y$ind %==% 1L, 1:2)

  if (nrow0(y)) {
    return(collapse::av(x, order_refer = vec_na(x)))
  }

  rc_order_refer(y, "order_refer")

  if (all_unique(y$npi)) {
    return(join2(x, y, on = "npi"))
  }
  join2(x, collapse_rows(y, "npi", "order_refer"), on = "npi")
}

#' @noRd
pivot_multi_site <- function(x) {
  y <- pivot2(x, "^fac_ccn$|_multi$", "fac_ccn", "multi")

  collapse::gvr(x, "_multi$") <- NULL

  if (nrow0(y)) {
    return(collapse::av(x, multi = vec_na(x)))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:2)

  if (nrow0(y)) {
    return(collapse::av(x, multi = vec_na(x)))
  }

  rc_clia(y, "multi")

  if (all_unique(y$fac_ccn)) {
    return(join2(x, y, on = "fac_ccn"))
  }

  join2(x, collapse_rows(y, "fac_ccn", "multi"), on = "fac_ccn")
}

#' @noRd
pivot_acr_org <- function(x) {
  y <- pivot2(x, "^fac_ccn$|^acr_", "fac_ccn", "acr_org")

  collapse::gvr(x, "^acr_") <- NULL

  y <- collapse::ss(y, j = 1:2)

  if (nrow0(y)) {
    return(collapse::av(x, acr_org = vec_na(x)))
  }

  rc_clia(y, "acr_org")

  if (all_unique(y$fac_ccn)) {
    return(join2(x, y, on = "fac_ccn"))
  }

  join2(x, collapse_rows(y, "fac_ccn", "acr_org"), on = "fac_ccn")
}

#' @noRd
pivot_owner <- function(x) {
  y <- pivot2(x, "^pac$|_ind$|_otxt$", c("pac", "own_otxt"), "own_type")

  collapse::gvr(x, "_ind$|_otxt$") <- NULL

  if (nrow0(y)) {
    return(collapse::av(x, own_type = vec_na(x)))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:3)

  if (nrow0(y)) {
    return(collapse::av(x, own_type = vec_na(x)))
  }

  rc_owner(y, "own_type")

  y <- rc_other(y, "own_type", "own_otxt") |>
    collapse::funique()

  if (all_unique(y$pac)) {
    return(join2(x, y, on = "pac"))
  }

  join2(x, collapse_rows(y, "pac", "own_type"), on = "pac")
}

#' @noRd
pivot_subgroup <- function(x) {
  y <- pivot2(x, "^enid$|^sub_|^sg_", c("enid", "sg_otxt"), "sub_group")

  collapse::gvr(x, "^sub_|^sg_") <- NULL

  if (nrow0(y)) {
    return(collapse::av(x, sub_group = vec_na(x)))
  }

  y <- collapse::ss(y, y$ind %==% 1L, c("enid", "sg_otxt", "sub_group"))

  if (nrow0(y)) {
    return(collapse::av(x, sub_group = vec_na(x)))
  }

  rc_hospitals(y, "sub_group")

  y <- rc_other(y, "sub_group", "sg_otxt") |>
    collapse::funique()

  if (all_unique(y$enid)) {
    return(join2(x, y, on = "enid"))
  }

  join2(x, collapse_rows(y, "enid", "sub_group"), on = "enid")
}

#' @noRd
pivot_quality <- function(x) {
  y <- pivot2(x, "^year$|^npi$|_ind$", c("year", "npi"), "indicators")

  collapse::gvr(x, "_ind$") <- NULL

  y <- collapse::ss(y, y$ind %==% 1L, 1:3)

  if (nrow0(y)) {
    return(collapse::av(x, indicators = vec_na(x)))
  }

  rc_quality(y, "indicators")

  if (all_unique(y$npi)) {
    return(join2(x, y, on = c("year", "npi")))
  }

  y <- collapse::ss(y, collapse::whichNA(y$indicators, invert = TRUE))

  y <- collapse::rsplit(y, y$year) |>
    purrr::map(\(x) collapse_rows(x, "npi", "indicators")) |>
    rowbind2("year") |>
    collapse::qTBL()

  join2(x, y, on = c("year", "npi"))
}
