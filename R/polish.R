#' @noRd
add_class <- function(x, endpoint) {
  structure(x, class = c(endpoint, "tbl_df", "tbl", "data.frame"))
}

#' Polish generic
#' Defines data cleaning methods for results
#' @param x data.frame
#' @returns data.frame
#' @export
#' @keywords internal
polish <- function(x) {
  UseMethod("polish")
}

#' @export
polish.default <- function(x) {
  replace_nz(x) |>
    data_frame()
}

#' @export
polish.integer <- function(x) {
  invisible(x)
}

#' @export
polish.affiliations <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      provider_first_name = "first",
      provider_last_name = "last",
      provider_middle_name = "middle",
      suff = "suffix",
      npi = "npi",
      ind_pac_id = "pac",
      facility_type = "facility_type",
      facility_affiliations_certification_number = "facility_ccn",
      facility_type_certification_number = "parent_ccn"
    )) |>
    rc_integer("npi") |>
    data_frame()
}

#' @export
polish.clinicians <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      provider_first_name = "first",
      provider_middle_name = "middle",
      provider_last_name = "last",
      suff = "suffix",
      gndr = "gender",
      cred = "cred",
      med_sch = "school",
      grd_yr = "grad_year",
      pri_spec = "specialty",
      sec_spec_all = "spec_other",
      npi = "npi",
      ind_pac_id = "pac",
      ind_enrl_id = "enid",
      facility_name = "org_name",
      org_pac_id = "org_pac",
      num_org_mem = "org_mem",
      adr_ln_1 = "add_1",
      adr_ln_2 = "add_2",
      citytown = "org_city",
      state = "org_state",
      zip_code = "org_zip",
      telephone_number = "org_phone"
    )) |>
    RC_clinicians() |>
    data_frame()
}

#' @export
polish.esrd <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      cms_certification_number_ccn = "ccn",
      facility_name = "facility_name",
      five_star = "stars",
      network = "network",
      profit_or_nonprofit = "status",
      chain_organization = "chain_name",
      certification_date = "cert_date",
      address_line_1 = "add_1",
      address_line_2 = "add_2",
      citytown = "city",
      state = "state",
      zip_code = "zip",
      countyparish = "county",
      telephone_number = "phone"
    )) |>
    RC_esrd() |>
    data_frame()
}

#' @export
polish.hospitals2 <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      facility_id = "ccn",
      facility_name = "org_name",
      hospital_type = "hosp_type",
      hospital_ownership = "ownership",
      hospital_overall_rating = "rating",
      address = "address",
      citytown = "city",
      state = "state",
      zip_code = "zip",
      countyparish = "county",
      telephone_number = "phone"
    )) |>
    rc_integer_supp("rating") |>
    data_frame()
}

#' @export
polish.hospitals <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      `ORGANIZATION NAME` = "org_name",
      `DOING BUSINESS AS NAME` = "org_dba",
      `ENROLLMENT ID` = "enid",
      `ENROLLMENT STATE` = "enid_state",
      `PROVIDER TYPE CODE` = "prov_type",
      `PROVIDER TYPE TEXT` = "prov_desc",
      NPI = "npi",
      `MULTIPLE NPI FLAG` = "multi",
      CCN = "ccn",
      `ASSOCIATE ID` = "pac",
      `INCORPORATION DATE` = "inc_date",
      `INCORPORATION STATE` = "inc_state",
      `ORGANIZATION TYPE STRUCTURE` = "org_type",
      `ORGANIZATION OTHER TYPE TEXT` = "org_otxt",
      `PROPRIETARY NONPROFIT` = "status",
      `ADDRESS LINE 1` = "add_1",
      `ADDRESS LINE 2` = "add_2",
      CITY = "city",
      STATE = "state",
      `ZIP CODE` = "zip",
      `PRACTICE LOCATION TYPE` = "loc_type",
      `LOCATION OTHER TYPE TEXT` = "loc_otxt",
      `REH CONVERSION DATE` = "reh_date",
      `CAH OR HOSPITAL CCN` = "reh_ccn",
      `SUBGROUP - ACUTE CARE` = "sub_acute",
      `SUBGROUP - GENERAL` = "sub_gen",
      `SUBGROUP - SPECIALTY HOSPITAL` = "sub_spec",
      `SUBGROUP - ALCOHOL DRUG` = "sub_adu",
      `SUBGROUP - CHILDRENS` = "sub_child",
      `SUBGROUP - LONG-TERM` = "sub_ltc",
      `SUBGROUP - PSYCHIATRIC` = "sub_psy",
      `SUBGROUP - REHABILITATION` = "sub_irf",
      `SUBGROUP - SHORT-TERM` = "sub_stc",
      `SUBGROUP - SWING-BED APPROVED` = "sub_sba",
      `SUBGROUP - PSYCHIATRIC UNIT` = "sub_psu",
      `SUBGROUP - REHABILITATION UNIT` = "sub_iru",
      `SUBGROUP - OTHER` = "sub_oth",
      `SUBGROUP - OTHER TEXT` = "sub_otxt"
    )) |>
    RC_hospitals() |>
    data_frame()
}

