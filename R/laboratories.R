#' Clinical Laboratories
#'
#' @description
#' `laboratories()` allows you to search for information on clinical laboratories
#' including demographics and the type of testing services the facility provides.
#'
#' ### Clinical Laboratory Improvement Amendments (CLIA)
#' CMS regulates all laboratory testing (except research) performed on humans
#' in the U.S. through the Clinical Laboratory Improvement Amendments (CLIA).
#' In total, CLIA covers approximately 320,000 laboratory entities. The Division
#' of Clinical Laboratory Improvement & Quality, within the Quality, Safety &
#' Oversight Group, under the Center for Clinical Standards and Quality (CCSQ)
#' has the responsibility for implementing the CLIA Program. Although all
#' clinical laboratories must be properly certified to receive Medicare or
#' Medicaid payments, CLIA has no direct Medicare or Medicaid program
#' responsibilities.
#'
#' ### CLIA Certificate types
#' There are five different CLIA certificate types which all are effective for a
#' period of two years:
#'
#' Certificate of **Waiver**
#' Issued to a laboratory to perform only waived tests; does not waive the lab
#' from all CLIA requirements. Waived tests are laboratory tests that are simple
#' and easy to perform. Routine inspections are not conducted for waiver labs,
#' though 2% are visited each year to ensure quality laboratory testing.
#'
#' Certificate for **Provider-Performed Microscopy Procedures** (PPM)
#' Issued to a laboratory in which a physician, midlevel practitioner or dentist
#' performs limited tests that require microscopic examination. PPM tests are
#' considered moderate complexity. Waived tests can also be performed under this
#' certificate type. There are no routine inspections conducted for PPM labs.
#'
#' Certificate of **Registration**
#' Initially issued to a laboratory that has applied for a Certificate of
#' Compliance or a Certificate of Accreditation, enabling the lab to conduct
#' moderate/high complexity testing until the survey is performed and the
#' laboratory found to be in compliance with the CLIA regulations. Includes PPM
#' and waived testing.
#'
#' Certificate of **Compliance**
#' Allows the laboratory to conduct moderate/high complexity testing and is
#' issued after an inspection finds the lab to be in compliance with all
#' applicable CLIA requirements. Includes PPM and waived testing.
#'
#' Certificate of **Accreditation**
#' Exactly the same as the Certificate of Compliance, except that the laboratory
#' must be accredited by one of the following CMS-approved accreditation
#' organizations:
#'
#'    * American Association for Laboratory Accreditation (AALA)
#'    * American Association of Blood Banks (AABB)
#'    * American Osteopathic Association (AOA)
#'    * American Society for Histocompatibility and Immunogenetics (ASHI)
#'    * College of American Pathologists (CAP)
#'    * Commission on Office Laboratory Accreditation (COLA)
#'    * the Joint Commission (JCAHO)
#'
#' ### Links:
#'   - [Provider of Services File - Clinical Laboratories](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)
#'
#' *Update Frequency:* **Quarterly**
#'
#' @param name Provider or clinical laboratory's name
#' @param clia 10-character CLIA number
#' @param certificate CLIA certificate type:
#'    * `"waiver"`
#'    * `"compliance"`
#'    * `"accreditation"`
#'    * `"ppm"` (Provider-Performed Microscopy Procedures)
#'    * `"registration"`
#' @param city City
#' @param state State
#' @param zip Zip code
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' laboratories(clia = "11D0265516")
#' @autoglobal
#' @export
laboratories <- function(name = NULL,
                         clia = NULL,
                         certificate = NULL,
                         city = NULL,
                         state = NULL,
                         zip = NULL,
                         tidy = TRUE) {

  if (!is.null(certificate)) {
    rlang::arg_match(certificate,
    c("waiver", "compliance", "accreditation", "ppm", "registration"))
    certificate <- cert(certificate)
  }

  args <- dplyr::tribble(
    ~param,          ~arg,
    "FAC_NAME",       name,
    "PRVDR_NUM",      clia,
    "CRTFCT_TYPE_CD", certificate,
    "CITY_NAME",      city,
    "STATE_CD",       state,
    "ZIP_CD",         zip)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
         cms_update("Provider of Services File - Clinical Laboratories",
         "id")$distro[1], "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                  ~y,
      "name",              name,
      "clia",              clia,
      "certificate",       certificate,
      "city",              city,
      "state",             state,
      "zip",               zip) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            as.character(cli_args$y),
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
    return(invisible(NULL))

  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::tibble() |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::contains("_dt"), ~anytime::anydate(.)),
                    dplyr::across(dplyr::contains("_sw"), ~yn_logical(.)),
                    pgm_trmntn_cd = termcd(pgm_trmntn_cd),
                    crtfctn_actn_type_cd = toa(crtfctn_actn_type_cd),
                    cmplnc_stus_cd = status(cmplnc_stus_cd),
                    rgn_cd = region(rgn_cd),
                    gnrl_cntl_type_cd = owner(gnrl_cntl_type_cd),
                    crtfct_type_cd = app(crtfct_type_cd),
                    gnrl_fac_type_cd = factype(gnrl_fac_type_cd),
                    current_clia_lab_clsfctn_cd = labclass(current_clia_lab_clsfctn_cd),
                    prvdr_ctgry_cd = labclass(prvdr_ctgry_cd),
                    prvdr_ctgry_sbtyp_cd = labclass(prvdr_ctgry_sbtyp_cd)) |>
      dplyr::select(name = fac_name,
                    name_addl = addtnl_fac_name,
                    clia = prvdr_num,
                    certificate = crtfct_type_cd,
                    clia_medicare = clia_mdcr_num,
                    application = aplctn_type_cd,
                    effective_date = crtfct_efctv_dt,
                    expiration_date = trmntn_exprtn_dt,
                    status = cmplnc_stus_cd,
                    poc_ind = acptbl_poc_sw,
                    termination_reason = pgm_trmntn_cd,
                    termination_code = clia_trmntn_cd,
                    type_of_action = crtfctn_actn_type_cd,
                    ownership_type = gnrl_cntl_type_cd,
                    facility_type = gnrl_fac_type_cd,
                    director_affiliations = drctly_afltd_lab_cnt,
                    category = prvdr_ctgry_cd,
                    subcategory = prvdr_ctgry_sbtyp_cd,

                    orig_part_date = orgnl_prtcptn_dt,
                    application_date = aplctn_rcvd_dt,
                    certification_date = crtfctn_dt,
                    mailed_date = crtfct_mail_dt,
                    address = st_adr,
                    address2 = addtnl_st_adr,
                    city = city_name,
                    state = state_cd,
                    zip = zip_cd,
                    phone = phne_num,
                    fax = fax_phne_num,
                    region = rgn_cd,
                    state_region = state_rgn_cd,
                    fips_cnty_cd,
                    fips_state_cd,
                    cbsa_urbn_rrl_ind,
                    cbsa_cd,
                    carrier = intrmdry_carr_cd,
                    carrier_prior = intrmdry_carr_prior_cd,
                    medicaid_vendor = mdcd_vndr_num,
                    chow_count = chow_cnt,
                    chow_date = chow_dt,
                    chow_prior_date = chow_prior_dt,
                    fiscal_year_end = fy_end_mo_day_cd,
                    eligible_ind = elgblty_sw,
                    skeleton_ind = skltn_rec_sw,
                    multi_site_cert_ind = mlt_site_excptn_sw,
                    hospital_campus_ind = hosp_lab_excptn_sw,
                    public_health_ind = non_prft_excptn_sw,
                    temp_test_site_ind = lab_temp_tstg_site_sw,
                    shared_lab_ind = shr_lab_sw,
                    shared_lab_xref_number,
                    lab_site_count = lab_site_cnt,
                    ppm_test_count = ppmp_test_vol_cnt,
                    acrdtn_schdl_cd,
                    form_116_acrdtd_test_vol_cnt,
                    form_116_test_vol_cnt,
                    form_1557_crtfct_schdl_cd,
                    form_1557_cmplnc_schdl_cd,
                    form_1557_test_vol_cnt,
                    wvd_test_vol_cnt,

                    # American Association for Laboratory Accreditation
                    acr_aala = a2la_acrdtd_cd,
                    acr_aala_ind = a2la_acrdtd_y_match_sw,
                    acr_aala_date = a2la_acrdtd_y_match_dt,

                    # American Association of Blood Banks
                    acr_aabb = aabb_acrdtd_cd,
                    acr_aabb_ind = aabb_acrdtd_y_match_sw,
                    acr_aabb_date = aabb_acrdtd_y_match_dt,

                    # American Osteopathic Association
                    acr_aoa = aoa_acrdtd_cd,
                    acr_aoa_ind = aoa_acrdtd_y_match_sw,
                    acr_aoa_date = aoa_acrdtd_y_match_dt,

                    # American Society for Histocompatibility and Immunogenetics
                    acr_ashi = ashi_acrdtd_cd,
                    acr_ashi_ind = ashi_acrdtd_y_match_sw,
                    acr_ashi_date = ashi_acrdtd_y_match_dt,

                    # College of American Pathologists
                    acr_cap = cap_acrdtd_cd,
                    acr_cap_ind = cap_acrdtd_y_match_sw,
                    acr_cap_date = cap_acrdtd_y_match_dt,

                    # Commission on Office Laboratory Accreditation
                    acr_cola = cola_acrdtd_cd,
                    acr_cola_ind = cola_acrdtd_y_match_sw,
                    acr_cola_date = cola_acrdtd_y_match_dt,

                    # the Joint Commission
                    acr_jcaho = jcaho_acrdtd_cd,
                    acr_jcaho_ind = jcaho_acrdtd_y_match_sw,
                    acr_jcaho_date = jcaho_acrdtd_y_match_dt,

                    cross_ref_provider_number,
                    related_provider_number,
                    dplyr::contains("_provider_number_"),

                    clia_lab_classification_current = current_clia_lab_clsfctn_cd,
                    dplyr::starts_with("clia_lab_classification_cd_"),
                    dplyr::everything())

  }
  return(results)
}

