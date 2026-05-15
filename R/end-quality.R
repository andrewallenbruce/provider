#' Quality Payment Program
#'
#' The Quality Payment Program (QPP) Experience dataset provides participation
#' and performance information in the Merit-based Incentive Payment System
#' (MIPS) during each performance year. They cover eligibility and
#' participation, performance categories, and final score and payment
#' adjustments.
#'
#' The dataset provides additional details at the TIN/NPI level on what was
#' published in the previous performance year. You can sort the data by
#' variables like clinician type, practice size, scores, and payment
#' adjustments.
#'
#' @param year `<int>` A vector of years from 2018 to 2025
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' quality_metrics(2018:2025)
#'
#' @export
quality_metrics <- function(year) {
  check_numeric(year)

  x <- purrr::map(
    year,
    function(yr) {
      httr2::request("https://qpp.cms.gov/api/eligibility/stats") |>
        httr2::req_url_query(year = yr) |>
        httr2::req_perform() |>
        httr2::resp_body_json(simplifyVector = TRUE, check_type = FALSE) |>
        _$data
    }
  ) |>
    set_names(year) |>
    collapse::unlist2d(idcols = c("year", "category", "metric")) |>
    collapse::rnm(c("V1" = "mean"), .nse = FALSE) |>
    data_frame() |>
    rc_integer("year")

  collapse::recode_char(
    x,
    individual = "ind",
    dualEligibilityAverage = "Dual Eligible Ratio",
    hccRiskScoreAverage = "HCC Risk Score",
    set = TRUE
  )
  return(x)
}


# @examplesIf FALSE
# qpp_metrics <- quality_metrics(year = 2018:2025)
#
# qpp_eligible <- quality_eligibility(
#   year = 2018:2024,
#   npi = c(1144544834, 1043477615, 1932365699, 1225701881))
#
# qpp_experience <- build(
#   endpoint("qppe"),
#   query(npi = any_of(1144544834, 1043477615, 1932365699, 1225701881)))
#
#
# qpp_exp <- qpp_experience@string |>
#   providertwo:::gremove("/stats") |>
#   providertwo:::greplace("size=1", "size=5000") |>
#   providertwo:::map_perform_parallel() |>
#   providertwo:::set_clean(qpp_experience@year) |>
#   purrr::list_rbind(names_to = "prog_year") |>
#   providertwo:::map_na_if() |>
#   fastplyr::as_tbl()
#
# list(
#   experience  = providertwo:::set_clean(qpp_exp, names(qpp_exp)),
#   eligibility = qpp_eligible,
#   metrics     = qpp_metrics)
# check_number_whole(year, min = 2018, max = next_year())

#' @noRd
quality_eligibility <- function(year, npi) {
  check_required(year)
  check_required(npi)
  check_number_whole(year, min = 2018)

  url <- glue::as_glue("https://qpp.cms.gov/api/eligibility/npis/") +
    glue::glue_collapse(npi, sep = ",") +
    glue::glue("?year={year}")

  res <- purrr::map(url, function(x) {
    httr2::request(x) |>
      httr2::req_headers(Accept = "application/vnd.qpp.cms.gov.v6+json") |>
      httr2::req_error(body = \(resp) {
        httr2::resp_body_json(resp)$error$message
      }) |>
      httr2::req_perform() |>
      httr2::resp_body_json(simplifyVector = TRUE, check_type = FALSE) |>
      collapse::get_elem("data")
  }) |>
    rlang::set_names(year) |>
    purrr::list_rbind(names_to = "prog_year")

  if (rlang::has_name(res, "error")) {
    res$error <- NULL
  }

  res |>
    collapse::mtt(
      prog_year = as.integer(prog_year),
      # nationalProviderIdentifierType = entity_(nationalProviderIdentifierType),
      # firstApprovedDate = as_date(firstApprovedDate),
      specialty = as.character(glue::glue(
        "{res$specialty$specialtyDescription} [D] {res$specialty$typeDescription} [T] {res$specialty$categoryReference} [C]"
      ))
    ) |>
    collapse::rnm(
      firstName = "first_name",
      middleName = "middle_name",
      lastName = "last_name",
      nationalProviderIdentifierType = "entity",
      newlyEnrolled = "is_new",
      firstApprovedDate = "date_enrolled",
      isMaqi = "is_maqi",
      # qpStatus                       = "qp_status",
      # qpScoreType                    = "qp_score_type",
      # amsMipsEligibleClinician       = "ams_mips_elig",
      organizations = "ORGS"
    ) |>
    collapse::colorderv(c(
      "prog_year",
      "npi",
      "entity",
      "last_name",
      "first_name",
      "middle_name",
      "specialty",
      "date_enrolled",
      "is_new",
      "is_maqi"
    )) |>
    collapse::roworderv(c("npi", "prog_year"), decreasing = TRUE) |>
    data_frame()
}

