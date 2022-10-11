test_that("`age_days()` works", {
  date_ex <- data.frame(x = seq.Date(as.Date("2021-01-01"),
    by = "month",
    length.out = 3
  ), y = seq.Date(as.Date("2022-01-01"),
    by = "month",
    length.out = 3
  ))
  date_ex_res <- date_ex
  date_ex_res$age <- as.numeric(366)
  expect_equal(age_days(df = date_ex, start = x, end = y), date_ex_res)
  expect_equal(age_days(date_ex, x, y), date_ex_res)
})
