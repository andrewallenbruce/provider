library(tidyverse)

cpt_rpt <- readr::read_csv(here::here("data", "cpt_rpt.csv"))

rpt <- cpt_rpt |>
  reframe(
    referring_provider,
    rendering_provider,
    location,
    # revenue_center_name,
    # patient_record_rendering_provider,
    # billing_provider,
    pt_id = str_replace(patient_pid, "REP", "PT"),
    enc = str_remove(encounter, patient_pid),
    enc = str_remove(enc, "A") |> as.integer(),
    dos = cpt_dos,
    dob = patient_dob,
    pt_age = fuimus::years_floor(dob, dos) |> as.integer(),
    dor = rendering_signed,
    dor_lag = provider_lag,
    icd_code = diagnosis,
    hcpcs_order = claim_order |> as.integer(),
    hcpcs_code = cpt,
    hcpcs_desc = description,
    hcpcs_unit = units |> as.integer(),
    hcpcs_mod_1 = mod1,
    hcpcs_mod_2 = mod2,
    pos = strex::str_extract_numbers(place_of_service_name) |> fuimus::pad_number(),
    pos_name = place_of_service_name,
    ins_class = pri_ins_class_name,
    ins_prim = pri_insurance,
    ins_sec = sec_insurance,
    charges,
    payments,
    adjustments,
    ins_pmt = insurance_paid,
    ins_adj = insurance_adj,
    ins_allow = allowed,
    adj_code_1 = adj_code,
    adj_code_2,
    adj_code_3
  ) |>
  arrange(pt_id, enc, dos)

# Obscure locations
loc_key <- rpt |>
  distinct(location) |>
  mutate(loc = case_match(
    location,
    c("COC", "KVC", "PBP", "TFI", "RESPONSIVE MANAGEMENT CLINIC, INC.") ~ "CLINIC",
    c("ONWHS", "CSTMS", "OW", "TSU") ~ "SCHOOL",
    "KVC HOSPITAL" ~ "HOSPITAL",
    .default = location
  ))

clean_rpt <- rpt |>
  left_join(
    loc_key,
    by = join_by(location)) |>
  relocate(
    loc,
    .before = location) |>
  select(-location) |>
  rename(location = loc)

# Obscure patient IDs
pt_key <- clean_rpt |>
  count(pt_id) |>
  mutate(
    pt = consecutive_id(pt_id),
    pt_no = strex::str_extract_numbers(pt_id)) |>
  unnest(pt_no) |>
  arrange(pt_no) |>
  mutate(
    id = consecutive_id(pt_no) |>
      str_pad(width = 4, pad = "0"),
    id = str_c("PT", id)
  ) |>
  select(pt_id, id) |>
  arrange(id)

clean_rpt <- clean_rpt |>
  left_join(
    pt_key,
    by = join_by(pt_id)) |>
  relocate(
    id,
    .before = pt_id) |>
  select(-pt_id) |>
  rename(
    ptid = id,
    ptenc = enc) |>
  arrange(dos, ptid, ptenc)

# Generalize insurance classes
class_key <- clean_rpt |>
  count(ins_class) |>
  mutate(
    class = case_match(
      ins_class,
      c("BEACON HEALTH OPTIONS", "EAP", "CONTRACT") ~ "OTHER",
      c("KS MEDICAID", "MO MEDICAID", "MEDICAID CMO") ~ "MEDICAID",
      NA_character_ ~ "SELF",
      "MEDICARE REPLACEMENT" ~ "MEDICARE ADVANTAGE",
      "WORKER COMP" ~ "WORK COMP",
      "UBH" ~ "UHC",
      .default = ins_class
    )
  ) |>
  select(ins_class, class)

clean_rpt <- clean_rpt |>
  left_join(class_key, by = join_by(ins_class)) |>
  relocate(class, .before = ins_class) |>
  mutate(ins_class = class,
         class = NULL)

