test_that("check_npi() works", {

  expect_equal(check_npi(1528060837), "1528060837")
  expect_type(check_npi(1528060837), "character")

  expect_snapshot(check_npi(1234567891), error = TRUE)
  expect_snapshot(check_npi(12345691234), error = TRUE)
  expect_snapshot(check_npi("O12345678912"), error = TRUE)

})

test_that("check_pac() works", {

  expect_equal(check_pac(2860305554), "2860305554")
  expect_type(check_pac(2860305554), "character")

  expect_snapshot(check_pac(0123456789), error = TRUE)
  expect_snapshot(check_pac("O12345678912"), error = TRUE)

})

test_that("check_enid() works", {

  expect_equal(check_enid("I20031110000070"), NULL)

  expect_snapshot(check_enid(0123456789123456), error = TRUE)
  expect_snapshot(check_enid("I123456789123456"), error = TRUE)
  expect_snapshot(check_enid("012345678912345"), error = TRUE)
  expect_snapshot(check_enid("L20031110000070"), error = TRUE)

  expect_equal(check_enid("O20031110000070", type = "org"), NULL)
  expect_snapshot(check_enid("I20031110000070", type = "org"), error = TRUE)

  expect_equal(check_enid("I20031110000070", type = "ind"), NULL)
  expect_snapshot(check_enid("O20031110000070", type = "ind"), error = TRUE)

})
