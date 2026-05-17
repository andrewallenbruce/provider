library(provider)
library(collapse)
library(pillar)

nppes_json <- fs::path(here::here("data-raw"), "nppes", ext = "json")
x <- llmjson::repair_json_file(nppes_json, return_objects = FALSE)
x <- RcppSimdJson::fparse(x)$results |> data_frame()

# Remove created_epoch/last_epoch/endpoints fields
collapse::gvr(x, "epoch|endpoints") <- NULL
x

# TBL 1: Primary Key
key <- new_data_frame(
  number = as.integer(x$number),
  entity = cheapr::val_match(
    x$enumeration_type,
    "NPI-1" ~ 1L,
    "NPI-2" ~ 2L,
    .default = NA_integer_
  )
)

# TBL 2: BASIC
basic <- set_names(x$basic, x$number) |>
  collapse::unlist2d(idcols = c("number", "var")) |>
  collapse::qTBL() |>
  collapse::recode_char(
    "--" = NA_character_,
    # "." = "",
    "certification_date" = "cert_date",
    "enumeration_date" = "enum_date",
    "last_updated" = "updated",
    "sole_proprietor" = "sole",
    "credential" = "cred",
    "first_name" = "first",
    "middle_name" = "middle",
    "last_name" = "last",
    fixed = TRUE
  )

basic <- collapse::ss(
  basic,
  basic$var %!iin% c("status", "name_prefix", "name_suffix")
) |>
  collapse::pivot(
    ids = "number",
    how = "w",
    names = "var",
    values = "V1",
    check.dups = TRUE
  ) |>
  rc_integer("number") |>
  rc_bin("sole") |>
  rc_ymd(c("enum_date", "cert_date", "updated"))

basic

# TBL 4: PRACTICE LOCATIONS
location <- set_names(x$practiceLocations, x$number) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(
    idcol = "number",
    fill = TRUE,
    id.factor = TRUE,
    return = 4L
  ) |>
  collapse::recode_char("--" = NA_character_) |>
  collapse::gvr("^number$|^address_[12p]|^city$|^state$|postal|phone") |>
  collapse::funique() |>
  collapse::rnm(
    address = "address_1",
    add_2 = "address_2",
    phone = "telephone_number",
    purpose = "address_purpose",
    zip = "postal_code"
  ) |>
  rc_address() |>
  collapse::roworderv(c("number")) |>
  collapse::qTBL()

collapse::settfmv(location, "number", as.character)
collapse::settfmv(location, "number", as.integer)
collapse::settfmv(location, "purpose", tolower)
location

# TBL 3: ADDRESS
address <- set_names(x$addresses, x$number) |>
  collapse::rowbind(
    idcol = "number",
    fill = TRUE,
    id.factor = TRUE,
    return = 4L
  ) |>
  collapse::gvr("^number$|^address_[12p]|^city$|^state$|postal|phone") |>
  collapse::funique() |>
  collapse::rnm(
    address = "address_1",
    add_2 = "address_2",
    phone = "telephone_number",
    purpose = "address_purpose",
    zip = "postal_code"
  ) |>
  rc_address() |>
  collapse::roworderv(c("number", "purpose"))

collapse::settfmv(address, "number", as.character)
collapse::settfmv(address, "number", as.integer)
collapse::settfmv(address, "purpose", tolower)


address$phone <- cheapr::if_else_(
  cheapr::is_na(address$phone) & address$purpose == "mailing",
  cheapr::lag_(address$phone),
  address$phone
)

## Which addresses are identical
address <- collapse::rsplit(address, ~purpose)

L <- as.list(address$location)
LL <- set_names(
  purrr::map(collapse::t_list(unname(L)), paste0, collapse = ""),
  L$number
)

M <- as.list(address$mailing)
MM <- set_names(
  purrr::map(collapse::t_list(unname(M)), paste0, collapse = ""),
  M$number
)

# x <- secretbase::shake256("secret base", bits = 32L, convert = NA)
# y <- secretbase::shake256("secret base", bits = 32L, convert = NA)
# identical(x, y)
# waldo::compare(LL, MM, max_diffs = 200, quote_strings = FALSE)

veq <- vctrs::vec_equal(LL, MM)
both <- names(MM[cheapr::which_(veq, invert = TRUE)])
one <- names(MM[cheapr::which_(veq)])

address <- collapse::rowbind(
  mailing = collapse::ss(address$mailing, address$mailing$number %iin% both),
  location = collapse::ss(
    address$location,
    address$location$number %iin% c(both, one)
  ),
  idcol = "purpose",
  id.factor = FALSE
) |>
  collapse::roworderv(c("number", "purpose"))

collapse::rowbind(
  location,
  address
) |>
  collapse::roworderv(c("number", "address", "purpose")) |>
  collapse::fcountv("number", add = TRUE) |>
  collapse::roworderv("N", decreasing = TRUE) |>
  print(n = Inf)

collapse::join(key, basic, on = "number") |>
  collapse::join(address, on = "number", multiple = TRUE)


other_names <- set_names(x$other_names, x$number) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "number", fill = TRUE, id.factor = FALSE) |>
  collapse::recode_char("--" = NA_character_) |>
  collapse::qTBL()

set_names(x$identifiers, x$number) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "number", fill = TRUE, id.factor = FALSE) |>
  collapse::recode_char("--" = NA_character_) |>
  collapse::qTBL()

set_names(x$taxonomies, x$number) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "number", fill = TRUE, id.factor = FALSE) |>
  collapse::recode_char("--" = NA_character_) |>
  provider:::replace_nz() |>
  collapse::qTBL()

collapse::rnm(
  ex,
  c(
    add_purp = "address_purpose",
    zip = "postal_code",
    enum_type = "enumeration_type",
    tx_group = "tx_taxonomy_group",
    id_ID = "id_identifier"
  ),
  .nse = FALSE
)
