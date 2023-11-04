httptest2::without_internet({
  test_that("affiliations() returns correct request URL", {
    httptest2::expect_GET(
      affiliations(npi           = 1144429580,
                   pac           = 3577659580,
                   facility_type = "irf",
                   facility_ccn  = "67T055",
                   parent_ccn    = 670055),
      'https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/27ea-46a8?show-reference-ids=true')
  })
})
