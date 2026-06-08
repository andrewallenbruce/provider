library(provider)
library(collapse)
library(pillar)

nppes_ao <- fs::path(here::here("data-raw/nppes"), "nppes_ao", ext = "json")
x <- llmjson::repair_json_file(nppes_ao, return_objects = FALSE)
x <- RcppSimdJson::fparse(x)$results |> data_frame()
x

nppes_type2 <- fs::path(
  here::here("data-raw/nppes"),
  "nppes_type2",
  ext = "json"
)
x <- llmjson::repair_json_file(nppes_type2, return_objects = FALSE)
x <- RcppSimdJson::fparse(x)$results |> data_frame()
x
x[apply(x, 2, function(x) lapply(x, length) == 0)] <- NA
x
