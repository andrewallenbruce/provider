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

test_that("pos_char() works", {
  x <- c("facility", "Facility", "F", "f", "office", "Office", "O", "o")
  y <- c(rep("F", 4), rep("O", 4))
  expect_equal(pos_char(x), y)
})

test_that("entype_char() works", {
  x <- c("NPI-1", "I", "NPI-2", "O", "Group")
  y <- c(rep("Individual", 2), rep("Organization", 2), "Group")
  expect_equal(entype_char(x), y)
})

test_that("display_long() works", {
  x <- dplyr::tibble(x = "NPI", y = "1144544834")
  y <- dplyr::tibble(name = c("x", "y"), value = c("NPI", "1144544834"))
  expect_equal(display_long(x), y)
})

test_that("tidyup() works", {
  df <- dplyr::tibble(
    name = "John Doe ",
    year = "1981",
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
    year = dint::as_date_y(1981),
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

  expect_equal(tidyup(df, yn = "yn", int = c("int", "year"),
                      dbl = "dbl", yr = "year", up = "name",
                      cred = "cred", ent = c("ind", "org")), tidy)
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
  c <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query=%5BSELECT%20%2A%20FROM%209b86bb13-9701-5081-88ac-5b095abf95fc%5D%5BWHERE%20NPI%20=%20%221144544834%22%5D%5BLIMIT%2010000%20OFFSET%200%5D"
  # c <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query=%5BSELECT%20%2A%20FROM%2011b43516-3559-5a36-94be-7d5bab6a0548%5D%5BWHERE%20NPI%20=%20%221144544834%22%5D%5BLIMIT%2010000%20OFFSET%200%5D"
  a <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query=%5BSELECT%20%2A%20FROM%20865f5fa3-dd0c-53be-abcd-595e21790407%5D%5BWHERE%20NPI%20=%20%221144544834%22%5D%5BLIMIT%2010000%20OFFSET%200%5D"
  # a <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query=%5BSELECT%20%2A%20FROM%20cdc08a02-00a0-5f77-8d0a-f87c8eccea32%5D%5BWHERE%20NPI%20=%20%221144544834%22%5D%5BLIMIT%2010000%20OFFSET%200%5D"
  expect_equal(file_url(fn = "c", args = args, offset = 0L), c)
  expect_equal(file_url(fn = "a", args = args, offset = 0L), a)
})
