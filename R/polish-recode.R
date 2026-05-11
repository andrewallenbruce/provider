#' @noRd
credit_pivot <- function(x) {
  cols <- c(
    "a2la_",
    "aabb_",
    "aoa_",
    "ashi_",
    "cap_",
    "cola_",
    "jcaho_"
  )

  y <- collapse::gvr(x, c("fac_ccn", cols)) |>
    collapse::pivot(
      ids = "fac_ccn",
      names = list(variable = "acr_org", value = "acr_date"),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv("fac_ccn")

  if (nrow(y) == 0L) {
    collapse::gvr(x, cols) <- NULL
    return(collapse::av(
      x,
      acr_org = cheapr::na_init(y$acr_org, nrow(x)),
      acr_date = cheapr::na_init(y$acr_date, nrow(x))
    ))
  }

  collapse::settfmv(y, "acr_org", as.character)

  RC_clia_credit(y$acr_org)

  collapse::gvr(x, cols) <- NULL

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
    collapse::funique() |>
    collapse::roworderv("pac")

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

  y <- collapse::ss(y, j = 1:2)

  y <- collapse::rsplit(y$own_type, y$pac, flatten = TRUE) |>
    purrr::map_chr(\(x) paste0(x, collapse = ", ")) |>
    as_data_frame() |>
    set_names(c("pac", "own_type")) |>
    collapse::rowbind(y) |>
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

  y <- collapse::ss(y, j = 1:2)
  g <- collapse::GRP(y$enid, call = FALSE)

  y <- collapse::gsplit(y$subgroup, g, use.g.names = TRUE) |>
    purrr::map_chr(\(x) paste0(x, collapse = ", ")) |>
    as_data_frame() |>
    set_names(c("enid", "subgroup")) |>
    collapse::rowbind(y) |>
    collapse::roworderv(c("enid", "subgroup"))

  collapse::join(x, y, on = "enid", verbose = 0L)
}

#' @noRd
RC_clia_term <- function(xcol) {
  collapse::recode_char(
    xcol,
    "00" = "Active",
    "01" = "Voluntary [Merger/Closure]",
    "02" = "Voluntary [Reimbursement]",
    "03" = "Voluntary [Term Risk]",
    "04" = "Voluntary [Other]",
    "05" = "Involuntary [Safety]",
    "06" = "Involuntary [Agreement]",
    "07" = "Other",
    "08" = "Fee Nonpayment (CLIA)",
    "09" = "Unsuccessful PT (CLIA)",
    "10" = "Other (CLIA)",
    "11" = "Incomplete Application (CLIA)",
    "12" = "Not Performing Tests (CLIA)",
    "13" = "Multiple to Single (CLIA)",
    "14" = "Shared Lab (CLIA)",
    "15" = "Unrenewed Waiver PPM (CLIA)",
    "16" = "Duplicate CLIA (CLIA)",
    "17" = "Unable to Contact (CLIA)",
    "20" = "Bankruptcy (CLIA)",
    "33" = "Accreditation Unconfirmed (CLIA)",
    "80" = "Awaiting State Approval",
    "99" = "OIG Action (CLIA)",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_cert <- function(xcol) {
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
RC_clia_own <- function(xcol) {
  collapse::recode_char(
    xcol,
    "01" = "RNHCI",
    "02" = "Private",
    "03" = "Other",
    "04" = "Proprietary",
    "05" = "Validation",
    "05" = "[GOE] City",
    "06" = "[GOE] County",
    "07" = "[GOE] State",
    "08" = "[GOE] Federal",
    "09" = "[GOE] Other",
    "10" = "Unknown",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_fac <- function(xcol) {
  collapse::recode_char(
    xcol,
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
    "16" = "Industrial",
    "17" = "Insurance",
    "18" = "ICF-IID",
    "19" = "Mobile",
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
RC_clia_act <- function(xcol) {
  collapse::recode_char(
    xcol,
    "1" = "Init",
    "2" = "Recert",
    "3" = "Term",
    "4" = "CHOW",
    "5" = "Validate",
    "8" = "Survey (Complaint)",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_credit <- function(xcol) {
  collapse::recode_char(
    xcol,
    "a2la_date" = "A2LA",
    "aabb_date" = "AABB",
    "aoa_date" = "AOA",
    "ashi_date" = "ASHI-HLA",
    "cap_date" = "CAP",
    "cola_date" = "COLA",
    "jcaho_date" = "JCAHO",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_subgroup <- function(xcol) {
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
RC_own_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "acq_ind" = "Created for Aquisition",
    "corp_ind" = "Corporation",
    "llc_ind" = "LLC",
    "mps_ind" = "Provider/Supplier",
    "msr_ind" = "Management Service",
    "mst_ind" = "Medical Staffing",
    "hld_ind" = "Holding Company",
    "inv_ind" = "Investment Firm",
    "fin_ind" = "Bank",
    "con_ind" = "Consulting Firm",
    "fp_ind" = "For-Profit",
    "np_ind" = "Non-Profit",
    "pe_ind" = "Private Equity",
    "reit_ind" = "REIT",
    "cho_ind" = "Chain",
    "oth_ind" = "Other",
    "ano_ind" = "Another Org/Ind",
    default = NA_character_,
    set = TRUE
  )
}
