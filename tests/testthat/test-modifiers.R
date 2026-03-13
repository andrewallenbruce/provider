test_that("greater_than works", {

  x <- greater_than("500")

  expect_s3_class(x, "modifier")

  expect_equal(x$operator, ">")
  expect_equal(x$value, "500")

  expect_type(x$value, "character")
  expect_type(x, "list")
})
