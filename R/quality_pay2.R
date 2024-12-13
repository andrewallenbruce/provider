#' Quality Payment Program REWRITE
#'
#' @param year `<int>` // **required** QPP performance year, in `YYYY` format.
#' Run [qpp_years()] to return a vector of the years currently available.
#'
#' @param npi `<int>` 10-digit Individual National Provider Identifier
#' assigned to the clinician when they enrolled in Medicare. Multiple rows for
#' the same NPI indicate multiple TIN/NPI combinations.
#'
#' @param state `<chr>` State or US territory code location of the TIN
#'  associated with the clinician.
#'
#' @param specialty `<chr>` Specialty corresponding to the type of
#' service that the clinician submitted most on their Medicare Part B claims
#' for this TIN/NPI combination.
#'
#' + Nurse Practitioner
#' + Internal Medicine
#' + Physician Assistant
#' + Family Practice
#' + Emergency Medicine
#' + Diagnostic Radiology
#' + Anesthesiology
#' + Neurology
#' + Cardiology
#'
#' @param type `<chr>` Participation type; level at which the
#' performance data was collected, submitted or reported for the final score
#' attributed to the clinician; drives most of the data returned.
#'
#' + `"Group"`
#' + `"Individual"`
#' + `"MIPS APM"`
#'
#' @param tidy `<lgl>` // __default:__ `TRUE` Tidy output
#'
#' @param nest `<lgl>` // __default:__ `TRUE` Nest `status` & `measures`
#'
#' @param eligibility `<lgl>` // __default:__ `TRUE` Append results
#' from [quality_eligibility()]
#'
#' @param ... Empty
#'
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' quality_pay2(year = "2020", npi = 1144544834)
#'
#' quality_pay2(year = "2022", npi = 1043477615)
#'
#' @autoglobal
#'
#' @noRd
quality_pay2 <- function(year,
                         npi         = NULL,
                         state       = NULL,
                         specialty   = NULL,
                         type        = NULL,
                         tidy        = FALSE,
                         nest        = FALSE,
                         eligibility = TRUE,
                         ...) {

  stopifnot(not_null(year), is.character(year))
  year <- match.arg(year, as.character(qpp_years()))

  params <- list(
    "npi" = if (null(npi)) NULL else validate_npi(npi),
    "practice state or us territory" = state,
    "clinician specialty" = specialty,
    "participation type" = type)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
    api_years("qpp", as.integer(year))[["distro"]], "/data?", format_api_params(params))

  response <- request(url) |> req_perform()

  if (empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,                     ~y,
      "year",                 year,
      "npi",                  npi,
      "state",                state,
      "specialty",            specialty,
      "type",   type) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results           <- resp_body_json(response, simplifyVector = TRUE)
  results[["year"]] <- year

  if (false(tidy)) return(results)

  names(results) <- janitor::make_clean_names(names(results))

  measures <- dplyr::select(results,
        dplyr::matches("year$|npi|participation_option|_measure_", perl = TRUE)) |>
        tidyr::pivot_longer(
          cols          = dplyr::matches("_measure_", perl = TRUE),
          names_to      = c("category", "name", "id"),
          names_pattern = "(.*)_measure_(.*)_([0-9]{1,2}$)",
          values_to     = "value") |>
        dplyr::filter(value != "") |>
        dplyr::mutate(
          id = NULL,
          name = dplyr::case_match(name,
            "achievement_points" ~ "score",
            "collection_type" ~ "type",
            .default = name))

  measures <- collapse::rsplit(
    measures,
    measures[["category"]]) |>
    purrr::map(
      function(df)
        tidyr::pivot_wider(
          df,
          names_from = name,
          values_from = value,
          values_fn = list))

  measures <- dplyr::bind_rows(
    measures[c("quality", "pi")]  |>
      purrr::map(\(df) tidyr::unnest(df, c(id, type, score))) |>
      purrr::list_rbind(),
    measures[c("cost", "ia")]  |>
      purrr::map(\(df) tidyr::unnest(df, c(id, score))) |>
      purrr::list_rbind() |>
      dplyr::mutate(type = NA_character_)) |>
        dplyr::mutate(score = as.double(score)) |>
        tidyr::nest(
          .by = c(year, npi, participation_option), .key = "measures")

  statuses <- dplyr::select(
    results, year, npi, participation_option,
    dplyr::matches("opted_into_mips|ia_credit|non_reporting|_status|_reweighting_", perl = TRUE)) |>
    tidyr::pivot_longer(
      cols          = !c(year, npi, participation_option),
      names_to      = "category",
      values_to     = "status") |>
    tidyr::nest(.by = c(year, npi, participation_option), .key = "statuses")

  joinby <- dplyr::join_by(year, npi, participation_option)

  results <- dplyr::left_join(
        dplyr::select(results |>
                        dplyr::tibble(),
          !dplyr::matches(
            "opted_into_mips|ia_credit|non_reporting|_measure_|_status|_reweighting_",
            perl = TRUE)), measures, joinby) |>
        dplyr::left_join(statuses, joinby) |>
        dplyr::mutate(grpid = dplyr::row_number(), .by = year)

      if (eligibility) {
        return(
          dplyr::left_join(
            results,
            quality_eligibility(
              year = year,
              npi = c(uniq(results$npi)),
              tidy = FALSE),
            dplyr::join_by(year, npi)
            )
          )
      }
  results
}


