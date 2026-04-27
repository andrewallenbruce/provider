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

#' @autoglobal
#' @noRd
quality_metrics <- function(year) {
  check_required(year)
  purrr::map(year, function(y) {
    cheapr::fast_df(
      year = rep.int(as.integer(y), 4L),
      category = c(rep.int("Individual", 2L), rep.int("Group", 2L)),
      metric = rep.int(c("HCC Risk Score", "Dual Eligibility Ratio"), 2L),
      mean = httr2::request("https://qpp.cms.gov/api/eligibility/stats") |>
        httr2::req_url_query(year = y) |>
        httr2::req_perform() |>
        httr2::resp_body_json(simplifyVector = TRUE, check_type = FALSE) |>
        collapse::get_elem("data") |>
        unlist_()
    )
  }) |>
    collapse::rowbind() |>
    collapse::roworderv(c("metric", "category", "year"), decreasing = TRUE)
}

#' @autoglobal
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

# The Quality Payment Program (QPP) Experience dataset provides
# participation and performance information in the Merit-based
# Incentive Payment System (MIPS) during each performance year.
# They cover eligibility and participation, performance categories,
# and final score and payment adjustments. The dataset provides
# additional details at the TIN/NPI level on what was published in
# the previous performance year. You can sort the data by variables
# like clinician type, practice size, scores, and payment adjustments.
#
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
  `quality measure id 1` = "qim_1",
  `quality measure score 1` = "qis_1",
  `quality measure id 2` = "qim_2",
  `quality measure score 2` = "qis_2",
  `quality measure id 3` = "qim_3",
  `quality measure score 3` = "qis_3",
  `quality measure id 4` = "qim_4",
  `quality measure score 4` = "qis_4",
  `quality measure id 5` = "qim_5",
  `quality measure score 5` = "qis_5",
  `quality measure id 6` = "qim_6",
  `quality measure score 6` = "qis_6",
  `quality measure id 7` = "qim_7",
  `quality measure score 7` = "qis_7",
  `quality measure id 8` = "qim_8",
  `quality measure score 8` = "qis_8",
  `quality measure id 9` = "qim_9",
  `quality measure score 9` = "qis_9",
  `quality measure id 10` = "qim_10",
  `quality measure score 10` = "qis_10",
  `promoting interoperability (pi) category score` = "pi_score",
  `extreme hardship pi` = "pi_extr",
  `pi hardship` = "pi_hard",
  `pi reweighting` = "pi_rw",
  `pi bonus` = "pi_bonus",
  `pi measure id 1` = "pim_1",
  `pi measure score 1` = "pis_1",
  `pi measure id 2` = "pim_2",
  `pi measure score 2` = "pis_2",
  `pi measure id 3` = "pim_3",
  `pi measure score 3` = "pis_3",
  `pi measure id 4` = "pim_4",
  `pi measure score 4` = "pis_4",
  `pi measure id 5` = "pim_5",
  `pi measure score 5` = "pis_5",
  `pi measure id 6` = "pim_6",
  `pi measure score 6` = "pis_6",
  `pi measure id 7` = "pim_7",
  `pi measure score 7` = "pis_7",
  `pi measure id 8` = "pim_8",
  `pi measure score 8` = "pis_8",
  `pi measure id 9` = "pim_9",
  `pi measure score 9` = "pis_9",
  `pi measure id 10` = "pim_10",
  `pi measure score 10` = "pis_10",
  `pi measure id 11` = "pim_11",
  `pi measure score 11` = "pis_11",
  `ia score` = "ia_score",
  `extreme hardship ia` = "ia_extr",
  `ia study` = "ia_study",
  `ia measure id 1` = "iam_1",
  `ia measure score 1` = "ias_1",
  `ia measure id 2` = "iam_2",
  `ia measure score 2` = "ias_2",
  `ia measure id 3` = "iam_3",
  `ia measure score 3` = "ias_3",
  `ia measure id 4` = "iam_4",
  `ia measure score 4` = "ias_4",
  `cost score` = "cs_score",
  `extreme hardship cost` = "cs_extr",
  `cost measure id 1` = "csm_1",
  `cost measure score 1` = "css_1",
  `cost measure id 2` = "csm_2",
  `cost measure score 2` = "css_2"
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
  `quality measure id 1` = "qam_1",
  `quality measure collection type 1` = "qac_1",
  `quality measure score 1` = "qas_1",
  `quality measure id 2` = "qam_2",
  `quality measure collection type 2` = "qac_2",
  `quality measure score 2` = "qas_2",
  `quality measure id 3` = "qam_3",
  `quality measure collection type 3` = "qac_3",
  `quality measure score 3` = "qas_3",
  `quality measure id 4` = "qam_4",
  `quality measure collection type 4` = "qac_4",
  `quality measure score 4` = "qas_4",
  `quality measure id 5` = "qam_5",
  `quality measure collection type 5` = "qac_5",
  `quality measure score 5` = "qas_5",
  `quality measure id 6` = "qam_6",
  `quality measure collection type 6` = "qac_6",
  `quality measure score 6` = "qas_6",
  `quality measure id 7` = "qam_7",
  `quality measure collection type 7` = "qac_7",
  `quality measure score 7` = "qas_7",
  `quality measure id 8` = "qam_8",
  `quality measure collection type 8` = "qac_8",
  `quality measure score 8` = "qas_8",
  `quality measure id 9` = "qam_9",
  `quality measure collection type 9` = "qac_9",
  `quality measure score 9` = "qas_9",
  `quality measure id 10` = "qam_10",
  `quality measure collection type 10` = "qac_10",
  `quality measure score 10` = "qas_10",
  `quality measure id 11` = "qam_11",
  `quality measure collection type 11` = "qac_11",
  `quality measure score 11` = "qas_11",
  `quality measure id 12` = "qam_12",
  `quality measure collection type 12` = "qac_12",
  `quality measure score 12` = "qas_12",
  `promoting interoperability (pi) category score` = "pi_score",
  `pi reweighting (euc)` = "pi_rw_euc",
  `pi reweighting (hardship exception)` = "pi_rw_hs",
  `pi reweighting (special status or clinician type)` = "pi_rw_sp",
  `pi measure id 1` = "pim_1",
  `pi measure type 1` = "pit_1",
  `pi measure score 1` = "pi_measure_score_1",
  `pi measure id 2` = "pi_measure_id_2",
  `pi measure type 2` = "pi_measure_type_2",
  `pi measure score 2` = "pi_measure_score_2",
  `pi measure id 3` = "pi_measure_id_3",
  `pi measure type 3` = "pi_measure_type_3",
  `pi measure score 3` = "pi_measure_score_3",
  `pi measure id 4` = "pi_measure_id_4",
  `pi measure type 4` = "pi_measure_type_4",
  `pi measure score 4` = "pi_measure_score_4",
  `pi measure id 5` = "pi_measure_id_5",
  `pi measure type 5` = "pi_measure_type_5",
  `pi measure score 5` = "pi_measure_score_5",
  `pi measure id 6` = "pi_measure_id_6",
  `pi measure type 6` = "pi_measure_type_6",
  `pi measure score 6` = "pi_measure_score_6",
  `pi measure id 7` = "pi_measure_id_7",
  `pi measure type 7` = "pi_measure_type_7",
  `pi measure score 7` = "pi_measure_score_7",
  `pi measure id 8` = "pi_measure_id_8",
  `pi measure type 8` = "pi_measure_type_8",
  `pi measure score 8` = "pi_measure_score_8",
  `pi measure id 9` = "pi_measure_id_9",
  `pi measure type 9` = "pi_measure_type_9",
  `pi measure score 9` = "pi_measure_score_9",
  `pi measure id 10` = "pi_measure_id_10",
  `pi measure type 10` = "pi_measure_type_10",
  `pi measure score 10` = "pi_measure_score_10",
  `pi measure id 11` = "pi_measure_id_11",
  `pi measure type 11` = "pi_measure_type_11",
  `pi measure score 11` = "pi_measure_score_11",
  `improvement activities (ia) category score` = "ia_score",
  `ia reweighting (euc)` = "ia_rw_euc",
  `ia credit` = "ia_credit",
  `ia measure id 1` = "iam_1",
  `ia measure score 1` = "ias_1",
  `ia measure id 2` = "iam_2",
  `ia measure score 2` = "ias_2",
  `ia measure id 3` = "iam_3",
  `ia measure score 3` = "ias_3",
  `ia measure id 4` = "iam_4",
  `ia measure score 4` = "ias_4",
  `cost category score` = "cost_score",
  `cost reweighting (euc)` = "cost_rw_euc",
  `cost measure id 1` = "csm_1",
  `cost measure achievement points 1` = "csp_1",
  `cost measure id 2` = "csm_2",
  `cost measure achievement points 2` = "csp_2",
  `cost measure id 3` = "cost_measure_id_3",
  `cost measure achievement points 3` = "cost_measure_achievement_points_3",
  `cost measure id 4` = "cost_measure_id_4",
  `cost measure achievement points 4` = "cost_measure_achievement_points_4",
  `cost measure id 5` = "cost_measure_id_5",
  `cost measure achievement points 5` = "cost_measure_achievement_points_5",
  `cost measure id 6` = "cost_measure_id_6",
  `cost measure achievement points 6` = "cost_measure_achievement_points_6",
  `cost measure id 7` = "cost_measure_id_7",
  `cost measure achievement points 7` = "cost_measure_achievement_points_7",
  `cost measure id 8` = "cost_measure_id_8",
  `cost measure achievement points 8` = "cost_measure_achievement_points_8",
  `cost measure id 9` = "cost_measure_id_9",
  `cost measure achievement points 9` = "cost_measure_achievement_points_9",
  `cost measure id 10` = "cost_measure_id_10",
  `cost measure achievement points 10` = "cost_measure_achievement_points_10",
  `cost measure id 11` = "cost_measure_id_11",
  `cost measure achievement points 11` = "cost_measure_achievement_points_11",
  `cost measure id 12` = "cost_measure_id_12",
  `cost measure achievement points 12` = "cost_measure_achievement_points_12",
  `cost measure id 13` = "cost_measure_id_13",
  `cost measure achievement points 13` = "cost_measure_achievement_points_13",
  `cost measure id 14` = "cost_measure_id_14",
  `cost measure achievement points 14` = "cost_measure_achievement_points_14",
  `cost measure id 15` = "cost_measure_id_15",
  `cost measure achievement points 15` = "cost_measure_achievement_points_15",
  `cost measure id 16` = "cost_measure_id_16",
  `cost measure achievement points 16` = "cost_measure_achievement_points_16",
  `cost measure id 17` = "cost_measure_id_17",
  `cost measure achievement points 17` = "cost_measure_achievement_points_17",
  `cost measure id 18` = "cost_measure_id_18",
  `cost measure achievement points 18` = "cost_measure_achievement_points_18",
  `cost measure id 19` = "cost_measure_id_19",
  `cost measure achievement points 19` = "cost_measure_achievement_points_19",
  `cost measure id 20` = "cost_measure_id_20",
  `cost measure achievement points 20` = "cost_measure_achievement_points_20",
  `cost measure id 21` = "cost_measure_id_21",
  `cost measure achievement points 21` = "cost_measure_achievement_points_21",
  `cost measure id 22` = "cost_measure_id_22",
  `cost measure achievement points 22` = "cost_measure_achievement_points_22",
  `cost measure id 23` = "cost_measure_id_23",
  `cost measure achievement points 23` = "cost_measure_achievement_points_23",
  `cost measure id 24` = "cost_measure_id_24",
  `cost measure achievement points 24` = "cost_measure_achievement_points_24"
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
  `quality measure id 1` = "quality_measure_id_1",
  `quality measure collection type 1` = "quality_measure_collection_type_1",
  `quality measure score 1` = "quality_measure_score_1",
  `quality measure id 2` = "quality_measure_id_2",
  `quality measure collection type 2` = "quality_measure_collection_type_2",
  `quality measure score 2` = "quality_measure_score_2",
  `quality measure id 3` = "quality_measure_id_3",
  `quality measure collection type 3` = "quality_measure_collection_type_3",
  `quality measure score 3` = "quality_measure_score_3",
  `quality measure id 4` = "quality_measure_id_4",
  `quality measure collection type 4` = "quality_measure_collection_type_4",
  `quality measure score 4` = "quality_measure_score_4",
  `quality measure id 5` = "quality_measure_id_5",
  `quality measure collection type 5` = "quality_measure_collection_type_5",
  `quality measure score 5` = "quality_measure_score_5",
  `quality measure id 6` = "quality_measure_id_6",
  `quality measure collection type 6` = "quality_measure_collection_type_6",
  `quality measure score 6` = "quality_measure_score_6",
  `quality measure id 7` = "quality_measure_id_7",
  `quality measure collection type 7` = "quality_measure_collection_type_7",
  `quality measure score 7` = "quality_measure_score_7",
  `quality measure id 8` = "quality_measure_id_8",
  `quality measure collection type 8` = "quality_measure_collection_type_8",
  `quality measure score 8` = "quality_measure_score_8",
  `quality measure id 9` = "quality_measure_id_9",
  `quality measure collection type 9` = "quality_measure_collection_type_9",
  `quality measure score 9` = "quality_measure_score_9",
  `quality measure id 10` = "quality_measure_id_10",
  `quality measure collection type 10` = "quality_measure_collection_type_10",
  `quality measure score 10` = "quality_measure_score_10",
  `quality measure id 11` = "quality_measure_id_11",
  `quality measure collection type 11` = "quality_measure_collection_type_11",
  `quality measure score 11` = "quality_measure_score_11",
  `quality measure id 12` = "quality_measure_id_12",
  `quality measure collection type 12` = "quality_measure_collection_type_12",
  `quality measure score 12` = "quality_measure_score_12",
  `promoting interoperability (pi) category score` = "promoting_interoperability__pi__category_score",
  `promoting interoperability (pi) category weight` = "promoting_interoperability__pi__category_weight",
  `pi reweighting (euc)` = "pi_reweighting__euc_",
  `pi reweighting (hardship exception)` = "pi_reweighting__hardship_exception_",
  `pi reweighting (special status or clinician type)` = "pi_reweighting__special_status_or_clinician_type_",
  `pi measure id 1` = "pi_measure_id_1",
  `pi measure type 1` = "pi_measure_type_1",
  `pi measure score 1` = "pi_measure_score_1",
  `pi measure id 2` = "pi_measure_id_2",
  `pi measure type 2` = "pi_measure_type_2",
  `pi measure score 2` = "pi_measure_score_2",
  `pi measure id 3` = "pi_measure_id_3",
  `pi measure type 3` = "pi_measure_type_3",
  `pi measure score 3` = "pi_measure_score_3",
  `pi measure id 4` = "pi_measure_id_4",
  `pi measure type 4` = "pi_measure_type_4",
  `pi measure score 4` = "pi_measure_score_4",
  `pi measure id 5` = "pi_measure_id_5",
  `pi measure type 5` = "pi_measure_type_5",
  `pi measure score 5` = "pi_measure_score_5",
  `pi measure id 6` = "pi_measure_id_6",
  `pi measure type 6` = "pi_measure_type_6",
  `pi measure score 6` = "pi_measure_score_6",
  `pi measure id 7` = "pi_measure_id_7",
  `pi measure type 7` = "pi_measure_type_7",
  `pi measure score 7` = "pi_measure_score_7",
  `pi measure id 8` = "pi_measure_id_8",
  `pi measure type 8` = "pi_measure_type_8",
  `pi measure score 8` = "pi_measure_score_8",
  `pi measure id 9` = "pi_measure_id_9",
  `pi measure type 9` = "pi_measure_type_9",
  `pi measure score 9` = "pi_measure_score_9",
  `pi measure id 10` = "pi_measure_id_10",
  `pi measure type 10` = "pi_measure_type_10",
  `pi measure score 10` = "pi_measure_score_10",
  `pi measure id 11` = "pi_measure_id_11",
  `pi measure type 11` = "pi_measure_type_11",
  `pi measure score 11` = "pi_measure_score_11",
  `pi measure id 12` = "pi_measure_id_12",
  `pi measure type 12` = "pi_measure_type_12",
  `pi measure score 12` = "pi_measure_score_12",
  `pi measure id 13` = "pi_measure_id_13",
  `pi measure type 13` = "pi_measure_type_13",
  `pi measure score 13` = "pi_measure_score_13",
  `pi measure id 14` = "pi_measure_id_14",
  `pi measure type 14` = "pi_measure_type_14",
  `pi measure score 14` = "pi_measure_score_14",
  `pi measure id 15` = "pi_measure_id_15",
  `pi measure type 15` = "pi_measure_type_15",
  `pi measure score 15` = "pi_measure_score_15",
  `pi measure id 16` = "pi_measure_id_16",
  `pi measure type 16` = "pi_measure_type_16",
  `pi measure score 16` = "pi_measure_score_16",
  `pi measure id 17` = "pi_measure_id_17",
  `pi measure type 17` = "pi_measure_type_17",
  `pi measure score 17` = "pi_measure_score_17",
  `pi measure id 18` = "pi_measure_id_18",
  `pi measure type 18` = "pi_measure_type_18",
  `pi measure score 18` = "pi_measure_score_18",
  `pi measure id 19` = "pi_measure_id_19",
  `pi measure type 19` = "pi_measure_type_19",
  `pi measure score 19` = "pi_measure_score_19",
  `pi measure id 20` = "pi_measure_id_20",
  `pi measure type 20` = "pi_measure_type_20",
  `pi measure score 20` = "pi_measure_score_20",
  `pi measure id 21` = "pi_measure_id_21",
  `pi measure type 21` = "pi_measure_type_21",
  `pi measure score 21` = "pi_measure_score_21",
  `improvement activities (ia) category score` = "improvement_activities__ia__category_score",
  `improvement activities (ia) category weight` = "improvement_activities__ia__category_weight",
  `ia reweighting (euc)` = "ia_reweighting__euc_",
  `ia credit` = "ia_credit",
  `ia measure id 1` = "ia_measure_id_1",
  `ia measure score 1` = "ia_measure_score_1",
  `ia measure id 2` = "ia_measure_id_2",
  `ia measure score 2` = "ia_measure_score_2",
  `ia measure id 3` = "ia_measure_id_3",
  `ia measure score 3` = "ia_measure_score_3",
  `ia measure id 4` = "ia_measure_id_4",
  `ia measure score 4` = "ia_measure_score_4",
  `cost category score` = "cost_category_score",
  `cost improvement score` = "cost_improvement_score",
  `cost category weight` = "cost_category_weight",
  `cost reweighting (euc)` = "cost_reweighting__euc_",
  `cost measure id 1` = "cost_measure_id_1",
  `cost measure achievement points 1` = "cost_measure_achievement_points_1",
  `cost measure id 2` = "cost_measure_id_2",
  `cost measure achievement points 2` = "cost_measure_achievement_points_2",
  `cost measure id 3` = "cost_measure_id_3",
  `cost measure achievement points 3` = "cost_measure_achievement_points_3",
  `cost measure id 4` = "cost_measure_id_4",
  `cost measure achievement points 4` = "cost_measure_achievement_points_4",
  `cost measure id 5` = "cost_measure_id_5",
  `cost measure achievement points 5` = "cost_measure_achievement_points_5",
  `cost measure id 6` = "cost_measure_id_6",
  `cost measure achievement points 6` = "cost_measure_achievement_points_6",
  `cost measure id 7` = "cost_measure_id_7",
  `cost measure achievement points 7` = "cost_measure_achievement_points_7",
  `cost measure id 8` = "cost_measure_id_8",
  `cost measure achievement points 8` = "cost_measure_achievement_points_8",
  `cost measure id 9` = "cost_measure_id_9",
  `cost measure achievement points 9` = "cost_measure_achievement_points_9",
  `cost measure id 10` = "cost_measure_id_10",
  `cost measure achievement points 10` = "cost_measure_achievement_points_10",
  `cost measure id 11` = "cost_measure_id_11",
  `cost measure achievement points 11` = "cost_measure_achievement_points_11",
  `cost measure id 12` = "cost_measure_id_12",
  `cost measure achievement points 12` = "cost_measure_achievement_points_12",
  `cost measure id 13` = "cost_measure_id_13",
  `cost measure achievement points 13` = "cost_measure_achievement_points_13",
  `cost measure id 14` = "cost_measure_id_14",
  `cost measure achievement points 14` = "cost_measure_achievement_points_14",
  `cost measure id 15` = "cost_measure_id_15",
  `cost measure achievement points 15` = "cost_measure_achievement_points_15",
  `cost measure id 16` = "cost_measure_id_16",
  `cost measure achievement points 16` = "cost_measure_achievement_points_16",
  `cost measure id 17` = "cost_measure_id_17",
  `cost measure achievement points 17` = "cost_measure_achievement_points_17",
  `cost measure id 18` = "cost_measure_id_18",
  `cost measure achievement points 18` = "cost_measure_achievement_points_18",
  `cost measure id 19` = "cost_measure_id_19",
  `cost measure achievement points 19` = "cost_measure_achievement_points_19",
  `cost measure id 20` = "cost_measure_id_20",
  `cost measure achievement points 20` = "cost_measure_achievement_points_20",
  `cost measure id 21` = "cost_measure_id_21",
  `cost measure achievement points 21` = "cost_measure_achievement_points_21",
  `cost measure id 22` = "cost_measure_id_22",
  `cost measure achievement points 22` = "cost_measure_achievement_points_22",
  `cost measure id 23` = "cost_measure_id_23",
  `cost measure achievement points 23` = "cost_measure_achievement_points_23",
  `cost measure id 24` = "cost_measure_id_24",
  `cost measure achievement points 24` = "cost_measure_achievement_points_24"
)
