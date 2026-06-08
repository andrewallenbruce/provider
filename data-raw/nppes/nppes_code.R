library(provider)
library(collapse)
library(pillar)

nppes_json <- fs::path(here::here("data-raw/nppes"), "nppes", ext = "json")
x <- llmjson::repair_json_file(nppes_json, return_objects = FALSE)
x <- RcppSimdJson::fparse(x)$results |> data_frame()

# Remove created_epoch/last_epoch/endpoints fields
collapse::gvr(x, "epoch|endpoints") <- NULL
x

# TBL 1: Primary Key
key <- provider:::new_data_frame(
  number = as.integer(x$number),
  entity = cheapr::val_match(
    x$enumeration_type,
    "NPI-1" ~ 1L,
    "NPI-2" ~ 2L,
    .default = NA_integer_
  )
)

# collapse::any_duplicated(key$number)

# TBL 2: BASIC
basic <- set_names(x$basic, x$number) |>
  collapse::unlist2d(idcols = c("number", "var")) |>
  collapse::qTBL() |>
  collapse::recode_char(
    "--" = NA_character_,
    "certification_date" = "cert_date",
    "enumeration_date" = "enum_date",
    "last_updated" = "updated",
    "sole_proprietor" = "sole",
    "credential" = "cred",
    "first_name" = "first",
    "last_name" = "last",
    fixed = TRUE
  )

basic <- collapse::ss(
  basic,
  basic$var %!iin% c("status", "name_prefix", "name_suffix", "middle_name")
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

key <- collapse::join(key, basic, on = "number") |>
  collapse::roworderv(c("number", "updated"), decreasing = TRUE) |>
  collapse::gv(c(
    "number",
    "entity",
    "cred",
    "first",
    "last",
    "sex",
    "sole",
    "enum_date",
    "cert_date",
    "updated"
  ))

# 1 = Former
# 2 = Professional
# 5 = Other
o_names <- set_names(x$other_names, x$number) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "number", fill = TRUE, id.factor = FALSE) |>
  collapse::recode_char("--" = NA_character_) |>
  collapse::qTBL() |>
  collapse::funique() |>
  collapse::rnm(
    "cred" = "credential",
    "first" = "first_name",
    "last" = "last_name",
    .nse = FALSE
  ) |>
  rc_integer("code") |>
  collapse::gv(c(
    "number",
    "code",
    "first",
    "last",
    "cred"
  )) |>
  collapse::add_stub(stub = "o_", cols = -1)

o_names <- cheapr::new_df(
  number = as.integer(o_names$number),
  onames = list(o_names[-1])
) |>
  collapse::qTBL()

key <- collapse::join(key, o_names, on = "number") |>
  collapse::roworderv(c("number", "updated"), decreasing = TRUE) |>
  collapse::gv(c(
    "number",
    "entity",
    "cred",
    "first",
    "last",
    "sex",
    "sole",
    "enum_date",
    "cert_date",
    "updated",
    "onames"
  ))

# 1 = Other (Non-Medicare)
# 5 = Medicaid
id <- set_names(x$identifiers, x$number) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "number", fill = TRUE, id.factor = FALSE) |>
  collapse::recode_char("--" = NA_character_) |>
  collapse::qTBL() |>
  collapse::funique() |>
  collapse::rnm("id" = "identifier", .nse = FALSE) |>
  collapse::gv(c("number", "state", "id", "issuer")) |>
  collapse::add_stub(stub = "i_", cols = -1)

collapse::setv(id$i_issuer, NA, "Medicaid")

id

id <- cheapr::new_df(
  number = as.integer(id$number),
  ids = list(id[-1])
) |>
  collapse::qTBL()

key <- collapse::join(key, o_names, on = "number") |>
  collapse::roworderv(c("number", "updated"), decreasing = TRUE) |>
  collapse::gv(c(
    "number",
    "entity",
    "cred",
    "first",
    "last",
    "sex",
    "sole",
    "enum_date",
    "cert_date",
    "updated",
    "onames"
  ))


tx <- set_names(x$taxonomies, x$number) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "number", fill = TRUE, id.factor = FALSE) |>
  collapse::recode_char("--" = NA_character_) |>
  provider:::replace_nz() |>
  provider:::rc_trim() |>
  collapse::qTBL() |>
  collapse::funique() |>
  collapse::rnm("group" = "taxonomy_group", .nse = FALSE) |>
  collapse::gv(c(
    "number",
    "code",
    "desc",
    "license",
    "primary",
    "state",
    "group"
  )) |>
  # c("number", "primary")
  rc_integer(c("number")) |>
  collapse::roworderv(c("number", "primary"), decreasing = TRUE) |>
  collapse::add_stub(stub = "tx_", cols = -1) |>
  collapse::fcount(number, add = TRUE)


# vctrs::vec_identify_runs(tx$number)
# vctrs::vec_run_sizes(tx$number)
# vctrs::vec_unrep(tx$number)
#
# tx2 <- collapse::sbt(tx, N == 2L) |>
#   collapse::fgroup_by(number) |>
#   collapse::mtt(
#     tx_code2 = cheapr::lag_(tx_code),
#     tx_equal = tx_code == tx_code2
#     ) |>
#   collapse::colorder(tx_code, tx_code2, tx_equal) |>
#   collapse::fungroup()
#
# tx2 <- collapse::rowbind(
#   collapse::sbt(tx2, tx_primary),
#   collapse::sbt(tx2, !tx_equal)) |>
#   collapse::gv(c(
#     "number",
#     "tx_code",
#     "tx_desc",
#     "tx_license",
#     "tx_primary",
#     "tx_state",
#     "tx_group"
#   )) |>
#   collapse::roworderv(c("number", "tx_primary"))
#
# collapse::sbt(tx, N == 3L) |>
#   collapse::fgroup_by(number) |>
#   collapse::mtt(
#     tx_code2 = cheapr::lag_(tx_code),
#     tx_equal = tx_code == tx_code2
#   ) |>
#   collapse::colorder(tx_code, tx_code2, tx_equal) |>
#   collapse::fungroup()

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

address <- collapse::rowbind(
  location,
  address
) |>
  collapse::roworderv(c("number", "address", "purpose")) |>
  collapse::fcountv("number", add = TRUE) |>
  collapse::roworderv("N", decreasing = TRUE)
