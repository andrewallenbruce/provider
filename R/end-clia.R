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
#' @param fac_name `<chr>` Provider/Laboratory name
#' @param fac_ccn `<chr>` 10-digit CMS Certification Number
#' @param clia_ccn `<chr>` 6-digit CMS Certification Number
#' @param cert_type `<enum>` CLIA certificate type (see Details):
#'    - `"wav"` = Waiver
#'    - `"ppm"` = Provider-Performed Microscopy (PPM)
#'    - `"reg"` = Registration
#'    - `"cmp"` = Compliance
#'    - `"acr"` = Accreditation
#' @param acr_org `<enum>` CLIA accrediting organization (see Details):
#'    - `"a2la"` = American Association for Laboratory Accreditation
#'    - `"aabb"` = Association for the Advancement of Blood & Biotherapies
#'    - `"aoa"` = American Osteopathic Association
#'    - `"ashi"` = American Society for Histocompatibility & Immunogenetics
#'    - `"cap"` = College of American Pathologists
#'    - `"cola"` = Commission on Office Laboratory Accreditation
#'    - `"jcaho"` = The Joint Commission
#' @param multi_site `<enum>`  Single site CLIA multiple-site exceptions:
#'    - `"applied"` = Applied for to cover multiple testing locations
#'    - `"campus"` = Hospital with several labs on single hospital campus
#'    - `"non"` = Multiple sites with non-profit, federal, state or local government status (limited public health testing)
#'    - `"temp"` = Lab with multiple temporary testing sites
#' @param city,state,zip `<chr>` Lab city, state, zip
#' @param chows `<int>` Number of times there has been a Change of Ownership.
#' @param active `<lgl>` Return only active labs
#' @param eligible `<lgl>` Indicates lab is eligible to participate in
#'   Medicare/Medicaid.
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
#' clia(cert_type = c("acr", "reg"), city = "Valdosta", state = "GA")
#'
#' clia(acr_org = c("cap", "cola", "jcaho")) |> str()
#'
#' clia(multi_site = c("temp", "campus")) |> str()
#'
#' @export
clia <- function(
  fac_name = NULL,
  fac_ccn = NULL,
  clia_ccn = NULL,
  cert_type = NULL,
  acr_org = NULL,
  multi_site = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  chows = NULL,
  active = NULL,
  eligible = NULL,
  poc = NULL,
  count = FALSE,
  set = FALSE
) {
  check_char_(cert_type)
  check_char_(acr_org)
  check_bool_(active)
  check_bool_(eligible)
  check_bool_(poc)

  x <- cms(
    count = count,
    set = set,
    FAC_NAME = fac_name,
    PRVDR_NUM = fac_ccn,
    CLIA_MDCR_NUM = clia_ccn,
    CRTFCT_TYPE_CD = tag_enum(cert_type),
    CITY_NAME = city,
    STATE_CD = state,
    ZIP_CD = zip,
    CHOW_CNT = chows,
    PGM_TRMNTN_CD = tag_active(active),
    ELGBLTY_SW = convert_bool(eligible),
    ACPTBL_POC_SW = convert_bool(poc),
    !!!tag_acr_org(acr_org),
    !!!tag_multi_site(multi_site)
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

#' @noRd
tag_acr_org <- function(acr_org) {
  if (is.null(acr_org)) {
    return(NULL)
  }
  x <- tag_enum(acr_org)
  set_names(as.list(rep.int("Y", length(x))), x)
}

#' @noRd
tag_multi_site <- function(multi_site) {
  if (is.null(multi_site)) {
    return(NULL)
  }
  x <- tag_enum(multi_site)
  set_names(as.list(rep.int("Y", length(x))), x)
}
