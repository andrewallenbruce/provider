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

test_that("cols_aff() works", {
  x <- dplyr::tibble(npi                                        = 1,
                     ind_pac_id                                 = 1,
                     provider_first_name                        = 1,
                     provider_middle_name                       = 1,
                     provider_last_name                         = 1,
                     suff                                       = 1,
                     facility_type                              = 1,
                     facility_affiliations_certification_number = 1,
                     facility_type_certification_number         = 1)

  y <- dplyr::tibble(npi           = 1,
                     pac           = 1,
                     first         = 1,
                     middle        = 1,
                     last          = 1,
                     suffix        = 1,
                     facility_type = 1,
                     facility_ccn  = 1,
                     parent_ccn    = 1)
  expect_equal(cols_aff(x), y)
})
