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
  df <- dplyr::tibble(
    name = "John Doe ",
    date = "1981/03/07",
    int = "123456789",
    dbl = "12.34",
    yn = "Y",
    cred = "M.D.",
    ind = "NPI-1",
    org = "NPI-2",
    blank = "",
    space = " ",
    star = "*",
    dash = "--")

  tidy <- dplyr::tibble(
    name = "JOHN DOE",
    date = anytime::anydate("1981/03/07"),
    int = 123456789,
    dbl = 12.34,
    yn = TRUE,
    cred = "MD",
    ind = "Individual",
    org = "Organization",
    blank = NA_character_,
    space = NA_character_,
    star = NA_character_,
    dash = NA_character_)

  expect_equal(
    tidyup(df, yn = "yn", int = "int", dbl = "dbl",
           up = "name", cred = "cred", ent = c("ind", "org")), tidy)
})

test_that("combine() works", {
  df <- dplyr::tibble(
    x = "1234 Address Lane",
    y = "STE 123",
    z = NA)

  add <- dplyr::tibble(
    address = "1234 Address Lane STE 123")

  expect_equal(combine(df, address, c('x', 'y', 'z')), add)
})

test_that("encode_param() works", {
  args <- dplyr::tribble(
    ~param,      ~arg,
    "NPI",       "1144544834")

  expect_equal(encode_param(args), "filter%5BNPI%5D=1144544834")
  expect_equal(encode_param(args, "sql"), "%5BWHERE%20NPI%20=%20%221144544834%22%5D")
})
