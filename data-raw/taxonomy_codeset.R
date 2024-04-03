## code to prepare dataset goes here
nucc <- provider::download_nucc_csv()

board <- pins::board_folder(here::here("pkgdown/assets/pins-board"))

board |> pins::pin_write(nucc,
                         name = "taxonomy_codes",
                         description = "NUCC Health Care Provider Taxonomy code set",
                         type = "qs")

board |> pins::write_board_manifest()

x <- rvest::session("https://www.nucc.org") |>
  rvest::session_follow_link("Code Sets") |>
  rvest::session_follow_link("Taxonomy") |>
  rvest::session_follow_link("CSV") |>
  rvest::html_elements("a") |>
  rvest::html_attr("href") |>
  stringr::str_subset("taxonomy") |>
  stringr::str_subset("csv")

x <- rvest::session(paste0("https://www.nucc.org", x)) |>
  rvest::session_follow_link("Version")

x <- x$response$url

taxonomy <- data.table::fread(x) |>
  dplyr::tibble() |>
  janitor::clean_names() |>
  dplyr::mutate(
    dplyr::across(dplyr::everything(), ~ dplyr::na_if(., "")),
    dplyr::across(dplyr::everything(), ~ stringr::str_squish(.))) |>
  dplyr::mutate(version = as.character(240),
                release_date = lubridate::ymd("2024-01-01"))
taxonomy <- taxonomy |>
  dplyr::select(
    code,
    display_name,
    section,
    grouping,
    classification,
    specialization,
    definition,
    notes,
    version,
    release_date
  )
# https://www.nucc.org/images/stories/CSV/nucc_taxonomy_240.csv
# "2023-07-01"
# "2024-01-01"

info <- taxonomy |>
  dplyr::select(code, display_name, definition, notes)

long <- taxonomy |>
  dplyr::select(code,
                section,
                grouping,
                classification,
                specialization) |>
  dplyr::mutate(section_level = 0, .before = section) |>
  dplyr::mutate(grouping_level = 1, .before = grouping) |>
  dplyr::mutate(classification_level = 2, .before = classification) |>
  dplyr::mutate(specialization_level = 3, .before = specialization) |>
  tidyr::unite("section", section:section_level, remove = TRUE) |>
  tidyr::unite("grouping", grouping:grouping_level, remove = TRUE) |>
  tidyr::unite("classification", classification:classification_level, remove = TRUE, na.rm = TRUE) |>
  tidyr::unite("specialization", specialization:specialization_level, remove = TRUE, na.rm = TRUE) |>
  tidyr::pivot_longer(!code, names_to = "level", values_to = "description") |>
  dplyr::filter(description != "3") |>
  tidyr::separate_wider_delim(description, delim = "_", names = c("description", "group")) |>
  dplyr::mutate(group = NULL,
                level = factor(level,
                               levels = c("section", "grouping", "classification", "specialization"),
                               labels = c("I. Section", "II. Grouping", "III. Classification", "IV. Specialization"),
                               ordered = TRUE))

longnest <- long |>
  dplyr::left_join(info, by = "code") |>
  tidyr::nest(hierarchy = c(level, description)) |>
  dplyr::select(code, display_name, hierarchy, definition, notes)

# Update Pin
board <- pins::board_folder(here::here("inst/extdata/pins"))

board |>
  pins::pin_write(taxonomy,
                  name = "taxonomy",
                  title = "Provider Taxonomy Code Set",
                  description = "NUCC Health Care Provider Taxonomy Code Set January 2024",
                  type = "qs")

board |>
  pins::pin_write(longnest,
                  name = "taxlong",
                  title = "Provider Taxonomy Code Set",
                  description = "NUCC Health Care Provider Taxonomy Code Set January 2024",
                  type = "qs")

board |> pins::write_board_manifest()

# pins::pin_search(board)
# pins::pin_delete(board, "tax_long")
