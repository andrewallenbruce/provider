test_that("change() works", {

  set.seed(123)

  a <- dplyr::tibble(
    year = 2015:2020,
    x = sample(1000:2000, size = 6),
    y = sample(1000:2000, size = 6))
  b <- a
  b$x_chg <- c(NA, 48, -284, 347, -331, 743)
  b$x_pct <- c(NA, 0.034, -0.194, 0.295, -0.217, 0.622)
  b$y_chg <- c(NA, -700, 181, -70, 15, -230)
  b$y_pct <- c(NA, -0.385, 0.162, -0.054, 0.012, -0.185)

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
