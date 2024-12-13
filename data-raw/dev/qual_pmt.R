year        = "2022"
npi         = 1043477615
state       = NULL
specialty   = NULL
type        = NULL
tidy        = TRUE
nest        = TRUE
eligibility = TRUE

results |>
  janitor::clean_names() |>
  dplyr::tibble() |>
  dplyr::glimpse() |>
  colnames() |>
  fuimus::create_vec()

c("year",
  "npi",
  "pkey" = "provider_key",
  "cehrt_id",
  "pr_state" = "practice_state_or_us_territory",
  "pr_size" = "practice_size",
  "cred" = "clinician_type",
  "spec" = "clinician_specialty",
  "years_med" = "years_in_medicare",
  "patients" = "medicare_patients",
  "allowed" = "allowed_charges",
  "services",

  "dual_ratio" = "dual_eligibility_ratio",
  "adjustment" = "payment_adjustment_percentage",
  "score_final" = "final_score",
  "score_qu" = "quality_category_score",
  "score_qi" = "quality_improvement_score",
  "score_pi" = "promoting_interoperability_pi_category_score",

  "bonus_complex" = "complex_patient_bonus",
  "bonus_small" = "small_practice_bonus",

  "rw_qu" = "quality_reweighting_euc",
  "rw_pi" = "pi_reweighting_euc",
  "rw_pi_hardship" = "pi_reweighting_hardship_exception",
  "rw_pi_special" = "pi_reweighting_special_status_or_clinician_type",

  "nonreporting" = "non_reporting",
  "participation" = "participation_option",
  "mips_optin" = "opted_into_mips",

  "status_small" = "small_practice_status",
  "status_rural" = "rural_status",
  "status_shortage" = "health_professional_shortage_area_status",
  "status_asc" = "ambulatory_surgical_center_based_status",
  "status_hospital" = "hospital_based_status",
  "status_nonpatient" = "non_patient_facing_status",
  "status_facility" = "facility_based_status",
  "status_safety" = "safety_net_status",
  "status_extreme" = "extreme_uncontrollable_circumstance_euc",

  "qm_id_1" = "quality_measure_id_1",
  "qm_id_2" = "quality_measure_id_2",
  "qm_id_3" = "quality_measure_id_3",
  "qm_id_4" = "quality_measure_id_4",
  "qm_id_5" = "quality_measure_id_5",
  "qm_id_6" = "quality_measure_id_6",
  "qm_id_7" = "quality_measure_id_7",
  "qm_id_8" = "quality_measure_id_8",
  "qm_id_9" = "quality_measure_id_9",
  "qm_id_10" = "quality_measure_id_10",
  "qm_id_11" = "quality_measure_id_11",
  "qm_id_12" = "quality_measure_id_12",
  "qm_cl_1" = "quality_measure_collection_type_1",
  "qm_cl_2" = "quality_measure_collection_type_2",
  "qm_cl_3" = "quality_measure_collection_type_3",
  "qm_cl_4" = "quality_measure_collection_type_4",
  "qm_cl_5" = "quality_measure_collection_type_5",
  "qm_cl_6" = "quality_measure_collection_type_6",
  "qm_cl_7" = "quality_measure_collection_type_7",
  "qm_cl_8" = "quality_measure_collection_type_8",
  "qm_cl_9" = "quality_measure_collection_type_9",
  "qm_cl_10" = "quality_measure_collection_type_10",
  "qm_cl_11" = "quality_measure_collection_type_11",
  "qm_cl_12" = "quality_measure_collection_type_12",
  "qm_sc_1" = "quality_measure_score_1",
  "qm_sc_2" = "quality_measure_score_2",
  "qm_sc_3" = "quality_measure_score_3",
  "qm_sc_4" = "quality_measure_score_4",
  "qm_sc_5" = "quality_measure_score_5",
  "qm_sc_6" = "quality_measure_score_6",
  "qm_sc_7" = "quality_measure_score_7",
  "qm_sc_8" = "quality_measure_score_8",
  "qm_sc_9" = "quality_measure_score_9",
  "qm_sc_10" = "quality_measure_score_10",
  "qm_sc_11" = "quality_measure_score_11",
  "qm_sc_12" = "quality_measure_score_12",

  "pim_id_1" = "pi_measure_id_1",
  "pim_id_2" = "pi_measure_id_2",
  "pim_id_3" = "pi_measure_id_3",
  "pim_id_4" = "pi_measure_id_4",
  "pim_id_5" = "pi_measure_id_5",
  "pim_id_6" = "pi_measure_id_6",
  "pim_id_7" = "pi_measure_id_7",
  "pim_id_8" = "pi_measure_id_8",
  "pim_id_9" = "pi_measure_id_9",
  "pim_id_10" = "pi_measure_id_10",
  "pim_id_11" = "pi_measure_id_11",

  "pim_tp_1" = "pi_measure_type_1",
  "pim_tp_2" = "pi_measure_type_2",
  "pim_tp_3" = "pi_measure_type_3",
  "pim_tp_4" = "pi_measure_type_4",
  "pim_tp_5" = "pi_measure_type_5",
  "pim_tp_6" = "pi_measure_type_6",
  "pim_tp_7" = "pi_measure_type_7",
  "pim_tp_8" = "pi_measure_type_8",
  "pim_tp_9" = "pi_measure_type_9",
  "pim_tp_10" = "pi_measure_type_10",
  "pim_tp_11" = "pi_measure_type_11",

  "pi_measure_score_1",
  "pi_measure_score_2",
  "pi_measure_score_3",
  "pi_measure_score_4",
  "pi_measure_score_5",
  "pi_measure_score_6",
  "pi_measure_score_7",
  "pi_measure_score_8",
  "pi_measure_score_9",
  "pi_measure_score_10",
  "pi_measure_score_11",

  "improvement_activities_ia_category_score",
  "ia_reweighting_euc",
  "ia_credit",
  "ia_measure_id_1",
  "ia_measure_score_1",
  "ia_measure_id_2",
  "ia_measure_score_2",
  "ia_measure_id_3",
  "ia_measure_score_3",
  "ia_measure_id_4",
  "ia_measure_score_4",

  "cost_category_score",
  "cost_reweighting_euc",
  "cost_measure_id_1",
  "cost_measure_achievement_points_1",
  "cost_measure_id_2",
  "cost_measure_achievement_points_2",
  "cost_measure_id_3",
  "cost_measure_achievement_points_3",
  "cost_measure_id_4",
  "cost_measure_achievement_points_4",
  "cost_measure_id_5",
  "cost_measure_achievement_points_5",
  "cost_measure_id_6",
  "cost_measure_achievement_points_6",
  "cost_measure_id_7",
  "cost_measure_achievement_points_7",
  "cost_measure_id_8",
  "cost_measure_achievement_points_8",
  "cost_measure_id_9",
  "cost_measure_achievement_points_9",
  "cost_measure_id_10",
  "cost_measure_achievement_points_10",
  "cost_measure_id_11",
  "cost_measure_achievement_points_11",
  "cost_measure_id_12",
  "cost_measure_achievement_points_12",
  "cost_measure_id_13",
  "cost_measure_achievement_points_13",
  "cost_measure_id_14",
  "cost_measure_achievement_points_14",
  "cost_measure_id_15",
  "cost_measure_achievement_points_15",
  "cost_measure_id_16",
  "cost_measure_achievement_points_16",
  "cost_measure_id_17",
  "cost_measure_achievement_points_17",
  "cost_measure_id_18",
  "cost_measure_achievement_points_18",
  "cost_measure_id_19",
  "cost_measure_achievement_points_19",
  "cost_measure_id_20",
  "cost_measure_achievement_points_20",
  "cost_measure_id_21",
  "cost_measure_achievement_points_21",
  "cost_measure_id_22",
  "cost_measure_achievement_points_22",
  "cost_measure_id_23",
  "cost_measure_achievement_points_23",
  "cost_measure_id_24",
  "cost_measure_achievement_points_24"
)
