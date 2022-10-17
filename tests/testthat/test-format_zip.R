test_that("`age_days()` works", {
  zip_ex <- "12345-6789"
  zip_ex2 <- "12345"
  expect_equal(format_zipcode(123456789), zip_ex)
  expect_equal(format_zipcode(12345), zip_ex2)
})
