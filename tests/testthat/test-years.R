test_that("out_years() works", {

  out <- out_years()
  expect_equal(out, 2015:2022)
  expect_vector(out, ptype = integer(), size = 8)

})

test_that("open_years() works", {

  open <- open_years()
  expect_equal(open, 2017:2023)
  expect_vector(open, ptype = integer(), size = 7)

})


test_that("util_years() works", {

  util <- util_years()
  expect_equal(util, 2013:2022)
  expect_vector(util, ptype = integer(), size = 10)

})

test_that("rx_years() works", {

  rx <- rx_years()
  expect_equal(rx, 2013:2022)
  expect_vector(rx, ptype = integer(), size = 10)

})

test_that("qpp_years() works", {

  qpp <- qpp_years()
  expect_equal(qpp, 2017:2022)
  expect_vector(qpp, ptype = integer(), size = 6)

})

test_that("bene_years() works", {

  benyr <- bene_years("year")
  expect_equal(benyr, 2013:2023)
  expect_vector(benyr, ptype = integer(), size = 11)

  benmn <- bene_years("month")
  expect_equal(benmn, 2013:2024)
  expect_vector(benmn, ptype = integer(), size = 12)

})
