#' @noRd
collapse_rows <- function(x, key, var) {
  collapse::rsplit(x[[var]], x[[key]]) |>
    purrr::map(\(x) paste0(x, collapse = ", ")) |>
    collapse::unlist2d() |>
    rlang::set_names(c(key, var))
}

#' @noRd
count_zero <- function(x) {
  sum2(cheapr::counts(x)$count > 1L) == 0L
}

#' @noRd
pivot2 <- function(x, rex, id, var, val) {
  collapse::gvr(x, rex) |>
    collapse::pivot(
      ids = id,
      names = list(variable = var, value = val),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv(id[1])
}

#' @noRd
pivot_multi <- function(x) {
  y <- pivot2(x, "^fac_ccn$|_multi$", "fac_ccn", "multi", "ind")

  collapse::settfmv(y, "multi", as.character)
  collapse::gvr(x, "_multi$") <- NULL

  if (nrow(y) == 0L) {
    return(collapse::av(x, multi = rep.int(NA_character_, nrow(x))))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:2)

  if (nrow(y) == 0L) {
    return(collapse::av(x, multi = rep.int(NA_character_, nrow(x))))
  }

  RC_clia_multi(y$multi)

  if (count_zero(y$fac_ccn)) {
    return(join2(x, y, on = "fac_ccn"))
  }

  join2(x, collapse_rows(y, "fac_ccn", "multi"), on = "fac_ccn")
}

#' @noRd
pivot_credit <- function(x) {
  y <- pivot2(
    x,
    rex = "^fac_ccn$|^acr_",
    id = "fac_ccn",
    var = "acr_org",
    val = "acr_date"
  )

  collapse::settfmv(y, "acr_org", as.character)
  collapse::gvr(x, "^acr_") <- NULL

  if (nrow(y) == 0L) {
    N <- rep.int(NA_character_, nrow(x))
    return(collapse::av(x, acr_org = N, acr_date = N))
  }

  RC_clia_credit(y$acr_org)
  join2(x, y, on = "fac_ccn")
}

#' @noRd
pivot_owner <- function(x) {
  y <- pivot2(
    x,
    rex = "^pac$|_ind$|_otxt$",
    id = c("pac", "own_otxt"),
    var = "own_type",
    val = "ind"
  )

  collapse::settfmv(y, "own_type", as.character)
  collapse::gvr(x, "_ind$|_otxt$") <- NULL

  if (nrow(y) == 0L) {
    return(collapse::av(x, own_type = rep.int(NA_character_, nrow(x))))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:3)

  if (nrow(y) == 0L) {
    return(collapse::av(x, own_type = rep.int(NA_character_, nrow(x))))
  }

  RC_own_type(y$own_type)

  y <- rc_other(y, stub = "own") |>
    collapse::funique()

  if (count_zero(y$pac)) {
    return(join2(x, y, on = "pac"))
  }

  join2(x, collapse_rows(y, "pac", "own_type"), on = "pac")
}

#' @noRd
pivot_subgroup <- function(x) {
  y <- pivot2(
    x,
    rex = "^enid$|sub_",
    id = c("enid", "sub_otxt"),
    var = "sub_group",
    val = "ind"
  )

  collapse::settfmv(y, "sub_group", as.character)
  collapse::gvr(x, "sub_") <- NULL

  if (nrow(y) == 0L) {
    return(collapse::av(x, sub_group = rep.int(NA_character_, nrow(x))))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:3)

  if (nrow(y) == 0L) {
    return(collapse::av(x, sub_group = rep.int(NA_character_, nrow(x))))
  }

  RC_subgroup(y$sub_group)

  y <- rc_other(y, stub = "sub") |>
    collapse::funique()

  if (count_zero(y$enid)) {
    return(join2(x, y, on = "enid"))
  }

  join2(x, collapse_rows(y, "enid", "sub_group"), on = "enid")
}

#' @noRd
pivot_compliance <- function(x) {
  y <- collapse::gvr(x, "^fac_ccn$|_ind$") |>
    collapse::pivot(
      ids = "fac_ccn",
      names = list(variable = "compliance", value = "ind"),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv("fac_ccn")

  collapse::settfmv(y, "compliance", as.character)
  collapse::gvr(x, "_ind$") <- NULL

  if (nrow(y) == 0L) {
    return(collapse::av(x, compliance = rep.int(NA_character_, nrow(x))))
  }

  COMP <- collapse::ss(y, y$compliance %==% "cmp_ind")

  if (nrow(COMP) == 0L) {
    y <- collapse::ss(y, y$ind %==% 1L, 1:2)
    if (nrow(y) == 0L) {
      return(collapse::av(x, compliance = rep.int(NA_character_, nrow(x))))
    }
    collapse::recode_char(
      y$compliance,
      "poc_ind" = "Compliant (POC)",
      "elig_ind" = "Eligible (CMS)",
      default = NA_character_,
      set = TRUE
    )

    if (count_zero(y$fac_ccn)) {
      return(join2(x, y, on = "fac_ccn"))
    }

    return(join2(x, collapse_rows(y, "fac_ccn", "compliance"), on = "fac_ccn"))
  }

  COMP$compliance <- cheapr::case(
    COMP$ind == 1L ~ "Compliant (Survey)",
    COMP$ind == 0L ~ "Non-compliant (Survey)",
    .default = NA_character_
  )

  COMP <- collapse::ss(COMP, j = 1:2)

  y <- collapse::ss(y, y$ind %==% 1L, 1:2)
  y <- collapse::ss(y, y$compliance %!=% "cmp_ind")

  collapse::recode_char(
    y$compliance,
    "poc_ind" = "Compliant (POC)",
    "elig_ind" = "Eligible (CMS)",
    default = NA_character_,
    set = TRUE
  )

  y <- cheapr::row_c(COMP, y)

  if (nrow(y) == 0L) {
    return(collapse::av(x, compliance = rep.int(NA_character_, nrow(x))))
  }

  if (count_zero(y$fac_ccn)) {
    return(join2(x, y, on = "fac_ccn"))
  }

  join2(x, collapse_rows(y, "fac_ccn", "compliance"), on = "fac_ccn")
}
