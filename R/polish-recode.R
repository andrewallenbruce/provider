#' @noRd
RC_clia_term_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "00" = "Active",
    "01" = "Voluntary-Merger/Closure",
    "02" = "Voluntary-Reimbursement Dissatisfaction",
    "03" = "Voluntary-Termination Risk",
    "04" = "Voluntary-Other",
    "05" = "Involuntary-Health/Safety Failure",
    "06" = "Involuntary-Agreement Failure",
    "07" = "Other Status Change",
    "08" = "Fee Nonpayment (CLIA)",
    "09" = "Unsuccessful PT (CLIA)",
    "10" = "Other (CLIA)",
    "11" = "Incomplete Application (CLIA)",
    "12" = "Not Performing Tests (CLIA)",
    "13" = "Multiple to Single Site (CLIA)",
    "14" = "Shared Laboratory (CLIA)",
    "15" = "Failure to Renew Waiver PPM (CLIA)",
    "16" = "Duplicate CLIA (CLIA)",
    "17" = "Mail Returned Cert Ended (CLIA)",
    "20" = "Bankruptcy (CLIA)",
    "33" = "Accreditation Unconfirmed (CLIA)",
    "80" = "Awaiting State Approval",
    "99" = "OIG Do Not Activate (CLIA)",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_cert_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "1" = "Compliance",
    "2" = "Waiver",
    "3" = "Accreditation",
    "4" = "PPM",
    "9" = "Registration",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_own_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "01" = "Religious Affiliation",
    "02" = "Private",
    "03" = "Other",
    "04" = "Proprietary",
    "05" = "Validation",
    "05" = "Govt-City",
    "06" = "Govt-County",
    "07" = "Govt-State",
    "08" = "Govt-Federal",
    "09" = "Govt-Other",
    "10" = "Unknown",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_fac_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "01" = "Ambulance",
    "02" = "ASC",
    "03" = "Ancillary Site",
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
    "16" = "Industrial",
    "17" = "Insurance",
    "18" = "ICF-IID",
    "19" = "Mobile Lab",
    "20" = "Pharmacy",
    "21" = "Physician",
    "22" = "Other Practitioner",
    "23" = "Prison",
    "24" = "Public Health",
    "25" = "RHC",
    "26" = "SHS",
    "27" = "SNF",
    "28" = "Tissue Bank",
    "29" = "Other",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_act_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "1" = "Initial",
    "2" = "Recertification",
    "3" = "Termination",
    "4" = "Change of Ownership",
    "5" = "Validation",
    "8" = "Full Survey After Complaint",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_credit_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "a2la_ind" = "A2LA",
    "aabb_ind" = "AABB",
    "aoa_ind" = "AOA",
    "ashi_ind" = "ASHI-HLA",
    "cap_ind" = "CAP",
    "cola_ind" = "COLA",
    "jcaho_ind" = "JCAHO",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_subgroup_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "sub_acute" = "Acute",
    "sub_gen" = "General",
    "sub_spec" = "Specialty",
    "sub_adu" = "ADH",
    "sub_child" = "Child",
    "sub_ltc" = "LTC",
    "sub_psy" = "Psych",
    "sub_irf" = "IRF",
    "sub_stc" = "STC",
    "sub_sba" = "Swing-Bed",
    "sub_psu" = "Psych Unit",
    "sub_iru" = "IRF Unit",
    "sub_oth" = "Other",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_owner_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "acq_ind" = "Created for Aquisition",
    "corp_ind" = "Corporation",
    "llc_ind" = "LLC",
    "mps_ind" = "Medical Provider/Supplier",
    "msr_ind" = "Management Services Company",
    "mst_ind" = "Medical Staffing Company",
    "hld_ind" = "Holding Company",
    "inv_ind" = "Investment Firm",
    "fin_ind" = "Financial Institution",
    "con_ind" = "Consulting Firm",
    "fp_ind" = "For-Profit",
    "np_ind" = "Non-Profit",
    "pe_ind" = "Private Equity",
    "reit_ind" = "REIT",
    "cho_ind" = "Chain Home Office",
    "oth_ind" = "Other",
    "ano_ind" = "Owned by Another Org/Ind",
    default = NA_character_,
    set = TRUE
  )
}

