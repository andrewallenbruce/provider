test_that("open_years() works", {

  open <- open_years()
  expect_equal(open, 2016:2022)
  expect_vector(open, ptype = integer(), size = 7)

})

test_that("prac_years() works", {

  prac <- prac_years()
  expect_equal(prac, 2013:2021)
  expect_vector(prac, ptype = integer(), size = 9)

})

test_that("cc_years() works", {

  cc <- cc_years()
  expect_equal(cc, 2007:2018)
  expect_vector(cc, ptype = integer(), size = 12)

})

test_that("quality_years() works", {

  quality <- quality_years()
  expect_equal(quality, 2017:2021)
  expect_vector(quality, ptype = integer(), size = 5)

})

test_that("bene_years() works", {

  benyr <- bene_years("year")
  expect_equal(benyr, 2013:2022)
  expect_vector(benyr, ptype = integer(), size = 10)

  benmn <- bene_years("month")
  expect_equal(benmn, 2013:2023)
  expect_vector(benmn, ptype = integer(), size = 11)

})
