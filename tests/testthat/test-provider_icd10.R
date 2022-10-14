with_mock_dir("icd_10", {
  test_that("`provider_icd10` works", {

    icd_test <- tibble::tibble(
      icd_10_cm_code = "A15.0",
      icd_10_cm_term = "Tuberculosis of lung")

    expect_equal(provider_icd10(code = "A15.0"), icd_test)
    expect_equal(provider_icd10(term = "Tuberculosis of lung"), icd_test)
  })
})

with_mock_dir("icd_10_letter", {
  test_that("searching for a code by letter works", {

    icd_code_letter <- tibble::tibble(
      icd_10_cm_code = "Z00.00",
      icd_10_cm_term = "Encounter for general adult medical examination without abnormal findings")

    expect_equal(provider_icd10(code = "z", field = "code", limit = 1), icd_code_letter)
  })
})
