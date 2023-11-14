httptest2::without_internet({
  test_that("providers() returns correct request URL", {
    httptest2::expect_GET(
      providers(npi                   = 1497796718,
                pac                   = 2961314075,
                enid                  = "I20031105000487",
                specialty_code        = "14-93",
                specialty_description = "PRACTITIONER - EMERGENCY MEDICINE",
                first                 = "REGINALD",
                middle                = "D",
                last                  = "SMITH",
                state                 = "GA",
                gender                = "M"),
      'https://data.cms.gov/data.json')
  })
})
