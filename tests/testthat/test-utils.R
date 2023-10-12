test_that("format_zipcode() works", {
  expect_equal(format_zipcode(123456789), "12345-6789")
  expect_equal(format_zipcode(12345), "12345")
  })

test_that("clean_credentials() works", {
  expect_equal(clean_credentials("M.D."), "MD")
})

test_that("na_blank() works", {
  expect_equal(na_blank(""), NA_character_)
  expect_equal(na_blank(" "), NA_character_)
  expect_equal(na_blank("*"), NA_character_)
  expect_equal(na_blank("--"), NA_character_)
})

test_that("yn_logical() works", {
  x <- c("Y", "YES", "Yes", "yes", "y", "True",
         "N", "NO", "No", "no", "n", "False")
  y <- c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE,
    FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
  expect_equal(yn_logical(x), y)
})

test_that("tf_2_yn() works", {
  x <- c(TRUE, FALSE)
  y <- c("Y", "N")
  expect_equal(tf_2_yn(x), y)
})

test_that("encode_param() works", {
  args <- dplyr::tribble(
    ~param,      ~arg,
    "NPI",       "1144544834")

  expect_equal(encode_param(args), "filter%5BNPI%5D=1144544834")
  expect_equal(encode_param(args, "sql"), "%5BWHERE%20NPI%20=%20%221144544834%22%5D")
})
