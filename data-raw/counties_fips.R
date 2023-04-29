## code to prepare `counties_fips` dataset goes here

counties_fips <- careroll::careroll() |>
  dplyr::count(county, state, fips, name = "count") |>
  dplyr::ungroup() |>
  dplyr::select(!count)

usethis::use_data(counties_fips, overwrite = TRUE)
