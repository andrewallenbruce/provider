library(collapse)
library(stringfish)
library(tidyverse)
library(janitor)

cpt_rpt <- data.table::fread(
  here::here("data/CPTAnalysisReport_20240312_4940 - CPT Analysis.csv")) |>
  janitor::clean_names() |>
  dplyr::tibble() |>
  dplyr::mutate(
    patient_name = stringfish::sf_gsub(patient_name, '["\']', ""),
    patient_pid = stringr::str_remove(patient_pid, "REP"),
    rendering_provider = stringfish::sf_toupper(rendering_provider),
    referring_provider = stringfish::sf_toupper(referring_provider),
    diagnosis = stringfish::sf_gsub(diagnosis, ",", "|"),
    dplyr::across(dplyr::where(is.character), ~ dplyr::na_if(.x, "")),
    dplyr::across(c(patient_dob, cpt_dos, rendering_signed), anytime::anydate),
    encounter = strex::str_after_first(encounter, "A") |> as.integer(),
    dos_pt_age = fuimus::years_floor(patient_dob, cpt_dos),
    cpt = dplyr::case_match(
      cpt,
      c("QA90834MS", "SP90834MS", "SP90834PHD") ~ "90834",
      c("QA90837MS", "SP90837MS", "CP90837", "SP90837LCPC", "SP90837PHD") ~ "90837",
      c("QA99214MM", "SP99214MM") ~ "99214",
      c("QA90791MS", "SP90791MS", "CP90791", "SP90791PHD") ~ "90791",
      c("QA99204MM", "SP99204MM", "QA99204NP") ~"99204",
      "QA99212NP" ~ "99212",
      c("QA99213MM", "SP99213MM", "QA99213NP", "SP99213NP") ~ "99213",
      c("SP99214NP", "QA99214NP") ~ "99214",
      c("QA99215MM", "SP99215NP") ~ "99215",
      "SP96131" ~ "96131",
      "SP96130" ~ "96130",
      "SP96137" ~ "96137",
      "SP96136" ~ "96136",
      c("QA90832MS", "SP90832PHD", "SP90832MS") ~ "90832",
      c("QA99203MM", "QA99203NP", "SP99203MM") ~ "99203",
      c("QA99205NP", "QA99205MM", "SP99205MM") ~ "99205",
      "EN99404" ~ "99404",
      c("QA90792MM", "QA90792NP") ~ "90792",
      "QA90838MM" ~ "90838",
      .default = cpt),
    cpt_valid = stringfish::sf_grepl(cpt, "^[A-CEGHJ-MP-V0-9]\\d{3}[AFMTU0-9]$")
  ) |>
  fuimus::count_days(
    start = cpt_dos,
    end = rendering_signed,
    name = "sign_lag"
  ) |>
  dplyr::select(
    -c(
      patient_name,
      referring_provider,
      patient_record_rendering_provider,
      pri_ins_name_mnemonic,
      revenue_code,
      revenue_center_mnemonic,
      mod3,
      mod4,
      place_of_service_name,
      allowed_cpt_only,
      program_allowed,
      pri_insurance_policy_num,
      sec_insurance_policy_num,
      billing_provider,
      pri_insurance_auth,
      revenue_center_name,
      location
    )
  )

# UMLS API KEY = 381e5d73-c36c-40fc-b26b-387190e11511

# Detect double quotes and any space around them
"s/\"//g"

# Detect single or double quotes
'["\']'


# cpt_rpt <- data.table::fread(
#   here::here(
#     "data/CPTAnalysisReport_20240312_4940 - CPT Analysis.csv"
#   )
# )

nppes_info |>
  dplyr::filter(rendering_provider == "STEPHEN SMITH")

cpt_new <- cpt_rpt |>
  dplyr::mutate(
    rendering_provider = dplyr::if_else(
      stringfish::sf_grepl(rendering_provider, "J. STEPHEN HAZEL"),
      "STEPHEN HAZEL",
      rendering_provider)
  ) |>
  dplyr::left_join(
    nppes_info,
    by = dplyr::join_by(rendering_provider),
    relationship = "many-to-many"
  ) |>
  dplyr::select(
    pt_dob = patient_dob,
    pt_age = dos_pt_age,
    pt_pid = patient_pid,
    pt_enc_n = encounter,
    pt_enc_desc = description,
    pt_dos = cpt_dos,
    rnd_prov = rendering_provider,
    rnd_npi = rendering_npi,
    rnd_cred = rendering_cred,
    rnd_tax = rendering_txcode,
    rnd_tax_desc = rendering_txdesc,
    rnd_date_sign = rendering_signed,
    rnd_sign_lag = sign_lag,
    hcpcs_icd = diagnosis,
    hcpcs_ord = claim_order,
    hcpcs_code = cpt,
    hcpcs_valid = cpt_valid,
    hcpcs_mod_1 = mod1,
    hcpcs_mod_2 = mod2,
    hcpcs_pos = place_of_service_code,
    hcpcs_uos = units,
    ins_class_pri = pri_ins_class_name,
    ins_name_pri = pri_insurance,
    ins_class_sec = sec_insurance,
    hcpcs_charges = charges,
    hcpcs_allowed = allowed,
    hcpcs_payments = payments,
    hcpcs_adjustments = adjustments,
    ins_pmt = insurance_paid,
    ins_adj = insurance_adj,
    hcpcs_adj_1 = adj_code,
    hcpcs_adj_2 = adj_code_2,
    hcpcs_adj_3 = adj_code_3
  )

cpt_new |>
  filter(
    is.na(rnd_npi),
    !is.na(rnd_prov)
  ) |>
  distinct(rnd_prov) |>
  pull(rnd_prov)

nppes_info |>
  filter(stringfish::sf_grepl(rendering_provider, "NORA|STACEY|LAIRD|HEESEONG|HAZEL"))

# readr::write_csv(cpt_rpt, here::here("data", "cpt_rpt.csv"))