#' @autoglobal
#' @noRd
owner_pivot <- function(x) {
  y <- collapse::gvr(x, "own_pac|_ind$") |>
    collapse::pivot(
      ids = "own_pac",
      factor = FALSE,
      names = list(variable = "own_ind", value = "bin"),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv("own_pac")

  if (nrow(y) == 0L) {
    collapse::gvr(x, "_ind$") <- NULL
    x <- collapse::av(x, own_ind = rep.int(NA_character_, nrow(x)))
    return(x)
  }

  y <- collapse::ss(y, y$bin %==% 1L)

  if (nrow(y) == 0L) {
    collapse::gvr(x, "_ind$") <- NULL
    x <- collapse::av(x, own_ind = rep.int(NA_character_, nrow(x)))
    return(x)
  }

  RC_owner_type(y$own_ind)

  collapse::gv(y, "bin") <- NULL
  collapse::gvr(x, "_ind$") <- NULL

  y <- collapse::roworderv(y, "own_pac") |>
    collapse::gby(own_pac) |>
    collapse::mtt(own_ind = paste0(own_ind, collapse = ", ")) |>
    collapse::fungroup() |>
    collapse::funique()

  collapse::join(x, y, on = "own_pac", verbose = 0L)
}

#' @autoglobal
#' @noRd
credit_pivot <- function(x) {
  col_acr <- c("a2la_", "aabb_", "aoa_", "ashi_", "cap_", "cola_", "jcaho_")

  y <- collapse::gvr(x, c("fac_ccn", col_acr)) |>
    collapse::roworderv("fac_ccn")

  i <- collapse::gvr(y, c("fac_ccn", "_ind")) |>
    collapse::pivot(
      ids = "fac_ccn",
      factor = FALSE,
      names = list(variable = "acr_org", value = "bin"),
      na.rm = TRUE
    ) |>
    collapse::funique()

  if (nrow(i) == 0L) {
    collapse::gvr(x, col_acr) <- NULL
    n <- rep.int(NA_character_, nrow(x))
    x <- collapse::av(x, acr_org = n, acr_date = n)
    return(x)
  }

  i <- collapse::ss(i, i$bin %==% 1L, 1:2)

  if (nrow(i) == 0L) {
    collapse::gvr(x, col_acr) <- NULL
    n <- rep.int(NA_character_, nrow(x))
    x <- collapse::av(x, acr_org = n, acr_date = n)
    return(x)
  }

  d <- collapse::gvr(y, c("fac_ccn", "_date")) |>
    collapse::pivot(
      ids = "fac_ccn",
      factor = FALSE,
      names = list(value = "acr_date"),
      na.rm = TRUE
    ) |>
    collapse::funique()

  d <- collapse::ss(d, j = c(1L, 3L))

  y <- collapse::join(i, d, on = "fac_ccn", verbose = 0L)

  RC_clia_credit_type(y$acr_org)

  collapse::gvr(x, col_acr) <- NULL

  collapse::join(x, y, on = "fac_ccn", verbose = 0L, multiple = TRUE)
}

#' @autoglobal
#' @noRd
subgroup_pivot <- function(x) {
  y <- collapse::gvr(x, "^enid$|sub_") |>
    collapse::roworderv("enid") |>
    collapse::pivot(
      ids = c("enid", "sub_otxt"),
      factor = FALSE,
      names = list("subgroup", "ind"),
      na.rm = TRUE
    ) |>
    collapse::funique()

  if (nrow(y) == 0L) {
    collapse::gvr(x, "sub_") <- NULL
    n <- rep.int(NA_character_, nrow(x))
    x <- collapse::av(x, subgroup = n)
    return(x)
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:3)

  if (nrow(y) == 0L) {
    collapse::gvr(x, "sub_") <- NULL
    n <- rep.int(NA_character_, nrow(x))
    x <- collapse::av(x, subgroup = n)
    return(x)
  }

  RC_subgroup_type(y$subgroup)

  # o <- cheapr::which_(
  #   y$subgroup %==% "Other" &
  #   cheapr::which_not_na(y$sub_otxt)
  # )

  # if (empty(o)) {
  # Handle Other Text
  # }

  collapse::gvr(x, "sub_") <- NULL

  y <- collapse::ss(y, j = c(1, 3)) |>
    collapse::funique() |>
    collapse::roworderv(c("enid", "subgroup")) |>
    collapse::fcountv("enid", add = TRUE)

  z <- cheapr::sset(y, cheapr::which_(y$N > 1L), 1:2)
  y <- cheapr::sset(y, cheapr::which_(y$N == 1L), 1:2)

  g <- collapse::GRP(z$enid)
  y <- collapse::gsplit(z$subgroup, g) |>
    set_names(collapse::GRPnames(g)) |>
    purrr::map_chr(\(x) paste0(x, collapse = ", ")) |>
    cheapr::as_df() |>
    set_names(c("enid", "subgroup")) |>
    collapse::rowbind(y) |>
    collapse::roworderv(c("enid", "subgroup"))

  collapse::join(x, y, on = "enid", verbose = 0L)
}
