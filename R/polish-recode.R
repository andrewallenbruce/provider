#' @noRd
rc_hospitals <- function(
  x,
  column,
  arg = caller_arg(column),
  call = caller_env()
) {
  switch(
    column,
    sub_type = collapse::recode_char(
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
    ),
    `PROVIDER TYPE CODE` = collapse::recode_char(
      x[[column]],
      "00-24" = "REH",
      "00-85" = "CAH",
      default = NA_character_,
      set = TRUE
    ),
    `PROPRIETARY NONPROFIT` = collapse::recode_char(
      x[[column]],
      "P" = "For-Profit",
      "N" = "Non-Profit",
      default = NA_character_,
      set = TRUE
    ),
    `PRACTICE LOCATION TYPE` = collapse::recode_char(
      x[[column]],
      "MAIN/PRIMARY HOSPITAL LOCATION" = "Primary",
      "HOSPITAL PSYCHIATRIC UNIT" = "Psych",
      "HOSPITAL REHABILITATION UNIT" = "Rehab",
      "HOSPITAL SWING-BED UNIT" = "Swing-Bed",
      "OPT EXTENSION SITE" = "Opt Ext",
      "OTHER HOSPITAL PRACTICE LOCATION" = "Other",
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

#' @noRd
rc_clia <- function(x, column, arg = caller_arg(column), call = caller_env()) {
  switch(
    column,
    CRTFCTN_ACTN_TYPE_CD = collapse::recode_char(
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
    CRTFCT_TYPE_CD = collapse::recode_char(
      x[[column]],
      "1" = "Compliance",
      "2" = "Waiver",
      "3" = "Accreditation",
      "4" = "PPM",
      "9" = "Registration",
      default = NA_character_,
      set = TRUE
    ),
    GNRL_FAC_TYPE_CD = collapse::recode_char(
      x[[column]],
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
    ),
    GNRL_CNTL_TYPE_CD = collapse::recode_char(
      x[[column]],
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
    ),
    multi = collapse::recode_char(
      x[[column]],
      "site_multi" = "Applied",
      "hosp_multi" = "Campus",
      "non_multi" = "Non-profit",
      "tmp_multi" = "Temporary",
      default = NA_character_,
      set = TRUE
    ),
    CLIA_TRMNTN_CD = collapse::recode_char(
      x[[column]],
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
    ),
    cli::cli_abort(
      "{.val {arg}} is not a column in {.var x}",
      arg = arg,
      call = call
    )
  )
}

#' @noRd
rc_owner <- function(x, column, arg = caller_arg(column), call = caller_env()) {
  switch(
    column,
    own_type = collapse::recode_char(
      x[[column]],
      "acq_ind" = "Acquisition",
      "corp_ind" = "Corp",
      "llc_ind" = "LLC",
      "mps_ind" = "Prov/Supp",
      "msr_ind" = "Mgmt",
      "mst_ind" = "Staff",
      "hld_ind" = "Holding",
      "inv_ind" = "Investment",
      "fin_ind" = "Bank",
      "con_ind" = "Consult",
      "fp_ind" = "For-Profit",
      "np_ind" = "Non-Profit",
      "pe_ind" = "PE",
      "reit_ind" = "Real Estate",
      "cho_ind" = "Chain",
      "oth_ind" = "Other",
      "ano_ind" = "Another Org/Ind",
      default = NA_character_,
      set = TRUE
    ),
    `ROLE CODE - OWNER` = collapse::recode_char(
      x[[column]],
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
    ),
    cli::cli_abort(
      "{.val {arg}} is not a column in {.var x}",
      arg = arg,
      call = call
    )
  )
}

#' @noRd
rc_quality <- function(x, column) {
  collapse::recode_char(
    x[[column]],
    "asc_ind" = "ASC-Based",
    "extreme_ind" = "Extreme Hardship",
    "engaged_ind" = "Engaged",
    "facility_ind" = "Facility-Based",
    "fac_score_ind" = "Received Facility Score",
    "hospital_ind" = "Hospital-Based",
    "hpsa_ind" = "HPSA Clinician",
    "non_patient_ind" = "Non-Patient Facing",
    "non_report_ind" = "Non-Reporting",
    "opted_ind" = "Opted Into MIPS",
    "rural_ind" = "Rural Clinician",
    "safety_ind" = "Safety Net",
    "small_ind" = "Small Practice",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
rc_order_refer <- function(x, column) {
  collapse::recode_char(
    x[[column]],
    "ptb_ind" = "Part B",
    "dme_ind" = "DME",
    "hha_ind" = "HHA",
    "pmd_ind" = "PMD",
    "hsp_ind" = "Hospice",
    default = NA_character_,
    set = TRUE
  )
}
