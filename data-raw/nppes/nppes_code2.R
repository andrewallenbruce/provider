library(provider)
library(collapse)
library(pillar)

nppes_ao <- fs::path(here::here("data-raw/nppes"), "nppes_ao", ext = "json")
x <- llmjson::repair_json_file(nppes_ao, return_objects = FALSE)
x <- RcppSimdJson::fparse(x)$results |> provider:::data_frame()

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

# TBL 2: BASIC
basic <- rlang::set_names(x$basic, x$number) |>
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
    "authorized_official_title_or_position" = "cred",
    "authorized_official_first_name" = "first",
    "authorized_official_last_name" = "last",
    "organization_name" = "org_name",
    "organizational_subpart" = "subpart",
    fixed = TRUE
  )

basic <- collapse::ss(
  basic,
  basic$var %!iin%
    c(
      "status",
      "name_prefix",
      "name_suffix",
      "middle_name",
      "authorized_official_telephone_number"
    )
) |>
  collapse::pivot(
    ids = "number",
    how = "w",
    names = "var",
    values = "V1",
    check.dups = TRUE
  ) |>
  provider:::rc_bin("subpart") |>
  provider:::rc_ymd(c("enum_date", "cert_date", "updated"))

collapse::settransformv(basic, "number", as.integer)

key <- collapse::join(key, basic, on = "number")

# TBL 2: TAXONOMIES
tx <- rlang::set_names(x$taxonomies, x$number) |>
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
  collapse::roworderv(c("number", "primary"), decreasing = TRUE) |>
  collapse::add_stub(stub = "tx_", cols = -1)

collapse::settransformv(tx, c("tx_state", "tx_license"), as.character)
collapse::settransformv(tx, "number", as.integer)
tx

# tx <- cheapr::as_df(tx)
# res <- vctrs::vec_split(tx[colnames(tx)[-1]], tx["number"])
# tx <- vctrs::vec_cbind(res$key, tibble::new_tibble(list(tx = res$val)))

key <- collapse::join(key, tx, on = "number")

# TBL 7: ADDRESSES
address <- rlang::set_names(x$addresses, x$number) |>
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
    phone = "telephone_number",
    purpose = "address_purpose",
    zip = "postal_code"
  ) |>
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
LL <- rlang::set_names(
  purrr::map(collapse::t_list(unname(L)), paste0, collapse = ""),
  L$number
)

M <- as.list(address$mailing)
MM <- rlang::set_names(
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

key <- collapse::join(key, address, on = "number")

#########################################################
nppes_type2 <- fs::path(
  here::here("data-raw/nppes"),
  "nppes_type2",
  ext = "json"
)

x <- llmjson::repair_json_file(nppes_type2, return_objects = FALSE)
x <- RcppSimdJson::fparse(x)$results |> provider:::data_frame()
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

# TBL 2: BASIC
basic <- rlang::set_names(x$basic, x$number) |>
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
    "authorized_official_title_or_position" = "title",
    "authorized_official_credential" = "cred",
    "authorized_official_first_name" = "first",
    "authorized_official_last_name" = "last",
    "organization_name" = "org_name",
    "organizational_subpart" = "subpart",
    fixed = TRUE
  )

basic <- collapse::ss(
  basic,
  basic$var %!iin%
    c(
      "status",
      "name_prefix",
      "name_suffix",
      "middle_name",
      "authorized_official_telephone_number",
      "authorized_official_name_prefix"
    )
) |>
  collapse::pivot(
    ids = "number",
    how = "w",
    names = "var",
    values = "V1",
    check.dups = TRUE
  ) |>
  provider:::rc_bin("subpart") |>
  provider:::rc_ymd(c("enum_date", "cert_date", "updated"))

collapse::settransformv(basic, "number", as.integer)

key <- collapse::join(key, basic, on = "number")

# TBL 3: OTHER NAMES
# 1 = Former
# 2 = Professional
# 3 = Doing Business As
# 5 = Other
o_names <- rlang::set_names(x$other_names, x$number) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "number", fill = TRUE, id.factor = FALSE) |>
  collapse::recode_char("--" = NA_character_) |>
  collapse::qTBL() |>
  collapse::funique() |>
  collapse::rnm(
    "org_name" = "organization_name",
    .nse = FALSE
  ) |>
  collapse::gv(c(
    "number",
    "code",
    "org_name"
  )) |>
  collapse::add_stub(stub = "o_", cols = -1)

collapse::settransformv(o_names, "o_code", as.integer)

# o_names <- cheapr::as_df(o_names)
# res <- vctrs::vec_split(o_names[colnames(o_names)[-1]], o_names["number"])
# o_names <- vctrs::vec_cbind(
#   res$key,
#   tibble::new_tibble(list(o_names = res$val))
# )

key <- collapse::join(key, o_names, on = "number")

# TBL 2: TAXONOMIES
tx <- rlang::set_names(x$taxonomies, x$number) |>
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
  collapse::roworderv(c("number", "primary"), decreasing = TRUE) |>
  collapse::add_stub(stub = "tx_", cols = -1)

collapse::settransformv(tx, c("tx_state", "tx_license"), as.character)
collapse::settransformv(tx, "number", as.integer)

# tx <- cheapr::as_df(tx)
# res <- vctrs::vec_split(tx[colnames(tx)[-1]], tx["number"])
# tx <- vctrs::vec_cbind(res$key, tibble::new_tibble(list(tx = res$val)))

key <- collapse::join(key, tx, on = "number", multiple = TRUE)

# TBL 7: ADDRESSES
address <- rlang::set_names(x$addresses, x$number) |>
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
    phone = "telephone_number",
    purpose = "address_purpose",
    zip = "postal_code"
  ) |>
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
LL <- rlang::set_names(
  purrr::map(collapse::t_list(unname(L)), paste0, collapse = ""),
  L$number
)

M <- as.list(address$mailing)
MM <- rlang::set_names(
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

key <- collapse::join(key, address, on = "number", multiple = TRUE)
