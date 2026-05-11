#' @examplesIf interactive()
#' # Artic Envestigations Program Laboratory, Anchorage, AK
#' laboratories(clia = "02D0873639")
#'
#' # Dengue Laboratory, San Juan, PR
#' laboratories(clia = "40D0869394")
#'
#' # CDC/CGH/DGHA International Laboratory, Atlanta, GA
#' laboratories(clia = "11D1061576")
#'
#' # Infectious Diseases Laboratory, Atlanta, GA
#' laboratories(clia = "11D0668319")
#'
#' # National Center for Environmental Health, Division of Laboratory Science, Atlanta, GA
#' laboratories(clia = "11D0668290")
#'
#' # Vector-Borne Diseases Laboratory, Fort Collins, CO
#' laboratories(clia = "06D0880233")
#'
#' # Wiregrass Georgia Tech College Student Health Center, Valdosta, GA
#' laboratories(clia = "11D2306220")
#'
#' laboratories(clia = "11D0265516")
#'
#' laboratories(certificate = "ppm", city = "Valdosta", state = "GA", active = TRUE)
#'
#' @autoglobal
#'
#' @export
laboratories <- function(
  name = NULL,
  clia = NULL,
  certificate = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  active = FALSE,
  tidy = TRUE,
  na.rm = TRUE,
  pivot = TRUE,
  ...
) {
  if (!is.null(certificate)) {
    rlang::arg_match(
      certificate,
      c("waiver", "compliance", "accreditation", "ppm", "registration")
    )
    certificate <- cert(certificate)
  }

  if (isTRUE(active)) {
    active <- "00"
  } else {
    active <- NULL
  }

  args <- dplyr::tribble(
    ~param           , ~arg        ,
    "FAC_NAME"       , name        ,
    "PRVDR_NUM"      , clia        ,
    "CRTFCT_TYPE_CD" , certificate ,
    "CITY_NAME"      , city        ,
    "STATE_CD"       , state       ,
    "ZIP_CD"         , zip         ,
    "PGM_TRMNTN_CD"  , active
  )

  response <- httr2::request(build_url("lab", args)) |>
    httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {
    if (active == "00") {
      active <- TRUE
    }
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    # results <- tidyup(
    #   results,
    #   dtype = 'ymd',
    #   dt = '_dt',
    #   yn = '_sw',
    #   int = 'drctly_afltd',
    #   zip = 'zip_cd'
    # ) |>
    #   combine(address, c('st_adr', 'addtnl_st_adr')) |>
    #   combine(provider_name, c('fac_name', 'addtnl_fac_name')) |>
    #   dplyr::mutate(
    #     pgm_trmntn_cd = fct_term(pgm_trmntn_cd),
    #     crtfctn_actn_type_cd = fct_toa(crtfctn_actn_type_cd),
    #     cmplnc_stus_cd = fct_stat(cmplnc_stus_cd),
    #     rgn_cd = fct_region(rgn_cd),
    #     gnrl_cntl_type_cd = fct_owner(gnrl_cntl_type_cd),
    #     crtfct_type_cd = fct_app(crtfct_type_cd),
    #     gnrl_fac_type_cd = fct_facility(gnrl_fac_type_cd),
    #     current_clia_lab_clsfctn_cd = fct_lab(current_clia_lab_clsfctn_cd),
    #     prvdr_ctgry_cd = fct_lab(prvdr_ctgry_cd),
    #     prvdr_ctgry_sbtyp_cd = fct_lab(prvdr_ctgry_sbtyp_cd),
    #     # state_cd                    = fct_stabb(state_cd),
    #     duration = duration_vec(trmntn_exprtn_dt),
    #     expired = dplyr::if_else(duration < 0, TRUE, FALSE),
    #     duration = NULL
    #   ) |>
    #   cols_lab()

    if (pivot) {
      # res <- dplyr::select(results, -dplyr::starts_with("acr_"))
      #
      # acr <- dplyr::select(results, clia_number, dplyr::starts_with("acr_")) |>
      #   dplyr::select(
      #     clia_number,
      #     a2la = acr_a2la,
      #     a2la_ind = acr_a2la_ind,
      #     a2la_date = acr_a2la_date,
      #     aabb = acr_aabb,
      #     aabb_ind = acr_aabb_ind,
      #     aabb_date = acr_aabb_date,
      #     aoa = acr_aoa,
      #     aoa_ind = acr_aoa_ind,
      #     aoa_date = acr_aoa_date,
      #     ashi = acr_ashi,
      #     ashi_ind = acr_ashi_ind,
      #     ashi_date = acr_ashi_date,
      #     cap = acr_cap,
      #     cap_ind = acr_cap_ind,
      #     cap_date = acr_cap_date,
      #     cola = acr_cola,
      #     cola_ind = acr_cola_ind,
      #     cola_date = acr_cola_date,
      #     jcaho = acr_jcaho,
      #     jcaho_ind = acr_jcaho_ind,
      #     jcaho_date = acr_jcaho_date
      #   )
      #
      # org <- acr |>
      #   dplyr::select(clia_number, a2la, aabb, aoa, ashi, cap, cola, jcaho) |>
      #   tidyr::pivot_longer(
      #     cols = !clia_number,
      #     names_to = "organization",
      #     values_to = "accredited"
      #   ) |>
      #   dplyr::mutate(
      #     accredited = dplyr::if_else(accredited == "X", TRUE, FALSE)
      #   )
      #
      # dt <- acr |>
      #   dplyr::select(clia_number, dplyr::ends_with("_date")) |>
      #   tidyr::pivot_longer(
      #     cols = !clia_number,
      #     names_to = "organization",
      #     values_to = "confirmed_date"
      #   ) |>
      #   dplyr::mutate(organization = stringr::str_remove(organization, "_date"))
      #
      # ind <- acr |>
      #   dplyr::select(clia_number, dplyr::ends_with("_ind")) |>
      #   tidyr::pivot_longer(
      #     cols = !clia_number,
      #     names_to = "organization",
      #     values_to = "confirmed"
      #   ) |>
      #   dplyr::mutate(organization = stringr::str_remove(organization, "_ind"))
      #
      # results <- dplyr::inner_join(
      #   org,
      #   ind,
      #   by = dplyr::join_by(clia_number, organization)
      # ) |>
      #   dplyr::inner_join(dt, by = dplyr::join_by(clia_number, organization)) |>
      #   dplyr::filter(accredited == TRUE) |>
      #   dplyr::right_join(res, by = dplyr::join_by(clia_number)) |>
      #   dplyr::mutate(organization = stringr::str_to_upper(organization)) |>
      #   dplyr::relocate(
      #     c(organization, accredited, confirmed, confirmed_date),
      #     .after = type_of_action
      #   ) |>
      #   dplyr::select(-dplyr::starts_with("affiliated_"))
      #
      # aff <- dplyr::select(
      #   res,
      #   clia_number,
      #   dplyr::starts_with("affiliated_")
      # ) |>
      #   dplyr::distinct() |>
      #   tidyr::pivot_longer(
      #     !clia_number,
      #     names_to = "affiliated_provider",
      #     values_to = "affiliated_provider_clia",
      #     values_drop_na = TRUE
      #   )
      #
      # aff$affiliated_provider <- NULL
      #
      # results <- dplyr::left_join(
      #   results,
      #   aff,
      #   by = dplyr::join_by(clia_number)
      # )
    }
  }
  return(results)
}

#' @autoglobal
#' @noRd
fct_lab <- function(x) {
  factor(
    x,
    levels = c("00", "22", "01", "05", "10"),
    labels = c(
      "CLIA Lab",
      "CLIA Lab",
      "CLIA88 Lab",
      "CLIA Exempt Lab",
      "CLIA VA Lab"
    )
  )
}