#' @autoglobal
#' @noRd
toa <- function(x) {

  dplyr::case_match(x,
                    "1" ~ "Initial",
                    "2" ~ "Recertification",
                    "3" ~ "Termination",
                    "4" ~ "Change of Ownership",
                    "5" ~ "Validation",
                    "8" ~ "Full Survey After Complaint",
                    .default = x
  )
}

#' @autoglobal
#' @noRd
app <- function(x) {

  dplyr::case_match(x,
                    "1" ~ "Compliance",
                    "2" ~ "Waiver",
                    "3" ~ "Accreditation",
                    "4" ~ "PPM",
                    "9" ~ "Registration",
                    .default = x
  )
}

#' @autoglobal
#' @noRd
cert <- function(x) {

  dplyr::case_match(x,
                    "compliance"    ~ "1",
                    "waiver"        ~ "2",
                    "accreditation" ~ "3",
                    "ppm"           ~ "4",
                    "registration"  ~ "9",
                    .default = x
  )
}

#' @autoglobal
#' @noRd
status <- function(x) {

  dplyr::case_match(x,
                    "A" ~ "In Compliance",
                    "B" ~ "Not In Compliance",
                    .default = x
  )
}

#' @autoglobal
#' @noRd
region <- function(x) {

  dplyr::case_match(x,
                    "01" ~ "Boston",
                    "02" ~ "New York",
                    "03" ~ "Philadelphia",
                    "04" ~ "Atlanta",
                    "05" ~ "Chicago",
                    "06" ~ "Dallas",
                    "07" ~ "Kansas City",
                    "08" ~ "Denver",
                    "09" ~ "San Francisco",
                    "10" ~ "Seattle",
                    .default = x
  )
}

