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
polish.affiliations <- function(x) {
  rename_with(
    x,
    c(
      provider_first_name = "first",
      provider_last_name = "last",
      provider_middle_name = "middle",
      suff = "suffix",
      npi = "npi",
      ind_pac_id = "pac",
      facility_type = "facility_type",
      facility_affiliations_certification_number = "facility_ccn",
      facility_type_certification_number = "parent_ccn"
    )
  ) |>
    replace_nz() |>
    rc_integer("npi") |>
    data_frame()
}

#' @export
polish.clia <- function(x) {
  x <- rename_with(
    x,
    c(
      FAC_NAME = "fac_1",
      ADDTNL_FAC_NAME = "fac_2",
      PRVDR_NUM = "fac_ccn",
      CLIA_MDCR_NUM = "clia_ccn",
      CROSS_REF_PROVIDER_NUMBER = "xrf_ccn",
      SHARED_LAB_XREF_NUMBER = "shr_ccn",
      INTRMDRY_CARR_CD = "mac",
      CHOW_CNT = "chow_cnt",
      CHOW_DT = "chow_date",
      ACPTBL_POC_SW = "poc_ind",
      CMPLNC_STUS_CD = "compliant",
      ST_ADR = "add_1",
      ADDTNL_ST_ADR = "add_2",
      CITY_NAME = "city",
      STATE_CD = "state",
      ZIP_CD = "zip",
      ELGBLTY_SW = "elig_ind",
      PGM_TRMNTN_CD = "pgm_term",
      CLIA_TRMNTN_CD = "clia_term",
      APLCTN_TYPE_CD = "app_type",
      CRTFCT_TYPE_CD = "cert_type",
      GNRL_FAC_TYPE_CD = "fac_type",
      GNRL_CNTL_TYPE_CD = "own_type",
      CRTFCTN_ACTN_TYPE_CD = "act_type",
      ORGNL_PRTCPTN_DT = "orig_date",
      CRTFCTN_DT = "cert_date",
      CRTFCT_EFCTV_DT = "eff_date",
      TRMNTN_EXPRTN_DT = "term_date",
      A2LA_ACRDTD_CD = "a2la_cred", # X=ACCREDITED
      A2LA_ACRDTD_Y_MATCH_DT = "a2la_date",
      A2LA_ACRDTD_Y_MATCH_SW = "a2la_ind",
      AABB_ACRDTD_CD = "aabb_cred",
      AABB_ACRDTD_Y_MATCH_DT = "aabb_date",
      AABB_ACRDTD_Y_MATCH_SW = "aabb_ind",
      AOA_ACRDTD_CD = "aoa_cred",
      AOA_ACRDTD_Y_MATCH_DT = "aoa_date",
      AOA_ACRDTD_Y_MATCH_SW = "aoa_ind",
      ASHI_ACRDTD_CD = "ashi_cred",
      ASHI_ACRDTD_Y_MATCH_DT = "ashi_date",
      ASHI_ACRDTD_Y_MATCH_SW = "ashi_ind",
      CAP_ACRDTD_CD = "cap_cred",
      CAP_ACRDTD_Y_MATCH_DT = "cap_date",
      CAP_ACRDTD_Y_MATCH_SW = "cap_ind",
      COLA_ACRDTD_CD = "cola_cred",
      COLA_ACRDTD_Y_MATCH_DT = "cola_date",
      COLA_ACRDTD_Y_MATCH_SW = "cola_ind",
      JCAHO_ACRDTD_CD = "jcaho_cred",
      JCAHO_ACRDTD_Y_MATCH_DT = "jcaho_date",
      JCAHO_ACRDTD_Y_MATCH_SW = "jcaho_ind",
      ACRDTN_SCHDL_CD = "acr_sch",
      FORM_1557_CRTFCT_SCHDL_CD = "crt_sch",
      FORM_1557_CMPLNC_SCHDL_CD = "cmp_sch",
      FORM_1557_TEST_VOL_CNT = "srv_cnt",
      FORM_116_ACRDTD_TEST_VOL_CNT = "acr_cnt",
      FORM_116_TEST_VOL_CNT = "cmp_cnt",
      PPMP_TEST_VOL_CNT = "ppm_cnt",
      WVD_TEST_VOL_CNT = "wvd_cnt",
      MLT_SITE_EXCPTN_SW = "multi_ind",
      HOSP_LAB_EXCPTN_SW = "hosp_ind",
      NON_PRFT_EXCPTN_SW = "non_ind",
      LAB_TEMP_TSTG_SITE_SW = "tmp_ind",
      DRCTLY_AFLTD_LAB_CNT = "alab_cnt",
      LAB_SITE_CNT = "site_cnt"
    )
  )
  x <- replace_nz(x) |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_date_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_integer(collapse::gvr(x, "_cnt$", return = 2L)) |>
    data_frame()

  x <- collapse::av(
    x,
    fac_name = combine_cols(x$fac_1, x$fac_2),
    address = combine_cols(x$add_1, x$add_2),
    cert_type = clia_cert_type(x$cert_type),
    own_type = clia_own_type(x$own_type),
    fac_type = clia_fac_type(x$fac_type),
    act_type = clia_act_type(x$act_type)
  )

  collapse::gvr(x, "fac_[12]$|add_[12]$") <- NULL
  collapse::colorderv(
    x,
    c(
      "^fac_name$",
      "_ccn$",
      "_type$",
      "_ind$",
      "_cred$",
      "_date$",
      "_cnt$",
      "_sch$"
    ),
    regex = TRUE
  )
}

