#' @noRd
rm_period <- function(x) {
  gsub(".", "", x, fixed = TRUE)
}

#' @noRd
rm_percent <- function(x) {
  gsub("%", "", x, fixed = TRUE)
}

#' @noRd
set_nz <- function(x) {
  collapse::setv(x, "", NA_character_)
}

#' @noRd
replace_nz <- function(x) {
  collapse::settfmv(x, is.character, set_nz)
}

#' @noRd
rc_trim <- function(x) {
  purrr::modify_if(x, is.character, trimws)
}

#' @noRd
recoder <- function(.f) {
  function(x, v) {
    collapse::tfmv(.data = x, vars = v, FUN = .f)
  }
}

#' @noRd
rc_bin <- recoder(bin_col)

#' @noRd
rc_ymd <- recoder(as_date_ymd)

#' @noRd
rc_ymd2 <- recoder(as_date_ymd2)

#' @noRd
rc_mdy <- recoder(as_date_mdy)

#' @noRd
bin_col <- function(x) {
  cheapr::case(
    x %in_% c("YES", "Y", "Yes", "True") ~ 1L,
    x %in_% c("NO", "N", "No", "False") ~ 0L,
    .default = NA_integer_
  )
}

#' @noRd
as_date_ymd <- function(x, ...) {
  as.Date.character(x, format = "%Y-%m-%d", ...)
}

#' @noRd
as_date_ymd2 <- function(x, ...) {
  as.Date.character(x, format = "%Y%m%d", ...)
}

#' @noRd
as_date_mdy <- function(x, ...) {
  as.Date.character(x, format = "%m/%d/%Y", ...)
}


#' @noRd
recast <- function(.data, ...) {
  name <- as.character(substitute(.data))
  if (length(name) != 1L || name == ".") {
    stop("Cannot assign to name: ", deparse(substitute(.data)))
  }
  res <- collapse::ftransformv(.data, ...)
  assign(name, res, envir = parent.frame(3L))
  invisible(res)
}

#' @noRd
recode <- S7::new_generic("recode", "x")

