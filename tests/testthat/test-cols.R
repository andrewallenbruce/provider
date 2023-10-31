test_that("cols_aff() works", {
  x <- dplyr::tibble(npi = 123,
                     ind_pac_id = 123,
                     frst_nm = "a",
                     mid_nm = "b",
                     lst_nm = "c",
                     suff = "d",
                     facility_type = "e",
                     facility_affiliations_certification_number = 123,
                     facility_type_certification_number = 123)
  y <- dplyr::tibble(npi = 123,
                     pac = 123,
                     first = "a",
                     middle = "b",
                     last = "c",
                     suffix = "d",
                     facility_type = "e",
                     facility_ccn = 123,
                     parent_ccn = 123)
  expect_equal(cols_aff(x), y)
})
