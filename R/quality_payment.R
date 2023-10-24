#' Quality Payment Program Experience
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [quality_payment()]  allows the user access to information on participation
#' and performance in the Merit-based Incentive Payment System (MIPS) and
#' Advanced Alternative Payment Models (APMs) tracks.
#'
#' @section Quality Payment Program (QPP) Experience:
#' The QPP dataset provides participation and performance information in the
#' Merit-based Incentive Payment System (MIPS) during each performance year.
#' They cover eligibility and participation, performance categories, final
#' score and payment adjustments. The dataset provides additional details at the
#' TIN/NPI level on what was published in the previous performance year.
#'
#' @section Links:
#' + [Quality Payment Program Experience](https://data.cms.gov/quality-of-care/quality-payment-program-experience)
#'
#' @section Update Frequency:
#' __Annually__
#'
#' @param year < *integer* > // **required** QPP performance year, in `YYYY`format.
#' Run [qpp_years()] to return a vector of the years currently available.
#' @param npi < *integer* > 10-digit Individual National Provider Identifier
#' assigned to the clinician when they enrolled in Medicare. Multiple rows for
#' the same NPI indicate multiple TIN/NPI combinations.
#' @param state < *character* > State or US territory code location of the TIN
#'  associated with the clinician.
#' @param specialty < *character* > Specialty corresponding to the type of
#' service that the clinician submitted most on their Medicare Part B claims
#' for this TIN/NPI combination.
#' + Nurse Practitioner
#' + Internal Medicine
#' + Physician Assistant
#' + Family Practice
#' + Emergency Medicine
#' + Diagnostic Radiology
#' + Anesthesiology
#' + Neurology
#' + Cardiology
#' @param type < *character* > Participation type; level at which the performance data
#' was collected, submitted or reported for the final score attributed to the
#' clinician; drives most of the data returned.
#' + `"Group"`
#' + `"Individual"`
#' + `"MIPS APM"`
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param nest < *boolean* > // __default:__ `TRUE` Nest output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' quality_payment(year = 2020, npi = 1144544834)
#' @rdname quality_payment
#' @autoglobal
#' @export
quality_payment <- function(year,
                            npi = NULL,
                            state = NULL,
                            specialty = NULL,
                            type = NULL,
                            tidy = TRUE,
                            nest = TRUE,
                            na.rm = TRUE) {


  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, values = as.character(qpp_years()))

  npi <- npi %nn% validate_npi(npi)

  args <- dplyr::tribble(
    ~param,                          ~arg,
    "npi",                            npi,
    "practice state or us territory", state,
    "clinician specialty",            specialty,
    "participation type",             type)

  id <- api_years("qpp") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,                               ~y,
      "year",                           year,
      "npi",                            npi,
      "practice state or us territory", state,
      "clinician specialty",            specialty,
      "participation type",             type) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results$year <- year
    results <- tidyup(results,
                      int = c("year",
                              "practice_size",
                              "years_in_medicare",
                              "medicare_patients",
                              "services"),
                      dbl = c("allowed_charges",
                              "payment_adjustment_percentage",
                              "final_score",
                              "quality_category_score",
                              "promoting_interoperability_pi_category_score",
                              "ia_score",
                              "cost_score",
                              "complex_patient_bonus",
                              "quality_improvement_bonus"),
                      yn = c("engaged",
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
                             "extreme_hardship_cost"),
                      yr = 'year') |>
      cols_qpp()

      if (nest) {
        pcol <- c(paste0('quality_measure_id_', 1:10),
                  paste0('quality_measure_score_', 1:10),
                  paste0('pi_measure_id_', 1:11),
                  paste0('pi_measure_score_', 1:11),
                  paste0('ia_measure_id_', 1:4),
                  paste0('ia_measure_score_', 1:4),
                  paste0('cost_measure_id_', 1:2),
                  paste0('cost_measure_score_', 1:2))

        top <- results |>
          dplyr::select(-c(dplyr::contains("measure_"),
                           dplyr::contains("ind_"))) |>
          dplyr::mutate(npi_id = dplyr:consecutive_id(npi), .after = npi)

        measures <- dplyr::select(results, year, npi,
                                  dplyr::contains("measure_")) |>
          dplyr::mutate(npi_id = dplyr::row_number(), .after = npi) |>
          tidyr::pivot_longer(
            cols = dplyr::any_of(pcol),
            names_to = c("measure", "x", "type", "group"),
            names_pattern = "(.*)_(.*)_(.*)_(.)",
            values_to = "val") |>
          dplyr::mutate(x = NULL) |>
          tidyr::pivot_wider(names_from = type,
                             values_from = val,
                             values_fn = list) |>
          tidyr::unnest(cols = dplyr::any_of(c('id', 'score'))) |>
          dplyr::filter(!is.na(score)) |>
          dplyr::mutate(score = as.double(score)) |>
          tidyr::nest(.by = c(year, npi),
                      .key = "measures")

        statuses <- dplyr::select(results, year, npi,
                                  dplyr::contains("ind_")) |>
          dplyr::mutate(npi_id = dplyr::row_number(), .after = npi) |>
          tidyr::pivot_longer(
            cols = dplyr::starts_with("ind_"),
            names_to = c("x", "category"),
            names_pattern = "(...)_(.*)",
            values_to = "status") |>
          dplyr::mutate(x = NULL) |>
          dplyr::filter(!is.na(status) & status != FALSE) |>
          tidyr::nest(.by = c(year, npi),
                      .key = "statuses")

        results <- dplyr::left_join(
          top, measures,
          by = dplyr::join_by(year, npi)) |>
          dplyr::left_join(statuses, dplyr::join_by(year, npi))
        }
    if (na.rm) results <- narm(results)
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_qpp <- function(df) {

  cols <- c('year',
            'npi',
            'state'                        = 'practice_state_or_us_territory',
            'size'                         = 'practice_size',
            'specialty'                    = 'clinician_specialty',
            'years'                        = 'years_in_medicare',
            'type'                         = 'participation_type',
            'beneficiaries'                = 'medicare_patients',
            'services',
            'allowed_charges',
            'final_score',
            'pay_adjust'                   = 'payment_adjustment_percentage',
            'quality_score'                = 'quality_category_score',
            'pi_score'                     = 'promoting_interoperability_pi_category_score',
            'ia_score',
            'cost_score',
            'complex_bonus'                = 'complex_patient_bonus',
            'qi_bonus'                     = 'quality_improvement_bonus',
            'ind_quality_bonus'            = 'quality_bonus',
            'ind_engaged'                  = 'engaged',
            'ind_opted_into_mips'          = 'opted_into_mips',
            'ind_small_practitioner'       = 'small_practitioner',
            'ind_rural'                    = 'rural_clinician',
            'ind_hpsa'                     = 'hpsa_clinician',
            'ind_asc'                      = 'ambulatory_surgical_center',
            'ind_hospital_based'           = 'hospital_based_clinician',
            'ind_non_patient_facing'       = 'non_patient_facing',
            'ind_facility_based'           = 'facility_based',
            'ind_extreme_hardship'         = 'extreme_hardship',
            'ind_extreme_hardship_quality' = 'extreme_hardship_quality',
            'ind_extreme_hardship_pi'      = 'extreme_hardship_pi',
            'ind_pi_hardship'              = 'pi_hardship',
            'ind_pi_reweighting'           = 'pi_reweighting',
            'ind_pi_bonus'                 = 'pi_bonus',
            'pi_cehrt_id',
            'ind_extreme_hardship_ia'      = 'extreme_hardship_ia',
            'ind_ia_study'                 = 'ia_study',
            'ind_extreme_hardship_cost'    = 'extreme_hardship_cost',
            paste0('quality_measure_id_', 1:10),
            paste0('quality_measure_score_', 1:10),
            paste0('pi_measure_id_', 1:11),
            paste0('pi_measure_score_', 1:11),
            paste0('ia_measure_id_', 1:4),
            paste0('ia_measure_score_', 1:4),
            paste0('cost_measure_id_', 1:2),
            paste0('cost_measure_score_', 1:2))

  df |> dplyr::select(dplyr::any_of(cols))
}