# c(
#   "year",
#   "npi",
#   "provider_key",
#   "state" = "practice_state_or_us_territory",
#   "practice_size",
#   "clinician_type",
#   "clinician_specialty",
#   "years_in_medicare",
#   "non_reporting",
#   "participation_option",
#   "medicare_patients",
#   "allowed_charges",
#   "services",
#   "opted_into_mips",
#   "small_practice_status",
#   "rural_status",
#   "cehrt_id",
#   "health_professional_shortage_area_status",
#   "ambulatory_surgical_center_based_status",
#   "hospital_based_status",
#   "non_patient_facing_status",
#   "facility_based_status",
#   "dual_eligibility_ratio",
#   "safety_net_status",
#   "extreme_uncontrollable_circumstance_euc",
#   "final_score",
#   "payment_adjustment_percentage",
#   "complex_patient_bonus",
#   "quality_reweighting_euc",
#   "quality_category_score",
#   "quality_improvement_score",
#   "small_practice_bonus",
#
#   "quality_measure_id_1",
#   "quality_measure_collection_type_1",
#   "quality_measure_score_1",
#   "quality_measure_id_2",
#   "quality_measure_collection_type_2",
#   "quality_measure_score_2",
#   "quality_measure_id_3",
#   "quality_measure_collection_type_3",
#   "quality_measure_score_3",
#   "quality_measure_id_4",
#   "quality_measure_collection_type_4",
#   "quality_measure_score_4",
#   "quality_measure_id_5",
#   "quality_measure_collection_type_5",
#   "quality_measure_score_5",
#   "quality_measure_id_6",
#   "quality_measure_collection_type_6",
#   "quality_measure_score_6",
#   "quality_measure_id_7",
#   "quality_measure_collection_type_7",
#   "quality_measure_score_7",
#   "quality_measure_id_8",
#   "quality_measure_collection_type_8",
#   "quality_measure_score_8",
#   "quality_measure_id_9",
#   "quality_measure_collection_type_9",
#   "quality_measure_score_9",
#   "quality_measure_id_10",
#   "quality_measure_collection_type_10",
#   "quality_measure_score_10",
#   "quality_measure_id_11",
#   "quality_measure_collection_type_11",
#   "quality_measure_score_11",
#   "quality_measure_id_12",
#   "quality_measure_collection_type_12",
#   "quality_measure_score_12",
#
#   "promoting_interoperability_pi_category_score",
#   "pi_reweighting_euc",
#   "pi_reweighting_hardship_exception",
#   "pi_reweighting_special_status_or_clinician_type",
#   "pi_measure_id_1",
#   "pi_measure_type_1",
#   "pi_measure_score_1",
#   "pi_measure_id_2",
#   "pi_measure_type_2",
#   "pi_measure_score_2",
#   "pi_measure_id_3",
#   "pi_measure_type_3",
#   "pi_measure_score_3",
#   "pi_measure_id_4",
#   "pi_measure_type_4",
#   "pi_measure_score_4",
#   "pi_measure_id_5",
#   "pi_measure_type_5",
#   "pi_measure_score_5",
#   "pi_measure_id_6",
#   "pi_measure_type_6",
#   "pi_measure_score_6",
#   "pi_measure_id_7",
#   "pi_measure_type_7",
#   "pi_measure_score_7",
#   "pi_measure_id_8",
#   "pi_measure_type_8",
#   "pi_measure_score_8",
#   "pi_measure_id_9",
#   "pi_measure_type_9",
#   "pi_measure_score_9",
#   "pi_measure_id_10",
#   "pi_measure_type_10",
#   "pi_measure_score_10",
#   "pi_measure_id_11",
#   "pi_measure_type_11",
#   "pi_measure_score_11",
#
#   "improvement_activities_ia_category_score",
#   "ia_reweighting_euc",
#   "ia_credit",
#   "ia_measure_id_1",
#   "ia_measure_score_1",
#   "ia_measure_id_2",
#   "ia_measure_score_2",
#   "ia_measure_id_3",
#   "ia_measure_score_3",
#   "ia_measure_id_4",
#   "ia_measure_score_4",
#
#   "cost_category_score",
#   "cost_reweighting_euc",
#   "cost_measure_id_1",
#   "cost_measure_achievement_points_1",
#   "cost_measure_id_2",
#   "cost_measure_achievement_points_2",
#   "cost_measure_id_3",
#   "cost_measure_achievement_points_3",
#   "cost_measure_id_4",
#   "cost_measure_achievement_points_4",
#   "cost_measure_id_5",
#   "cost_measure_achievement_points_5",
#   "cost_measure_id_6",
#   "cost_measure_achievement_points_6",
#   "cost_measure_id_7",
#   "cost_measure_achievement_points_7",
#   "cost_measure_id_8",
#   "cost_measure_achievement_points_8",
#   "cost_measure_id_9",
#   "cost_measure_achievement_points_9",
#   "cost_measure_id_10",
#   "cost_measure_achievement_points_10",
#   "cost_measure_id_11",
#   "cost_measure_achievement_points_11",
#   "cost_measure_id_12",
#   "cost_measure_achievement_points_12",
#   "cost_measure_id_13",
#   "cost_measure_achievement_points_13",
#   "cost_measure_id_14",
#   "cost_measure_achievement_points_14",
#   "cost_measure_id_15",
#   "cost_measure_achievement_points_15",
#   "cost_measure_id_16",
#   "cost_measure_achievement_points_16",
#   "cost_measure_id_17",
#   "cost_measure_achievement_points_17",
#   "cost_measure_id_18",
#   "cost_measure_achievement_points_18",
#   "cost_measure_id_19",
#   "cost_measure_achievement_points_19",
#   "cost_measure_id_20",
#   "cost_measure_achievement_points_20",
#   "cost_measure_id_21",
#   "cost_measure_achievement_points_21",
#   "cost_measure_id_22",
#   "cost_measure_achievement_points_22",
#   "cost_measure_id_23",
#   "cost_measure_achievement_points_23",
#   "cost_measure_id_24",
#   "cost_measure_achievement_points_24"
# )
#
# `%s+%` <- stringi::`%s+%`
#
# c("quality_measure_id_", "quality_measure_score_", "quality_measure_collection_type_") %s+% rep(1:12, each = 3)
# c("pi_measure_id_", "pi_measure_type_", "pi_measure_score_") %s+% rep(1:11, each = 3)
# c("ia_measure_id_", "ia_measure_score_") %s+% rep(1:4, each = 2)
# c("cost_measure_id_", "cost_measure_achievement_points_") %s+% rep(1:24, each = 2)
