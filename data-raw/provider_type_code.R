## code to prepare `provider_type_code` dataset goes here

link <- "https://data.cms.gov/sites/default/files/2025-10/1e42b271-dfe0-4c64-8022-0c507993667e/PPEF_Data_Dictionary.pdf"
dict <- tabulapdf::extract_tables(file = link)[3:8]

provider_type <- dict |>
  purrr::map(\(x) {
    collapse::ss(x, j = 1:2) |>
      rlang::set_names(c("code", "description"))
  }) |>
  collapse::rowbind() |>
  collapse::sbt(!is.na(code)) |>
  collapse::rowbind(cheapr::fast_df(
    code = "00-24",
    description = "PART A PROVIDER - RURAL EMERGENCY HOSPITAL"
  )) |>
  collapse::mtt(
    description = cheapr::if_else_(
      code == "00-14",
      "PART A PROVIDER - OUTPATIENT PHYSICAL THERAPY/OCCUPATIONAL THERAPY/SPEECH PATHOLOGY SERVICES",
      description
    ),
    type = substring(code, 1, 2),
    spec = substring(code, 4, 5),
    type_description = cheapr::case(
      stringr::str_detect(
        description,
        "PART A PROVIDER - "
      ) ~ "PART A PROVIDER",
      stringr::str_detect(
        description,
        "PART B SUPPLIER - "
      ) ~ "PART B SUPPLIER",
      stringr::str_detect(description, "PRACTITIONER - ") ~ "PRACTITIONER",
      stringr::str_detect(description, "DME SUPPLIER - ") ~ "DME SUPPLIER",
      stringr::str_detect(
        description,
        "ORDER AND REFERRING ONLY - "
      ) ~ "ORDER AND REFERRING ONLY",
      stringr::str_detect(description, "MDPP SUPPLIER - ") ~ "MDPP SUPPLIER",
      .default = NA_character_
    ),
    description = stringr::str_remove_all(
      description,
      paste0(type_description, " - ")
    )
  ) |>
  collapse::colorder(code, type, type_description, spec, description) |>
  collapse::rnm(description = spec_description) |>
  collapse::roworder(type, spec)

usethis::use_data(provider_type_code, overwrite = TRUE)

########################################################

provider_type_code |>
  collapse::fcount(type, type_description)

spec_dupes <- provider_type_code |>
  collapse::fcount(spec) |>
  collapse::roworder(-N) |>
  collapse::sbt(N > 1) |>
  _$spec

provider_type_code |>
  collapse::sbt(spec %in% spec_dupes) |>
  collapse::roworder(spec, type)


