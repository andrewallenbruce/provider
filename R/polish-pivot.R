#' @noRd
collapse_rows <- function(x, key, var) {
  collapse::rsplit(x[[var]], x[[key]]) |>
    purrr::map(\(x) paste0(x, collapse = ", ")) |>
    collapse::unlist2d() |>
    rlang::set_names(c(key, var))
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
    if (sum2(cheapr::counts(y$fac_ccn)$count > 1L) == 0L) {
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

  if (sum2(cheapr::counts(y$fac_ccn)$count > 1L) == 0L) {
    return(join2(x, y, on = "fac_ccn"))
  }

  join2(x, collapse_rows(y, "fac_ccn", "compliance"), on = "fac_ccn")
}

#' @noRd
pivot_multi <- function(x) {
  y <- collapse::gvr(x, "^fac_ccn$|_multi$") |>
    collapse::pivot(
      ids = "fac_ccn",
      names = list(variable = "multi", value = "ind"),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv("fac_ccn")

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

  if (sum2(cheapr::counts(y$fac_ccn)$count > 1L) == 0L) {
    return(join2(x, y, on = "fac_ccn"))
  }

  y <- collapse_rows(y, "fac_ccn", "multi")
  join2(x, y, on = "fac_ccn")
}

#' @noRd
pivot_credit <- function(x) {
  y <- collapse::gvr(x, "^fac_ccn$|^acr_") |>
    collapse::pivot(
      ids = "fac_ccn",
      names = list(variable = "acr_org", value = "acr_date"),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv("fac_ccn")

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
  y <- collapse::gvr(x, "^pac$|_ind$|_otxt$") |>
    collapse::pivot(
      ids = c("pac", "own_otxt"),
      names = list(variable = "own_type", value = "ind"),
      na.rm = TRUE
    ) |>
    collapse::roworderv("pac") |>
    collapse::funique()

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

  y <- combine_columns(
    y,
    main = "own_type",
    other = "own_otxt",
    prefix = "Other: ",
    sep = ""
  ) |>
    collapse::funique()

  if (sum2(cheapr::counts(y$pac)$count > 1L) == 0L) {
    return(join2(x, y, on = "pac"))
  }

  y <- collapse_rows(y, "pac", "own_type")
  join2(x, y, on = "pac")
}

#' @noRd
pivot_subgroup <- function(x) {
  y <- collapse::gvr(x, "^enid$|sub_") |>
    collapse::pivot(
      ids = c("enid", "sub_otxt"),
      names = list("subgroup", "ind"),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv("enid")

  collapse::settfmv(y, "subgroup", as.character)
  collapse::gvr(x, "sub_") <- NULL

  if (nrow(y) == 0L) {
    return(collapse::av(x, subgroup = rep.int(NA_character_, nrow(x))))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:3)

  if (nrow(y) == 0L) {
    return(collapse::av(x, subgroup = rep.int(NA_character_, nrow(x))))
  }

  RC_subgroup(y$subgroup)

  y <- combine_columns(
    y,
    main = "subgroup",
    other = "sub_otxt",
    prefix = "Other: ",
    sep = ""
  ) |>
    collapse::funique()

  if (sum2(cheapr::counts(y$enid)$count > 1L) == 0L) {
    return(join2(x, y, on = "enid"))
  }

  y <- collapse_rows(y, "enid", "subgroup")
  join2(x, y, on = "enid")
}
