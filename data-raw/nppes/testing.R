library(collapse)
library(pillar)
library(provider)

npi <- c(
  1003826272,
  1013647569,
  1023473279,
  1083295638,
  1174270805,
  1225701881,
  1235702796,
  1255782751,
  1255877502,
  1275117269,
  1306500665,
  1548743511,
  1588817837,
  1689182859,
  1841008505,
  1841967825,
  1851713903,
  1861857013,
  1891355863,
  1891390084,
  1962116806,
  1982059275,
  1982296737,
  1992338701
)

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
