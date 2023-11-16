#' Compare Provider Performance
#'
#' @description
#'
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
#' @name compare
NULL

#' @param df < *tbl_df* > // **required**
#'
#' [tibble()] returned from `utilization(type = "service")`
#'
#' @examplesIf interactive()
#'
#' compare_hcpcs(utilization(year = 2018, type = "service", npi = 1023076643))
#'
#' map_dfr(util_years(), ~utilization(year = .x,
#'                                    npi = 1023076643,
#'                                    type = "service")) |>
#' compare_hcpcs()
#'
#' @describeIn compare performance detail
#'
#' @autoglobal
#' @export
compare_hcpcs <- function(df) {

  if (!inherits(df, "utilization_service")) {
    cli::cli_abort(c(
      "{.var df} must be of class {.cls 'utilization_service'}.",
      "x" = "{.var df} is of class {.cls {class(df)}}."))
  }

  x <- df |>
    dplyr::select(year, state, hcpcs, pos) |>
    dplyr::mutate(pos = as.character(pos),
                  pos = dplyr::if_else(pos == "Facility", "F", "O"))

  x$type <- "geography"

  state <- furrr::future_pmap_dfr(x, utilization, .options = furrr::furrr_options(seed = NULL))
  # state <- purrr::pmap(x, utilization) |> purrr::list_rbind()

  x$state <- "National"

  national <- furrr::future_pmap_dfr(x, utilization, .options = furrr::furrr_options(seed = NULL))
  # national <- purrr::pmap(x, utilization) |> purrr::list_rbind()

  vctrs::vec_rbind(
    hcpcs_cols(df),
    hcpcs_cols(state),
    hcpcs_cols(national)) |>
    dplyr::mutate(level = fct_level(level)) |>
    dplyr::relocate(providers, .before = beneficiaries)
}

#' @param df data frame
#' @autoglobal
#' @noRd
hcpcs_cols <- function(df) {

  cols <- c('year',
            'level',
            'hcpcs',
            'pos',
            'category',
            'subcategory',
            'family',
            'procedure',
            'providers'     ='tot_provs',
            'beneficiaries' = 'tot_benes',
            'services'      = 'tot_srvcs',
            'avg_charge',
            'avg_allowed',
            'avg_payment',
            'avg_std_pymt')

  df |> dplyr::select(dplyr::any_of(cols))
}

#' @param df < *tbl_df* > // **required** [tibble()] returned from `utilization(type = "provider")`
#'
#' @param pivot < *boolean* > // __default:__ `FALSE` Pivot output
#'
#' @describeIn compare chronic condition prevalence
#'
#' @examplesIf interactive()
#'
#' compare_conditions(utilization(year = 2018, type = "provider", npi = 1023076643))
#'
#' map_dfr(util_years(), ~utilization(year = .x,
#'                                    npi = 1023076643,
#'                                    type = "provider")) |>
#' compare_conditions()
#'
#' @autoglobal
#' @export
compare_conditions <- function(df, pivot = FALSE) {

  if (!inherits(df, "utilization_provider")) {
    cli::cli_abort(c(
      "{.var df} must be of class {.cls 'utilization_provider'}.",
      "x" = "{.var df} is of class {.cls {class(df)}}."))
  }

  x <- dplyr::select(df, year, sublevel = state, conditions) |>
    tidyr::unnest(conditions) |>
    dplyr::mutate(hcc_risk_avg = NULL,
                  level = "Provider", .after = year) |>
    cnd_rename() |>
    tidyr::pivot_longer(cols = !c(year, level, sublevel),
                        names_to = "condition",
                        values_to = "prevalence") |>
    dplyr::filter(!is.na(prevalence), year %in% cc_years())

  y <- dplyr::select(x, year, condition, sublevel) |>
    dplyr::mutate(set     = "Specific",
                  demo    = "All",
                  subdemo = "All",
                  age     = "All")

  state <- furrr::future_pmap_dfr(y, conditions, .options = furrr::furrr_options(seed = NULL))
  state <- dplyr::select(state, year, level, condition, prevalence)
  # state <- purrr::pmap(y, conditions) |>
  #   purrr::list_rbind() |>
  #   dplyr::select(year, level, condition, prevalence)

  y$sublevel <- "National"

  national <- furrr::future_pmap_dfr(y, conditions, .options = furrr::furrr_options(seed = NULL))
  national <- dplyr::select(national, year, level, condition, prevalence)
  # national <- purrr::pmap(y, conditions) |>
  #   purrr::list_rbind() |>
  #   dplyr::select(year, level, condition, prevalence)

  x$sublevel <- NULL

  results <- vctrs::vec_rbind(x, state, national) |>
    dplyr::mutate(level = fct_level(level)) |>
    dplyr::arrange(year, condition)

  if (pivot) {
    results <- tidyr::pivot_wider(results,
                                  names_from = c(year, level),
                                  values_from = prevalence)
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cnd_rename <- function(df) {
  cols <- c('Atrial Fibrillation'                         = 'cc_af',
            "Alzheimer's Disease/Dementia"                = 'cc_alz',
            'Asthma'                                      = 'cc_asth',
            'Cancer'                                      = 'cc_canc',
            'Heart Failure'                               = 'cc_chf',
            'Chronic Kidney Disease'                      = 'cc_ckd',
            'COPD'                                        = 'cc_copd',
            'Depression'                                  = 'cc_dep',
            'Diabetes'                                    = 'cc_diab',
            'Hyperlipidemia'                              = 'cc_hplip',
            'Hypertension'                                = 'cc_hpten',
            'Ischemic Heart Disease'                      = 'cc_ihd',
            'Osteoporosis'                                = 'cc_opo',
            'Arthritis'                                   = 'cc_raoa',
            'Schizophrenia and Other Psychotic Disorders' = 'cc_sz',
            'Stroke'                                      = 'cc_strk')

  df |> dplyr::rename(dplyr::any_of(cols))
}
