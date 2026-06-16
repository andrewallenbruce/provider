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
    rc_bin(collapse::gvr(x, "multi|_ind$", return = 2L)) |>
    pivot_subgroup() |>
    rc_ptype()
}

#' @noRd
S7::method(polish, s3_hospitals2) <- function(x) {
  collapse::setv(x[["hospital_overall_rating"]], "N/A", NA_character_)
  collapse::settfmv(x, "hospital_overall_rating", as.integer)
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_nppes) <- function(x) {
  collapse::gvr(x, "_epoch$|^endpoints$") <- NULL
  collapse::setv(x[["enumeration_type"]], "NPI-1", "1")
  collapse::setv(x[["enumeration_type"]], "NPI-2", "2")
  collapse::settfmv(x, c("number", "enumeration_type"), as.integer)

  collapse::recode_char(
    colnames(x),
    "number" = "npi",
    "enumeration_type" = "entity",
    "practiceLocations" = "location",
    "identifiers" = "id",
    "other_names" = "other",
    "taxonomies" = "taxonomy",
    "addresses" = "address",
    set = TRUE
  )

  x <- collapse::colorderv(x, c("npi", "entity")) |>
    collapse::roworderv("entity")

  list(
    type_1 = nppes_entity_1(x),
    type_2 = nppes_entity_2(x)
  )
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
S7::method(polish, s3_quality) <- function(x) {
  x <- c(2017, 2022, 2023) |>
    purrr::map(\(year) quality_get(x, year)) |>
    collapse::rowbind(fill = TRUE) |>
    add_class("quality")

  x <- recode(x)
  collapse::roworderv(x, c("npi", "year"))
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
