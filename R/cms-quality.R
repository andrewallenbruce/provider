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

# x <- api_medicare2()
# x$current |>
#   fastplyr::as_tbl() |>
#   collapse::sbt(title == "Quality Payment Program Experience") |>
#   _$identifier
#
# qpp <- x$temporal$`Quality Payment Program Experience`
#
# map_perform_parallel <- function(x, query = NULL) {
#   purrr::map(x, httr2::request) |>
#     httr2::req_perform_parallel(on_error = "continue") |>
#     httr2::resps_successes() |>
#     purrr::map(function(x) parse_string(x, query = query))
# }
#
# dim_care_temporal <- function(x) {
#   list(
#     total = paste0(x$identifier, "/stats?offset=0&size=1") |>
#       map_perform_parallel(query = "found_rows") |>
#       unlist(use.names = FALSE),
#     fields = paste0(
#       x$identifier,
#       "?count=true&results=true&offset=0&limit=1"
#     ) |>
#       map_perform_parallel(query = "names") |>
#       rlang::set_names(x$year)
#   )
# }
#
# qpp2 <- dim_care_temporal(qpp)
# qpp2
#
# cheapr::fast_df(
#   year = qpp$year,
#   nrows = qpp2$total,
#   ncols = collapse::vlengths(qpp2$fields, use.names = FALSE)
# )
#
# qpp2$fields$`2017`[c(2:27, 48, 76, 87)]
# qpp2$fields$`2018`[c(2:27, 48, 76, 87)]
# qpp2$fields$`2019`[c(2:27, 48, 76, 87)]
# qpp2$fields$`2020`[c(2:27, 48, 76, 87)]
# qpp2$fields$`2021`[c(2:27, 48, 76, 87)]
# qpp2$fields$`2022`[c(2:26, 28:30, 67, 105, 116)]
