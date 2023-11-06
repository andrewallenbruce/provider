httptest2::without_internet({
  test_that("taxonomy_crosswalk() returns correct request URL", {
    httptest2::expect_GET(
      taxonomy_crosswalk(taxonomy_code = "2086S0102X",
                         specialty_code = "2",
                         specialty_description = "Physician/General Surgery"),
      'https://data.cms.gov/data.json')

    httptest2::expect_GET(
      taxonomy_crosswalk(keyword_search = "Histocompatibility"),
      'https://data.cms.gov/data.json')
  })
})

test_that("cols_cross() works", {
  x <- dplyr::tibble(
    medicare_specialty_code                                          = 1,
    medicare_provider_supplier_type                                  = 1,
    provider_taxonomy_code                                           = 1,
    provider_taxonomy_description_type_classification_specialization = 1)

  y <- dplyr::tibble(
    specialty_code        = 1,
    specialty_description = 1,
    taxonomy_code         = 1,
    taxonomy_description  = 1)

  expect_equal(cols_cross(x), y)
})
