#' @noRd
rc_subgroup <- function(x, column) {
  collapse::recode_char(
    x[[column]],
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
rc_own_type <- function(x, column) {
  collapse::recode_char(
    x[[column]],
    "acq_ind" = "Acquisition",
    "corp_ind" = "Corporation",
    "llc_ind" = "LLC",
    "mps_ind" = "Provider/Supplier",
    "msr_ind" = "Management",
    "mst_ind" = "Staffing",
    "hld_ind" = "Holding",
    "inv_ind" = "Investment",
    "fin_ind" = "Bank",
    "con_ind" = "Consulting",
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

#' @noRd
rc_clia <- function(x, column, arg = caller_arg(column), call = caller_env()) {
  switch(
    column,
    action = collapse::recode_char(
      x[[column]],
      "1" = "Initial",
      "2" = "Recertify",
      "3" = "Terminate",
      "4" = "CHOW",
      "5" = "Validate",
      "8" = "Survey",
      default = NA_character_,
      set = TRUE
    ),
    acr_org = collapse::recode_char(
      x[[column]],
      "acr_a2la_date" = "A2LA",
      "acr_aabb_date" = "AABB",
      "acr_aoa_date" = "AOA",
      "acr_ashi_date" = "ASHI-HLA",
      "acr_cap_date" = "CAP",
      "acr_cola_date" = "COLA",
      "acr_jcaho_date" = "JCAHO",
      default = NA_character_,
      set = TRUE
    ),
    cert_type = collapse::recode_char(
      x[[column]],
      "1" = "Compliance",
      "2" = "Waiver",
      "3" = "Accreditation",
      "4" = "PPM",
      "9" = "Registration",
      default = NA_character_,
      set = TRUE
    ),
    fac_type = collapse::recode_char(
      x[[column]],
      "01" = "Ambulance",
      "02" = "ASC",
      "03" = "Ancillary",
      "04" = "ALF",
      "05" = "Blood",
      "06" = "Community",
      "07" = "CORF",
      "08" = "ESRD",
      "09" = "FQHC",
      "10" = "Fair",
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
      "24" = "Public",
      "25" = "RHC",
      "26" = "SHS",
      "27" = "SNF",
      "28" = "Tissue",
      "29" = "Other",
      default = NA_character_,
      set = TRUE
    ),
    owner = collapse::recode_char(
      x[[column]],
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
    ),
    multi_site = collapse::recode_char(
      x[[column]],
      "site_multi" = "Applied",
      "hosp_multi" = "Hospital Campus",
      "non_multi" = "Non-profit",
      "tmp_multi" = "Temporary",
      default = NA_character_,
      set = TRUE
    ),
    term = collapse::recode_char(
      x[[column]],
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
    ),
    cli::cli_abort(
      "{.val {arg}} is not a column in {.var x}",
      arg = arg,
      call = call
    )
  )
}
