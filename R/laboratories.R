#' Clinical Laboratories
#'
#' @description
#' Access information on clinical laboratories including demographics and
#' the type of testing services the facility provides.
#'
#' @section Clinical Laboratory Improvement Amendments (CLIA):
#'
#' CMS regulates all laboratory testing (except research) performed on humans
#' in the U.S. through the Clinical Laboratory Improvement Amendments (CLIA).
#' In total, CLIA covers approximately 320,000 laboratory entities.
#'
#' The Division of Clinical Laboratory Improvement & Quality, within the Quality,
#' Safety & Oversight Group, under the Center for Clinical Standards and Quality
#' (CCSQ) has the responsibility for implementing the CLIA Program.
#'
#' Although all clinical laboratories must be properly certified to receive
#' Medicare or Medicaid payments, CLIA has no direct Medicare or Medicaid
#' program responsibilities.
#'
#' @section CLIA Certificates:
#'
#' There are five CLIA certificate types all of which are effective for a
#' period of two years. They are as follows, in order of increasing complexity:
#'
#' 1. Certificate of **Waiver**: Issued to a laboratory to perform only waived
#' tests; does not waive the lab from all CLIA requirements. Waived tests are
#' laboratory tests that are simple to perform. Routine inspections are not
#' conducted for waiver labs, although 2% are visited each year to ensure
#' quality laboratory testing.
#'
#' 2. Certificate for **Provider-Performed Microscopy Procedures** (PPM): Issued
#' to a laboratory in which a physician, midlevel practitioner or dentist
#' performs limited tests that require microscopic examination. PPM tests are
#' considered moderate complexity. Waived tests can also be performed under this
#' certificate type. There are no routine inspections conducted for PPM labs.
#'
#' 3. Certificate of **Registration**: Initially issued to a laboratory that has
#' applied for a Certificate of Compliance or Accreditation, enabling the lab to
#' conduct moderate/high complexity testing until the survey is performed and
#' the laboratory is found to be in CLIA compliance. Includes PPM and waived
#' testing.
#'
#' 4. Certificate of **Compliance**: Allows the laboratory to conduct
#' moderate/high complexity testing and is issued after an inspection finds the
#' lab to be in compliance with all applicable CLIA requirements. Includes PPM
#' and waived testing.
#'
#' 5. Certificate of **Accreditation**: Exactly the same as the Certificate of
#' Compliance, except that the laboratory must be accredited by one of the
#' following CMS-approved accreditation organizations:
#'
#' + [American Association for Laboratory Accreditation](https://a2la.org/) (A2LA)
#' + [Association for the Advancement of Blood & Biotherapies](https://www.aabb.org/) (AABB)
#' + [American Osteopathic Association](https://osteopathic.org/) (AOA)
#' + [American Society for Histocompatibility and Immunogenetics](https://www.ashi-hla.org/) (ASHI)
#' + [College of American Pathologists](https://www.cap.org/) (CAP)
#' + [Commission on Office Laboratory Accreditation](https://www.cola.org/) (COLA)
#' + [The Joint Commission](https://www.jointcommission.org/) (JCAHO)
#'
#' Links:
#'   - [Provider of Services File - Clinical Laboratories](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)
#'
#' *Update Frequency:* **Quarterly**
#'
#' @param name < *character* > Provider or clinical laboratory's name
#' @param clia < *character* > 10-character CLIA number
#' @param certificate < *character* > CLIA certificate type:
#' + `"waiver"`
#' + `"ppm"`
#' + `"registration"`
#' + `"compliance"`
#' + `"accreditation"`
#' @param city < *character* > City
#' @param state < *character* > State
#' @param zip < *character* > Zip code
#' @param active < *boolean* > // __default:__ `FALSE` Return only active providers
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#' @param pivot < *boolean* > // __default:__ `TRUE` Pivot output
#' @param ... Empty
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' laboratories(clia = "11D0265516")
#' laboratories(certificate = "ppm", city = "Valdosta", state = "GA", active = TRUE)
#' @autoglobal
#' @export
laboratories <- function(name        = NULL,
                         clia        = NULL,
                         certificate = NULL,
                         city        = NULL,
                         state       = NULL,
                         zip         = NULL,
                         active      = FALSE,
                         tidy        = TRUE,
                         na.rm       = TRUE,
                         pivot       = TRUE,
                         ...) {

  if (!is.null(certificate)) {
    rlang::arg_match(certificate,
    c("waiver", "compliance", "accreditation", "ppm", "registration"))
    certificate <- cert(certificate)
  }

  zip <- zip %nn% as.character(zip)

  if (isTRUE(active)) {
    active <- "00"
    } else {
      active <- NULL
      }

  args <- dplyr::tribble(
    ~param,          ~arg,
    "FAC_NAME",       name,
    "PRVDR_NUM",      clia,
    "CRTFCT_TYPE_CD", certificate,
    "CITY_NAME",      city,
    "STATE_CD",       state,
    "ZIP_CD",         zip,
    "PGM_TRMNTN_CD",  active)

  response <- httr2::request(build_url("lab", args)) |>
    httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    if (active == "00") {active <- TRUE}

    cli_args <- dplyr::tribble(
      ~x,                  ~y,
      "name",              name,
      "clia",              clia,
      "certificate",       certificate,
      "city",              city,
      "state",             state,
      "zip",               zip,
      "active",            active) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results,
                      dtype = 'ymd',
                      dt    = '_dt',
                      yn    = '_sw',
                      int   = 'drctly_afltd',
                      zip   = 'zip_cd') |>
      combine(address, c('st_adr', 'addtnl_st_adr')) |>
      combine(provider_name, c('fac_name', 'addtnl_fac_name')) |>
      dplyr::mutate(pgm_trmntn_cd               = fct_term(pgm_trmntn_cd),
                    crtfctn_actn_type_cd        = fct_toa(crtfctn_actn_type_cd),
                    cmplnc_stus_cd              = fct_stat(cmplnc_stus_cd),
                    rgn_cd                      = fct_region(rgn_cd),
                    gnrl_cntl_type_cd           = fct_owner(gnrl_cntl_type_cd),
                    crtfct_type_cd              = fct_app(crtfct_type_cd),
                    gnrl_fac_type_cd            = fct_facility(gnrl_fac_type_cd),
                    current_clia_lab_clsfctn_cd = fct_lab(current_clia_lab_clsfctn_cd),
                    prvdr_ctgry_cd              = fct_lab(prvdr_ctgry_cd),
                    prvdr_ctgry_sbtyp_cd        = fct_lab(prvdr_ctgry_sbtyp_cd),
                    state_cd                    = fct_stabb(state_cd),
                    duration                    = duration_vec(trmntn_exprtn_dt),
                    expired                     = dplyr::if_else(duration < 0, TRUE, FALSE),
                    duration                    = NULL) |>
      cols_lab()

    if (pivot) {
      res <- dplyr::select(results, -dplyr::starts_with("acr_"))

      acr <- dplyr::select(results,
                           clia_number,
                           dplyr::starts_with("acr_")) |>
        dplyr::select(clia_number,
                      a2la       = acr_a2la,
                      a2la_ind   = acr_a2la_ind,
                      a2la_date  = acr_a2la_date,
                      aabb       = acr_aabb,
                      aabb_ind   = acr_aabb_ind,
                      aabb_date  = acr_aabb_date,
                      aoa        = acr_aoa,
                      aoa_ind    = acr_aoa_ind,
                      aoa_date   = acr_aoa_date,
                      ashi       = acr_ashi,
                      ashi_ind   = acr_ashi_ind,
                      ashi_date  = acr_ashi_date,
                      cap        = acr_cap,
                      cap_ind    = acr_cap_ind,
                      cap_date   = acr_cap_date,
                      cola       = acr_cola,
                      cola_ind   = acr_cola_ind,
                      cola_date  = acr_cola_date,
                      jcaho      = acr_jcaho,
                      jcaho_ind  = acr_jcaho_ind,
                      jcaho_date = acr_jcaho_date)

      org <- acr |>
        dplyr::select(clia_number, a2la, aabb, aoa, ashi, cap, cola, jcaho) |>
        tidyr::pivot_longer(cols = !clia_number,
                            names_to = "organization",
                            values_to = "accredited") |>
        dplyr::mutate(accredited = dplyr::if_else(accredited == "X", TRUE, FALSE))

      dt <- acr |>
        dplyr::select(clia_number, dplyr::ends_with("_date")) |>
        tidyr::pivot_longer(cols = !clia_number,
                            names_to = "organization",
                            values_to = "confirmed_date") |>
        dplyr::mutate(organization = stringr::str_remove(organization, "_date"))

      ind <- acr |>
        dplyr::select(clia_number, dplyr::ends_with("_ind")) |>
        tidyr::pivot_longer(cols = !clia_number,
                            names_to = "organization",
                            values_to = "confirmed") |>
        dplyr::mutate(organization = stringr::str_remove(organization, "_ind"))

      results <- dplyr::inner_join(org,
                                   ind,
                                   by = dplyr::join_by(clia_number,
                                                       organization)) |>
        dplyr::inner_join(dt,
                          by = dplyr::join_by(clia_number,
                                              organization)) |>
        dplyr::filter(accredited == TRUE) |>
        dplyr::right_join(res,
                          by = dplyr::join_by(clia_number)) |>
        dplyr::mutate(organization = stringr::str_to_upper(organization)) |>
        dplyr::relocate(c(organization,
                          accredited,
                          confirmed,
                          confirmed_date),
                        .after = type_of_action) |>
        dplyr::select(-dplyr::starts_with("affiliated_"))


      aff <- dplyr::select(res,
                           clia_number,
                           dplyr::starts_with("affiliated_")) |>
        dplyr::distinct() |>
        tidyr::pivot_longer(!clia_number,
                            names_to = "affiliated_provider",
                            values_to = "affiliated_provider_clia",
                            values_drop_na = TRUE)

      aff$affiliated_provider <- NULL

      results <- dplyr::left_join(results,
                                  aff,
                                  by = dplyr::join_by(clia_number))
    }
    if (na.rm) results <- narm(results)
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_lab <- function(df) {

  cols <- c('provider_name',
            'clia_number'           = 'prvdr_num',
            'certificate'           = 'crtfct_type_cd',
            'clia_medicare'         = 'clia_mdcr_num',
            # 'application'         = 'aplctn_type_cd',
            'effective_date'        = 'crtfct_efctv_dt',
            'expiration_date'       = 'trmntn_exprtn_dt',
            'expired',
            'termination_reason'    = 'pgm_trmntn_cd',
            'status'                = 'cmplnc_stus_cd',
            'poc_ind'               = 'acptbl_poc_sw',
            # 'termination_code'    = 'clia_trmntn_cd',
            'type_of_action'        = 'crtfctn_actn_type_cd',
            'ownership_type'        = 'gnrl_cntl_type_cd',
            'facility_type'         = 'gnrl_fac_type_cd',
            'director_affiliations' = 'drctly_afltd_lab_cnt',
            # 'category'            = 'prvdr_ctgry_cd',
            # 'subcategory'         = 'prvdr_ctgry_sbtyp_cd',

            'address',
            'city'                  = 'city_name',
            'state'                 = 'state_cd',
            'zip'                   = 'zip_cd',
            'phone'                 = 'phne_num',
            'fax'                   = 'fax_phne_num',
            'orig_part_date'        = 'orgnl_prtcptn_dt',
            'application_date'      = 'aplctn_rcvd_dt',
            'certification_date'    = 'crtfctn_dt',
            'mailed_date'           = 'crtfct_mail_dt',

            'region'                = 'rgn_cd',
            # 'state_region'        = 'state_rgn_cd',
            # 'fips_county'         = 'fips_cnty_cd',
            # 'fips_state'          = 'fips_state_cd',
            # 'cbsa'                = 'cbsa_cd',
            # 'cbsa_ind'            = 'cbsa_urbn_rrl_ind',
            # 'carrier'             = 'intrmdry_carr_cd',
            # 'carrier_prior'       = 'intrmdry_carr_prior_cd',
            # 'medicaid_vendor'     = 'mdcd_vndr_num',
            # 'chow_count'          = 'chow_cnt',
            # 'chow_date_prev'      = 'chow_prior_dt',
            # 'chow_date'           = 'chow_dt',
            # 'fiscal_year_end'     = 'fy_end_mo_day_cd',
            # 'eligible_ind'        = 'elgblty_sw',
            # 'skeleton_ind'        = 'skltn_rec_sw',
            # 'multi_site_ind'      = 'mlt_site_excptn_sw',
            # 'hosp_campus_ind'     = 'hosp_lab_excptn_sw',
            # 'pub_health_ind'      = 'non_prft_excptn_sw',
            # 'tmp_test_site_ind'   = 'lab_temp_tstg_site_sw',
            # 'shared_lab_ind'      = 'shr_lab_sw',
            # 'shared_lab_xref_number',
            # 'lab_site_count'      = 'lab_site_cnt',
            # 'ppm_test_count'      = 'ppmp_test_vol_cnt',
            # 'acc_sched'           = 'acrdtn_schdl_cd',
            # 'form_116_acrdtd_test_vol_cnt',
            # 'form_116_test_vol_cnt',
            # 'form_1557_crtfct_schdl_cd',
            # 'form_1557_cmplnc_schdl_cd',
            # 'form_1557_test_vol_cnt',
            # 'wvd_test_vol_cnt',

            # American Association for Laboratory Accreditation
            'acr_a2la'              = 'a2la_acrdtd_cd',
            'acr_a2la_ind'          = 'a2la_acrdtd_y_match_sw',
            'acr_a2la_date'         = 'a2la_acrdtd_y_match_dt',

            # American Association of Blood Banks
            'acr_aabb'              = 'aabb_acrdtd_cd',
            'acr_aabb_ind'          = 'aabb_acrdtd_y_match_sw',
            'acr_aabb_date'         = 'aabb_acrdtd_y_match_dt',

            # American Osteopathic Association
            'acr_aoa'               = 'aoa_acrdtd_cd',
            'acr_aoa_ind'           = 'aoa_acrdtd_y_match_sw',
            'acr_aoa_date'          = 'aoa_acrdtd_y_match_dt',

            # American Society for Histocompatibility and Immunogenetics
            'acr_ashi'              = 'ashi_acrdtd_cd',
            'acr_ashi_ind'          = 'ashi_acrdtd_y_match_sw',
            'acr_ashi_date'         = 'ashi_acrdtd_y_match_dt',

            # College of American Pathologists
            'acr_cap'               = 'cap_acrdtd_cd',
            'acr_cap_ind'           = 'cap_acrdtd_y_match_sw',
            'acr_cap_date'          = 'cap_acrdtd_y_match_dt',

            # Commission on Office Laboratory Accreditation
            'acr_cola'              = 'cola_acrdtd_cd',
            'acr_cola_ind'          = 'cola_acrdtd_y_match_sw',
            'acr_cola_date'         = 'cola_acrdtd_y_match_dt',

            # the Joint Commission
            'acr_jcaho'             = 'jcaho_acrdtd_cd',
            'acr_jcaho_ind'         = 'jcaho_acrdtd_y_match_sw',
            'acr_jcaho_date'        = 'jcaho_acrdtd_y_match_dt',

            'clia_class_current'    = 'current_clia_lab_clsfctn_cd')

  df |> dplyr::select(dplyr::any_of(cols),
    # dplyr::starts_with("clia_lab_classification_cd_"),
    dplyr::contains("_provider_number_"))
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
                    .default = x)
}

