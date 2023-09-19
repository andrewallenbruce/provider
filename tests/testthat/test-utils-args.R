test_that("encode_param() works", {

  args <- dplyr::tribble(
  ~param,      ~arg,
  "NPI",        "1144544834")

  expect_equal(encode_param(args), "filter%5BNPI%5D=1144544834")
  expect_equal(encode_param(args, "sql"), "%5BWHERE%20NPI%20=%20%221144544834%22%5D")
})
