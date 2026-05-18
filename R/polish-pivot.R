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
rep_NA <- function(x) {
  cheapr::rep_(NA_character_, collapse::fnrow(x))
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
  y <- pivot2(
    x,
    "^npi$|^ptb$|^dme$|^hha$|^pmd$|^hospice$",
    "npi",
    "order_refer"
  )

  cols <- c("order_refer", "ptb", "dme", "hha", "pmd", "hospice")

  collapse::gv(x, cols) <- NULL

  y <- collapse::ss(y, y$ind %==% 1L, 1:2)

  if (nrow0(y)) {
    return(collapse::av(x, order_refer = rep_NA(x)))
  }

  collapse::recode_char(
    y$order_refer,
    "ptb" = "Part B",
    "dme" = "DME",
    "hha" = "HHA",
    "pmd" = "PMD",
    "hospice" = "Hospice",
    default = NA_character_,
    set = TRUE
  )

  if (all_unique(y$npi)) {
    return(join2(x, y, on = "npi"))
  }
  join2(x, collapse_rows(y, "npi", "order_refer"), on = "npi")
}

#' @noRd
pivot_multi_site <- function(x) {
  y <- pivot2(x, "^fac_ccn$|_multi$", "fac_ccn", "multi_site")

  collapse::gvr(x, "_multi$") <- NULL

  if (nrow0(y)) {
    return(collapse::av(x, multi_site = rep_NA(x)))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:2)

  if (nrow0(y)) {
    return(collapse::av(x, multi_site = rep_NA(x)))
  }

  rc_clia(y, "multi_site")

  if (all_unique(y$fac_ccn)) {
    return(join2(x, y, on = "fac_ccn"))
  }

  join2(x, collapse_rows(y, "fac_ccn", "multi_site"), on = "fac_ccn")
}

#' @noRd
pivot_acr_org <- function(x) {
  y <- pivot2(x, "^fac_ccn$|^acr_", "fac_ccn", "acr_org")

  collapse::gvr(x, "^acr_") <- NULL

  y <- collapse::ss(y, j = 1:2)

  if (nrow0(y)) {
    return(collapse::av(x, acr_org = rep_NA(x)))
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
    return(collapse::av(x, own_type = rep_NA(x)))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:3)

  if (nrow0(y)) {
    return(collapse::av(x, own_type = rep_NA(x)))
  }

  rc_own_type(y, "own_type")

  y <- rc_other(y, stub = "own") |>
    collapse::funique()

  if (all_unique(y$pac)) {
    return(join2(x, y, on = "pac"))
  }

  join2(x, collapse_rows(y, "pac", "own_type"), on = "pac")
}

#' @noRd
pivot_subgroup <- function(x) {
  y <- pivot2(x, "^enid$|^sub_|^sg_", c("enid", "sg_otxt"), "sub_type") |>
    collapse::rnm("sg_otxt" = "sub_otxt", .nse = FALSE)

  collapse::gvr(x, "^sub_|^sg_") <- NULL

  if (nrow0(y)) {
    return(collapse::av(x, sub_group = rep_NA(x)))
  }

  y <- collapse::ss(y, y$ind %==% 1L, c("enid", "sub_otxt", "sub_type"))

  if (nrow0(y)) {
    return(collapse::av(x, sub_group = rep_NA(x)))
  }

  rc_hospitals(y, "sub_type")

  y <- rc_other(y, stub = "sub") |>
    collapse::funique() |>
    collapse::rnm("sub_type" = "sub_group", .nse = FALSE)

  if (all_unique(y$enid)) {
    return(join2(x, y, on = "enid"))
  }

  join2(x, collapse_rows(y, "enid", "sub_group"), on = c("enid"))
}
