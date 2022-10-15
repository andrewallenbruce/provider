test_that("`provider_luhn()` works", {
  expect_equal(provider_luhn(npi = 1528060837), TRUE)
  expect_equal(provider_luhn(npi = "1528060837"), TRUE)
  expect_equal(provider_luhn(npi = 1234567891), FALSE)
  expect_equal(provider_luhn(npi = "abcdefghij"), FALSE)
})