prim_key <- clean_rpt |>
  count(ins_class, ins_prim) |>
  mutate(
    prim = case_match(
      ins_prim,
      c(
        "Allstate Health Solutions",
        "ALLEGIANT INS CO",
        "AARP HEALTHCARE OPTIONS",
        "AARP",
        "AMERICAN HEALTHCARE ALLIANCE",
        "ADMINISTRATIVE CONCEPTS",
        "BEACON HEALTH OPTIONS/ CARELON BEH HEALT",
        "BEACON OPTIONS",
        "Barton Community College",
        "BLACKHAWK CLAIMS SERVICES GA, INC",
        "Baylor Scott & White Health Plan",
        "Benefit Management, Inc",
        "Bright Spring Medical",
        "CCMSI",
        "COMPSYCH",
        "COMPSYCH EAP",
        "CORESOURCE",
        "CORNERSTONES OF CARE",
        "CRIME VICTIMS",
        "COX HEALTH SYSTEM",
        "CURALINC HEALTHCARE",
        "CURALINC HEALTHCARE EAP",
        "Cincinnati Insurance Companies",
        "Divisified Administration Corp",
        "EBMS",
        "ESIS OVERLAND PARK WC",
        "FIRST HEALTH",
        "GEHA",
        "GOLDEN RULE INSURANCE CO",
        "GOVERNMENT PERSONNEL MUTUAL LIFE INSURAN",
        "GROUP HEALTH COOPERATIVE",
        "Gallagher Bassett",
        "Gravie Administrative Services",
        "HEALTH EZ",
        "HEALTH PARTNERS",
        "HPI",
        "Imagine360",
        "JOHNSON COUNTY DA OFFICE",
        "Jason Woody",
        "KVC",
        "KVC HOSPITAL",
        "LIFEWISE ASSURANCE COMPANY",
        "MEDICA",
        "MISSOURI HEALTHNET",
        "MO Healthnet",
        "MUTUAL OF OMAHA EAP",
        "NEW DIRECTIONS",
        "NEW DIRECTIONS EAP",
        "NIPPON LIFE INSURANCE COMPANY OF AMERICA",
        "OLATHE SCHOOL DISTRICT EDUCATION CENTER",
        "PHCS",
        "PHCS BY MULTIPLAN",
        "PREFERRED HEALTH PROFESSIONALS",
        "PRAIRIE BAND POTAWATOMIE",
        "PROVIDRS CARE",
        "QUICK TRIP",
        "Quik Trip",
        "RELIANCE MAX",
        "Sisco",
        "Surest",
        "STATE OF KANSAS DCF",
        "TRAVELERS",
        "TFI FAMILY SERVICES",
        "TUFTS HEALTH PLAN",
        "TLC",
        "VALUEOPTIONS/BEACON EAP",
        "WEBTPA"
      ) ~ "OTHER",

      c(
        "ALL SAVERS PLANS-UHC",
        "BIND/UNITED HEALTH GROUP",
        "OPTUM BEHAVIORAL HEALTH",
        "UBH",
        "UBH EAP",
        "UHC- STUDENT RESOURCES",
        "UHSS-UHC",
        "UMR",
        "UNITED BEHAVIORAL HEALTH",
        "UNITED BEHAVIORAL HEALTH-HCA",
        "UNITED HEALTH CARE CHOICE PLUS",
        "UNITED HEALTHCARE",
        "UNITED HEALTHCARE OXFORDHEALTH",
        "UNITED HEALTHCARE COMM PLAN-KS",
        "UNITED HEALTHCARE COMM PLAN-MO",
        "OPTUM EAP",
        "UNITED HEALTHCARE DUAL COMPLETE",
        "UNITED HEALTHCARE MEDICARE COMPLETE",
        "UNITED HEALTHCARE MEDICARE SOLUTIONS",
        "UHC MEDICARE ADVANTAGE"
      ) ~ "UHC",

      c(
        "BCBS FEDERAL",
        "BCBS OF KANSAS CITY MISSOURI",
        "BCBS OF MISSOURI",
        "BLUE CROSS BLUE SHIELD OF KANSAS",
        "HEALTHY BLUE MISSOURI",
        "BCBS MEDICARE MO"
      ) ~ "BCBS",

      c(
        "CIGNA BEHAVIORAL HEALTH",
        "CIGNA HEALTHCARE",
        "GWH CIGNA PPO",
        "OSCAR/CIGNA",
        "CIGNA EAP",
        "CIGNA MEDICARE SUPPLEMENT"
      ) ~ "CIGNA",

      c(
        "AETNA AMERICAN CONTINENTAL INS CO",
        "AETNA EAP",
        "AETNA BETTER HEALTH OF KS",
        "AETNA MEDICARE",
        "ALLIED BENEFIT SYSTEMS INC",
        "Allied Benefits Systems, LLC",
        "Lucent Health"
      ) ~ "AETNA",
      c("HUMANA MEDICARE", "HUMANA, INC") ~ "HUMANA",
      c("MERITAIN-AETNA", "MERITAIN HEALTH") ~ "MERITAIN",
      c("HARTFORD LIFE & ACCIDENT", "Hartford Insurance") ~ "HARTFORD",
      c(
        "KANSAS MEDICAID",
        "KANSAS MEDICAID-C",
        "MO MEDICAID",
        "HOME STATE HEALTH PLAN"
      ) ~ "MEDICAID",
      "KANSAS MEDICARE" ~ "MEDICARE",
      "MEDICARE RAILROAD PALMETTO GBA" ~ "RAILROAD",
      "WELLCARE MEDICARE ADVANTAGE" ~ "WELLCARE",
      c("TRUSTMARK HEALTH BENEFITS", "Trustmark Small Business Benefits") ~ "TRUSTMARK",
      c("VA CCN CORRESPONDENCE", "VA CCN OPTUM", "VA MEDICAL CENTER") ~ "VA",
      c("SUNFLOWER HEALTH PLAN", "Sunflower Health Plan", "ALLWELL FROM SUNFLOWER HEALTH PLAN") ~ "SUNFLOWER",
      "MAGELLAN EAP" ~ "MAGELLAN",
      c("TRICARE WEST REGION UHC MILITARY WEST", "TRICARE FOR LIFE") ~ "TRICARE WEST",
      "Tricare East" ~ "TRICARE EAST",
      "Liberty Mutual" ~ "LIBERTY",
      "Sedgwick Claims" ~ "SEDGWICK",
      .default = ins_prim
    )
  ) |>
  select(ins_class, ins_prim, prim)