#' @export
polish.clinicians <- function(x) {
  rename_with(
    x,
    c(
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
      citytown = "city",
      state = "state",
      zip_code = "zip"
    )
  ) |>
    replace_nz() |>
    RC_clinicians() |>
    data_frame()
}

#' @export
polish.default <- function(x) {
  replace_nz(x) |>
    data_frame()
}

#' @export
polish.esrd <- function(x) {
  rename_with(
    x,
    c(
      cms_certification_number_ccn = "ccn",
      facility_name = "facility_name",
      five_star = "rating",
      network = "network",
      profit_or_nonprofit = "status",
      chain_organization = "chain_name",
      certification_date = "cert_date",
      address_line_1 = "add_1",
      address_line_2 = "add_2",
      citytown = "city",
      state = "state",
      zip_code = "zip",
      countyparish = "county"
    )
  ) |>
    replace_nz() |>
    RC_esrd() |>
    data_frame()
}

#' @export
polish.fqhc_enroll <- function(x) {
  rename_with(
    x,
    c(
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
      `ZIP CODE` = "zip"
    )
  ) |>
    replace_nz() |>
    RC_fqhc_enroll() |>
    data_frame()
}

#' @export
polish.fqhc_owner <- function(x) {
  rename_with(
    x,
    c(
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
    )
  ) |>
    replace_nz() |>
    RC_fqhc_owner() |>
    data_frame()
}

#' @export
polish.hospice_enroll <- function(x) {
  rename_with(
    x,
    c(
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
      `ZIP CODE` = "zip"
    )
  ) |>
    replace_nz() |>
    RC_rhc_enroll() |>
    data_frame()
}

#' @export
polish.hospice_owner <- function(x) {
  rename_with(
    x,
    c(
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
    )
  ) |>
    replace_nz() |>
    RC_rhc_owner() |>
    data_frame()
}

#' @export
polish.hospital_owner <- function(x) {
  rename_with(
    x,
    c(
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
      `OTHER TYPE - OWNER` = "oth_ind",
      `OTHER TYPE TEXT - OWNER` = "oth_txt"
    )
  ) |>
    replace_nz() |>
    RC_rhc_owner() |>
    data_frame()
}

#' @export
polish.hospitals <- function(x) {
  rename_with(
    x,
    c(
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
    )
  ) |>
    replace_nz() |>
    RC_hospitals() |>
    data_frame()
}