#' @autoglobal
#' @noRd
owner <- function(x) {

  dplyr::case_match(x,
                    "01" ~ "Religious Affiliation",
                    "02" ~ "Private",
                    "03" ~ "Other",
                    "04" ~ "Proprietary",
                    "05" ~ "Govt: City",
                    "06" ~ "Govt: County",
                    "07" ~ "Govt: State",
                    "08" ~ "Govt: Federal",
                    "09" ~ "Govt: Other",
                    "10" ~ "Unknown",
                    .default = x
  )
}

#' @autoglobal
#' @noRd
factype <- function(x) {

  dplyr::case_match(x,
                    "01" ~ "Ambulance",
                    "02" ~ "Ambulatory Surgical Center",
                    "03" ~ "Ancillary Test Site",
                    "04" ~ "Assisted Living Facility",
                    "05" ~ "Blood Banks",
                    "06" ~ "Community Clinic",
                    "07" ~ "Comprehensive Outpatient Rehab",
                    "08" ~ "End-Stage Renal Disease Dialysis",
                    "09" ~ "Federally Qualified Health Center",
                    "10" ~ "Health Fair",
                    "11" ~ "Health Maintenance Organization",
                    "12" ~ "Home Health Agency",
                    "13" ~ "Hospice",
                    "14" ~ "Hospital",
                    "15" ~ "Independent",
                    "16" ~ "Industrial",
                    "17" ~ "Insurance",
                    "18" ~ "Intermediate Care Facility/Individuals with Intellectual Disabilities",
                    "19" ~ "Mobile Lab",
                    "20" ~ "Pharmacy",
                    "21" ~ "Physician Office",
                    "22" ~ "Other Practitioner",
                    "23" ~ "Prison",
                    "24" ~ "Public Health Laboratory",
                    "25" ~ "Rural Health Clinic",
                    "26" ~ "School/Student Health Service",
                    "27" ~ "Skilled Nursing Facility",
                    "28" ~ "Tissue Bank/Repositories",
                    "29" ~ "Other",
                    .default = x
  )
}

