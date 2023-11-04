httptest2::without_internet({
  test_that("quality_payment() returns correct request URL", {
    httptest2::expect_GET(
      quality_payment(year      = 2020,
                      npi       = 1144544834,
                      state     = "GA",
                      specialty = "Physician Assistant",
                      type      = "Group"),
      'https://data.cms.gov/data.json')
  })
})
