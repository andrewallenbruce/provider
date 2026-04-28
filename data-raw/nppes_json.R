x <- llmjson::repair_json_file(
  fs::path(
    here::here("data-raw"),
    "nppes",
    ext = "json"
  ),
  return_objects = FALSE
)

jsonify::pretty_json(x)

ex$endpoints
ex$identifiers
ex$other_names
ex$practiceLocations

RcppSimdJson::fparse(x)$result_count

res <- RcppSimdJson::fparse(x)$results |> fastplyr::as_tbl()

collapse::gvr(res, "epoch") <- NULL
# cheapr::lengths_(ex$basic)

# Ex 1
ex <- res[1:5, ]

basic <- set_names(ex$basic, ex$number) |>
  collapse::unlist2d(idcols = c("npi", "var")) |>
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
    ids = "npi",
    how = "w",
    names = "var",
    values = "V1",
    check.dups = TRUE
  ) |>
  fastplyr::as_tbl()

ex$basic <- NULL
ex$endpoints <- NULL
ex <- collapse::join(basic, ex, on = c("npi" = "number")) |>
  fastplyr::as_tbl()

addresses <- set_names(ex$addresses, ex$npi) |>
  collapse::rowbind(idcol = "npi", fill = TRUE, id.factor = FALSE) |>
  collapse::gvr("^npi$|^address_[12p]|^city$|^state$|fax|postal|phone") |>
  collapse::funique() |>
  collapse::mtt(
    address = combine_cols(address_1, address_2),
    address_1 = NULL,
    address_2 = NULL,
    phone = combine_cols(telephone_number, fax_number),
    telephone_number = NULL,
    fax_number = NULL
  )

ex$addresses <- NULL
ex <- collapse::join(addresses, ex, on = "npi") |> fastplyr::as_tbl()
ex$practiceLocations <- NULL
ex$other_names <- NULL

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