#' @autoglobal
#' @noRd
fct_toa <- function(x) {
  factor(x,
         levels = c("1", "2", "3", "4", "5", "8"),
         labels = c("Initial",
                    "Recertification",
                    "Termination",
                    "Change of Ownership",
                    "Validation",
                    "Full Survey After Complaint"),
         ordered = TRUE)
}

#' @autoglobal
#' @noRd
fct_app <- function(x) {
  factor(x,
         levels = c("1", "2", "3", "4", "9"),
         labels = c("Compliance",
                    "Waiver",
                    "Accreditation",
                    "PPM",
                    "Registration"),
         ordered = TRUE)
}

#' @autoglobal
#' @noRd
fct_stat <- function(x) {
  factor(x,
         levels = c("A", "B"),
         labels = c("In Compliance",
                    "Not In Compliance"),
         ordered = TRUE)
}

#' @autoglobal
#' @noRd
fct_region <- function(x) {
  factor(x,
         levels = c('01', '02', '03', '04', '05',
                    '06', '07', '08', '09', '10'),
         labels = c('Boston',
                    'New York',
                    'Philadelphia',
                    'Atlanta',
                    'Chicago',
                    'Dallas',
                    'Kansas City',
                    'Denver',
                    'San Francisco',
                    'Seattle'))
}

