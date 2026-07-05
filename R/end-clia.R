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
#' @param name `<chr>` Provider/Laboratory name
#' @param ccn `<chr>` 10-digit CMS Certification Number
#' @param clia `<chr>` 6-digit CMS Certification Number
#' @param certificate `<enum>` CLIA certificate type (see Details):
#'    - `"wav"` = Waiver
#'    - `"ppm"` = Provider-Performed Microscopy (PPM)
#'    - `"reg"` = Registration
#'    - `"cmp"` = Compliance
#'    - `"acr"` = Accreditation
#' @param accrediting `<enum>` CLIA accrediting organization (see Details):
#'    - `"a2la"` = American Association for Laboratory Accreditation
#'    - `"aabb"` = Association for the Advancement of Blood & Biotherapies
#'    - `"aoa"` = American Osteopathic Association
#'    - `"ashi"` = American Society for Histocompatibility & Immunogenetics
#'    - `"cap"` = College of American Pathologists
#'    - `"cola"` = Commission on Office Laboratory Accreditation
#'    - `"jcaho"` = The Joint Commission
#' @param multi `<enum>`  Single site CLIA multiple-site exceptions:
#'    - `"applied"` = Applied for to cover multiple testing locations
#'    - `"campus"` = Hospital with several labs on single hospital campus
#'    - `"non"` = Multiple sites with non-profit, federal, state or local government status (limited public health testing)
#'    - `"temp"` = Lab with multiple temporary testing sites
#' @param city,state `<chr>` Lab city, state
#' @param active `<lgl>` Return only active labs
#' @param eligible `<lgl>` Indicates lab is eligible to participate in
#'   Medicare/Medicaid.
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' clia(count = TRUE)
#' clia(certificate = c("acr", "reg"), city = "Valdosta", state = "GA")
#' clia(accrediting = c("cap", "cola", "jcaho"))
#' @export
clia <- function(
  name = NULL,
  ccn = NULL,
  clia = NULL,
  certificate = NULL,
  accrediting = NULL,
  multi = NULL,
  city = NULL,
  state = NULL,
  active = NULL,
  eligible = NULL,
  count = FALSE
) {
  check_char_(certificate)
  check_char_(accrediting)
  check_bool_(active)
  check_bool_(eligible)

  x <- end_cms(
    count = count,
    set = FALSE,
    FAC_NAME = name,
    PRVDR_NUM = ccn,
    CLIA_MDCR_NUM = clia,
    CRTFCT_TYPE_CD = tag_enum(certificate),
    CITY_NAME = city,
    STATE_CD = state,
    PGM_TRMNTN_CD = tag_active(active),
    ELGBLTY_SW = tag_bool(eligible),
    !!!tag_enum(accrediting),
    !!!tag_enum(multi)
  )

  x <- execute(x)

  polish(x)
}

#' @noRd
tag_active <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }
  if (x) "00" else not("00")
}
