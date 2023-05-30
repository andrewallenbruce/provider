#' Search the CMS Quality Payment Program Experience API
#'
#' @description Information on participation and performance in the Merit-based
#'    Incentive Payment System (MIPS) and Advanced Alternative Payment Models
#'    (APMs) tracks.
#'
#' @details The Quality Payment Program (QPP) Experience dataset provides
#'    participation and performance information in the Merit-based Incentive
#'    Payment System (MIPS) during each performance year. They cover
#'    eligibility and participation, performance categories, and final score
#'    and payment adjustments. The dataset provides additional details at the
#'    TIN/NPI level on what was published in the previous performance year.
#'    You can sort the data by variables like clinician type, practice size,
#'    scores, and payment adjustments.
#'
#'   ## Links
#'   * [Quality Payment Program Experience](https://data.cms.gov/quality-of-care/quality-payment-program-experience)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Annually**
#' @param year year
#' @param npi NPI of the Provider
#' @param state State where the provider is enrolled
#' @param specialty Type of enrollment - ASC to Hospital OR IFED
#' @param part_type Organizational name of the enrolled provider
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' qpp_experience(year = 2020, state = "GA")
#' @autoglobal
#' @export
qpp_experience <- function(year,
                           npi       = NULL,
                           state     = NULL,
                           specialty = NULL,
                           part_type = NULL,
                           tidy      = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}

  # match args ----------------------------------------------------
  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(cms_update("Quality Payment Program Experience", "years")))

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                              ~y,
    "npi",                            npi,
    "practice state or us territory", state,
    "clinician specialty",            specialty,
    "participation type",             part_type)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # update distribution ids -------------------------------------------------
  id <- cms_update("Quality Payment Program Experience", "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  #post   <- "/data.json?"
  post   <- "/data?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- tibble::tribble(
      ~x,                               ~y,
      "year",                           as.character(year),
      "npi",                            as.character(npi),
      "practice state or us territory", state,
      "clinician specialty",            specialty,
      "participation type",             part_type) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            as.character(cli_args$y),
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
    return(invisible(NULL))

  }

  # parse response ---------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
                check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., " ")),
                    dplyr::across(dplyr::any_of(c("practice_size",
                                                  "years_in_medicare",
                                                  "medicare_patients",
                                                  "allowed_charges",
                                                  "services")),
                                  as.integer),
                    dplyr::across(dplyr::any_of(c("engaged",
                                                  "opted_into_mips",
                                                  "small_practitioner",
                                                  "rural_clinician",
                                                  "hpsa_clinician",
                                                  "ambulatory_surgical_center",
                                                  "hospital_based_clinician",
                                                  "non_patient_facing",
                                                  "facility_based",
                                                  "extreme_hardship",
                                                  "extreme_hardship_quality",
                                                  "quality_bonus",
                                                  "extreme_hardship_pi",
                                                  "pi_hardship",
                                                  "pi_reweighting",
                                                  "pi_bonus",
                                                  "extreme_hardship_ia",
                                                  "ia_study",
                                                  "extreme_hardship_cost")),
                                  tf_logical)) |>
      dplyr::mutate(year = as.integer(year)) |>
      dplyr::select(year,
                    npi,
                    provider_key,
                    state = practice_state_or_us_territory,
                    practice_size,
                    specialty = clinician_specialty,
                    med_yrs = years_in_medicare,
                    part_type = participation_type,
                    beneficiaries = medicare_patients,
                    allowed_charges,
                    services,
                    final_score,
                    pmt_adj_pct = payment_adjustment_percentage,
                    complex_patient_bonus,
                    quality_category_score,
                    quality_improvement_bonus,
                    quality_bonus,
                    engaged,
                    opted_into_mips,
                    small_practitioner,
                    rural_clinician,
                    hpsa_clinician,
                    asc = ambulatory_surgical_center,
                    hospital_based = hospital_based_clinician,
                    non_patient_facing,
                    facility_based,
                    extreme_hardship,
                    extreme_hardship_quality,
                    quality_measure_id_1,
                    quality_measure_score_1,
                    dplyr::everything())
  }
  return(results)
}
