nanonext::ncurl(
  "https://data.cms.gov/data-api/v1/dataset/7adb8b1b-b85c-4ed3-b314-064776e50180/data/stats?",
  method = "GET",
  headers = c(`Content-Type` = "application/json"),
  timeout = 1500L
)$data |>
  RcppSimdJson::fparse() |>
  _$found_rows

tls <- nanonext::tls_config()
tls
