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
S7::method(recode, s3_hospitals) <- function(x) {
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
    "CORPORATION" = "Corporation",
    "OTHER" = "Other",
    "PARTNERSHIP" = "Partnership",
    "SOLE PROPRIETOR" = "Sole Proprietor",
    default = NA_character_,
    set = TRUE
  )
}

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
    "03" = "Anc",
    "04" = "ALF",
    "05" = "Blood",
    "06" = "Comm",
    "07" = "CORF",
    "08" = "ESRD",
    "09" = "FQHC",
    "10" = "Fair",
    "11" = "HMO",
    "12" = "HHA",
    "13" = "Hospice",
    "14" = "Hospital",
    "15" = "Ind",
    "16" = "Industry",
    "17" = "Insurance",
    "18" = "ICF-IID",
    "19" = "Mobile",
    "20" = "Rx",
    "21" = "Phys",
    "22" = "Other Pract",
    "23" = "Prison",
    "24" = "Public",
    "25" = "RHC",
    "26" = "SHS",
    "27" = "SNF",
    "28" = "Tissue",
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
    "01" = "Vol Term [Merger/Closure]",
    "02" = "Vol Term [Reimbursement]",
    "03" = "Vol Term [Term Risk]",
    "04" = "Vol Term [Other]",
    "05" = "Inv Term [Safety]",
    "06" = "Inv Term [Violation]",
    "07" = "Oth Term",
    "08" = "Nonpayment [CLIA]",
    "09" = "Failed PT [CLIA]",
    "10" = "Other [CLIA]",
    "11" = "Incomp Appl [CLIA]",
    "12" = "No Longer Performing Tests [CLIA]",
    "13" = "Mult-to-Single [CLIA]",
    "14" = "Shared Site [CLIA]",
    "15" = "Expired PPM Waiver [CLIA]",
    "16" = "Dupe CLIA [CLIA]",
    "17" = "No Contact [CLIA]",
    "20" = "Bankrupt [CLIA]",
    "33" = "Unconfirmed Accred [CLIA]",
    "80" = "State Approval Pending",
    "99" = "OIG [CLIA]",
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
      "adjustment",
      "final_score",
      "complex_bonus",
      "qa_score",
      "cost_score",
      "qi_score",
      "dual_ratio",
      "ci_score"
    ),
    as.double
  )
}
