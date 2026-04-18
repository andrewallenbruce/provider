# The Quality Payment Program (QPP) Experience dataset provides
# participation and performance information in the Merit-based
# Incentive Payment System (MIPS) during each performance year.
# They cover eligibility and participation, performance categories,
# and final score and payment adjustments. The dataset provides
# additional details at the TIN/NPI level on what was published in
# the previous performance year. You can sort the data by variables
# like clinician type, practice size, scores, and payment adjustments.
#
# https://data.cms.gov/resources/quality-payment-program-experience-data-dictionary
#
# "?count=true&results=true&offset=0&limit=1"
#
# === `quality_totals` ===
#    year   nrows ncols
#   <int>   <int> <int>
# 1  2023  524998   204
# 2  2022  624200   165
# 3  2021  698730    92
# 4  2020  921517    92
# 5  2019  944376    92
# 6  2018  881959    92
# 7  2017 1054657    92

# map_perform_parallel <- function(x, query = NULL) {
#   purrr::map(x, httr2::request) |>
#     httr2::req_perform_parallel(on_error = "continue") |>
#     httr2::resps_successes() |>
#     purrr::map(function(x) parse_string(x, query = query))
# }
#
# temporal <- function(x) {
#   list(
#     fields = paste0(x$identifier, "?offset=0&size=10") |>
#       map_perform_parallel() |>
#       rlang::set_names(x$year),
#     total = paste0(x$identifier, "/stats?") |>
#       map_perform_parallel(query = "found_rows") |>
#       rlang::set_names(x$year)
#   )
# }
#
# api <- api_medicare2()
#
# api$current |>
#   fastplyr::as_tbl() |>
#   collapse::sbt(title == "Quality Payment Program Experience")
#
# qpp <- api$temporal$`Quality Payment Program Experience`
#
# ex <- paste0(qpp$identifier, "?offset=0&size=5") |>
#   map_perform_parallel() |>
#   rlang::set_names(qpp$year) |>
#   purrr::map(replace_nz) |>
#   purrr::map(tibble::as_tibble)
#
# ex_17_21 <- ex[names(ex) %in% 2017:2021] |> rowbind2(nm = "year")
# ex_22_23 <- ex[!names(ex) %in% 2017:2021]
#
# x <- temporal(qpp)
# quality_totals <- fastplyr::new_tbl(
#   year = as.integer(names(x$total)),
#   nrows = as.integer(x$total),
#   ncols = as.integer(collapse::vlengths(x$fields, use.names = FALSE))
# )
#
# x$fields$`2017`[c(2:27, 48, 76, 87)]
# x$fields$`2018`[c(2:27, 48, 76, 87)]
# x$fields$`2019`[c(2:27, 48, 76, 87)]
# x$fields$`2020`[c(2:27, 48, 76, 87)]
# x$fields$`2021`[c(2:27, 48, 76, 87)]
# x$fields$`2022`[c(2:26, 28:30, 67, 105, 116)]