provider_type_vars <- function(code) {
  cheapr::val_match(
    code,
    # PART A PROVIDER
    "00-00" ~ "rnhci",
    "00-01" ~ "cmhc",
    "00-02" ~ "corf",
    "00-03" ~ "esrd",
    "00-04" ~ "fqhc",
    "00-05" ~ "hla",
    "00-06" ~ "hha",
    "00-08" ~ "hospice",
    "00-09" ~ "hospital",
    "00-10" ~ "ihs",
    "00-13" ~ "opo",
    "00-14" ~ "opt",
    "00-17" ~ "rhc",
    "00-18" ~ "snf",
    "00-19" ~ "other",
    "00-24" ~ "reh",
    "00-85" ~ "cah",
    # PART B SUPPLIER
    "12-23" ~ "sports",
    "12-31" ~ "card_rehab",
    "12-45" ~ "mam",
    "12-47" ~ "idtf",
    "12-49" ~ "asc",
    "12-59" ~ "amb",
    "12-60" ~ "phwa",
    "12-61" ~ "vhca",
    "12-63" ~ "pxrs",
    "12-65" ~ "optg",
    "12-69" ~ "icl",
    "12-70" ~ "clinic",
    "12-73" ~ "mvax",
    "12-74" ~ "rtc",
    "12-75" ~ "slide",
    "12-87" ~ "other",
    "12-A5" ~ "pharma",
    "12-C0" ~ "sleep",
    "12-C1" ~ "flu",
    "12-C3" ~ "card_int",
    "12-D5" ~ "otp",
    "12-D6" ~ "hit",
    "12-Z1" ~ "hdept",
    "12-Z4" ~ "mfpp",
    "12-Z5" ~ "grp_oth",
    # ORDER AND REFERRING ONLY
    "33-01" ~ "practice",
    "33-02" ~ "surgery",
    "33-03" ~ "immunology",
    "33-04" ~ "oto",
    "33-05" ~ "anes",
    "33-06" ~ "cardio",
    "33-07" ~ "derma",
    "33-08" ~ "family",
    "33-09" ~ "pain",
    "33-10" ~ "gastro",
    "33-11" ~ "internal",
    "33-12" ~ "osteo",
    "33-13" ~ "neuro",
    "33-14" ~ "surg_neuro",
    "33-15" ~ "speech",
    "33-16" ~ "obgyn",
    "33-17" ~ "hospice",
    "33-18" ~ "ophthalmology",
    "33-19" ~ "oral",
    "33-20" ~ "surg_ortho",
    "33-21" ~ "electro",
    "33-22" ~ "path",
    "33-23" ~ "sports",
    "33-24" ~ "plastic",
    "33-25" ~ "rehab",
    "33-26" ~ "psych",
    "33-27" ~ "psych_geri",
    "33-28" ~ "colorectal",
    "33-29" ~ "pulmonary",
    "33-30" ~ "rad_diag",
    "33-33" ~ "surg_thor",
    "33-34" ~ "uro",
    "33-35" ~ "chiro",
    "33-36" ~ "nuclear",
    "33-37" ~ "peds",
    "33-38" ~ "geri",
    "33-39" ~ "nephro",
    "33-40" ~ "surg_hand",
    "33-41" ~ "opto",
    "33-42" ~ "cnm", # certified nurse midwife
    "33-43" ~ "crna", # certified registered nurse anesthetist
    "33-44" ~ "infectious",
    "33-46" ~ "endo",
    "33-48" ~ "foot",
    "33-50" ~ "np", # nurse practitioner
    "33-62" ~ "psych_ind",
    "33-64" ~ "audio",
    "33-65" ~ "phys_therapist",
    "33-66" ~ "rheuma",
    "33-67" ~ "opt_ind",
    "33-68" ~ "psych_clin",
    "33-71" ~ "diet",
    "33-72" ~ "pain",
    "33-76" ~ "pvd",
    "33-77" ~ "vasc",
    "33-78" ~ "surg_card",
    "33-79" ~ "addiction",
    "33-80" ~ "csw",
    "33-81" ~ "critical",
    "33-82" ~ "hema",
    "33-83" ~ "hema_onco",
    "33-84" ~ "prevent",
    "33-85" ~ "surg_maxi",
    "33-86" ~ "neuropsych",
    "33-88" ~ "other_non",
    "33-89" ~ "cns",
    "33-90" ~ "onco_med",
    "33-91" ~ "onco_srg",
    "33-92" ~ "onco_rad",
    "33-93" ~ "emergency",
    "33-94" ~ "rad_int",
    "33-97" ~ "pa",
    "33-98" ~ "onco_gyno",
    "33-99" ~ "other_phys",
    "33-C0" ~ "sleep",
    "33-C3" ~ "card_int",
    "33-C5" ~ "dentist",
    "33-C6" ~ "hospitalist",
    "33-C7" ~ "txp",
    "33-C8" ~ "tox",
    "33-C9" ~ "cells",
    "33-D3" ~ "geno",
    "33-D4" ~ "hyper",
    "33-D7" ~ "mds",
    # MDPP SUPPLIER
    "53-D1" ~ "mdpp",
    .default = NA_character_
  )
}