#' @export
polish.pending <- function(x) {
  rowbind2(x, "prov_type", fill = TRUE) |>
    replace_nz() |>
    rename_with(c(
      FIRST_NAME = "first",
      LAST_NAME = "last",
      NPI = "npi"
    )) |>
    rc_integer("npi") |>
    data_frame()
}

#' @export
polish.providers <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      ORG_NAME = "org_name",
      FIRST_NAME = "first",
      MDL_NAME = "middle",
      LAST_NAME = "last",
      STATE_CD = "state",
      PROVIDER_TYPE_CD = "prov_type",
      PROVIDER_TYPE_DESC = "prov_desc",
      NPI = "npi",
      MULTIPLE_NPI_FLAG = "multi",
      PECOS_ASCT_CNTL_ID = "pac",
      ENRLMT_ID = "enid"
    )) |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    data_frame()
}

#' @export
polish.clia <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      FAC_NAME = "fac_name_1",
      ADDTNL_FAC_NAME = "fac_name_2",
      PRVDR_NUM = "facility_ccn",
      CLIA_MDCR_NUM = "parent_ccn",
      CROSS_REF_PROVIDER_NUMBER = "xref_ccn",
      SHARED_LAB_XREF_NUMBER = "shared_ccn",
      INTRMDRY_CARR_CD = "mac",
      CHOW_CNT = "chown",
      CHOW_DT = "chow_date",
      ACPTBL_POC_SW = "poc_ind",
      CMPLNC_STUS_CD = "compliant",
      ST_ADR = "add_1",
      ADDTNL_ST_ADR = "add_2",
      PHNE_NUM = "phone_1",
      FAX_PHNE_NUM = "phone_2",
      CITY_NAME = "city",
      STATE_CD = "state",
      ZIP_CD = "zip",
      # RGN_CD = "reg_cd",
      # STATE_RGN_CD = "reg_st",
      # SSA_STATE_CD = "ssa_st",
      # SSA_CNTY_CD = "ssa_cty",
      # FIPS_STATE_CD = "fips_st",
      # FIPS_CNTY_CD = "fips_cty",
      # CBSA_CD = "cbsa_1",
      # CBSA_URBN_RRL_IND = "cbsa_2",
      ELGBLTY_SW = "elig_ind",
      PGM_TRMNTN_CD = "term_pgm",
      CLIA_TRMNTN_CD = "term_clia",
      APLCTN_TYPE_CD = "app_type",
      CRTFCT_TYPE_CD = "cert_type",
      GNRL_FAC_TYPE_CD = "fac_type",
      GNRL_CNTL_TYPE_CD = "own_type",
      CRTFCTN_ACTN_TYPE_CD = "act_type",
      ORGNL_PRTCPTN_DT = "orig_date",
      # APLCTN_RCVD_DT = "app_date",
      CRTFCTN_DT = "cert_date",
      CRTFCT_EFCTV_DT = "eff_date",
      # CRTFCT_MAIL_DT = "mail_date",
      TRMNTN_EXPRTN_DT = "term_date",
      # A2LA_ACRDTD_CD = "a2la_cred", # X=ACCREDITED
      A2LA_ACRDTD_Y_MATCH_DT = "a2la_date",
      A2LA_ACRDTD_Y_MATCH_SW = "a2la_ind",
      # AABB_ACRDTD_CD = "aabb_cred",
      AABB_ACRDTD_Y_MATCH_DT = "aabb_date",
      AABB_ACRDTD_Y_MATCH_SW = "aabb_ind",
      # AOA_ACRDTD_CD = "aoa_cred",
      AOA_ACRDTD_Y_MATCH_DT = "aoa_date",
      AOA_ACRDTD_Y_MATCH_SW = "aoa_ind",
      # ASHI_ACRDTD_CD = "ashi_cred",
      ASHI_ACRDTD_Y_MATCH_DT = "ashi_date",
      ASHI_ACRDTD_Y_MATCH_SW = "ashi_ind",
      # CAP_ACRDTD_CD = "cap_cred",
      CAP_ACRDTD_Y_MATCH_DT = "cap_date",
      CAP_ACRDTD_Y_MATCH_SW = "cap_ind",
      # COLA_ACRDTD_CD = "cola_cred",
      COLA_ACRDTD_Y_MATCH_DT = "cola_date",
      COLA_ACRDTD_Y_MATCH_SW = "cola_ind",
      # JCAHO_ACRDTD_CD = "jcaho_cred",
      JCAHO_ACRDTD_Y_MATCH_DT = "jcaho_date",
      JCAHO_ACRDTD_Y_MATCH_SW = "jcaho_ind",
      ACRDTN_SCHDL_CD = "acr_sch",
      FORM_1557_CRTFCT_SCHDL_CD = "crt_sch",
      FORM_1557_CMPLNC_SCHDL_CD = "cmp_sch",
      FORM_1557_TEST_VOL_CNT = "srv_vol",
      FORM_116_ACRDTD_TEST_VOL_CNT = "acr_vol",
      FORM_116_TEST_VOL_CNT = "cmp_vol",
      PPMP_TEST_VOL_CNT = "ppm_vol",
      WVD_TEST_VOL_CNT = "wvd_vol",
      MLT_SITE_EXCPTN_SW = "multi_ind",
      HOSP_LAB_EXCPTN_SW = "hosp_ind",
      NON_PRFT_EXCPTN_SW = "non_ind",
      LAB_TEMP_TSTG_SITE_SW = "tmp_ind",
      DRCTLY_AFLTD_LAB_CNT = "alabs",
      LAB_SITE_CNT = "sites"
    )) |>
    RC_clia() |>
    data_frame()
}