# QPP Submissions API
# https://preview.qpp.cms.gov/api/submissions/public/docs/
# https://data.cms.gov/resources/quality-payment-program-experience-data-dictionary
#
# "?count=true&results=true&offset=0&limit=1"
#
# === `quality_totals` ===
#    year   nrows ncols
#   <int>   <int> <int>
# 1  2023  524998   204
# 2  2022  624200   165
# 3  2021  698730    92
# 4  2020  921517    92
# 5  2019  944376    92
# 6  2018  881959    92
# 7  2017 1054657    92

# map_perform_parallel <- function(x, query = NULL) {
#   purrr::map(x, httr2::request) |>
#     httr2::req_perform_parallel(on_error = "continue") |>
#     httr2::resps_successes() |>
#     purrr::map(function(x) parse_string(x, query = query))
# }
#
# temporal <- function(x) {
#   list(
#     fields = paste0(x$identifier, "?offset=0&size=10") |>
#       map_perform_parallel() |>
#       rlang::set_names(x$year),
#     total = paste0(x$identifier, "/stats?") |>
#       map_perform_parallel(query = "found_rows") |>
#       rlang::set_names(x$year)
#   )
# }
#
# api <- api_medicare2()
#
# api$current |>
#   fastplyr::as_tbl() |>
#   collapse::sbt(title == "Quality Payment Program Experience")
#
# qpp <- api$temporal$`Quality Payment Program Experience`
#
# ex <- paste0(qpp$identifier, "?offset=0&size=5") |>
#   map_perform_parallel() |>
#   rlang::set_names(qpp$year) |>
#   purrr::map(replace_nz) |>
#   purrr::map(tibble::as_tibble)
#
# ex_17_21 <- ex[names(ex) %in% 2017:2021] |> rowbind2(nm = "year")
# ex_22_23 <- ex[!names(ex) %in% 2017:2021]
#
# x <- temporal(qpp)
# quality_totals <- fastplyr::new_tbl(
#   year = as.integer(names(x$total)),
#   nrows = as.integer(x$total),
#   ncols = as.integer(collapse::vlengths(x$fields, use.names = FALSE))
# )
#
# x$fields$`2017`[c(2:27, 48, 76, 87)]
# x$fields$`2018`[c(2:27, 48, 76, 87)]
# x$fields$`2019`[c(2:27, 48, 76, 87)]
# x$fields$`2020`[c(2:27, 48, 76, 87)]
# x$fields$`2021`[c(2:27, 48, 76, 87)]
# x$fields$`2022`[c(2:26, 28:30, 67, 105, 116)]

# 2017 - 2021
qpp_2017_2021 <- c(
  year = "year",
  `practice state or us territory` = "state",
  `practice size` = "psize",
  `clinician specialty` = "specialty",
  `years in medicare` = "years",
  npi = "npi",
  engaged = "eng_ind",
  `participation type` = "ptype",
  `medicare patients` = "patients",
  `allowed charges` = "charges",
  services = "services",
  `opted into mips` = "mip_ind",
  `small practitioner` = "sml_ind",
  `rural clinician` = "rur_ind",
  `hpsa clinician` = "hpsa_ind",
  `ambulatory surgical center` = "asc_ind",
  `hospital-based clinician` = "hsp_ind",
  `non-patient facing` = "non_ind",
  `facility-based` = "fac_ind",
  `extreme hardship` = "extr_ind",
  `final score` = "final_score",
  `payment adjustment percentage` = "adj_pct",
  `complex patient bonus` = "cplx_ind",
  `extreme hardship quality` = "qa_extr",
  `quality category score` = "qa_score",
  `quality improvement bonus` = "qi_bonus",
  `quality bonus` = "qa_bonus",
  `promoting interoperability (pi) category score` = "pi_score",
  `extreme hardship pi` = "pi_extr",
  `pi hardship` = "pi_hard",
  `pi reweighting` = "pi_rw",
  `pi bonus` = "pi_bonus",
  `ia score` = "ia_score",
  `extreme hardship ia` = "ia_extr",
  `ia study` = "ia_study",
  `cost score` = "cs_score",
  `extreme hardship cost` = "cs_extr"
)

