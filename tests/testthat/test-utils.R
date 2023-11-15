test_that("format_zipcode() works", {
  expect_equal(format_zipcode(123456789), "12345-6789")
  expect_equal(format_zipcode(12345), "12345")
  })

test_that("clean_credentials() works", {
  expect_equal(clean_credentials("M.D."), "MD")
})

test_that("na_blank() works", {
  x <- c("", " ", "*", "--")
  expect_equal(na_blank(x), rep(NA_character_, 4))
})

test_that("yn_logical() works", {
  x <- c("Y", "YES", "Yes", "yes", "y", "True",
         "N", "NO", "No", "no", "n", "False")
  y <- c(rep(TRUE, 6), rep(FALSE, 6))
  expect_equal(yn_logical(x), y)
})

test_that("tf_2_yn() works", {
  x <- c(TRUE, FALSE)
  y <- c("Y", "N")
  expect_equal(tf_2_yn(x), y)
})

test_that("abb2full() works", {
  expect_equal(abb2full("GA"), "Georgia")
  expect_snapshot(abb2full("YN"), error = TRUE)
})

test_that("display_long() works", {
  x <- dplyr::tibble(x = "NPI", y = "1144544834", id = 1)
  y <- dplyr::tibble(name = c("x", "y", "id"), value = c("NPI", "1144544834", "1"))
  z <- dplyr::tibble(id = c("1", "1"), name = c("x", "y"), value = c("NPI", "1144544834"))
  expect_equal(display_long(x), y)
  expect_equal(display_long(x, cols = !id), z)
})

test_that("df2chr() works", {
  df <- dplyr::tibble(
    name  = "John Doe ",
    date  = "1981/03/07",
    int   = "123456789",
    chr   = 123456789,
    dbl   = "12.34",
    yn    = "Y",
    cred  = "M.D.",
    blank = "",
    space = " ",
    star  = "*",
    dash  = "--")

  dff <- dplyr::tibble(
    name = "John Doe ",
    date = "1981/03/07",
    int = "123456789",
    chr = "123456789",
    dbl = "12.34",
    yn = "Y",
    cred = "M.D.",
    blank = "",
    space = " ",
    star = "*",
    dash = "--")
  expect_equal(df2chr(df), dff)
})

test_that("tidyup() works", {
  df <- dplyr::tibble(
    name  = "John Doe ",
    date  = "1981/03/07",
    int   = "123456789",
    chr   = 123456789,
    dbl   = "12.34",
    yn    = "Y",
    cred  = "M.D.",
    blank = "",
    space = " ",
    star  = "*",
    dash  = "--")

  df2      <- df
  df2$date <- "03/07/1981"

  tidy <- dplyr::tibble(
    name  = "JOHN DOE",
    date  = lubridate::ymd("1981/03/07"),
    int   = 123456789,
    chr   = "123456789",
    dbl   = 12.34,
    yn    = TRUE,
    cred  = "MD",
    blank = NA_character_,
    space = NA_character_,
    star  = NA_character_,
    dash  = NA_character_)

  tidy2      <- tidy
  tidy2$date <- lubridate::mdy("03/07/1981")

  expect_equal(tidyup(df,
                      yn    = "yn",
                      dtype = 'ymd',
                      int   = c("int", "year"),
                      dbl   = "dbl",
                      up    = "name",
                      cred  = "cred"),
               tidy)

  expect_equal(tidyup(df2,
                      yn    = "yn",
                      dtype = 'mdy',
                      int   = c("int", "year"),
                      chr   = "chr",
                      dbl   = "dbl",
                      up    = "name",
                      cred  = "cred"),
               tidy2)
})

test_that("combine() works", {
  x <- dplyr::tibble(x = "1234 Address Lane", y = "STE 123", z = NA)
  y <- dplyr::tibble(address = "1234 Address Lane STE 123")
  expect_equal(combine(x, address, c('x', 'y', 'z')), y)
})

test_that("narm() works", {
  x <- dplyr::tibble(x = "1234 Address Lane", y = "STE 123", z = NA, a = NA)
  y <- dplyr::tibble(x = "1234 Address Lane", y = "STE 123")
  expect_equal(narm(x), y)
})


test_that("github_raw() works", {
  expect_equal(github_raw("andrewallenbruce/provider/"),
  "https://raw.githubusercontent.com/andrewallenbruce/provider/")
})

test_that("format_param() works", {
  a <- "npi"
  b <- "1234567891"
  y <- "filter[npi]=1234567891"
  z <- "[WHERE npi = %221234567891%22]"

  expect_equal(format_param(a, b), y)
  expect_equal(format_param(a, b, "sql"), z)
  expect_snapshot(format_param(), error = TRUE)
  expect_snapshot(format_param(param = a), error = TRUE)
  expect_snapshot(format_param(arg = b), error = TRUE)
  expect_snapshot(format_param(a, b, "filthy"), error = TRUE)
})

test_that("encode_param() works", {
  args <- dplyr::tibble(param = "NPI", arg = "1144544834")
  a <- "filter%5BNPI%5D=1144544834"
  b <- "%5BWHERE%20NPI%20=%20%221144544834%22%5D"

  expect_equal(encode_param(args), a)
  expect_equal(encode_param(args, "sql"), b)
})

test_that("encode_url() works", {
  expect_equal(encode_url("[ * ]"), "%5B%20%2A%20%5D")
})

test_that("file_url() works", {
  args <- dplyr::tibble(param = "NPI", arg = "1144544834")
  expect_snapshot(file_url(fn = "c", args = args, offset = 0L), error = FALSE)
  expect_snapshot(file_url(fn = "a", args = args, offset = 0L), error = FALSE)
})

test_that("format_cli() works", {
  args <- dplyr::tibble(x = "NPI", y = "1144544834")
  expect_snapshot(format_cli(args))
})
