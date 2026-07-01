"https://data.cms.gov/provider-data/api/1/datastore/query/1a38077c-d8d0-5d1b-a417-45c940d81226?keys=true&limit=25&offset=0&conditions%5B0%5D%5Bproperty%5D=provider_last_name&conditions%5B0%5D%5Bvalue%5D%5B0%5D=Smith&conditions%5B0%5D%5Boperator%5D=in"

"https://data.cms.gov/provider-data/api/1/datastore/query/"
"1a38077c-d8d0-5d1b-a417-45c940d81226?keys=true&limit=25&offset=0&"
"conditions%5B0%5D%5Bproperty%5D=suff&conditions%5B0%5D%5Bvalue%5D=&conditions%5B0%5D%5Boperator%5D=%3D" |>
  httr2::url_parse()

paste0(
  "https://data.cms.gov/provider-data/api/1/datastore/query/",
  "372635c5-93db-51ac-a5ab-452db4092c92?",
  "results=true&schema=false&keys=true&limit=25&offset=0&",
  "expressions[0][operator]=max",
  "expressions[0][property]=grd_yr"
) |>
  # httr2::url_parse() |>
  httr2::request() |>
  httr2::req_perform() |>
  httr2::resp_body_json(simplifyVector = TRUE) |>
  _$results |>
  collapse::qTBL() |>
  str()

paste0(
  "https://data.cms.gov/provider-data/api/1/datastore/query/",
  "372635c5-93db-51ac-a5ab-452db4092c92?",
  "results=true&schema=false&keys=true&limit=25&offset=0&",
  "sorts[0][property]=grd_yr&",
  "sorts[0][order]=desc"
) |>
  httr2::url_parse() |>
  httr2::url_build() |>
  httr2::request() |>
  httr2::req_perform() |>
  httr2::resp_body_json(simplifyVector = TRUE) |>
  _$results |>
  collapse::qTBL() |>
  str()


grep(
  paste(
    "aff",
    "^cli[an]",
    "dial",
    "fac",
    "hosp",
    "^o[prw]",
    "^p[er]",
    "qual",
    "^re[av]",
    "tran",
    "util",
    sep = "|"
  ),
  getNamespaceExports("provider"),
  perl = TRUE,
  value = TRUE
)
