library(collapse)
library(pillar)
library(provider)

loc_rank <- function(x) {
  cheapr::val_match(
    x,
    "primary" ~ 0L,
    "secondary" ~ 1L,
    "mailing" ~ 9L,
    .default = NA
  ) |>
    as.integer()
}

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

npi <- c(
  1851713903,
  1174270805,
  1225701881,
  1588817837,
  1982059275,
  1255782751,
  1255877502,
  1841008505,
  1003826272,
  kindbody
) |>
  collapse::funique()

x <- nppes(npi)
x

x$type_2$address$loc <- loc_rank(x$type_2$address$loc_type)

x$type_2$address <- collapse::ss(
  x$type_2$address,
  j = c(
    "npi",
    "loc",
    "address",
    "city",
    "state",
    "zip"
  )
) |>
  collapse::funique() |>
  collapse::roworderv(c("npi", "loc"))

x$type_1$address$loc <- loc_rank(x$type_1$address$loc_type)

x$type_1$address <- collapse::ss(
  x$type_1$address,
  j = c(
    "npi",
    "loc",
    "address",
    "city",
    "state",
    "zip"
  )
) |>
  collapse::funique() |>
  collapse::roworderv(c("npi", "loc"))

x$type_2$address |>
  print(n = Inf)
x$type_1$address |>
  print(n = Inf)

x$type_2$tax <- collapse::ss(
  x$type_2$base,
  j = c(
    "npi",
    "tx_code",
    "tx_lic",
    "tx_prim",
    "tx_state",
    "tx_grp"
  )
) |>
  collapse::funique()

x$type_1$tax <- collapse::ss(
  x$type_1$base,
  j = c(
    "npi",
    "tx_code",
    "tx_lic",
    "tx_prim",
    "tx_state",
    "tx_grp"
  )
) |>
  collapse::funique()

x$type_1$id <- collapse::ss(
  x$type_1$base,
  j = c(
    "npi",
    "id_code",
    "id_issuer",
    "id_state"
  )
) |>
  collapse::funique()

x$type_2$base <- collapse::ss(
  x$type_2$base,
  j = c(
    "npi",
    "entity",
    "org_name",
    "org_par",
    "org_dba",
    "first",
    "last",
    "cred",
    "cert_date",
    "enum_date",
    "last_update"
  )
) |>
  collapse::funique()

x$type_1$base <- collapse::ss(
  x$type_1$base,
  j = c(
    "npi",
    "entity",
    "first",
    "last",
    "cred",
    "sub_type",
    "cert_date",
    "enum_date",
    "last_update"
  )
) |>
  collapse::funique()

x