prim_key2 <- prim_key |>
  mutate(
    class = ins_class,
    class = case_match(
      class,
      c("AETNA", "BCBS", "CIGNA", "UHC") ~ "COMMERCIAL",
      c("TRICARE", "VA") ~ "MILITARY",
      .default = class
    ),
    class = case_when(
      class == "OTHER" & prim == "AETNA" ~ "COMMERCIAL",
      class == "OTHER" & prim == "CIGNA" ~ "COMMERCIAL",
      class == "OTHER" & prim == "MAGELLAN" ~ "COMMERCIAL",
      class == "OTHER" & prim == "UHC" ~ "COMMERCIAL",
      .default = class
    ),
    .before = prim
  )

clean_rpt <- clean_rpt |>
  left_join(prim_key2, by = join_by(ins_class, ins_prim)) |>
  relocate(class, .before = ins_class) |>
  mutate(ins_class = class, class = NULL) |>
  relocate(prim, .before = ins_prim) |>
  mutate(ins_prim = prim, prim = NULL)

sec_key <- clean_rpt |>
  count(ins_prim, ins_sec) |>
  mutate(
    sec = case_when(ins_prim == "SELF" ~ "SELF", .default = ins_sec),
    sec = case_match(
      ins_sec,
      c("AARP HEALTHCARE OPTIONS", "AARP HEALTHCARE OPTIONS CLAIM DIVISON") ~ "AARP",
      c("AETNA AMERICAN CONTINENTAL INS CO", "AETNA BETTER HEALTH OF KS", "AETNA EAP", "AETNA MEDICARE", "AETNA SENIOR SUPPLEMENTAL") ~ "AETNA",
      c("AMERICAN NATIONAL", "AMERICAN REPUBLIC", "AMERICO", "AMFIRST INSURANCE COMPANY", "American Family Mutual Insurance Company", "UNITED AMERICAN INS. COMPANY") ~ "AMERICAN",
      "Allstate Health Solutions" ~ "ALLSTATE",
      "BANKERS FIDELITY LIFE INSURNACE" ~ "FIDELITY",
      c("BCBS OF MISSOURI", "BCBS MEDICARE MO", "BCBS OF KANSAS CITY MISSOURI", "BLUE CROSS BLUE SHIELD OF KANSAS", "HEALTHY BLUE MISSOURI") ~ "BCBS",
      "CHAMP VA" ~ "CHAMPVA",
      c("CIGNA BEHAVIORAL HEALTH", "CIGNA EAP", "CIGNA MEDICARE SUPPLEMENT", "CIGNA MEDICARE SUPPLEMENT SOLUTIONS", "GWH CIGNA PPO") ~ "CIGNA",
      c("HUMANA MEDICARE", "HUMANA, INC") ~ "HUMANA",
      c("MO MEDICAID", "KANSAS MEDICAID", "KANSAS MEDICAID-C") ~ "MEDICAID",
      "KANSAS MEDICARE" ~ "MEDICARE",
      "MAGELLAN EAP" ~ "MAGELLAN",
      c("SUNFLOWER HEALTH PLAN", "Sunflower Health Plan") ~ "SUNFLOWER",
      c("UNITED HEALTHCARE", "UNITED HEALTHCARE COMM PLAN-MO", "UNITED HEALTHCARE DUAL COMPLETE", "UNITED HEALTHCARE MEDICARE COMPLETE", "UNITED HEALTHCARE COMM PLAN-KS", "OPTUM BEHAVIORAL HEALTH", "UHC MEDICARE ADVANTAGE", "UHSS-UHC", "UMR", "UNITED BEHAVIORAL HEALTH") ~ "UHC",
      "TRICARE WEST REGION UHC MILITARY WEST" ~ "TRICARE WEST",
      "TRICARE/CHAMPVA SUPPLEMENT PLAN" ~ "TRICARE FOR LIFE",
      c("USAA LIFE INSURANCE CO", "UNITED WORLD LIFE", "thrivent", "Thrivent Financial Lutheran", "TRANSAMERICA PREMIER LIFE", "BEACON HEALTH OPTIONS/ CARELON BEH HEALT", "COLONIAL PENN LIFE INSURANCE CO.", "COMPANION LIFE", "CRIME VICTIMS", "CSI- MEDICARE SUPPLEMENT", "GLOBE LIFE & ACCIDENT", "HOME STATE HEALTH PLAN", "LINECO", "LUMICO", "MANHATTAN LIFE INSURANCE COMPANY", "MEDICA", "MEDICAL MUTUAL", "MEDICO CORP LIFE INSURANCE COMPANY", "MEDICO INSURANCE CO", "MEDIPLUS", "MISSOURI HEALTHNET", "MO Healthnet", "MUTUAL OF OMAHA", "MUTUAL OF OMAHA EAP", "NATIONAL GENERAL", "OLD SURETY", "OLD SURETY LIFE", "PHYSICIANS MUTUAL", "SELMAN & COMPANY", "STATE FARM INSURANCE CO") ~ "OTHER",
      .default = ins_sec
    )
  ) |>
  select(ins_prim, ins_sec, sec)

