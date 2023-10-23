httptest2::without_internet({
  test_that("nppes() returns correct request URL", {
    httptest2::expect_GET(nppes(npi = 1528060837),
      'https://npiregistry.cms.hhs.gov/api/?version=2.1&number=1528060837&limit=1200&skip=0')
  })
})