#' @export
polish.fqhc_enroll <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      `ENROLLMENT ID` = "enid",
      `ENROLLMENT STATE` = "enid_state",
      `PROVIDER TYPE CODE` = "prov_type",
      `PROVIDER TYPE TEXT` = "prov_desc",
      NPI = "npi",
      `MULTIPLE NPI FLAG` = "multi",
      CCN = "ccn",
      `ASSOCIATE ID` = "pac",
      `ORGANIZATION NAME` = "org_name",
      `DOING BUSINESS AS NAME` = "org_dba",
      `INCORPORATION DATE` = "inc_date",
      `INCORPORATION STATE` = "inc_state",
      `ORGANIZATION TYPE STRUCTURE` = "org_type",
      `ORGANIZATION OTHER TYPE TEXT` = "org_otxt",
      PROPRIETARY_NONPROFIT = "status",
      `ADDRESS LINE 1` = "add_1",
      `ADDRESS LINE 2` = "add_2",
      CITY = "city",
      STATE = "state",
      `ZIP CODE` = "zip",
      `TELEPHONE NUMBER` = "phone"
    )) |>
    RC_fqhc_enroll() |>
    data_frame()
}

#' @export
polish.fqhc_owner <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      `ENROLLMENT ID` = "enid",
      `ASSOCIATE ID` = "pac",
      `ORGANIZATION NAME` = "org_name",
      `ASSOCIATE ID - OWNER` = "own_pac",
      `TYPE - OWNER` = "own_type",
      `ROLE CODE - OWNER` = "own_code",
      `ROLE TEXT - OWNER` = "own_role",
      `ASSOCIATION DATE - OWNER` = "own_date",
      `FIRST NAME - OWNER` = "own_first",
      `MIDDLE NAME - OWNER` = "own_middle",
      `LAST NAME - OWNER` = "own_last",
      `TITLE - OWNER` = "own_title",
      `ORGANIZATION NAME - OWNER` = "own_org",
      `DOING BUSINESS AS NAME - OWNER` = "own_dba",
      `ADDRESS LINE 1 - OWNER` = "own_add_1",
      `ADDRESS LINE 2 - OWNER` = "own_add_2",
      `CITY - OWNER` = "own_city",
      `STATE - OWNER` = "own_state",
      `ZIP CODE - OWNER` = "own_zip",
      `PERCENTAGE OWNERSHIP` = "own_pct",
      `CREATED FOR ACQUISITION - OWNER` = "acq_ind",
      `CORPORATION - OWNER` = "corp_ind",
      `LLC - OWNER` = "llc_ind",
      `MEDICAL PROVIDER SUPPLIER - OWNER` = "mps_ind",
      `MANAGEMENT SERVICES COMPANY - OWNER` = "msr_ind",
      `MEDICAL STAFFING COMPANY - OWNER` = "mst_ind",
      `HOLDING COMPANY - OWNER` = "hld_ind",
      `INVESTMENT FIRM - OWNER` = "inv_ind",
      `FINANCIAL INSTITUTION - OWNER` = "fin_ind",
      `CONSULTING FIRM - OWNER` = "con_ind",
      `FOR PROFIT - OWNER` = "fp_ind",
      `NON PROFIT - OWNER` = "np_ind",
      `PRIVATE EQUITY COMPANY - OWNER` = "pe_ind",
      `REIT - OWNER` = "reit_ind",
      `CHAIN HOME OFFICE - OWNER` = "cho_ind",
      `OTHER TYPE - OWNER` = "oth_ind",
      `OTHER TYPE TEXT - OWNER` = "oth_txt",
      `OWNED BY ANOTHER ORG OR IND - OWNER` = "ano_ind"
    )) |>
    RC_fqhc_owner() |>
    data_frame()
}

