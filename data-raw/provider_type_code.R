## code to prepare `provider_type_code` dataset goes here

doc_dict <- tabulapdf::extract_tables(
  file = "https://data.cms.gov/sites/default/files/2025-10/1e42b271-dfe0-4c64-8022-0c507993667e/PPEF_Data_Dictionary.pdf"
)

provider_type_code <- doc_dict[3:8] |>
  purrr::map(\(x) {
    collapse::ss(x, j = 1:2) |>
      rlang::set_names(c("code", "description"))
  }) |>
  collapse::rowbind() |>
  collapse::sbt(!is.na(code)) |>
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
  collapse::frename(description = spec_description)

usethis::use_data(provider_type_code, overwrite = TRUE)

provider_type_code |>
  collapse::fcount(type, type_description)

provider_type_code |>
  collapse::rsplit(~type_description)
