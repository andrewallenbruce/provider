parse_url <- function(x) {
  path_rex <- "^.*(?=[0-9a-fA-F]{8}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{12})"
  uuid_rex <- "(?:[0-9a-fA-F]){8}-?(?:[0-9a-fA-F]){4}-?(?:[0-9a-fA-F]){4}-?(?:[0-9a-fA-F]){4}-?(?:[0-9a-fA-F]){12}"
  tail_rex <- "(?<=[0-9a-fA-F]{8}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{12}).*$"
  list(
    path = stringi::stri_extract_first_regex(x, path_rex),
    uuid = stringi::stri_extract_first_regex(x, uuid_rex),
    tail = stringi::stri_extract_first_regex(x, tail_rex)
  )
}

# UUIDs are 36 characters
x <- api_medicare()

x |>
  fastplyr::as_tbl()
# print(n = Inf) |>
# collapse::sbt(stringr::str_which(title, "Hospital Price")) |>
_$identifier |>
  parse_url()