#' @autoglobal
#' @noRd
labclass <- function(x) {

  dplyr::case_match(x,
                    c("00", "22") ~ "CLIA Lab",
                    "01" ~ "CLIA88 Lab",
                    "05" ~ "CLIA Exempt Lab",
                    "10" ~ "CLIA VA Lab",
                    .default = x
  )
}

#' @autoglobal
#' @noRd
termcd <- function(x) {

  dplyr::case_match(x,
                    "00" ~ "Active Provider",
                    "01" ~ "Voluntary: Merger, Closure",
                    "02" ~ "Voluntary: Dissatisfaction with Reimbursement",
                    "03" ~ "Voluntary: Risk of Involuntary Termination",
                    "04" ~ "Voluntary: Other Reason for Withdrawal",
                    "05" ~ "Involuntary: Failure to Meet Health-Safety Req",
                    "06" ~ "Involuntary: Failure to Meet Agreement",
                    "07" ~ "Other: Provider Status Change",
                    "08" ~ "Nonpayment of Fees (CLIA Only)",
                    "09" ~ "Rev/Unsuccessful Participation in PT (CLIA Only)",
                    "10" ~ "Rev/Other Reason (CLIA Only)",
                    "11" ~ "Incomplete CLIA Application Information (CLIA Only)",
                    "12" ~ "No Longer Performing Tests (CLIA Only)",
                    "13" ~ "Multiple to Single Site Certificate (CLIA Only)",
                    "14" ~ "Shared Laboratory (CLIA Only)",
                    "15" ~ "Failure to Renew Waiver PPM Certificate (CLIA Only)",
                    "16" ~ "Duplicate CLIA Number (CLIA Only)",
                    "17" ~ "Mail Returned No Forward Address Cert Ended (CLIA Only)",
                    "20" ~ "Notification Bankruptcy (CLIA Only)",
                    "33" ~ "Accreditation Not Confirmed (CLIA Only)",
                    "80" ~ "Awaiting State Approval",
                    "99" ~ "OIG Action Do Not Activate (CLIA Only)",
                    .default = x
  )
}