clean_rpt <- clean_rpt |>
  left_join(sec_key, by = join_by(ins_prim, ins_sec)) |>
  relocate(sec, .before = ins_sec) |>
  mutate(ins_sec = sec, sec = NULL)

invalid_hcpcs_key <- clean_rpt |>
  filter(
    !stringfish::sf_grepl(
      hcpcs_code,
      "^[A-CEGHJ-MP-V0-9]\\d{3}[AFMTU0-9]$"
    )
  ) |>
  count(hcpcs_code, hcpcs_desc) |>
  mutate(
    alert = case_match(
      hcpcs_code,
      c("NOSHOW", "MISSEDAPPT") ~ "NO SHOW",
      c("MEDREC", "REPORT", "MATERIALCTR", "MATERIALIVA", "MATERIALOFF", "FREEFORM", "LETTER") ~ "MEDICAL RECORDS",
      c("SPBARIATRIC", "STUDENT") ~ "SELF PAY",
      c("MINDBLOOM18TREA", "MINDBLOOM2TREAT", "MINDBLOOM3TREAT", "MINDBLOOM3TREAT", "MINDBLOOM6TREAT", "MINDBLOOMFULLTR") ~ "OTHER",
      "COPARFU" ~ "FOLLOW UP",
      "WCPAIN" ~ "WORK COMP",
      "UNTIMELY" ~ "UNTIMELY",
      "UNAPPLIEDPAYMEN" ~ "UNAPPLIED PAYMENT",
      "NOCHARGE" ~ "NO CHARGE",
      "000000" ~ "TELEHEALTH",
      .default = NA_character_
    )
  ) |>
  select(hcpcs_code, hcpcs_desc, other_desc = alert)