x <- provider_type_code |>
  # collapse::mtt(variable = provider_type_vars(code)) |>
  # collapse::sbt(is.na(variable)) |>
  collapse::rsplit(~type)

x$`14`

x$`30` |>
  fastplyr::as_tbl() |>
  collapse::mtt(
    spec_description = cheapr::val_match(
      spec_description,
      "ORAL SURGERY - DENTIST" ~ "DENTIST - ORAL SURGERY",
      "MULTI-SPECIALTY - PHYSICIAN" ~ "PHYSICIAN - MULTI-SPECIALTY",
      .default = spec_description
    ),
    desc2 = stringi::stri_extract_first_regex(
      spec_description,
      pattern = providertwo:::str_look(
        pattern = " - ",
        look = "ahead"
      )
    ),
    desc2 = cheapr::if_else_(is.na(desc2), spec_description, desc2),
    spec_description = NULL,
    variable = cheapr::val_match(
      spec,
      "01" ~ "practice",
      "02" ~ "surgery",
      "03" ~ "immuno",
      "04" ~ "oto",
      "05" ~ "anes",
      "06" ~ "cardio",
      "07" ~ "derma",
      "08" ~ "family",
      "09" ~ "pain",
      "10" ~ "gastro",
      "11" ~ "internal",
      "12" ~ "osteo",
      "13" ~ "neuro",
      "14" ~ "surg_neuro",
      "15" ~ "speech",
      "16" ~ "obgyn",
      "17" ~ "hospice",
      "18" ~ "ophthalmology",
      "19" ~ "surg_oral",
      "20" ~ "surg_ortho",
      "21" ~ "electro",
      "22" ~ "path",
      "23" ~ "sports",
      "24" ~ "plastic",
      "25" ~ "rehab",
      "26" ~ "psych",
      "27" ~ "psych_geri",
      "28" ~ "surg_colo",
      "29" ~ "pulmonary",
      "30" ~ "rad_diag",
      "33" ~ "surg_thor",
      "34" ~ "uro",
      "35" ~ "chiro",
      "36" ~ "nuclear",
      "37" ~ "peds",
      "38" ~ "geri",
      "39" ~ "neph",
      "40" ~ "surg_hand",
      "41" ~ "opto",
      "42" ~ "cnm", # certified nurse midwife
      "43" ~ "crna", # certified registered nurse anesthetist
      "44" ~ "infectious",
      "46" ~ "endo",
      "48" ~ "feet",
      "49" ~ "asc",
      "50" ~ "np", # nurse practitioner
      "62" ~ "psych_ind",
      "64" ~ "audio",
      "65" ~ "physio",
      "66" ~ "rheuma",
      "67" ~ "opt_ind",
      "68" ~ "psych_clin",
      "70" ~ "multi_spec",
      "71" ~ "diet",
      "72" ~ "pain",
      "76" ~ "pvd",
      "77" ~ "vasc",
      "78" ~ "surg_card",
      "79" ~ "addiction",
      "80" ~ "csw",
      "82" ~ "hema",
      "83" ~ "hema_onco",
      "84" ~ "prevent",
      "85" ~ "surg_maxi",
      "86" ~ "neuropsych",
      "87" ~ "dme_other",
      "88" ~ "dme_unknown",
      "89" ~ "cns",
      "90" ~ "onco_med",
      "91" ~ "onco_srg",
      "92" ~ "onco_rad",
      "93" ~ "emergency",
      "94" ~ "rad_int",
      "97" ~ "pa",
      "98" ~ "onco_gyno",
      "99" ~ "unknown_phys",
      "A5" ~ "pharma",
      "B1" ~ "oxygen",
      "B2" ~ "pedorth",
      "B3" ~ "msc_ped",
      "B4" ~ "rehab",
      "B5" ~ "ocular",
      "C0" ~ "sleep",
      .default = NA_character_
    )
  ) |>
  print(n = Inf)
