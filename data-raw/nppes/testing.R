kindbody <- c(
  1225701881,
  1174270805,
  1235702796,
  1962116806,
  1013647569,
  1306500665,
  1982296737,
  1083295638,
  1841967825,
  1891390084,
  1275117269,
  1992338701,
  1891355863,
  1548743511,
  1023473279,
  1861857013,
  1689182859,
  1982059275
)

npi_test <- c(
  1851713903,
  1174270805,
  1225701881,
  1588817837,
  1982059275,
  1255782751,
  1255877502,
  1841008505,
  1003826272
)

x <- nppes2(npi_test)
x <- collapse::rsplit(x, ~entity, keep.by = TRUE)

#==========| ENTITY Type 1 |=========
key <- collapse::ss(x$`1`, j = c("npi", "entity"))

##--------- <BASIC> ------------
basic <- rlang::set_names(x$`1`$basic, x$`1`$npi) |>
  collapse::unlist2d(idcols = c("npi", "var")) |>
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
    ids = "npi",
    how = "w",
    names = "var",
    values = "V1",
    check.dups = TRUE
  ) |>
  provider:::rc_bin("sole") |>
  provider:::rc_ymd(c("enum_date", "cert_date", "updated"))

collapse::settransformv(basic, "npi", as.integer)

key <- collapse::join(key, basic, on = "npi") |>
  collapse::roworderv("npi")

##--------- <OTHER NAMES> ------------
other <- rlang::set_names(x$`1`$other, x$`1`$npi) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "npi", fill = TRUE) |>
  collapse::recode_char("--" = NA_character_) |>
  collapse::qTBL() |>
  collapse::rnm(
    "cred" = "credential",
    "first" = "first_name",
    "last" = "last_name",
    .nse = FALSE
  ) |>
  collapse::gv(c(
    "npi",
    "code",
    "first",
    "last",
    "cred"
  )) |>
  collapse::add_stub(stub = "other_", cols = -1)

collapse::settransformv(other, "other_code", as.integer)
collapse::settransformv(other, "npi", as.character)
collapse::settransformv(other, "npi", as.integer)

key <- collapse::join(key, other, on = "npi")

##--------- <IDENTIFIERS> ------------
ids <- rlang::set_names(x$`1`$ids, x$`1`$npi) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "npi", fill = TRUE) |>
  collapse::recode_char("--" = NA_character_) |>
  collapse::qTBL() |>
  collapse::gv(c("npi", "code", "identifier", "issuer", "state")) |>
  collapse::add_stub(stub = "id_", cols = -1)

collapse::settransformv(ids, "id_code", as.integer)
collapse::settransformv(ids, "npi", as.character)
collapse::settransformv(ids, "npi", as.integer)

key <- collapse::join(key, ids, on = "npi", multiple = TRUE)

##--------- <TAXONOMIES> ------------
tax <- rlang::set_names(x$`1`$taxonomies, x$`1`$npi) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "npi", fill = TRUE) |>
  collapse::recode_char("--" = NA_character_) |>
  provider:::replace_nz() |>
  provider:::rc_trim() |>
  collapse::qTBL() |>
  collapse::rnm("group" = "taxonomy_group", .nse = FALSE) |>
  collapse::add_stub(stub = "tax_", cols = -1)

collapse::settransformv(tax, "tax_primary", as.integer)
collapse::settransformv(tax, "npi", as.character)
collapse::settransformv(tax, "npi", as.integer)

key <- collapse::join(key, tax, on = "npi", multiple = TRUE)

##--------- <PRACTICE LOCATIONS> ------------
loc <- rlang::set_names(x$`1`$locations, x$`1`$npi) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(
    idcol = "npi",
    fill = TRUE,
    id.factor = TRUE,
    return = 4L
  ) |>
  collapse::recode_char("--" = NA_character_) |>
  collapse::gvr("^npi$|^address_[1p]|^city$|^state$|postal") |>
  collapse::rnm(
    "address" = "address_1",
    "purpose" = "address_purpose",
    "zip" = "postal_code",
    .nse = FALSE
  )
collapse::settfmv(loc, "npi", as.character)
collapse::settfmv(loc, "npi", as.integer)
collapse::settfmv(loc, "purpose", tolower)

##--------- <ADDRESSES> ------------
add <- rlang::set_names(x$`1`$addresses, x$`1`$npi) |>
  collapse::rowbind(
    idcol = "npi",
    fill = TRUE,
    id.factor = TRUE,
    return = 4L
  ) |>
  collapse::gvr("^npi$|^address_[1p]|^city$|^state$|postal") |>
  collapse::rnm(
    "address" = "address_1",
    "purpose" = "address_purpose",
    "zip" = "postal_code",
    .nse = FALSE
  )

collapse::settfmv(add, "npi", as.character)
collapse::settfmv(add, "npi", as.integer)
collapse::settfmv(add, "purpose", tolower)

key <- collapse::join(
  key,
  collapse::rowbind(loc, add),
  on = "npi",
  multiple = TRUE
)

#==========| ENTITY Type 2 |=========
key2 <- collapse::ss(x$`2`, j = c("npi", "entity"))