#' @export
polish.rhc_enroll <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      `ENROLLMENT ID` = "enid",
      `ENROLLMENT STATE` = "enid_state",
      NPI = "npi",
      `MULTIPLE NPI FLAG` = "multi",
      CCN = "ccn",
      `ASSOCIATE ID` = "pac",
      `ORGANIZATION NAME` = "org_name",
      `DOING BUSINESS AS NAME` = "org_dba",
      `INCORPORATION DATE` = "inc_date",
      `INCORPORATION STATE` = "inc_state",
      `ORGANIZATION TYPE STRUCTURE` = "org_type",
      `ORGANIZATION OTHER TYPE TEXT` = "org_otxt",
      PROPRIETARY_NONPROFIT = "status",
      `ADDRESS LINE 1` = "add_1",
      `ADDRESS LINE 2` = "add_2",
      CITY = "city",
      STATE = "state",
      `ZIP CODE` = "zip",
      `TELEPHONE NUMBER` = "phone"
    )) |>
    RC_rhc_enroll() |>
    data_frame()
}

#' @export
polish.rhc_owner <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      `ENROLLMENT ID` = "enid",
      `ASSOCIATE ID` = "pac",
      `ORGANIZATION NAME` = "org_name",
      `ASSOCIATE ID - OWNER` = "own_pac",
      `TYPE - OWNER` = "own_type",
      `ROLE CODE - OWNER` = "own_code",
      `ROLE TEXT - OWNER` = "own_role",
      `ASSOCIATION DATE - OWNER` = "own_date",
      `FIRST NAME - OWNER` = "own_first",
      `MIDDLE NAME - OWNER` = "own_middle",
      `LAST NAME - OWNER` = "own_last",
      `TITLE - OWNER` = "own_title",
      `ORGANIZATION NAME - OWNER` = "own_org",
      `DOING BUSINESS AS NAME - OWNER` = "own_dba",
      `ADDRESS LINE 1 - OWNER` = "own_add_1",
      `ADDRESS LINE 2 - OWNER` = "own_add_2",
      `CITY - OWNER` = "own_city",
      `STATE - OWNER` = "own_state",
      `ZIP CODE - OWNER` = "own_zip",
      `PERCENTAGE OWNERSHIP` = "own_pct",
      `CREATED FOR ACQUISITION - OWNER` = "acq_ind",
      `CORPORATION - OWNER` = "corp_ind",
      `LLC - OWNER` = "llc_ind",
      `MEDICAL PROVIDER SUPPLIER - OWNER` = "mps_ind",
      `MANAGEMENT SERVICES COMPANY - OWNER` = "msr_ind",
      `MEDICAL STAFFING COMPANY - OWNER` = "mst_ind",
      `HOLDING COMPANY - OWNER` = "hld_ind",
      `INVESTMENT FIRM - OWNER` = "inv_ind",
      `FINANCIAL INSTITUTION - OWNER` = "fin_ind",
      `CONSULTING FIRM - OWNER` = "con_ind",
      `FOR PROFIT - OWNER` = "fp_ind",
      `NON PROFIT - OWNER` = "np_ind",
      `PRIVATE EQUITY COMPANY - OWNER` = "pe_ind",
      `REIT - OWNER` = "reit_ind",
      `CHAIN HOME OFFICE - OWNER` = "cho_ind",
      `OTHER TYPE - OWNER` = "oth_ind",
      `OTHER TYPE TEXT - OWNER` = "oth_txt",
      `OWNED BY ANOTHER ORG OR IND - OWNER` = "ano_ind"
    )) |>
    RC_rhc_owner() |>
    data_frame()
}

