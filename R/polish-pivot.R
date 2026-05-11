#' @noRd
credit_pivot <- function(x) {
  y <- collapse::gvr(x, "^fac_ccn$|^acr_") |>
    collapse::pivot(
      ids = "fac_ccn",
      names = list(variable = "acr_org", value = "acr_date"),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv("fac_ccn")

  if (nrow(y) == 0L) {
    collapse::gvr(x, "^acr_") <- NULL
    return(collapse::av(
      x,
      acr_org = cheapr::na_init(y$acr_org, nrow(x)),
      acr_date = cheapr::na_init(y$acr_date, nrow(x))
    ))
  }

  collapse::settfmv(y, "acr_org", as.character)

  RC_clia_credit(y$acr_org)

  collapse::gvr(x, "^acr_") <- NULL

  collapse::join(x, y, on = "fac_ccn", verbose = 0L, multiple = TRUE)
}

#' @noRd
owner_pivot <- function(x) {
  y <- collapse::gvr(x, "^pac$|_ind$|_otxt$") |>
    collapse::pivot(
      ids = c("pac", "own_otxt"),
      names = list(variable = "own_type", value = "ind"),
      na.rm = TRUE
    ) |>
    collapse::roworderv("pac") |>
    collapse::funique()

  if (nrow(y) == 0L) {
    collapse::gvr(x, "_ind$|_otxt$") <- NULL
    return(collapse::av(x, own_type = rep.int(NA_character_, nrow(x))))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:3)

  if (nrow(y) == 0L) {
    collapse::gvr(x, "_ind$|_otxt$") <- NULL
    return(collapse::av(x, own_type = rep.int(NA_character_, nrow(x))))
  }

  collapse::settfmv(y, "own_type", as.character)

  RC_own_type(y$own_type)

  collapse::gvr(x, "_ind$|_otxt$") <- NULL

  y <- combine_columns(
    y,
    main = "own_type",
    other = "own_otxt",
    prefix = "Other: ",
    sep = ""
  ) |>
    collapse::funique() |>
    collapse::fcountv("pac", add = TRUE)

  if (sum2(y$N > 1L) == 0L) {
    return(collapse::join(
      x,
      collapse::ss(y, j = 1:2),
      on = "pac",
      verbose = 0L
    ))
  }

  y <- collapse::rsplit(y$own_type, y$pac) |>
    purrr::map(\(x) paste0(x, collapse = ", ")) |>
    collapse::unlist2d() |>
    rlang::set_names(c("pac", "own_type")) |>
    collapse::roworderv(c("pac", "own_type")) |>
    collapse::funique()

  collapse::join(x, y, on = "pac", verbose = 0L)
}

#' @noRd
subgroup_pivot <- function(x) {
  y <- collapse::gvr(x, "^enid$|sub_") |>
    collapse::pivot(
      ids = c("enid", "sub_otxt"),
      names = list("subgroup", "ind"),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv("enid")

  if (nrow(y) == 0L) {
    collapse::gvr(x, "sub_") <- NULL
    return(collapse::av(x, subgroup = rep.int(NA_character_, nrow(x))))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:3)

  if (nrow(y) == 0L) {
    collapse::gvr(x, "sub_") <- NULL
    return(collapse::av(x, subgroup = rep.int(NA_character_, nrow(x))))
  }

  collapse::settfmv(y, "subgroup", as.character)

  RC_subgroup(y$subgroup)

  collapse::gvr(x, "sub_") <- NULL

  y <- combine_columns(
    y,
    main = "subgroup",
    other = "sub_otxt",
    prefix = "Other: ",
    sep = ""
  ) |>
    collapse::funique() |>
    collapse::fcountv("enid", add = TRUE)

  if (sum2(y$N > 1L) == 0L) {
    return(collapse::join(
      x,
      collapse::ss(y, j = 1:2),
      on = "enid",
      verbose = 0L
    ))
  }

  y <- collapse::rsplit(y$subgroup, y$enid) |>
    purrr::map(\(x) paste0(x, collapse = ", ")) |>
    collapse::unlist2d() |>
    rlang::set_names(c("enid", "subgroup")) |>
    collapse::roworderv(c("enid", "subgroup")) |>
    collapse::funique()

  collapse::join(x, y, on = "enid", verbose = 0L)
}
