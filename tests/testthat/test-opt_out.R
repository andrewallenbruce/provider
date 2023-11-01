httptest2::without_internet({
  test_that("opt_out() returns correct request URL", {
    httptest2::expect_GET(
      opt_out(npi = 1043522824,
              first = "James",
              last = "Smith",
              specialty = "Nurse Practitioner",
              order_refer = TRUE),
      'https://data.cms.gov/data.json')
  })
})
