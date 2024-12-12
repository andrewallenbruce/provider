test_that("change() works", {

  a <- dplyr::tibble(
    year = 2015:2020,
    x = c(1414L, 1462L, 1178L, 1525L, 1194L, 1937L),
    y = c(1817L, 1117L, 1298L, 1228L, 1243L, 1013L))

  b <- dplyr::tibble(
    year = 2015:2020,
    x = c(1414L, 1462L, 1178L, 1525L, 1194L, 1937L),
    y = c(1817L, 1117L, 1298L, 1228L, 1243L, 1013L),
    x_chg = c(0L, 48L, -284L, 347L, -331L, 743L),
    y_chg = c(0L, -700L, 181L, -70L, 15L, -230L),
    x_pct = c(0, 0.03395, -0.19425, 0.29457, -0.21705, 0.62228),
    y_pct = c(0, -0.38525, 0.16204, -0.05393, 0.01221, -0.18504),
    x_ror = c(1, 1.03395, 0.80575, 1.29457, 0.78295, 1.62228),
    y_ror = c(1, 0.61475, 1.16204, 0.94607, 1.01221, 0.81496),
    x_chg_cusum = c(0L, 48L, -236L, 111L, -220L, 523L),
    y_chg_cusum = c(0L, -700L, -519L, -589L, -574L, -804L),
  )
  expect_equal(change(a, c(x, y), csm = "_chg"), b, tolerance = 1e-3)
})

test_that("ror() works", {

  x <- dplyr::tibble(year = 2021:2023,
                     pay = c(2000, 2200, 1980))
  y <- dplyr::tibble(year = 2021:2023,
                     pay = c(2000, 2200, 1980),
                     pay_ror = c(NA, 1.1, 0.9))
  expect_equal(ror(x, pay), y)
})

test_that("geomean() works", {
  x <- c(NA, 1.1, 0.9)
  y <- 0.9949874
  expect_equal(geomean(x), y, tolerance = 1e-3)
})


test_that("change_year() works", {
  a <- dplyr::tibble(year = 2015:2020, x = 1000:1005)
  b <- a
  b$x_chg <- c(NA, 1, 1, 1, 1, 1)
  b$x_pct <- c(NA, 0.001, 0.001, 0.001, 0.001, 0.001)
  expect_equal(change_year(df = a, col = x), b)
})

test_that("years_df() works", {
  a <- dplyr::tibble(date = lubridate::today() - 366)
  b <- a
  b$years_passed <- as.double(1)
  expect_equal(years_df(a, date), b)
})

test_that("years_vec() works", {
  a <- dplyr::tibble(date = lubridate::today() - 366)
  expect_equal(years_vec(a$date), 1)
})

test_that("duration_vec() works", {
  a <- lubridate::today() - 366
  b <- difftime(a, lubridate::today(), units = "auto", tz = "UTC")
  b <- lubridate::as.duration(b)
  expect_equal(duration_vec(a), b)
})
