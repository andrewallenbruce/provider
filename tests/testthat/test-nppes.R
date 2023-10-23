httptest2::without_internet({
  test_that("nppes() returns correct request URL", {
    httptest2::expect_GET(
      nppes(npi = 1528060837),
      'https://npiregistry.cms.hhs.gov/api/?version=2.1&number=1528060837&limit=1200&skip=0')

    httptest2::expect_GET(
      nppes(city = "CARROLLTON", state = "GA", zip = 301173889, entype = "I"),
      'https://npiregistry.cms.hhs.gov/api/?version=2.1&enumeration_type=NPI-1&city=CARROLLTON&state=GA&postal_code=301173889&limit=1200&skip=0')
  })
})
