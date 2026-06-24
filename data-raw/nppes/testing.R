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

library(collapse)
library(pillar)
# library(provider)

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

collapse::ss(
  x$type_2,
  j = c(
    "npi",
    "address",
    "location",
    "city",
    "state",
    "zip"
  )
) |>
  collapse::funique() |>
  print(n = Inf)

y <- nppes(unique(x$type_2$npi))
y
z <- nppes(unique(x$type_1$npi))
z

x <- nppes(
  npi = c(
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
)
x

collapse::date_vars(x$type_1)
collapse::num_vars(x$type_1)
collapse::cat_vars(x$type_1)
collapse::logi_vars(x$type_1)

vctrs::vec_set_intersect(
  colnames(x$type_1),
  colnames(x$type_2)
)

vctrs::vec_set_difference(
  colnames(x$type_1),
  colnames(x$type_2)
)

vctrs::vec_set_difference(
  colnames(x$type_2),
  colnames(x$type_1)
)

collapse::colorderv(x$type_1, c("npi", "entity"))



cheapr::col_c(
  collapse::gv(x$type_2, c("npi", "entity")),
  collapse::gv(
    x$type_2,
    c(
      "first",
      "last",
      "cred",
      "org_name",
      "org_dba",
      "sub_type",
      "address",
      "location",
      "city",
      "state",
      "zip"
    )
  ),
  collapse::date_vars(x$type_2),
  collapse::gvr(x$type_2, "^id_"),
  collapse::gvr(x$type_2, "^tax_"),
  collapse::gvr(x$type_2, "^other_")
)
