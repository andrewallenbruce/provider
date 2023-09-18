test_that("npi_check() works", {

  expect_equal(npi_check(1528060837), "1528060837")
  expect_type(npi_check(1528060837), "character")

  expect_snapshot(npi_check(1234567891), error = TRUE)
  expect_snapshot(npi_check(12345691234), error = TRUE)
  expect_snapshot(npi_check("O12345678912"), error = TRUE)

})

test_that("pac_check() works", {

  expect_equal(pac_check(2860305554), "2860305554")
  expect_type(pac_check(2860305554), "character")

  expect_snapshot(pac_check(0123456789), error = TRUE)
  expect_snapshot(pac_check("O12345678912"), error = TRUE)

})

test_that("enroll_check() works", {

  expect_equal(enroll_check("I20031110000070"), NULL)

  expect_snapshot(enroll_check(0123456789123456), error = TRUE)
  expect_snapshot(enroll_check("I123456789123456"), error = TRUE)
  expect_snapshot(enroll_check("012345678912345"), error = TRUE)

})

test_that("enroll_org_check() works", {

  expect_equal(enroll_org_check("O20031110000070"), NULL)
  expect_snapshot(enroll_org_check("I20031110000070"), error = TRUE)

})

test_that("enroll_ind_check() works", {

  expect_equal(enroll_ind_check("I20031110000070"), NULL)
  expect_snapshot(enroll_ind_check("O20031110000070"), error = TRUE)

})