clean_rpt <- clean_rpt |>
  left_join(invalid_hcpcs_key, by = join_by(hcpcs_code, hcpcs_desc)) |>
  relocate(other_desc, .after = hcpcs_desc) |>
  mutate(
    hcpcs_code = if_else(!is.na(other_desc), other_desc, hcpcs_code),
    hcpcs_desc = if_else(!is.na(other_desc), other_desc, hcpcs_desc),
    other_desc = NULL
  )

clean_rpt <- clean_rpt |>
  select(-ins_pmt, -ins_adj) |>
  rename(allowed = ins_allow, ptage = pt_age) |>
  mutate(hcpcs_unit = abs(hcpcs_unit),
         charges = abs(charges),
         adjustments = abs(adjustments),
         allowed = abs(allowed),
         dor = if_else(dor_lag < 0, dor + (abs(dor_lag) * 2), dor),
         dor_lag = abs(dor_lag))

#--------------------------------- Providers ####

provider_base <- vctrs::vec_rbind(
  clean_rpt |>
    filter(!is.na(referring_provider)) |>
    distinct(referring_provider) |>
    reframe(
      provider = stringr::str_to_title(stringr::str_replace_all(referring_provider, "-", " ")),
      type = "Referring"),
  clean_rpt |>
    filter(!is.na(rendering_provider)) |>
    distinct(rendering_provider) |>
    reframe(
      provider = stringr::str_to_title(stringr::str_replace_all(rendering_provider, "-", " ")),
      type = "Rendering")) |>
  distinct(provider, .keep_all = TRUE) |>
  mutate(name_fmt = humaniformat::parse_names(provider)) |>
  unpack(name_fmt) |>
  mutate(middle_name = str_squish(middle_name),
         first_name = if_else(first_name == "J.", "John", first_name)) |>
  select(provider, type, first_name, middle_name, last_name) |>
  print(n = 300)

provider_base |> print(n = 300)

orgs <- c(
  "Olathe West Counselor",
  "Olathe Schools Summit Trails Ms",
  "Chisholm Trail Ms Olathe",
  "Mission Trails Ms Olathe",
  "Leawood Pediatrics",
  "Barton Community College",
  "Shawnee Mission Pediatrics",
  "Joco Mental  Health",
  "Children's Mercy Clinic",
  "Vibrant Health",
  "Paces Kck",
  "Responsive Management Clinic, Inc.",
  "Tricare  Insurance"
)

org_base <- provider_base |> filter(provider %in% orgs)
ind_base <- provider_base |> filter(!provider %in% orgs)

# skimr::skim(clean_rpt)

# readr::write_csv(clean_rpt, here::here("data", "clean_rpt.csv"))
# readr::write_csv(provider_base, here::here("data", "provider_base.csv"))
# nppes_summary <- readr::read_csv(here::here("data", "nppes_summary.csv"))

clean_rpt <- clean_rpt |>
  dplyr::left_join(
    ind_transfer |>
      dplyr::filter(type == "Referring") |>
      dplyr::reframe(
        referring_provider = provider,
        referring_credential = credential,
        referring_taxonomy = taxonomy)
  ) |>
  dplyr::left_join(
    ind_transfer |>
      dplyr::filter(type == "Rendering") |>
      dplyr::reframe(
        rendering_provider = provider,
        rendering_credential = credential,
        rendering_taxonomy = taxonomy)
  )


#--------------------------------- Providers ####
rendering_key <- clean_rpt |>
  distinct(rendering_provider) |>
  mutate(key = stringr::str_glue("PROV{fuimus::pad_number(dplyr::row_number())}") |> as.character())

clean_rpt_rend <- clean_rpt |>
  left_join(rendering_key, by = join_by(rendering_provider)) |>
  relocate(key, .before = rendering_provider) |>
  select(-rendering_provider) |>
  rename(render = key)

referring_key <- clean_rpt |>
  filter(!is.na(referring_provider)) |>
  distinct(referring_provider) |>
  mutate(key = stringr::str_glue("REFR{fuimus::pad_number(dplyr::row_number())}") |> as.character())

clean_rpt_rend <- clean_rpt_rend |>
  left_join(referring_key, by = join_by(referring_provider)) |>
  relocate(key, .before = referring_provider) |>
  select(-referring_provider) |>
  rename(refer = key)