#' @export
polish.transparency <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      Case_ID = "case",
      Hosp_Name = "name",
      Hosp_Address = "address",
      City = "city",
      State = "state",
      Action = "action",
      Date_of_Action = "action_date"
    )) |>
    rc_integer("case") |>
    rc_date_ymd("action_date") |>
    data_frame()
}

#' @export
polish.order_refer <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      FIRST_NAME = "first",
      LAST_NAME = "last",
      NPI = "npi",
      PARTB = "ptb",
      DME = "dme",
      HHA = "hha",
      PMD = "pmd",
      HOSPICE = "hospice"
    )) |>
    rc_integer("npi") |>
    rc_bin(c("ptb", "dme", "hha", "pmd", "hospice")) |>
    data_frame()
}

#' @export
polish.opt_out <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      NPI = "npi",
      `First Name` = "first",
      `Last Name` = "last",
      Specialty = "specialty",
      `Optout Effective Date` = "start_date",
      `Optout End Date` = "end_date",
      `Last updated` = "updated",
      `First Line Street Address` = "add_1",
      `Second Line Street Address` = "add_2",
      `City Name` = "city",
      `State Code` = "state",
      `Zip code` = "zip",
      `Eligible to Order and Refer` = "order_refer"
    )) |>
    RC_opt_out() |>
    data_frame()
}

#' @export
polish.reassignments <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      `Individual First Name` = "first",
      `Individual Last Name` = "last",
      `Individual State Code` = "state",
      `Individual Specialty Description` = "specialty",
      `Individual Total Employer Associations` = "employers",
      `Individual NPI` = "npi",
      `Individual PAC ID` = "pac",
      `Individual Enrollment ID` = "enid",
      `Group Legal Business Name` = "org_name",
      `Group Reassignments and Physician Assistants` = "employees",
      `Group PAC ID` = "org_pac",
      `Group Enrollment ID` = "org_enid",
      `Group State Code` = "org_state",
      `Record Type` = "rec_type"
    )) |>
    rc_integer(c("npi", "employers", "employees")) |>
    data_frame()
}

#' @export
polish.revocations <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      ORG_NAME = "org_name",
      FIRST_NAME = "first",
      MDL_NAME = "middle",
      LAST_NAME = "last",
      ENRLMT_ID = "enid",
      NPI = "npi",
      MULTIPLE_NPI_FLAG = "multi",
      STATE_CD = "state",
      PROVIDER_TYPE_DESC = "prov_desc",
      REVOCATION_RSN = "reason",
      REVOCATION_EFCTV_DT = "start_date",
      REENROLLMENT_BAR_EXPRTN_DT = "end_date"
    )) |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_date_ymd(c("start_date", "end_date")) |>
    data_frame()
}
