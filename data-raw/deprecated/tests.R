# test_that("github_raw() works", {
#   expect_equal(github_raw("andrewallenbruce/provider/"),
#   "https://raw.githubusercontent.com/andrewallenbruce/provider/")
# })

# ALWAYS FAILS
# test_that("file_url() works", {
#
#   args <- dplyr::tibble(param = "NPI", arg = "1144544834")
#
#   expect_snapshot(file_url(fn = "c", args = args, offset = 0L), error = FALSE)
#   expect_snapshot(file_url(fn = "a", args = args, offset = 0L), error = FALSE)
# })
#
# HASH IN URL IS CHANGING FREQUENTLY
# https://data.cms.gov/provider-data/api/1/datastore/sql?query=%5BSELECT%20%2A%20FROM%201e88f761-7d99-55ca-a8fc-20b193b0d2ea%5D%5BWHERE%20NPI%20=%20%221144544834%22%5D%5BLIMIT%2010000%20OFFSET%200%5D;&show_db_columns

