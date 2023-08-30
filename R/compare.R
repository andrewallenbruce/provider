#' Compare
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
#' @param df data frame returned by `by_service()`
#' @return A [tibble][tibble::tibble-package] containing the results.
#'
#' @examplesIf interactive()
#' by_service_years() |>
#' purrr::map(\(x) by_service(year = x, npi = 1023076643)) |>
#' purrr::list_rbind() |>
#' compare_geography()
#' mutate(level = "individual")
#'
#' @autoglobal
#' @export

compare_geography <- function(df) {

  g <- df |>
    dplyr::select(year, state, hcpcs_code, pos) |>
    dplyr::rowwise() |>
    dplyr::mutate(state = by_geography(year, state, hcpcs_code, pos),
                  national = by_geography(year,
                                          state = "National",
                                          hcpcs_code,
                                          pos),
                  .keep = "none")

  results <- dplyr::bind_rows(
    dplyr::select(df,
                  year,
                  level,
                  hcpcs_code,
                  pos,
                  beneficiaries = tot_benes,
                  services = tot_srvcs,
                  dplyr::contains("avg_")),
    dplyr::mutate(g$national,
                  beneficiaries = tot_benes / tot_provs,
                  services = tot_srvcs / tot_provs,
                  level = stringr::str_to_lower(level)) |>
      dplyr::select(year,
                    level,
                    hcpcs_code,
                    pos,
                    beneficiaries,
                    services,
                    dplyr::contains("avg_")),
    dplyr::mutate(g$state,
                  beneficiaries = tot_benes / tot_provs,
                  services = tot_srvcs / tot_provs,
                  level = stringr::str_to_lower(level)) |>
      dplyr::select(year,
                    level,
                    hcpcs_code,
                    pos,
                    beneficiaries,
                    services,
                    dplyr::contains("avg_")))

  return(results)

}
