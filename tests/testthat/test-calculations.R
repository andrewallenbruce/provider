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
    x_chg_cum = c(0L, 48L, -236L, 111L, -220L, 523L),
    y_chg_cum = c(0L, -700L, -519L, -589L, -574L, -804L),
    x_pct = c(0, 0.034, -0.194, 0.295, -0.217, 0.622),
    y_pct = c(0, -0.385, 0.162, -0.054, 0.012, -0.185),
    x_pct_cum = c(0, 0.034, -0.16, 0.1349, -0.0820, 0.54),
    y_pct_cum = c(0, -0.385, -0.223, -0.277, -0.265, -0.45))

  expect_equal(change(a, c(x, y)), b, tolerance = 1e-3)
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

test_that("summary_stats() works", {

  set.seed(1234)

  a <- dplyr::tibble(
    provider = sample(c("A", "B", "C"), size = 50, replace = TRUE),
    city     = sample(c("ATL", "NYC"), size = 50, replace = TRUE),
    charges  = sample(1000:2000, size = 50),
    payment  = sample(1000:2000, size = 50))

  sm <- summary_stats(a,
                condition    = city == "ATL",
                group_vars   = provider,
                summary_vars = c(charges, payment),
                arr          = n)

  b <- dplyr::tibble(
    provider       = c("B", "A", "C"),
    charges_median = c(1433, 1540, 1570.5),
    charges_mean   = c(1403.083, 1533.143, 1529.333),
    charges_sd     = c(233.785, 277.181, 348.370),
    payment_median = c(1763, 1443, 1433),
    payment_mean   = c(1628.083, 1425.143, 1496.167),
    payment_sd     = c(337.074, 233.323, 322.734),
    n              = c(12, 7, 6))

  expect_equal(sm, b)
})
