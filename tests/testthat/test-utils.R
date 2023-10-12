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

test_that("pos_char() works", {
  x <- c("facility", "Facility", "F", "f", "office", "Office", "O", "o")
  y <- c("F", "F", "F", "F", "O", "O", "O", "O")
  expect_equal(pos_char(x), y)
})

test_that("display_long() works", {

  df <- dplyr::tribble(
    ~x,      ~y,
    "NPI",   "1144544834")

  lng <- dplyr::tribble(
    ~name,  ~value,
    "x",    "NPI",
    "y",    "1144544834")

  expect_equal(display_long(df), lng)
})

test_that("tidyup() works", {

  df <- dplyr::tribble(
    ~name,      ~date,         ~int,      ~dbl,      ~yn,
    "John Doe ", "1981/03/07",  "123456789", "12.34", "Y")

  tidy <- dplyr::tribble(
    ~name, ~date, ~int, ~dbl, ~yn,
    "JOHN DOE",
    anytime::anydate("1981/03/07"),
    as.integer("123456789"),
    as.double("12.34"),
    TRUE)

  expect_equal(tidyup(df,
                      yn = "yn",
                      int = "int",
                      dbl = "dbl",
                      up = "name"), tidy)
})

test_that("address() works", {

  df <- dplyr::tribble(
    ~x,      ~y,
    "1234 Address Lane", "STE 123")

  add <- dplyr::tribble(
    ~address,
    "1234 Address Lane STE 123")

  expect_equal(address(df, c("x", "y")), add)
})

test_that("encode_param() works", {
  args <- dplyr::tribble(
    ~param,      ~arg,
    "NPI",       "1144544834")

  expect_equal(encode_param(args), "filter%5BNPI%5D=1144544834")
  expect_equal(encode_param(args, "sql"), "%5BWHERE%20NPI%20=%20%221144544834%22%5D")
})