clean_rpt_rend <- clean_rpt_rend |>
  dplyr::select(
    id = ptid,
    enc = ptenc,
    dos,
    dob,
    age = ptage,
    dor,
    lag = dor_lag,
    ref = refer,
    ref_cred = referring_credential,
    ref_tax = referring_taxonomy,
    ren = render,
    ren_cred = rendering_credential,
    ren_tax = rendering_taxonomy,
    icd = icd_code,
    ord = hcpcs_order,
    hcpcs = hcpcs_code,
    desc = hcpcs_desc,
    units = hcpcs_unit,
    mod1 = hcpcs_mod_1,
    mod2 = hcpcs_mod_2,
    pos,
    pos_name,
    loc = location,
    ins_class,
    ins_prim,
    ins_sec,
    charges,
    allowed,
    payments,
    adjustments,
    adj1 = adj_code_1,
    adj2 = adj_code_2,
    adj3 = adj_code_3
  )


readr::write_csv(clean_rpt_rend, "C:/Users/Andrew/Desktop/Repositories/acephale/posts/claims/data/clean_rpt_rend.csv")

resp_prov_base <- clean_rpt |>
  mutate(
    rendering = toupper(rendering_provider),
    rendering_names = humaniformat::parse_names(rendering),
    .after = rendering_provider) |>
  unpack(rendering_names) |>
  select(rendering_provider, first_name, middle_name, last_name) |>
  distinct()

resp_prov_base <- resp_prov_base |>
  dplyr::mutate(first_name = dplyr::case_match(
    first_name,
    "J." ~ "JOHN",
    .default = first_name
  )) |>
  dplyr::full_join(
    nppes_summary |>
      dplyr::rename(first_name = first, middle_name = middle, last_name = last),
    by = join_by(
      first_name,
      # middle_name,
      last_name
    )
  )

resp_prov_base |>
  filter(!is.na(npi)) |>
  select(-c(contains("name"))) |>
  distinct() |>
  print(n = 200)

# readr::write_csv(clean_rpt, "C:/Users/Andrew/Desktop/Repositories/acephale/posts/claims/data/clean_rpt.csv")

# mutate(year = clock::get_year(dos),
#        qtr = lubridate::quarter(dos, with_year = TRUE),
#        month = clock::date_month_factor(dos),
#        .after = dos)

# Place of Service,
# HCPCS descriptions,
# ICD-10-CM descriptions
rpt |>
  left_join(
    search_pos()[c("pos_code", "pos_type", "pos_name")],
    by = join_by(pos == pos_code)) |>
  left_join(
    describe_hcpcs(desc_type = "Long") |>
      select(
        hcpcs_code = hcpcs,
        hcpcs_sect = section,
        hcpcs_desc = description
      ), by = join_by(hcpcs_code)
  ) |>
  separate_longer_delim(icd_code, delim = ",") |>
  left_join(
    icd10cm() |>
      unnest(icd_ch_sec) |>
      unnest(icd_sec_code) |>
      select(
        icd_code,
        icd_desc = icd_description,
        icd_sect = icd_sec_name,
        icd_chap = icd_ch_name
      ), by = join_by(icd_code)
  ) |>
  relocate(c(pos_type, pos_name), .after = pos) |>
  relocate(c(hcpcs_sect, hcpcs_desc), .after = hcpcs_code) |>
  relocate(c(icd_chap, icd_sect, icd_desc), .after = icd_code) |>
  print(n = 100)

# HCPCS Modifiers
mods <- rpt |>
  select(hcpcs_mod_1, hcpcs_mod_2) |>
  pivot_longer(everything(), values_drop_na = TRUE) |>
  distinct(value) |>
  mutate(value = str_to_upper(value)) |>
  pull(value)

search_modifiers(mod = mods)

# Adjustment Codes
rpt |>
  select(adj_code_1, adj_code_2, adj_code_3) |>
  pivot_longer(everything(), values_drop_na = TRUE) |>
  distinct(value) |>
  separate_wider_delim(
    value,
    delim = "-",
    names = c("group", "code"),
    too_few = "align_end"
  ) |>
  mutate(
    group = if_else(is.na(group), code, group),
    group = na_if(group, ""),
    code = if_else(code == "CR", NA_character_, code),
  ) |>
  left_join(
    search_adjustments()$group,
    by = join_by(group == code)) |>
  rename(group_desc = description) |>
  left_join(
    search_adjustments()$carc[c("code", "description")],
    by = join_by(code)) |>
  print(n = 100)
