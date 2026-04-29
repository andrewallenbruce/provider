library(collapse)
x <- llmjson::repair_json_file(
  fs::path(here::here("data-raw"), "nppes", ext = "json"),
  return_objects = FALSE
)
x <- RcppSimdJson::fparse(x)$results |> fastplyr::as_tbl()
collapse::gvr(x, "epoch") <- NULL
collapse::gvr(x, "endpoints") <- NULL

#####################################################################
# TBL 1: Primary Key
key <- fastplyr::new_tbl(number = x$number, entity = x$enumeration_type)

# TBL 2: BASIC
basic <- set_names(x$basic, x$number) |>
  collapse::unlist2d(idcols = c("number", "var")) |>
  collapse::recode_char(
    "--" = NA_character_,
    "certification_date" = "cert_date",
    "enumeration_date" = "enum_date",
    "last_updated" = "updated",
    "sole_proprietor" = "sole",
    "credential" = "cred",
    "first_name" = "first",
    "middle_name" = "middle",
    "last_name" = "last",
    "name_prefix" = "prefix",
    "name_suffix" = "suffix"
  ) |>
  collapse::sbt(var != "status") |>
  collapse::pivot(
    ids = "number",
    how = "w",
    names = "var",
    values = "V1",
    check.dups = TRUE
  ) |>
  fastplyr::as_tbl()

collapse::gvr(x, "enumeration_type") <- NULL
collapse::gvr(x, "basic") <- NULL

# TBL 3: ADDRESS
address <- set_names(x$addresses, x$number) |>
  collapse::rowbind(idcol = "number", fill = TRUE, id.factor = FALSE) |>
  collapse::gvr("^number$|^address_[12p]|^city$|^state$|fax|postal|phone") |>
  collapse::funique() |>
  fastplyr::as_tbl() |>
  collapse::mtt(
    address = combine_cols(address_1, address_2),
    address_1 = NULL,
    address_2 = NULL,
    # phone = combine_cols(telephone_number, fax_number),
    phone = telephone_number,
    telephone_number = NULL,
    fax_number = NULL
  ) |>
  collapse::roworder(number, address_purpose) |>
  collapse::gby(number) |>
  collapse::mtt(
    phone = cheapr::if_else_(
      cheapr::is_na(phone) & address_purpose == "MAILING",
      cheapr::lag_(phone),
      phone
    )
  ) |>
  collapse::fungroup() |>
  collapse::rsplit(~address_purpose)

L <- as.list(address$LOCATION)

LL <- collapse::t_list(unname(L)) |>
  purrr::map(\(x) paste0(x, collapse = "")) |>
  set_names(L$number)

M <- as.list(address$MAILING)

MM <- collapse::t_list(unname(M)) |>
  purrr::map(\(x) paste0(x, collapse = "")) |>
  set_names(M$number)

waldo::compare(LL, MM, max_diffs = 200, quote_strings = FALSE)

keep_both <- MM[cheapr::which_(vctrs::vec_equal(LL, MM), invert = TRUE)] |>
  names()
keep_one <- MM[cheapr::which_(vctrs::vec_equal(LL, MM))] |> names()

address$MAILING <- cheapr::sset(
  address$MAILING,
  address$MAILING$number %in_% keep_both
)
address$LOCATION <- cheapr::sset(
  address$LOCATION,
  address$LOCATION$number %in_% c(keep_both, keep_one)
)

address <- collapse::rowbind(address, idcol = "purpose", id.factor = FALSE) |>
  collapse::roworderv(c("number", "purpose"))
collapse::gvr(x, "addresses") <- NULL

collapse::join(key, basic, on = "number") |>
  collapse::join(address, on = "number", multiple = TRUE)

other_names <- set_names(x$other_names, x$number) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "number", fill = TRUE, id.factor = FALSE) |>
  collapse::recode_char("--" = NA_character_) |>
  fastplyr::as_tbl()

collapse::gvr(x, "other_names") <- NULL

set_names(x$practiceLocations, x$number) |>
  cheapr::list_drop_null()

set_names(x$identifiers, x$number) |>
  cheapr::list_drop_null()

set_names(x$taxonomies, x$number) |>
  cheapr::list_drop_null()
#####################################################################
identifiers <- set_names(ex$identifiers, ex$npi) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "npi", fill = TRUE, id.factor = FALSE) |>
  collapse::funique() |>
  collapse::add_stub(stub = "id_", cols = -1) |>
  fastplyr::as_tbl()

ex$identifiers <- NULL
ex <- collapse::join(ex, identifiers, on = "npi") |>
  fastplyr::as_tbl()

taxonomies <- set_names(ex$taxonomies, ex$npi) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "npi", fill = TRUE, id.factor = FALSE) |>
  collapse::funique() |>
  provider:::replace_nz() |>
  collapse::add_stub(stub = "tx_", cols = -1) |>
  fastplyr::as_tbl()

ex$taxonomies <- NULL
ex <- collapse::join(ex, taxonomies, on = "npi") |>
  fastplyr::as_tbl()

cols_rname <- c(
  add_purp = "address_purpose",
  zip = "postal_code",
  enum_type = "enumeration_type",
  tx_group = "tx_taxonomy_group",
  id_ID = "id_identifier"
)

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

indexthis::to_index(
  res$number,
  res$enumeration_type,
  items = TRUE,
  items.simplify = FALSE,
  sorted = TRUE
)
