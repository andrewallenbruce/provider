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
#' @param compliant `<lgl>` Return only compliant or non-compliant labs
#' @param active `<lgl>` Return only active labs
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
#' @autoglobal
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
  compliant = NULL,
  active = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_char_(certificate)
  check_char_(accreditation)
  check_bool_(compliant)
  check_bool_(active)

  execute(
    base_cms(
      end = "clia",
      count = count,
      set = set,
      arg = param_cms(
        FAC_NAME = facility_name,
        PRVDR_NUM = facility_ccn,
        CLIA_MDCR_NUM = parent_ccn,
        CRTFCT_TYPE_CD = enum_(certificate),
        CITY_NAME = city,
        STATE_CD = state,
        ZIP_CD = zip,
        CMPLNC_STUS_CD = cmp_(compliant),
        PGM_TRMNTN_CD = act_(active),
        !!!accr_(accreditation)
      )
    )
  )
}

#' @noRd
act_ <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }
  if (x) "00" else NULL
}

#' @noRd
cmp_ <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }
  cheapr::val_match(x, TRUE ~ "A", FALSE ~ "B")
}

#' @noRd
accr_ <- function(accreditation) {
  if (is.null(accreditation)) {
    return(NULL)
  }
  x <- enum_(accreditation)
  set_names(as.list(rep.int("Y", length(x))), x)
}