#' @autoglobal
#' @noRd
fct_owner <- function(x) {
  factor(x,
         levels = c('01', '02', '03', '04', '05',
                    '06', '07', '08', '09', '10'),
         labels = c('Religious Affiliation',
                    'Private',
                    'Other',
                    'Proprietary',
                    'Govt: City',
                    'Govt: County',
                    'Govt: State',
                    'Govt: Federal',
                    'Govt: Other',
                    'Unknown'))
}

#' @autoglobal
#' @noRd
fct_lab <- function(x) {
  factor(x,
         levels = c("00", "22", "01", "05", "10"),
         labels = c("CLIA Lab",
                    "CLIA Lab",
                    "CLIA88 Lab",
                    "CLIA Exempt Lab",
                    "CLIA VA Lab"))
}

#' @autoglobal
#' @noRd
fct_facility <- function(x) {
  factor(x,
         levels = c('01', '02', '03', '04', '05',
                    '06', '07', '08', '09', '10',
                    '11', '12', '13', '14', '15',
                    '16', '17', '18', '19', '20',
                    '21', '22', '23', '24', '25',
                    '26', '27', '28', '29'),
         labels = c('Ambulance',
                    'Ambulatory Surgical Center',
                    'Ancillary Test Site',
                    'Assisted Living Facility',
                    'Blood Banks',
                    'Community Clinic',
                    'Comprehensive Outpatient Rehab',
                    'End-Stage Renal Disease Dialysis',
                    'Federally Qualified Health Center',
                    'Health Fair',
                    'Health Maintenance Organization',
                    'Home Health Agency',
                    'Hospice',
                    'Hospital',
                    'Independent',
                    'Industrial',
                    'Insurance',
                    'Intermediate Care Facility-Individuals with Intellectual Disabilities',
                    'Mobile Lab',
                    'Pharmacy',
                    'Physician Office',
                    'Other Practitioner',
                    'Prison',
                    'Public Health Laboratory',
                    'Rural Health Clinic',
                    'School-Student Health Service',
                    'Skilled Nursing Facility',
                    'Tissue Bank-Repositories',
                    'Other'),
         ordered = TRUE)
}

