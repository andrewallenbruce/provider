#' @noRd
pivot_compliance <- function(x) {
  y <- collapse::gvr(x, "^fac_ccn$|^cmp_$|^poc_|^elig_") |>
    collapse::pivot(
      ids = "fac_ccn",
      names = list(variable = "compliance", value = "ind"),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv("fac_ccn")

  collapse::settfmv(y, "compliance", as.character)

  if (nrow(y) == 0L) {
    collapse::gvr(x, "^multi_|^hosp_|^non_|^tmp_") <- NULL
    return(collapse::av(x, multi = rep.int(NA_character_, nrow(x))))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:2)

  if (nrow(y) == 0L) {
    collapse::gvr(x, "^multi_|^hosp_|^non_|^tmp_") <- NULL
    return(collapse::av(x, multi = rep.int(NA_character_, nrow(x))))
  }

  collapse::gvr(x, "^multi_|^hosp_|^non_|^tmp_") <- NULL

  collapse::recode_char(
    y$compliance,
    "cmp_ind" = "Compliant at Certification",
    "poc_ind" = "Compliant with Plan of Correction",
    "elig_ind" = "Eligible forMedicare/Medicaid",
    default = NA_character_,
    set = TRUE
  )

  if (sum2(cheapr::counts(y$fac_ccn)$count > 1L) == 0L) {
    return(collapse::join(x, y, on = "fac_ccn", verbose = 0L, multiple = TRUE))
  }

  y <- collapse::rsplit(y$multi, y$fac_ccn) |>
    purrr::map(\(x) paste0(x, collapse = ", ")) |>
    collapse::unlist2d() |>
    rlang::set_names(c("fac_ccn", "multi"))

  collapse::join(x, y, on = "fac_ccn", verbose = 0L, multiple = TRUE)
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
    return(collapse::join(x, y, on = "fac_ccn", verbose = 0L, multiple = TRUE))
  }

  y <- collapse::rsplit(y$multi, y$fac_ccn) |>
    purrr::map(\(x) paste0(x, collapse = ", ")) |>
    collapse::unlist2d() |>
    rlang::set_names(c("fac_ccn", "multi"))

  collapse::join(x, y, on = "fac_ccn", verbose = 0L, multiple = TRUE)
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
  collapse::join(x, y, on = "fac_ccn", verbose = 0L, multiple = TRUE)
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
    return(collapse::join(x, y, on = "pac", verbose = 0L))
  }

  y <- collapse::rsplit(y$own_type, y$pac) |>
    purrr::map(\(x) paste0(x, collapse = ", ")) |>
    collapse::unlist2d() |>
    rlang::set_names(c("pac", "own_type"))

  collapse::join(x, y, on = "pac", verbose = 0L)
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
    return(collapse::join(x, y, on = "enid", verbose = 0L))
  }

  y <- collapse::rsplit(y$subgroup, y$enid) |>
    purrr::map(\(x) paste0(x, collapse = ", ")) |>
    collapse::unlist2d() |>
    rlang::set_names(c("enid", "subgroup"))

  collapse::join(x, y, on = "enid", verbose = 0L)
}
