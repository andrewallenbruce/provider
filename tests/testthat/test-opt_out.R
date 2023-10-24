httptest2::without_internet({
  test_that("opt_out() returns correct request URL", {
    httptest2::expect_GET(
      opt_out(npi = 1528060837),
      'https://data.cms.gov/data.json')
  })
})