# 2022
qpp_2022 <- c(
  `practice state or us territory` = "state",
  `practice size` = "psize",
  `clinician type` = "ctype",
  `clinician specialty` = "specialty",
  `years in medicare` = "years",
  npi = "npi",
  `non-reporting` = "nreport",
  `participation option` = "ptype",
  `medicare patients` = "patients",
  `allowed charges` = "charges",
  services = "services",
  `opted into mips` = "mip_ind",
  `small practice status` = "sml_ind",
  `rural status` = "rur_ind",
  `health professional shortage area status` = "hpsa_ind",
  `ambulatory surgical center-based status` = "asc_ind",
  `hospital-based status` = "hsp_ind",
  `non-patient facing status` = "non_ind",
  `facility-based status` = "fac_ind",
  `dual eligibility ratio` = "dual_ratio",
  `safety-net status` = "safe_ind",
  `extreme uncontrollable circumstance (euc)` = "euc_ind",
  `final score` = "final_score",
  `payment adjustment percentage` = "adj_pct",
  `complex patient bonus` = "cplx_ind",
  `quality reweighting (euc)` = "qa_rw",
  `quality category score` = "qa_score",
  `quality improvement score` = "qi_score",
  `small practice bonus` = "sml_bns",
  `promoting interoperability (pi) category score` = "pi_score",
  `pi reweighting (euc)` = "pi_rw_euc",
  `pi reweighting (hardship exception)` = "pi_rw_hs",
  `pi reweighting (special status or clinician type)` = "pi_rw_sp",
  `improvement activities (ia) category score` = "ia_score",
  `ia reweighting (euc)` = "ia_rw_euc",
  `ia credit` = "ia_credit",
  `cost category score` = "cost_score",
  `cost reweighting (euc)` = "cost_rw_euc"
)

# 2023
qpp_2023 <- c(
  `practice state or us territory` = "practice_state_or_us_territory",
  `practice size` = "practice_size",
  `clinician type` = "clinician_type",
  `clinician specialty` = "clinician_specialty",
  `years in medicare` = "years_in_medicare",
  npi = "npi",
  `non-reporting` = "non_reporting",
  `reporting option` = "reporting_option",
  `participation option` = "participation_option",
  `mips value pathway id` = "mips_value_pathway_id",
  `mips value pathway title` = "mips_value_pathway_title",
  `medicare patients` = "medicare_patients",
  `allowed charges` = "allowed_charges",
  services = "services",
  `opted into mips` = "opted_into_mips",
  `small practice status` = "small_practice_status",
  `rural status` = "rural_status",
  `health professional shortage area status` = "health_professional_shortage_area_status",
  `ambulatory surgical center-based status` = "ambulatory_surgical_center_based_status",
  `hospital-based status` = "hospital_based_status",
  `non-patient facing status` = "non_patient_facing_status",
  `facility-based status` = "facility_based_status",
  `dual eligibility ratio` = "dual_eligibility_ratio",
  `safety-net status` = "safety_net_status",
  `extreme uncontrollable circumstance (euc)` = "extreme_uncontrollable_circumstance__euc_",
  `received facility score` = "received_facility_score",
  `final score` = "final_score",
  `payment adjustment percentage` = "payment_adjustment_percentage",
  `complex patient bonus` = "complex_patient_bonus",
  `quality reweighting (euc)` = "quality_reweighting__euc_",
  `quality category score` = "quality_category_score",
  `quality category weight` = "quality_category_weight",
  `quality improvement score` = "quality_improvement_score",
  `small practice bonus` = "small_practice_bonus",
  `promoting interoperability (pi) category score` = "promoting_interoperability__pi__category_score",
  `promoting interoperability (pi) category weight` = "promoting_interoperability__pi__category_weight",
  `pi reweighting (euc)` = "pi_reweighting__euc_",
  `pi reweighting (hardship exception)` = "pi_reweighting__hardship_exception_",
  `pi reweighting (special status or clinician type)` = "pi_reweighting__special_status_or_clinician_type_",
  `improvement activities (ia) category score` = "improvement_activities__ia__category_score",
  `improvement activities (ia) category weight` = "improvement_activities__ia__category_weight",
  `ia reweighting (euc)` = "ia_reweighting__euc_",
  `ia credit` = "ia_credit",
  `cost category score` = "cost_category_score",
  `cost improvement score` = "cost_improvement_score",
  `cost category weight` = "cost_category_weight",
  `cost reweighting (euc)` = "cost_reweighting__euc_"
)
