# httptest2::without_internet({
#   test_that("`provider_nppes()` returns correct request URL", {
#     httptest2::expect_GET(
#       provider_nppes(first = "paul", last = "dewey", state = "MN", country = "US"),
#       'https://npiregistry.cms.hhs.gov/api/?version=2.1&first_name=paul&last_name=dewey&state=MN&country_code=US&limit=10')
#     httptest2::expect_GET(
#       provider_nppes(npi = 1528060837),
#       'https://npiregistry.cms.hhs.gov/api/?version=2.1&number=1528060837&limit=10')
#   })
# })
