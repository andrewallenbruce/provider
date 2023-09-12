#' Compare Yearly HCPCS Utilization Data
#'
#' @description
#' `compare_hcpcs()` allows you to compare yearly HCPCS utilization by provider,
#' state and national averages
#'
#' @param df data frame returned by `by_service()`
#' @return A [tibble][tibble::tibble-package] containing the results.
#'
#' @examplesIf interactive()
#' prac_years() |>
#' map(\(x) by_service(year = x, npi = 1023076643)) |>
#' list_rbind() |>
#' compare_hcpcs()
#' @autoglobal
#' @export
compare_hcpcs <- function(df) {

  g <- df |>
    dplyr::select(year, state, hcpcs_code, pos) |>
    dplyr::rowwise() |>
    dplyr::mutate(state = by_geography(year, state, hcpcs_code, pos),
                  national = by_geography(year,
                                          state = "National",
                                          hcpcs_code,
                                          pos),
                  .keep = "none")

  results <- vctrs::vec_rbind(
    dplyr::select(df,
                  year,
                  level,
                  hcpcs_code,
                  pos,
                  beneficiaries = tot_benes,
                  services = tot_srvcs,
                  dplyr::contains("avg_")),
    dplyr::mutate(g$state,
                  beneficiaries = tot_benes / tot_provs,
                  services = tot_srvcs / tot_provs) |>
      dplyr::select(year,
                    level,
                    hcpcs_code,
                    pos,
                    beneficiaries,
                    services,
                    dplyr::contains("avg_")),
    dplyr::mutate(g$national,
                  beneficiaries = tot_benes / tot_provs,
                  services = tot_srvcs / tot_provs) |>
      dplyr::select(year,
                    level,
                    hcpcs_code,
                    pos,
                    beneficiaries,
                    services,
                    dplyr::contains("avg_")))

  return(results)

}

#' Compare Yearly Chronic Condition Prevalence Data
#'
#' @description
#' `compare_conditions()` allows you to compare yearly chronic condition
#' prevalence by provider, state and national averages
#'
#' @param df data frame returned by `by_provider()`
#' @return A [tibble][tibble::tibble-package] containing the results.
#'
#' @examplesIf interactive()
#' prac_years() |>
#' map(\(x) by_provider(year = x, npi = 1023076643)) |>
#' list_rbind() |>
#' compare_conditions()
#' @autoglobal
#' @export

compare_conditions <- function(df) {

  p <- dplyr::select(df, year, conditions) |>
    tidyr::unnest(conditions) |>
    dplyr::mutate(level = "Provider", .after = year) |>
    dplyr::rename("Atrial Fibrillation" = cc_af,
           "Alzheimer's Disease/Dementia" = cc_alz,
           "Asthma" = cc_asth,
           "Cancer" = cc_canc,
           "Heart Failure" = cc_chf,
           "Chronic Kidney Disease" = cc_ckd,
           "COPD" = cc_copd,
           "Depression" = cc_dep,
           "Diabetes" = cc_diab,
           "Hyperlipidemia" = cc_hplip,
           "Hypertension" = cc_hpten,
           "Ischemic Heart Disease" = cc_ihd,
           "Osteoporosis" = cc_opo,
           "Arthritis" = cc_raoa,
           "Schizophrenia and Other Psychotic Disorders" = cc_sz,
           "Stroke" = cc_strk) |>
    tidyr::pivot_longer(cols = !c(year, level),
                 names_to = "condition",
                 values_to = "prevalence") |>
    dplyr::filter(!is.na(prevalence),
           year %in% cc_years())

  n <- dplyr::select(p, year, condition) |>
    dplyr::rowwise() |>
    dplyr::mutate(national = cc_specific(year,
                                         condition,
                                         sublevel = "National",
                                         demographic = "All",
                                         subdemo = "All",
                                         age_group = "All"), .keep = "none")

  s <- dplyr::left_join(dplyr::select(p, year, condition),
                        dplyr::select(df, year, sublevel = state),
                        by = dplyr::join_by(year)) |>
    dplyr::rowwise() |>
    dplyr::mutate(statewide = cc_specific(year,
                                          condition,
                                          sublevel,
                                          demographic = "All",
                                          subdemo = "All",
                                          age_group = "All"), .keep = "none")

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

  return(results)
}
