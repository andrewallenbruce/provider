#' Compare Yearly Provider Data To State And National Averages
#'
#' @description
#' + `compare_hcpcs()` allows the user to compare a provider's yearly HCPCS
#' utilization data to state and national averages
#'
#' + `compare_conditions()` allows the user to compare the average yearly
#' prevalence of chronic conditions among a provider's patient mix to state and
#' national averages
#'
#' @return A [tibble][tibble::tibble-package] containing:
#' + `compare_hcpcs()`
#' + `compare_conditions()`
#' @examplesIf interactive()
#' compare_hcpcs(by_service(year = 2018, npi = 1023076643))
#' compare_conditions(by_provider(year = 2018, npi = 1023076643))
#'
#' compare_hcpcs(map_dfr(prac_years(), ~by_service(year = .x, npi = 1023076643)))
#' compare_conditions(map_dfr(prac_years(), ~by_provider(year = .x, npi = 1023076643)))
#' @name compare
NULL

#' @param serv_tbl < *tbl_df* > // **required** [tibble][tibble::tibble-package] returned from [by_service()]
#' @rdname compare
#' @autoglobal
#' @export
compare_hcpcs <- function(serv_tbl) {

  x <- serv_tbl |>
    dplyr::select(year, state, hcpcs_code, pos) |>
    dplyr::rowwise() |>
    dplyr::mutate(state = by_geography(year, state, hcpcs_code, pos),
                  national = by_geography(year, state = "National",
                                          hcpcs_code, pos), .keep = "none")

  results <- vctrs::vec_rbind(
    dplyr::rename(serv_tbl,
                  beneficiaries = tot_benes,
                  services = tot_srvcs) |>
      hcpcs_cols(),

    dplyr::mutate(x$state,
                  beneficiaries = tot_benes / tot_provs,
                  services = tot_srvcs / tot_provs) |>
      hcpcs_cols(),

    dplyr::mutate(x$national,
                  beneficiaries = tot_benes / tot_provs,
                  services = tot_srvcs / tot_provs) |>
      hcpcs_cols()) |>
    dplyr::mutate(level = forcats::fct_inorder(level))

  return(results)

}

#' @param df data frame
#' @autoglobal
#' @noRd
hcpcs_cols <- function(df) {

  cols <- c('year',
            'level',
            'hcpcs_code',
            'pos',
            'category',
            'subcategory',
            'family',
            'procedure',
            'beneficiaries',
            'services',
            'avg_charge',
            'avg_allowed',
            'avg_payment',
            'avg_std_pymt')

  df |> dplyr::select(dplyr::any_of(cols))
}

#' @param prov_tbl < *tbl_df* > // **required** [tibble][tibble::tibble-package] returned from [by_provider()]
#' @param pivot < *boolean* > // __default:__ `TRUE` Pivot output
#' @rdname compare
#' @autoglobal
#' @export
compare_conditions <- function(prov_tbl,
                               pivot = TRUE) {

  p <- dplyr::select(prov_tbl, year, conditions) |>
    tidyr::unnest(conditions) |>
    dplyr::mutate(level = "Provider", .after = year) |>
    dplyr::rename(
      "Atrial Fibrillation"                         = cc_af,
      "Alzheimer's Disease/Dementia"                = cc_alz,
      "Asthma"                                      = cc_asth,
      "Cancer"                                      = cc_canc,
      "Heart Failure"                               = cc_chf,
      "Chronic Kidney Disease"                      = cc_ckd,
      "COPD"                                        = cc_copd,
      "Depression"                                  = cc_dep,
      "Diabetes"                                    = cc_diab,
      "Hyperlipidemia"                              = cc_hplip,
      "Hypertension"                                = cc_hpten,
      "Ischemic Heart Disease"                      = cc_ihd,
      "Osteoporosis"                                = cc_opo,
      "Arthritis"                                   = cc_raoa,
      "Schizophrenia and Other Psychotic Disorders" = cc_sz,
      "Stroke"                                      = cc_strk) |>
    tidyr::pivot_longer(cols = !c(year, level),
                 names_to = "condition",
                 values_to = "prevalence") |>
    dplyr::filter(!is.na(prevalence),
           year %in% cc_years())

  n <- dplyr::select(p, year, condition) |>
    dplyr::rowwise() |>
    dplyr::mutate(national = conditions(year,
                                        condition,
                                        sublevel = "national",
                                        set = "specific",
                                        demo = "all",
                                        subdemo = "all",
                                        age = "all"),
                  .keep = "none")

  s <- dplyr::left_join(dplyr::select(p, year, condition),
                        dplyr::select(prov_tbl, year, sublevel = state),
                        by = dplyr::join_by(year)) |>
    dplyr::rowwise() |>
    dplyr::mutate(statewide = conditions(year,
                                         condition,
                                         sublevel,
                                         set = "specific",
                                         demo = "all",
                                         subdemo = "all",
                                         age = "all"),
                  .keep = "none")

  results <- vctrs::vec_rbind(p,
                   dplyr::select(s$statewide,
                                 year,
                                 level,
                                 condition,
                                 prevalence),
                   dplyr::select(n$national,
                                 year,
                                 level,
                                 condition,
                                 prevalence)) |>
    dplyr::arrange(year, condition)

  if (pivot) {
    results <- tidyr::pivot_wider(results,
                                  names_from = c(year, level),
                                  values_from = prevalence)
  }
  return(results)
}