#' @noRd
S7::method(recode, s3_clia) <- function(x) {
  recast(
    x,
    c("CHOW_CNT", "DRCTLY_AFLTD_LAB_CNT", "LAB_SITE_CNT"),
    as.integer
  )

  collapse::recode_char(
    x[["CRTFCTN_ACTN_TYPE_CD"]],
    "1" = "Initial",
    "2" = "Recertify",
    "3" = "Terminate",
    "4" = "CHOW",
    "5" = "Validate",
    "8" = "Survey",
    default = NA_character_,
    set = TRUE
  )

  collapse::recode_char(
    x[["CRTFCT_TYPE_CD"]],
    "1" = "Compliance",
    "2" = "Waiver",
    "3" = "Accreditation",
    "4" = "PPM",
    "9" = "Registration",
    default = NA_character_,
    set = TRUE
  )

  collapse::recode_char(
    x[["GNRL_FAC_TYPE_CD"]],
    "01" = "Ambulance",
    "02" = "ASC",
    "03" = "Ancillary",
    "04" = "ALF",
    "05" = "Blood Bank",
    "06" = "Community Clinic",
    "07" = "CORF",
    "08" = "ESRD",
    "09" = "FQHC",
    "10" = "Health Fair",
    "11" = "HMO",
    "12" = "HHA",
    "13" = "Hospice",
    "14" = "Hospital",
    "15" = "Independent",
    "16" = "Industry",
    "17" = "Insurance",
    "18" = "ICF-IID",
    "19" = "Mobile Lab",
    "20" = "Pharmacy",
    "21" = "Physician",
    "22" = "Other Practice",
    "23" = "Prison",
    "24" = "Health Dept",
    "25" = "RHC",
    "26" = "SHS",
    "27" = "SNF",
    "28" = "Tissue Bank",
    "29" = "Other",
    default = NA_character_,
    set = TRUE
  )

  collapse::recode_char(
    x[["GNRL_CNTL_TYPE_CD"]],
    "01" = "RNHCI",
    "02" = "Private",
    "03" = "Other",
    "04" = "Proprietary",
    "05" = "Validation",
    "05" = "[GOV] City",
    "06" = "[GOV] County",
    "07" = "[GOV] State",
    "08" = "[GOV] Federal",
    "09" = "[GOV] Other",
    "10" = "Unknown",
    default = NA_character_,
    set = TRUE
  )

  collapse::recode_char(
    x[["CLIA_TRMNTN_CD"]],
    "00" = "Active",
    "01" = "Term [VOL:Merger/Closure]",
    "02" = "Term [VOL:Reimbursement]",
    "03" = "Term [VOL:Term Risk]",
    "04" = "Term [VOL:Other]",
    "05" = "Term [Safety]",
    "06" = "Term [Violation]",
    "07" = "Term [Other]",
    "08" = "Nonpayment [CLIA]",
    "09" = "Failed PT [CLIA]",
    "10" = "Other [CLIA]",
    "11" = "Incomplete Application [CLIA]",
    "12" = "No Longer Performing Tests [CLIA]",
    "13" = "Multi-to-Single Site [CLIA]",
    "14" = "Shared Site [CLIA]",
    "15" = "Expired PPM Waiver [CLIA]",
    "16" = "Duplicate CLIA [CLIA]",
    "17" = "Unable to Contact [CLIA]",
    "20" = "Bankruptcy [CLIA]",
    "33" = "Unconfirmed Accreditation [CLIA]",
    "80" = "State Approval Pending",
    "99" = "OIG Action [CLIA]",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
S7::method(recode, s3_hospital) <- function(x) {
  recast(x, "NPI", as.integer)
  collapse::recode_char(
    x[["PROVIDER TYPE CODE"]],
    "00-24" = "REH",
    "00-85" = "CAH",
    default = NA_character_,
    set = TRUE
  )
  collapse::recode_char(
    x[["PROPRIETARY NONPROFIT"]],
    "P" = "For-Profit",
    "N" = "Non-Profit",
    default = NA_character_,
    set = TRUE
  )
  collapse::recode_char(
    x[["PRACTICE LOCATION TYPE"]],
    "MAIN/PRIMARY HOSPITAL LOCATION" = "Primary",
    "HOSPITAL PSYCHIATRIC UNIT" = "Psychiatric Unit",
    "HOSPITAL REHABILITATION UNIT" = "Rehabilitation Unit",
    "HOSPITAL SWING-BED UNIT" = "Swing-Bed Unit",
    "OPT EXTENSION SITE" = "Opt Extension",
    "OTHER HOSPITAL PRACTICE LOCATION" = "Other",
    default = NA_character_,
    set = TRUE
  )
  collapse::recode_char(
    x[["ORGANIZATION TYPE STRUCTURE"]],
    "LLC" = "LLC",
    "CORPORATION" = "Corp",
    "OTHER" = "Other",
    "PARTNERSHIP" = "Partnership",
    "SOLE PROPRIETOR" = "Sole Proprietor",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
S7::method(recode, s3_owner) <- function(x) {
  recast(x, "PERCENTAGE OWNERSHIP", as.double)
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
}

#' @noRd
S7::method(recode, s3_quality) <- function(x) {
  x <- collapse::tfmv(
    x,
    c(
      "year",
      "npi",
      "size",
      "years",
      "patients",
      "charges",
      "services",
      "ia_score",
      "pi_score",
      "small_bonus"
    ),
    as.integer
  )
  collapse::tfmv(
    x,
    c(
      "final_score",
      "qa_score",
      "cost_score",
      "qi_score",
      "ci_score",
      "adjustment",
      "complex_bonus",
      "dual_ratio"
    ),
    as.double
  )
}