# TBL 2: BASIC
basic2 <- rlang::set_names(x$`2`$basic, x$`2`$npi) |>
  collapse::unlist2d(idcols = c("npi", "var")) |>
  collapse::qTBL() |>
  collapse::recode_char(
    "--" = NA_character_,
    "certification_date" = "cert_date",
    "enumeration_date" = "enum_date",
    "last_updated" = "updated",
    "authorized_official_credential" = "cred",
    "authorized_official_title_or_position" = "title",
    "authorized_official_first_name" = "first",
    "authorized_official_last_name" = "last",
    "organization_name" = "org_name",
    "organizational_subpart" = "subpart",
    fixed = TRUE
  )

basic2 <- collapse::ss(
  basic2,
  basic2$var %!iin%
    c(
      "status",
      "authorized_official_name_prefix",
      "authorized_official_name_suffix",
      "authorized_official_middle_name",
      "authorized_official_telephone_number"
    )
) |>
  collapse::pivot(
    ids = "npi",
    how = "w",
    names = "var",
    values = "V1",
    check.dups = TRUE
  ) |>
  provider:::rc_bin("subpart") |>
  provider:::rc_ymd(c("enum_date", "cert_date", "updated"))

collapse::settransformv(basic2, "npi", as.integer)

key2 <- collapse::join(key2, basic2, on = "npi")
##--------- <OTHER NAMES> ------------
other2 <- rlang::set_names(x$`2`$other, x$`2`$npi) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "npi", fill = TRUE) |>
  collapse::recode_char("--" = NA_character_) |>
  collapse::qTBL() |>
  collapse::rnm("name" = "organization_name", .nse = FALSE) |>
  collapse::gv(c("npi", "code", "name")) |>
  collapse::add_stub(stub = "other_", cols = -1)

collapse::settransformv(other2, "other_code", as.integer)
collapse::settransformv(other2, "npi", as.character)
collapse::settransformv(other2, "npi", as.integer)

key2 <- collapse::join(key2, other2, on = "npi")

##--------- <IDENTIFIERS> ------------
# ids2 <- rlang::set_names(x$`2`$ids, x$`2`$npi) |>
#   cheapr::list_drop_null()
#
# # TODO deal with all NULL
#
# ids2 |>
#   collapse::rowbind(idcol = "npi", fill = TRUE) |>
#   collapse::recode_char("--" = NA_character_) |>
#   collapse::qTBL() |>
#   collapse::gv(c("npi", "code", "identifier", "issuer", "state")) |>
#   collapse::add_stub(stub = "id_", cols = -1)
#
# collapse::settransformv(ids2, "id_code", as.integer)
# collapse::settransformv(ids2, "npi", as.character)
# collapse::settransformv(ids2, "npi", as.integer)
#
# key2 <- collapse::join(key2, ids2, on = "npi", multiple = TRUE)

##--------- <TAXONOMIES> ------------
tax2 <- rlang::set_names(x$`2`$taxonomies, x$`2`$npi) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "npi", fill = TRUE) |>
  collapse::recode_char("--" = NA_character_) |>
  provider:::replace_nz() |>
  provider:::rc_trim() |>
  collapse::qTBL() |>
  collapse::rnm("group" = "taxonomy_group", .nse = FALSE) |>
  collapse::add_stub(stub = "tax_", cols = -1)

collapse::settransformv(tax2, "tax_primary", as.integer)
collapse::settransformv(tax2, "npi", as.character)
collapse::settransformv(tax2, "npi", as.integer)

key2 <- collapse::join(key2, tax2, on = "npi", multiple = TRUE)

##--------- <PRACTICE LOCATIONS> ------------
# loc2 <- rlang::set_names(x$`2`$locations, x$`2`$npi) |>
#   cheapr::list_drop_null()
#
# # TODO deal with all NULL
#
# loc2 |>
#   collapse::rowbind(
#     idcol = "npi",
#     fill = TRUE,
#     id.factor = TRUE,
#     return = 4L
#   ) |>
#   collapse::recode_char("--" = NA_character_) |>
#   collapse::gvr("^npi$|^address_[1p]|^city$|^state$|postal") |>
#   collapse::rnm(
#     "address" = "address_1",
#     "purpose" = "address_purpose",
#     "zip" = "postal_code",
#     .nse = FALSE
#   )
# collapse::settfmv(loc2, "npi", as.character)
# collapse::settfmv(loc2, "npi", as.integer)
# collapse::settfmv(loc2, "purpose", tolower)

##--------- <ADDRESSES> ------------
add2 <- rlang::set_names(x$`2`$addresses, x$`2`$npi) |>
  collapse::rowbind(
    idcol = "npi",
    fill = TRUE,
    id.factor = TRUE,
    return = 4L
  ) |>
  collapse::gvr("^npi$|^address_[1p]|^city$|^state$|postal") |>
  collapse::rnm(
    "address" = "address_1",
    "purpose" = "address_purpose",
    "zip" = "postal_code",
    .nse = FALSE
  )

collapse::settfmv(add2, "npi", as.character)
collapse::settfmv(add2, "npi", as.integer)
collapse::settfmv(add2, "purpose", tolower)

key2 <- collapse::join(
  key2,
  # collapse::rowbind(loc, add),
  add2,
  on = "npi",
  multiple = TRUE
)

list(ind = key, org = key2)
