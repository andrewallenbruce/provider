#' Download the current MS-DRG classification
#'
#' @description
#' `r lifecycle::badge("questioning")`
#'
#' `download_msdrg()` returns a [tibble()] of the current Medicare Severity Diagnosis-Related Group (MS-DRG) codes
#'
#' @section MS-DRGs:
#' The Medicare Severity Diagnosis-Related Group (MS-DRG) is a classification
#' system used by the Centers for Medicare and Medicaid Services (CMS) to group
#' patients with similar clinical characteristics and resource utilization into
#' a single payment category.
#'
#' The system is primarily used for Medicare reimbursement purposes, but it is
#' also adopted by many other payers as a basis for payment determination.
#'
#' MS-DRGs are based on the principal diagnosis, up to 24 additional diagnoses,
#' and up to 25 procedures performed during the stay. In a small number of
#' MS-DRGs, classification is also based on the age, sex, and discharge status
#' of the patient.
#'
#' Hospitals serving more severely ill patients receive increased
#' reimbursements, while hospitals treating less severely ill patients will
#' receive less reimbursement.
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' @examplesIf interactive()
#' download_msdrg()
#' @autoglobal
#' @noRd
download_msdrg <- function() {

  url <- "https://www.hipaaspace.com/medical.coding.library/drgs/"

  ms_drg_v36 <- url |>
    rvest::read_html() |>
    rvest::html_table(na.strings = c("N/A", "N/S"),
                      convert = FALSE)

  ms_drg_v36[[1]] |>
    janitor::clean_names() |>
    dplyr::select(-number) |>
    dplyr::mutate(mdc = dplyr::na_if(mdc, "N/A"),
                  mdc_description = dplyr::na_if(mdc_description, "N/S")) |>
    tidyr::separate_wider_delim(drg_type, " ", names = c("drg_type", "drg_abbrev")) |>
    dplyr::mutate(drg_abbrev = stringr::str_remove(drg_abbrev, "\\("),
                  drg_abbrev = stringr::str_remove(drg_abbrev, "\\)"),
                  drg_abbrev = dplyr::na_if(drg_abbrev, ""))

}
