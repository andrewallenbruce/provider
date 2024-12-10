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
                         eligibility = FALSE,
                         ...) {


  stopifnot(not_null(year), is.character(year))
  year <- match.arg(year, as.character(qpp_years()))

  args <- rlang::list2(if (null(npi)) NULL else validate_npi(npi), state, specialty, type) |>
    rlang::set_names(c("npi", "practice state or us territory", "clinician specialty", "participation type"))

  # id <- "b3438273-b4a6-44ca-8fb2-9e6026b74642"

  id <- api_years("qpp") |> data.table::as.data.table()
    id[year == 2022]

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

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

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (!tidy) results <- df2chr(results)

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
                             "extreme_hardship_cost")) |>
      cols_qpp("tidy") # FIXME |>
    # dplyr::mutate(participation_type = fct_part(participation_type),
    #               state = fct_stabb(state))

    if (nest) {
      pcol <- list(q = c('quality_measure_id_', 'quality_measure_score_') %s+% rep(1:10, each = 2),
                   p = c('pi_measure_id_', 'pi_measure_score_') %s+% rep(1:11, each = 2),
                   i = c('ia_measure_id_', 'ia_measure_score_') %s+% rep(1:4, each = 2),
                   c = c('cost_measure_id_', 'cost_measure_score_') %s+% rep(1:2, each = 2))

      pcol <- unlist(pcol, use.names = FALSE)

      top <- results |>
        dplyr::select(-c(dplyr::contains("measure_"),
                         dplyr::contains("ind_"))) |>
        dplyr::arrange(year, participation_type)

      measures <- dplyr::select(
        results,
        year,
        npi,
        participation_type,
        dplyr::any_of(pcol)) |>
        dplyr::arrange(year, participation_type) |>
        tidyr::pivot_longer(
          cols          = dplyr::any_of(pcol),
          names_to      = c("category", "x", "set", "cat_id"),
          names_pattern = "(.*)_(.*)_(.*)_(.)",
          values_to     = "val") |>
        dplyr::filter(!is.na(val)) |>
        dplyr::mutate(x = NULL,
                      cat_id = NULL) |>
        tidyr::pivot_wider(names_from = set,
                           values_from = val,
                           values_fn = list) |>
        tidyr::unnest(c(id, score)) |>
        dplyr::mutate(score = as.double(score),
                      category = fct_measure(category)) |>
        dplyr::rename(measure_id = id) |>
        tidyr::nest(.by = c(year, npi, participation_type),
                    .key  = "qpp_measures")

      statuses <- dplyr::select(results,
                                year,
                                npi,
                                participation_type,
                                dplyr::contains("ind_")) |>
        dplyr::arrange(year, participation_type) |>
        tidyr::pivot_longer(
          cols          = dplyr::starts_with("ind_"),
          names_to      = c("x", "qualified"),
          names_pattern = "(...)_(.*)",
          values_to     = "status") |>
        dplyr::mutate(x = NULL) |>
        dplyr::filter(!is.na(status) & status != FALSE) |>
        dplyr::mutate(qualified = fct_status(qualified),
                      status = NULL) |>
        tidyr::nest(.by = c(year, npi, participation_type),
                    .key = "qpp_status")

      by <- dplyr::join_by(year, npi, participation_type)

      results <- dplyr::left_join(top, measures, by) |>
        dplyr::left_join(statuses, by) |>
        cols_qpp("nest") |>
        dplyr::group_by(year) |>
        dplyr::mutate(org_id = dplyr::row_number(), .before = org_size) |>
        dplyr::ungroup()

      if (eligibility) {
        by = dplyr::join_by(year, npi, org_id)
        npi  <- unique(results$npi)
        elig <- quality_eligibility(year = year, npi = c(npi))
        results <- dplyr::left_join(results, elig, by) |>
          cols_qcomb()
      }
    }
  }
  return(results)
}
