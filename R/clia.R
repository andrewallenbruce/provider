#' Clinical Laboratories
#'
#' @description
#' `clia()` allows you to search for information on clinical laboratories
#' including demographics and the type of testing services the facility provides.
#'
#' ## Clinical Laboratory Improvement Amendments (CLIA)
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
#' ### Links:
#'   - [Provider of Services File - Clinical Laboratories](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)
#'
#' *Update Frequency:* **Quarterly**
#'
#' @param facility_name Hospital’s CMS Certification Number (CCN)
#' @param clia_number description
#' @param ccn description
#' @param city City of the hospital’s practice location address
#' @param state State of the hospital’s practice location address
#' @param zip State of the hospital’s practice location address
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' clia_labs(city = "Valdosta")
#' clia_labs(clia_number = "00205114A3")
#' clia_labs(ccn = "11D0265516")
#'
#' @autoglobal
#' @export
clia_labs <- function(facility_name = NULL,
                      clia_number = NULL,
                      ccn = NULL,
                      city = NULL,
                      state = NULL,
                      zip = NULL,
                      tidy = TRUE) {

  # args tribble
  args <- tibble::tribble(
    ~x,           ~y,
    "FAC_NAME",   facility_name,
    "CLIA_MDCR_NUM", clia_number,
    "PRVDR_NUM",  ccn,
    "CITY_NAME",  city,
    "STATE_CD",   state,
    "ZIP_CD",     zip)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # update distribution id -------------------------------------------------
  id <- cms_update(api = "Provider of Services File - Clinical Laboratories",
                   check = "id") |>
    dplyr::slice_head() |>
    dplyr::pull(distro)

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  # if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {
  #
  #   cli_args <- tibble::tribble(
  #     ~x,                  ~y,
  #     "npi",               as.character(npi),
  #     "facility_ccn",      as.character(facility_ccn),
  #     "city",              city,
  #     "state",             state,
  #     "zip",               zip) |>
  #     tidyr::unnest(cols = c(y))
  #
  #   cli_args <- purrr::map2(cli_args$x,
  #                           as.character(cli_args$y),
  #                           stringr::str_c,
  #                           sep = ": ",
  #                           collapse = "")
  #
  #   cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
  #   return(invisible(NULL))
  #
  # }

  # parse response ---------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
                                                  check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      dplyr::select(facility_name = fac_name,
                    ccn = prvdr_num,
                    clia_number = clia_mdcr_num,
                    type = prvdr_ctgry_cd,
                    subtype = prvdr_ctgry_sbtyp_cd,
                    poc = acptbl_poc_sw,
                    status = cmplnc_stus_cd,
                    med_eligible = elgblty_sw,
                    city = city_name,
                    state = state_cd,
                    date_app_received = aplctn_rcvd_dt,
                    current_clia_lab_clsfctn_cd,
                    term_code = pgm_trmntn_cd,
                    term_date = trmntn_exprtn_dt,
                    type_of_action = crtfctn_actn_type_cd,
                    ownership_type = gnrl_cntl_type_cd,
                    related_provider_number,
                    dplyr::starts_with("affiliated_provider_number_"),
                    dplyr::starts_with("clia_lab_classification_cd_")) |>
      dplyr::mutate(term_code = termcd(term_code),
                    type_of_action = toa(type_of_action))

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
