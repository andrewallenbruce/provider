x <- llmjson::repair_json_file(
  fs::path(
    here::here("data-raw"),
    "nppes",
    ext = "json"
  ),
  return_objects = FALSE
)

jsonify::pretty_json(x)


RcppSimdJson::fparse(x)$result_count

res <- RcppSimdJson::fparse(x)$results |> fastplyr::as_tbl()

collapse::gvr(res, "epoch") <- NULL

ex <- res[1, ]

cheapr::fast_df(npi = ex$number, entity = ex$enumeration_type) |>
  cheapr::col_c(
    ex$taxonomies[[1]],
    ex$addresses[[1]]
  )

ex$basic[[1]] |>
  collapse::unlist2d() |>
  collapse::pivot(how = "recast", names = list(".id", ".id"))

ex$endpoints
ex$identifiers
ex$other_names
ex$practiceLocations


collapse::rsplit(res, ~number)

library(structr)
s_map(name = s_string(), age = s_integer())

library(llmjson)

json_object(
  users = json_array(json_object(
    name = json_string(),
    age = json_integer()
  ))
)

json_object(
  result_count = json_integer(),
  results = json_array(
    json_object(
      addresses = json_array(
        json_object(
          address_1 = json_string(),
          address_2 = json_string(),
          address_purpose = json_string(),
          address_type = json_string(),
          city = json_string(),
          country_code = json_string(),
          country_name = json_string(),
          fax_number = json_string(),
          postal_code = json_string(),
          state = json_string(),
          telephone_number = json_string()
        )
      ),
      basic = json_object(
        credential = json_string(),
        enumeration_date = json_date(),
        first_name = json_string(),
        last_name = json_string(),
        last_updated = json_date(),
        name_prefix = json_string(),
        name_suffix = json_string(),
        sex = json_string(),
        sole_proprietor = json_string(),
        status = json_string()
      ),
      epoch = json_array(json_object(created_epoch = json_integer()))
    )
  )
)
