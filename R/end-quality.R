#' @noRd
qpp_uuid <- function() {
  x <- RcppSimdJson::fload("https://data.cms.gov/data.json", "/dataset") |>
    collapse::get_elem("distribution") |>
    collapse::rowbind(fill = TRUE) |>
    collapse::qTBL()

  x <- collapse::ss(
    x,
    grepl("^Quality", x$title, perl = TRUE) &
      !cheapr::is_na(x$accessURL) &
      cheapr::is_na(x$description)
  )

  collapse::av(
    x,
    year = extract_year(x$title),
    uuid = uuid_from_url(x$accessURL),
    pos = "front"
  ) |>
    collapse::gv(c("year", "uuid", "accessURL", "resourcesAPI"))
}

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
