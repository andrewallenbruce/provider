#' @include aaa-classes.R
#' @include aaa-generics.R
#' @noRd
S7::method(polish, S7::class_integer | Endpoint) <- function(x) {
  invisible(x)
}

#' @noRd
S7::method(polish, S7::class_data.frame) <- function(x) {
  cli::cli_alert_warning("Using default {.cls polish} method")
  add_class(x) |>
    replace_nz()
}

#' @noRd
S7::method(polish, s3_affiliations) <- function(x) {
  collapse::settfmv(x, "npi", as.integer)
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_clia) <- function(x) {
  recode(x)
  set_rename(x)
  get_columns(x) |>
    rc_bin(collapse::gvr(x, "eligible$|_multi$", return = 2L)) |>
    rc_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_combine("address", "add_2") |>
    rc_combine("fac_name", "fac_2") |>
    pivot_multi_site() |>
    pivot_acr_org()
}

#' @noRd
S7::method(polish, s3_clinicians) <- function(x) {
  collapse::settfmv(x, c("npi", "grd_yr", "num_org_mem"), as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_combine("specialty", "spec_other")
}

#' @noRd
S7::method(polish, s3_dialysis) <- function(x) {
  collapse::settfmv(x, c("five_star", "network"), as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_ymd("cert_date") |>
    rc_combine("address", "add_2")
}

#' @noRd
S7::method(polish, s3_facility) <- function(x) {
  x <- rowbind2(x, "fac_type", fill = TRUE) |>
    add_class("facility")

  collapse::settfmv(x, "NPI", as.integer)

  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_bin("multi") |>
    rc_ymd("inc_date") |>
    rc_other("org_type", "org_otxt")
}

#' @noRd
S7::method(polish, s3_hospitals) <- function(x) {
  recode(x)
  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_other("org_type", "org_otxt") |>
    rc_other("loc_type", "loc_otxt") |>
    rc_ymd(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_bin(collapse::gvr(x, "multi|^sub_", return = 2L)) |>
    pivot_subgroup() |>
    rc_ptype()
}

#' @noRd
S7::method(polish, s3_hospitals2) <- function(x) {
  suppressWarnings(collapse::settfmv(x, "hospital_overall_rating", as.integer))
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_opt_out) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_bin("order_refer") |>
    rc_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
S7::method(polish, s3_order_refer) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L))
}

#' @noRd
S7::method(polish, s3_owner) <- function(x) {
  x <- rowbind2(x, "fac_type", fill = TRUE) |>
    add_class("owner")

  collapse::settfmv(x, "PERCENTAGE OWNERSHIP", as.double)
  collapse::recode_char(
    x[["ROLE CODE - OWNER"]],
    "01" = "5%+ Ownership",
    "03" = "Partner",
    "25" = "Contracted Mgmt Employee",
    "34" = "5%+ Ownership (Direct)",
    "35" = "5%+ Ownership (Indirect)",
    "36" = "5%+ Mortgage",
    "37" = "5%+ Security",
    "38" = "General Partner",
    "39" = "Limited Partner",
    "40" = "Officer",
    "41" = "Director",
    "42" = "W2 Mgmt Employee",
    "43" = "Ops/Mgmt Control",
    "44" = "Other",
    default = NA_character_,
    set = TRUE
  )

  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("asc_date") |>
    pivot_owner()
}

#' @noRd
S7::method(polish, s3_pending) <- function(x) {
  x <- rowbind2(x, "prov_type", fill = TRUE) |>
    add_class("pending") |>
    rc_trim()

  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_providers) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin("multi")
}

#' @noRd
quality_get <- function(x, y) {
  y <- match.arg(as.character(y), c("2017", "2022", "2023"))
  z <- switch(
    y,
    "2017" = as.character(2017:2021),
    "2022" = "2022",
    "2023" = as.character(2023:2024)
  )

  if (!collapse::has_elem(x, z)) {
    return(list())
  }

  x <- collapse::get_elem(x, z, keep.tree = TRUE) |>
    rowbind2("year", fill = TRUE)

  NMS <- RE_NAME[["quality"]][[y]]

  collapse::setrename(x, NMS, .nse = FALSE)
  replace_nz(x)

  x <- collapse::gv(x, unlist_(NMS)) |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    pivot_quality()

  if (y == "2017") {
    x <- collapse::av(
      x,
      cred = vec_na(x),
      dual_ratio = vec_na(x, "double"),
      small_bonus = vec_na(x, "integer")
    )
  }

  if (y %in% c("2017", "2022")) {
    x <- collapse::av(
      x,
      reporting = vec_na(x),
      mvp = vec_na(x),
      ci_score = vec_na(x, "double")
    )
  }
  return(x)
}

#' @noRd
S7::method(polish, s3_quality) <- function(x) {
  x <- c(2017, 2022, 2023) |>
    purrr::map(\(year) quality_get(x, year)) |>
    collapse::rowbind(fill = TRUE) |>
    add_class("quality")

  recode(x)
  collapse::roworderv(x, c("year", "npi"))
}

#' @noRd
S7::method(polish, s3_reassignments) <- function(x) {
  collapse::settfmv(
    x,
    c(
      "Individual NPI",
      "Individual Total Employer Associations",
      "Group Reassignments and Physician Assistants"
    ),
    as.integer
  )
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_revocations) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin("multi") |>
    rc_trim() |>
    rc_ymd(c("start_date", "end_date"))
}

#' @noRd
S7::method(polish, s3_transparency) <- function(x) {
  collapse::settfmv(x, "Case_ID", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_ymd("action_date") |>
    rc_trim()
}

#' @noRd
S7::method(polish, s3_utilization) <- function(x) {
  x <- rowbind2(x, "year", fill = TRUE) |>
    add_class("utilization")

  collapse::settfmv(
    x,
    c(
      "year",
      "Rndrng_NPI",
      "Tot_HCPCS_Cds",
      "Tot_Benes",
      "Tot_Srvcs",
      "Tot_Sbmtd_Chrg",
      "Bene_Avg_Age",
      "Bene_Dual_Cnt",
      "Bene_Ndual_Cnt"
    ),
    as.integer
  )
  collapse::settfmv(
    x,
    c(
      "Bene_Avg_Risk_Scre",
      "Tot_Mdcr_Alowd_Amt",
      "Tot_Mdcr_Pymt_Amt"
    ),
    as.double
  )
  set_rename(x)
  get_columns(x) |>
    rc_bin("participating") |>
    rc_combine("address", "add_2") |>
    collapse::roworderv(c("year", "npi"))
}
