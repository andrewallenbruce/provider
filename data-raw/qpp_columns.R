ALL <- list(
  `practice state or us territory` = "state",
  `practice size` = "size",
  `clinician specialty` = "specialty",
  `years in medicare` = "years",
  npi = "npi",
  `medicare patients` = "patients",
  `allowed charges` = "charges",
  services = "services",
  `opted into mips` = "opted_into_mips",
  `final score` = "final_score",
  `payment adjustment percentage` = "adjustment",
  `complex patient bonus` = "complex_bonus",
  `quality category score` = "quality_score",
  `promoting interoperability (pi) category score` = "pi_score"
)

Q17 <- c(
  engaged = "engaged",
  `participation type` = "participation_type",
  `small practitioner` = "small_practitioner",
  `rural clinician` = "rural_clinician",
  `hpsa clinician` = "hpsa_clinician",
  `ambulatory surgical center` = "ambulatory_surgical_center",
  `hospital-based clinician` = "hospital_based_clinician",
  `non-patient facing` = "non_patient_facing",
  `facility-based` = "facility_based",
  `extreme hardship` = "extreme_hardship",
  `extreme hardship quality` = "extreme_hardship_quality",
  `quality improvement bonus` = "quality_improvement_bonus",
  `quality bonus` = "quality_bonus",
  `extreme hardship pi` = "extreme_hardship_pi",
  `pi hardship` = "pi_hardship",
  `pi reweighting` = "pi_reweighting",
  `pi bonus` = "pi_bonus",
  `ia score` = "ia_score",
  `extreme hardship ia` = "extreme_hardship_ia",
  `cost score` = "cost_score",
  `extreme hardship cost` = "extreme_hardship_cost"
)

Q22 <- c(
  `clinician type` = "clinician_type",
  `non-reporting` = "non_reporting",
  `participation option` = "participation_option",
  `reporting option` = "reporting_option",
  `mips value pathway title` = "mips_value_pathway_title",
  `small practice status` = "small_practice_status",
  `rural status` = "rural_status",
  `health professional shortage area status` = "health_professional_shortage_area_status",
  `ambulatory surgical center-based status` = "ambulatory_surgical_center_based_status",
  `hospital-based status` = "hospital_based_status",
  `non-patient facing status` = "non_patient_facing_status",
  `facility-based status` = "facility_based_status",
  `received facility score` = "received_facility_score",
  `dual eligibility ratio` = "dual_eligibility_ratio",
  `safety-net status` = "safety_net_status",
  `extreme uncontrollable circumstance (euc)` = "extreme_uncontrollable_circumstance__euc_",
  `quality improvement score` = "quality_improvement_score",
  `quality category weight` = "quality_category_weight",
  `quality reweighting (euc)` = "quality_reweighting__euc_",
  `small practice bonus` = "small_practice_bonus",
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

# 2017      == Q17_type + ALL_type
# 2022      == Q22_type + ALL_type
# 2023:2024 == Q23_type + Q22_type + ALL_type

ALL_type <- list(
  `practice state or us territory` = "character",
  `practice size` = "integer",
  `clinician specialty` = "character",
  `years in medicare` = "integer",
  npi = "integer",
  `medicare patients` = "integer",
  `allowed charges` = "integer",
  services = "integer",
  `opted into mips` = "logical",
  `final score` = "numeric",
  `payment adjustment percentage` = "numeric",
  `complex patient bonus` = "numeric",
  `quality category score` = "numeric",
  `promoting interoperability (pi) category score` = "integer"
)

Q17_type <- list(
  engaged = "logical",
  `participation type` = "character",
  `small practitioner` = "logical",
  `rural clinician` = "logical",
  `hpsa clinician` = "logical",
  `ambulatory surgical center` = "logical",
  `hospital-based clinician` = "logical",
  `non-patient facing` = "logical",
  `facility-based` = "logical",
  `extreme hardship` = "logical",
  `extreme hardship quality` = "logical",
  `quality improvement bonus` = "numeric",
  `quality bonus` = "logical",
  `extreme hardship pi` = "logical",
  `pi hardship` = "logical",
  `pi reweighting` = "logical",
  `pi bonus` = "logical",
  `ia score` = "integer",
  `extreme hardship ia` = "logical",
  `cost score` = "numeric",
  `extreme hardship cost` = "logical"
)

Q22_type <- list(
  `clinician type` = "character",
  `non-reporting` = "logical",
  `participation option` = "character",
  `small practice status` = "logical",
  `rural status` = "logical",
  `health professional shortage area status` = "logical",
  `ambulatory surgical center-based status` = "logical",
  `hospital-based status` = "logical",
  `non-patient facing status` = "logical",
  `facility-based status` = "logical",
  `dual eligibility ratio` = "numeric",
  `safety-net status` = "logical",
  `extreme uncontrollable circumstance (euc)` = "logical",
  `quality reweighting (euc)` = "logical",
  `quality improvement score` = "integer",
  `small practice bonus` = "integer",
  `pi reweighting (euc)` = "logical",
  `pi reweighting (hardship exception)` = "logical",
  `pi reweighting (special status or clinician type)` = "logical",
  `improvement activities (ia) category score` = "integer",
  `ia reweighting (euc)` = "logical",
  `ia credit` = "logical",
  `cost category score` = "integer",
  `cost reweighting (euc)` = "logical"
)

Q23_type <- list(
  `reporting option` = "character",
  `mips value pathway title` = "character",
  `received facility score` = "logical",
  `quality category weight` = "numeric",
  `promoting interoperability (pi) category weight` = "numeric",
  `improvement activities (ia) category weight` = "numeric",
  `cost improvement score` = "integer",
  `cost category weight` = "numeric"
)
