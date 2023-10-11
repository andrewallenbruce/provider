test_that("change() works", {

  set.seed(123)
  a <- dplyr::tibble(
    year = 2015:2020,
    x = sample(1000:2000, size = 6),
    y = sample(1000:2000, size = 6))

  b <- a
  b$x_chg     <- c(0, 48, -284, 347, -331, 743)
  b$y_chg     <- c(0, -700, 181, -70, 15, -230)

  b$x_chg_cum <- c(0, 48, -236, 111, -220, 523)
  b$y_chg_cum <- c(0, -700, -519, -589, -574, -804)

  b$x_pct     <- c(0, 0.034, -0.194, 0.295, -0.217, 0.622)
  b$y_pct     <- c(0, -0.385, 0.162, -0.054, 0.012, -0.185)

  b$x_pct_cum <- c(0, 0.034, -0.16, 0.135, -0.082, 0.54)
  b$y_pct_cum <- c(0, -0.385, -0.223, -0.277, -0.265, -0.45)

  expect_equal(change(a, c(x, y)), b)

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
