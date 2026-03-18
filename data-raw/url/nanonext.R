nanonext::ncurl(
  "https://data.cms.gov/data-api/v1/dataset/6a3aa708-3c9d-411a-a1a4-e046d3ade7ef/data/stats?",
  method = "GET",
  headers = c(`Content-Type` = "application/json"),
  timeout = 1500L
) |>
  _$data |>
  RcppSimdJson::fparse()