#' @export
polish.hospitals2 <- function(x) {
  rename_with(
    x,
    c(
      facility_id = "ccn",
      facility_name = "org_name",
      hospital_type = "hosp_type",
      hospital_ownership = "ownership",
      hospital_overall_rating = "rating",
      address = "address",
      citytown = "city",
      state = "state",
      zip_code = "zip",
      countyparish = "county"
    )
  ) |>
    replace_nz() |>
    rc_integer_supp("rating") |>
    data_frame()
}

#' @export
polish.integer <- function(x) {
  invisible(x)
}

#' @export
polish.opt_out <- function(x) {
  rename_with(
    x,
    c(
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
    )
  ) |>
    replace_nz() |>
    RC_opt_out() |>
    data_frame()
}

#' @export
polish.order_refer <- function(x) {
  rename_with(
    x,
    c(
      FIRST_NAME = "first",
      LAST_NAME = "last",
      NPI = "npi",
      PARTB = "ptb",
      DME = "dme",
      HHA = "hha",
      PMD = "pmd",
      HOSPICE = "hospice"
    )
  ) |>
    replace_nz() |>
    rc_integer("npi") |>
    rc_bin(c("ptb", "dme", "hha", "pmd", "hospice")) |>
    data_frame()
}

#' @export
polish.pending <- function(x) {
  replace_nz(x) |>
    rename_with(c(
      prov_type = "prov_type",
      FIRST_NAME = "first",
      LAST_NAME = "last",
      NPI = "npi"
    )) |>
    rc_integer("npi") |>
    data_frame()
}

#' @export
polish.providers <- function(x) {
  rename_with(
    x,
    c(
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
    )
  ) |>
    replace_nz() |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    data_frame()
}

#' @export
polish.reassignments <- function(x) {
  rename_with(
    x,
    c(
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
    )
  ) |>
    replace_nz() |>
    rc_integer(c("npi", "employers", "employees")) |>
    data_frame()
}

#' @export
polish.rhc_enroll <- function(x) {
  rename_with(
    x,
    c(
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
      `ZIP CODE` = "zip"
    )
  ) |>
    replace_nz() |>
    RC_rhc_enroll() |>
    data_frame()
}

#' @export
polish.rhc_owner <- function(x) {
  rename_with(
    x,
    c(
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
    )
  ) |>
    replace_nz() |>
    RC_rhc_owner() |>
    data_frame()
}

#' @export
polish.revocations <- function(x) {
  rename_with(
    x,
    c(
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
    )
  ) |>
    replace_nz() |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_date_ymd(c("start_date", "end_date")) |>
    data_frame()
}

#' @export
polish.snf_enroll <- function(x) {
  rename_with(
    x,
    c(
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
      `NURSING HOME PROVIDER NAME` = "nh_name",
      `AFFILIATION ENTITY NAME` = "aff_name",
      `ADDRESS LINE 1` = "add_1",
      `ADDRESS LINE 2` = "add_2",
      CITY = "city",
      STATE = "state",
      `ZIP CODE` = "zip"
    )
  ) |>
    replace_nz() |>
    RC_rhc_enroll() |>
    data_frame()
}

#' @export
polish.snf_owner <- function(x) {
  rename_with(
    x,
    c(
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
      `OTHER TYPE - OWNER` = "oth_ind",
      `OTHER TYPE TEXT - OWNER` = "oth_txt"
    )
  ) |>
    replace_nz() |>
    RC_rhc_owner() |>
    data_frame()
}

#' @export
polish.transparency <- function(x) {
  rename_with(
    x,
    c(
      Case_ID = "case",
      Hosp_Name = "name",
      Hosp_Address = "address",
      City = "city",
      State = "state",
      Action = "action",
      Date_of_Action = "action_date"
    )
  ) |>
    replace_nz() |>
    rc_integer("case") |>
    rc_date_ymd("action_date") |>
    data_frame()
}
