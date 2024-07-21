#' Compare Provider Performance
#'
#' `compare_hcpcs()` allows the user to compare a provider's yearly HCPCS
#' utilization data to state and national averages
#'
#' @param df < *tbl_df* > // **required**
#'
#' [tibble][tibble::tibble-package] returned from `utilization(type = "Service")`
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf interactive()
#' compare_hcpcs(utilization(year = 2018,
#'                           type = "Service",
#'                           npi = 1023076643))
#'
#' map_dfr(util_years(), ~utilization(year = .x,
#'                                    npi = 1023076643,
#'                                    type = "Service")) |>
#' compare_hcpcs()
#'
#' @autoglobal
#'
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

  x$type <- "Geography"

  state <- furrr::future_pmap_dfr(x,
                                  utilization,
                                  .options = furrr::furrr_options(seed = NULL))
  # state <- purrr::pmap(x, utilization) |> purrr::list_rbind()

  x$state <- "National"

  national <- furrr::future_pmap_dfr(x,
                                     utilization,
                                     .options = furrr::furrr_options(seed = NULL))
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
