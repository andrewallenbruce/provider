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
#' @param certificate `<chr>` CLIA certificate type (see details):
#'    - `"wav"`: Waiver
#'    - `"ppm"`: Provider-Performed Microscopy (PPM)
#'    - `"reg"`: Registration
#'    - `"cmp"`: Compliance
#'    - `"acc"`: Accreditation
#' @param city `<chr>` City
#' @param state `<chr>` State
#' @param zip `<chr>` Zip code
#' @param status `<chr>` `"cmp"` (Compliant) or `"non"` (Non-Compliant)
#' @param active `<lgl>` Return only active providers
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' clia(count = TRUE)
#' clia(status = "cmp", count = TRUE)
#' clia(ccn = provider:::cdc_labs$ccn)
#' clia(
#'   certificate = c("acc", "reg"),
#'   city = "Valdosta",
#'   state = "GA"
#' )
#' @autoglobal
#' @export
clia <- function(
  name = NULL,
  ccn = NULL,
  certificate = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  status = NULL,
  active = FALSE,
  count = FALSE
) {
  exec_cms(
    END = rlang::call_name(rlang::call_match()),
    COUNT = count,
    ARG = params(
      FAC_NAME = name,
      PRVDR_NUM = ccn,
      CRTFCT_TYPE_CD = enum_(certificate),
      CITY_NAME = city,
      STATE_CD = state,
      ZIP_CD = zip,
      CMPLNC_STUS_CD = enum_(status),
      PGM_TRMNTN_CD = active_(active)
    )
  )
}

#' @noRd
active_ <- function(active) {
  if (is.null(active)) {
    return(NULL)
  }
  check_bool(active)

  if (active) "00" else NULL
}
