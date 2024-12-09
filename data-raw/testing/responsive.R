# provider_base <- readr::read_csv(here::here("data", "provider_base.csv"), show_col_types = FALSE)

nppes_kansas <- function(...) {provider::nppes(state = "KS", ...)}
nppes_missouri <- function(...) {provider::nppes(state = "MO", ...)}

ind_names <- ind_base |>
  select(first = first_name, last = last_name)

ind_kansas <- purrr::pmap(ind_names, nppes_kansas) |> purrr::list_rbind() |>
  dplyr::select(npi, enum_date, first, middle, last, gender, credential, tx_code, tx_primary, tx_desc, city, state) |>
  dplyr::distinct()

ind_kansas <- dplyr::full_join(
  ind_kansas |> dplyr::group_split(tx_primary) |> purrr::pluck(2),
  ind_kansas |> dplyr::group_split(tx_primary) |> purrr::pluck(1) |> dplyr::mutate(tx_other = TRUE, tx_primary = NULL)) |>
  dplyr::arrange(npi) |>
  dplyr::mutate(tx_primary = dplyr::if_else(is.na(tx_primary), FALSE, tx_primary), tx_other = NULL)

ind_missouri <- purrr::pmap(ind_names, missouri) |> purrr::list_rbind() |>
  dplyr::select(npi, enum_date, first, middle, last, gender, credential, tx_code, tx_primary, tx_desc, city, state) |>
  dplyr::distinct()

ind_missouri <- dplyr::full_join(
  ind_missouri |> dplyr::group_split(tx_primary) |> purrr::pluck(2),
  ind_missouri |> dplyr::group_split(tx_primary) |> purrr::pluck(1) |> dplyr::mutate(tx_other = TRUE, tx_primary = NULL)) |>
  dplyr::arrange(npi) |>
  dplyr::mutate(tx_primary = dplyr::if_else(is.na(tx_primary), FALSE, tx_primary), tx_other = NULL) |>
  print(n = 300)

ind_joined <- dplyr::left_join(
  ind_base |> dplyr::reframe(provider, type, first = toupper(first_name), middle = toupper(middle_name), last = toupper(last_name)) |> dplyr::arrange(last),
  vctrs::vec_rbind(ind_kansas, ind_missouri) |> dplyr::distinct(npi, tx_code, .keep_all = TRUE) |> dplyr::arrange(last),
  by = dplyr::join_by(first, last)) |>
  dplyr::mutate(middle = dplyr::if_else(is.na(middle.x), middle.y, middle.x), .before = middle.x) |>
  dplyr::select(-c(middle.y, middle.x, city, state))

# tx_kansas <- provider::taxonomies(code = npi_kansas |> dplyr::pull(tx_code))
# tx_missouri <- provider::taxonomies(code = npi_missouri |> dplyr::pull(tx_code))
# tx_responsive <- provider::taxonomies(code = npi_responsive |> dplyr::pull(tx_code))

# can't find Jane Carver

ind_names_hard <- dplyr::tibble(
  first = c("KRISTINA", "JANE", "LORI", "ALLISON", "GRANT"),
  last = c("WEEKS", "CARVER", "BELL", "EMMONS", "EDWARDS")
)

ind_stragglers <- purrr::pmap(ind_names_hard, provider::nppes) |> purrr::list_rbind() |>
  dplyr::select(npi, enum_date, first, middle, last, gender, credential, tx_code, tx_primary, tx_desc) |>
  dplyr::distinct() |>
  dplyr::filter(!first %in% c("LAURIE", "LORRAINE", "ALYSON", "JAN", "CHRISTINA")) |>
  dplyr::mutate(last = if_else(first == "LORI" & last == "BELL", NA_character_, last)) |>
  dplyr::filter(!is.na(last))

ind_summary <- vctrs::vec_rbind(ind_joined, ind_stragglers) |>
  dplyr::select(provider, type, credential, tx_code, tx_primary, tx_desc) |>
  tidyr::nest(taxonomy = c(tx_code, tx_primary, tx_desc)) |>
  dplyr::distinct(provider, .keep_all = TRUE)

ind_transfer <- ind_base |>
  dplyr::left_join(ind_summary) |>
  dplyr::select(provider, type, credential, taxonomy)
