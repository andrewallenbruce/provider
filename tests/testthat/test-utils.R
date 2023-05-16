# # age_days ----------------------------------------------------------------
# test_that("`age_days()` works", {date_ex <- data.frame(
#     x = seq.Date(as.Date("2021-01-01"), by = "month", length.out = 3),
#     y = seq.Date(as.Date("2022-01-01"), by = "month", length.out = 3))
#   date_ex_res <- date_ex
#   date_ex_res$age <- as.numeric(366)
#   expect_equal(age_days(df = date_ex, start = x, end = y), date_ex_res)
#   expect_equal(age_days(date_ex, x, y), date_ex_res)})
#
# # days_today ---------------------------------------------------------------
# test_that("`days_today()` works", {
#   date_ex <- data.frame(x = c("1992-02-05","2020-01-04","1996-05-01",
#                             "2020-05-01","1996-02-04"), y = lubridate::today())
#   date_ex_res <- date_ex |> dplyr::mutate(age = as.numeric(
#     lubridate::days(as.Date(y)) - lubridate::days(as.Date(x)),
#     "hours") / 24)
#
# expect_equal(days_today(df = date_ex, start = x), date_ex_res)
# expect_equal(days_today(date_ex, x), date_ex_res)})

# format_zipcode ----------------------------------------------------------
# test_that("`format_zipcode()` works", {
#   zip_ex <- "12345-6789"
#   zip_ex2 <- "12345"
#   expect_equal(format_zipcode(123456789), zip_ex)
#   expect_equal(format_zipcode(12345), zip_ex2)})

# luhn_check --------------------------------------------------------------
# test_that("`luhn_check()` works", {
#   expect_equal(luhn_check(npi = 1528060837), TRUE)
#   expect_equal(luhn_check(npi = "1528060837"), TRUE)
#   expect_equal(luhn_check(npi = 1234567891), FALSE)
#   expect_equal(luhn_check(npi = "abcdefghij"), FALSE)})
