# format_zipcode ----------------------------------------------------------
# test_that("`format_zipcode()` works", {
#   zip_ex <- "12345-6789"
#   zip_ex2 <- "12345"
#   expect_equal(format_zipcode(123456789), zip_ex)
#   expect_equal(format_zipcode(12345), zip_ex2)})

test_that("encode_param() works", {

  args <- dplyr::tribble(
    ~param,      ~arg,
    "NPI",       "1144544834")

  expect_equal(encode_param(args), "filter%5BNPI%5D=1144544834")
  expect_equal(encode_param(args, "sql"), "%5BWHERE%20NPI%20=%20%221144544834%22%5D")
})