#' @autoglobal
#' @noRd
fct_term <- function(x) {
  factor(x,
         levels = c('00', '01', '02', '03', '04',
                    '05', '06', '07', '08', '09',
                    '10', '11', '12', '13', '14',
                    '15', '16', '17', '20', '33',
                    '80', '99'),
         labels = c('Active Provider',
                    'Voluntary: Merger, Closure',
                    'Voluntary: Dissatisfaction with Reimbursement',
                    'Voluntary: Risk of Involuntary Termination',
                    'Voluntary: Other Reason for Withdrawal',
                    'Involuntary: Failure to Meet Health-Safety Req',
                    'Involuntary: Failure to Meet Agreement',
                    'Other: Provider Status Change',
                    'Nonpayment of Fees (CLIA Only)',
                    'Rev/Unsuccessful Participation in PT (CLIA Only)',
                    'Rev/Other Reason (CLIA Only)',
                    'Incomplete CLIA Application Information (CLIA Only)',
                    'No Longer Performing Tests (CLIA Only)',
                    'Multiple to Single Site Certificate (CLIA Only)',
                    'Shared Laboratory (CLIA Only)',
                    'Failure to Renew Waiver PPM Certificate (CLIA Only)',
                    'Duplicate CLIA Number (CLIA Only)',
                    'Mail Returned No Forward Address Cert Ended (CLIA Only)',
                    'Notification Bankruptcy (CLIA Only)',
                    'Accreditation Not Confirmed (CLIA Only)',
                    'Awaiting State Approval',
                    'OIG Action Do Not Activate (CLIA Only)'),
         ordered = TRUE)
}
