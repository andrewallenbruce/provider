#' @noRd
qpp_uuid <- function() {
  x <- RcppSimdJson::fload("https://data.cms.gov/data.json", "/dataset") |>
    collapse::get_elem("distribution") |>
    collapse::rowbind(fill = TRUE) |>
    collapse::qTBL()

  x <- collapse::ss(
    x,
    grepl("^Quality", x$title, perl = TRUE) &
      !cheapr::is_na(x$accessURL) &
      cheapr::is_na(x$description)
  )

  collapse::av(
    x,
    year = extract_year(x$title),
    uuid = uuid_from_url(x$accessURL),
    pos = "front"
  ) |>
    collapse::gv(c("year", "uuid", "accessURL", "resourcesAPI"))
}

#' Quality Payment Program
#'
#' The Quality Payment Program (QPP) Experience dataset provides participation
#' and performance information in the Merit-based Incentive Payment System
#' (MIPS) during each performance year. They cover eligibility and
#' participation, performance categories, and final score and payment
#' adjustments.
#'
#' The dataset provides additional details at the TIN/NPI level on what was
#' published in the previous performance year. You can sort the data by
#' variables like clinician type, practice size, scores, and payment
#' adjustments.
#'
#' @param year `<int>` A vector of years from 2018 to 2025
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' quality_metrics(2018:2025)
#'
#' @export
quality_metrics <- function(year) {
  check_numeric(year)

  x <- purrr::map(
    year,
    function(yr) {
      httr2::request("https://qpp.cms.gov/api/eligibility/stats") |>
        httr2::req_url_query(year = yr) |>
        httr2::req_perform() |>
        httr2::resp_body_json(simplifyVector = TRUE, check_type = FALSE) |>
        _$data
    }
  ) |>
    set_names(year) |>
    collapse::unlist2d(idcols = c("year", "category", "metric")) |>
    collapse::rnm(c("V1" = "mean"), .nse = FALSE) |>
    data_frame() |>
    rc_integer("year")

  collapse::recode_char(
    x,
    individual = "ind",
    dualEligibilityAverage = "Dual Eligible Ratio",
    hccRiskScoreAverage = "HCC Risk Score",
    set = TRUE
  )
  return(x)
}

# QPP Submissions API
# https://preview.qpp.cms.gov/api/submissions/public/docs/
# https://data.cms.gov/resources/quality-payment-program-experience-data-dictionary
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

#
# x <- qpp_uuid()
# x <- as.list(set_names(paste0(x$accessURL, "?size=10"), x$year))
# x <- purrr::map(x, httr2::request) |>
#   httr2::req_perform_parallel(on_error = "continue") |>
#   purrr::map(function(resp) parse_string(resp) |> collapse::qTBL()) |>
#   set_names2(x)
#
# x_1721 <- purrr::map(x[names(x) %in% 2017:2021], function(x) {
#   collapse::frename(x, qpp_2017_2021, .nse = FALSE) |>
#     collapse::gv(unlist_(qpp_2017_2021))
# }) |>
#   rowbind2("year") |>
#   replace_nz() |>
#   rc_bin(collapse::gvr(x_1721, "_ind$", return = 2L)) |>
#   rc_integer(c(
#     "year",
#     "npi",
#     "size",
#     "years",
#     "patients",
#     "charges",
#     "services"
#   )) |>
#   rc_double(c(
#     "final_score",
#     "adjustment",
#     "complex_bonus",
#     "qua_score",
#     "pi_score",
#     "ia_score",
#     "cost_score"
#   ))
#
# x_22 <- collapse::frename(x$`2022`, qpp_2022, .nse = FALSE) |>
#   collapse::gv(unlist_(qpp_2022)) |>
#   replace_nz()
#
# x_22$year <- 2022L
#
# x_22 <- x_22 |>
#   rc_bin(collapse::gvr(x_22, "_ind$", return = 2L)) |>
#   rc_integer(c(
#     "year",
#     "npi",
#     "size",
#     "years",
#     "patients",
#     "charges",
#     "services"
#   )) |>
#   rc_double(c(
#     "final_score",
#     "adjustment",
#     "complex_bonus",
#     "small_bonus",
#     "qua_score",
#     "qua_improve",
#     "pi_score",
#     "ia_score",
#     "cost_score",
#     "dual_ratio"
#   ))
#
# x_2324 <- purrr::map(x[names(x) %in% 2023:2024], function(x) {
#   collapse::frename(x, qpp_2023_2024, .nse = FALSE) |>
#     collapse::gv(unlist_(qpp_2023_2024))
# }) |>
#   rowbind2("year") |>
#   replace_nz() |>
#   rc_bin(collapse::gvr(x_2324, "_ind$", return = 2L)) |>
#   rc_integer(c(
#     "year",
#     "npi",
#     "size",
#     "years",
#     "patients",
#     "charges",
#     "services"
#   )) |>
#   rc_double(c(
#     "final_score",
#     "adjustment",
#     "complex_bonus",
#     "small_bonus",
#     "qua_score",
#     "qua_improve",
#     "pi_score",
#     "ia_score",
#     "cost_score",
#     "cost_improve",
#     "dual_ratio"
#   ))
#
# collapse::rowbind(x_1721, x_22, x_2324, fill = TRUE)
