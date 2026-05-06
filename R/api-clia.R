#' Clinical Laboratories
#'
#' @description
#' Clinical laboratories including demographics and the type of testing
#' services the facility provides.
#'
#' @section CLIA:
#'
#' CMS regulates all laboratory testing (except research) performed on humans
#' in the U.S. through the __Clinical Laboratory Improvement Amendments__.
#' In total, __CLIA__ covers approximately 320,000 laboratory entities.
#'
#' Although all clinical laboratories must be properly certified to receive
#' Medicare or Medicaid payments, CLIA has no direct Medicare or Medicaid
#' program responsibilities.
#'
#' ### Certification
#'
#' ```{r, child = "man/md/clia_certification.md"}
#' ```
#'
#' @source
#'
#' ```{r, child = "man/md/clia_links.md"}
#' ```
#'
#' @param facility_name `<chr>` Provider/Laboratory name
#' @param facility_ccn `<chr>` 10-digit CMS Certification Number
#' @param parent_ccn `<chr>` 6-digit CMS Certification Number
#' @param certificate `<enum>` CLIA certificate type (see Details):
#'    - `"waiver"` = Waiver
#'    - `"ppm"` = Provider-Performed Microscopy (PPM)
#'    - `"registration"` = Registration
#'    - `"compliance"` = Compliance
#'    - `"accreditation"` = Accreditation
#' @param accreditation `<enum>` CLIA accrediting organization (see Details):
#'    - `"a2la"` = A2LA
#'    - `"aabb"` = AABB
#'    - `"aoa"` = AOA
#'    - `"ashi"` = ASHI-HLA
#'    - `"cap"` = CAP
#'    - `"cola"` = COLA
#'    - `"jcaho"` = JCAHO
#' @param city,state,zip `<chr>` Lab city, state, zip
#' @param chow `<int>` Number of times there has been a Change of Ownership.
#' @param compliant `<lgl>` Provider compliance status at time of certification
#'   survey.
#' @param active `<lgl>` Return only active labs
#' @param multi `<lgl>` Indicates lab has applied for a single site CLIA to
#'   cover multiple testing locations.
#' @param campus `<lgl>` Indicates single site CLIA is for hospital with several
#'   labs on a single hospital campus.
#' @param non_profit `<lgl>` Indicates single site CLIA is for multiple sites
#'   with non-profit, federal, state or local government status and engaged in
#'   limited public health testing.
#' @param eligible `<lgl>` Indicates lab is eligible to participate in
#'   Medicare/Medicaid.
#' @param temp_site `<lgl>` Indicates single site CLIA is for lab with multiple
#'   temporary testing sites.
#' @param poc `<lgl>` Indicates provider is in compliance with Plan of
#'   Correction.
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf httr2::is_online()
#' clia(count = TRUE)
#'
#' clia(compliant = FALSE, active = TRUE, count = TRUE)
#'
#' clia(facility_ccn = provider:::cdc_labs$ccn)
#'
#' clia(certificate = c("accreditation", "registration"), city = "Valdosta", state = "GA")
#'
#' clia(accreditation = c("cap", "cola", "jcaho"))
#'
#' @export
clia <- function(
  facility_name = NULL,
  facility_ccn = NULL,
  parent_ccn = NULL,
  certificate = NULL,
  accreditation = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  chow = NULL,
  compliant = NULL,
  active = NULL,
  multi = NULL,
  campus = NULL,
  non_profit = NULL,
  eligible = NULL,
  temp_site = NULL,
  poc = NULL,
  count = FALSE,
  set = FALSE
) {
  check_char_(certificate)
  check_char_(accreditation)
  check_bool_(compliant)
  check_bool_(active)
  check_bool_(multi)
  check_bool_(campus)
  check_bool_(non_profit)
  check_bool_(eligible)
  check_bool_(temp_site)
  check_bool_(poc)
  check_numeric(chow)

  x <- cms(
    FAC_NAME = facility_name,
    PRVDR_NUM = facility_ccn,
    CLIA_MDCR_NUM = parent_ccn,
    CRTFCT_TYPE_CD = tag_enum(certificate),
    CITY_NAME = city,
    STATE_CD = state,
    ZIP_CD = zip,
    CHOW_CNT = chow,
    CMPLNC_STUS_CD = convert_compliant(compliant),
    PGM_TRMNTN_CD = convert_active(active),
    ELGBLTY_SW = convert_bool(eligible),
    MLT_SITE_EXCPTN_SW = convert_bool(multi),
    HOSP_LAB_EXCPTN_SW = convert_bool(campus),
    NON_PRFT_EXCPTN_SW = convert_bool(non_profit),
    LAB_TEMP_TSTG_SITE_SW = convert_bool(temp_site),
    ACPTBL_POC_SW = convert_bool(poc),
    !!!convert_accreditation(accreditation),
    .count = count,
    .set = set,
  )

  x <- execute(x)

  polish(x)
}

#' @noRd
convert_active <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }
  if (x) "00" else NULL
}

#' @noRd
convert_compliant <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }
  cheapr::val_match(x, TRUE ~ "A", FALSE ~ "B")
}

#' @noRd
convert_accreditation <- function(accreditation) {
  if (is.null(accreditation)) {
    return(NULL)
  }
  x <- tag_enum(accreditation)
  set_names(as.list(rep.int("Y", length(x))), x)
}
