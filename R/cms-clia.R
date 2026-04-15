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
#' @param name `<chr>` Provider or clinical laboratory's name
#' @param ccn `<chr>` 10-character CLIA number
#' @param parent `<chr>` 6-character CLIA number
#' @param certificate `<enum>` CLIA certificate type (see details):
#'    - `"waiver"` = Waiver
#'    - `"ppm"` = Provider-Performed Microscopy (PPM)
#'    - `"registration"` = Registration
#'    - `"compliance"` = Compliance
#'    - `"accreditation"` = Accreditation
#' @param accreditation `<enum>` CLIA accrediting organization (see details):
#'    - `"a2la"` = A2LA
#'    - `"aabb"` = AABB
#'    - `"aoa"` = AOA
#'    - `"ashi"` = ASHI-HLA
#'    - `"cap"` = CAP
#'    - `"cola"` = COLA
#'    - `"jcaho"` = JCAHO
#' @param city `<chr>` City
#' @param state `<chr>` State
#' @param zip `<chr>` Zip code
#' @param compliant `<lgl>` Compliant or Non-Compliant
#' @param active `<lgl>` Return only active providers
#' @param count `<lgl>` Return the dataset's total row count
#' @param set `<lgl>` Return the entire dataset
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' clia(count = TRUE)
#' clia(compliant = FALSE, count = TRUE)
#' clia(ccn = provider:::cdc_labs$ccn)
#' clia(certificate = c("accreditation", "registration"),
#'      city = "Valdosta",
#'      state = "GA")
#' clia(accreditation = "jcaho", count = TRUE)
#' clia(accreditation = "a2la")
#' @autoglobal
#' @export
clia <- function(
  name = NULL,
  ccn = NULL,
  parent = NULL,
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
  check_character(certificate, allow_null = TRUE)
  check_character(accreditation, allow_null = TRUE)
  check_bool(compliant, allow_null = TRUE)
  check_bool(active, allow_null = TRUE)

  exec_cms(
    END = call_name(call_match()),
    COUNT = count,
    SET = set,
    ARG = param_cms(
      FAC_NAME = name,
      PRVDR_NUM = ccn,
      CLIA_MDCR_NUM = parent,
      CRTFCT_TYPE_CD = enum_(certificate),
      CITY_NAME = city,
      STATE_CD = state,
      ZIP_CD = zip,
      CMPLNC_STUS_CD = cmp_(compliant),
      PGM_TRMNTN_CD = act_(active),
      !!!accr_(accreditation)
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
accr_ <- function(x) {
  if (is.null(x)) {
    return(NULL)
  }
  arg_match(
    x,
    c("a2la", "aabb", "aoa", "ashi", "cap", "cola", "jcaho"),
    multiple = FALSE,
    error_arg = "accreditation",
    error_call = call2("clia")
  )
  x <- switch(
    x,
    a2la = "A2LA_ACRDTD_Y_MATCH_SW",
    aabb = "AABB_ACRDTD_Y_MATCH_SW",
    aoa = "AOA_ACRDTD_Y_MATCH_SW",
    ashi = "ASHI_ACRDTD_Y_MATCH_SW",
    cap = "CAP_ACRDTD_Y_MATCH_SW",
    cola = "COLA_ACRDTD_Y_MATCH_SW",
    jcaho = "JCAHO_ACRDTD_Y_MATCH_SW"
  )
  set_names(list("Y"), x)
}
