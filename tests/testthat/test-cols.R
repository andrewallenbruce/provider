test_that("cols_aff() works", {
  x <- dplyr::tibble(npi                                        = 1,
                     ind_pac_id                                 = 1,
                     frst_nm                                    = 1,
                     mid_nm                                     = 1,
                     lst_nm                                     = 1,
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

test_that("bene_cols() works", {
  x <- dplyr::tibble(
    year                                         = 1,
    month                                        = 1,
    bene_geo_lvl                                 = 1,
    bene_state_abrvtn                            = 1,
    bene_state_desc                              = 1,
    bene_county_desc                             = 1,
    bene_fips_cd                                 = 1,
    tot_benes                                    = 1,
    orgnl_mdcr_benes                             = 1,
    ma_and_oth_benes                             = 1,
    aged_tot_benes                               = 1,
    aged_esrd_benes                              = 1,
    aged_no_esrd_benes                           = 1,
    dsbld_tot_benes                              = 1,
    dsbld_esrd_and_esrd_only_benes               = 1,
    dsbld_no_esrd_benes                          = 1,
    a_b_tot_benes                                = 1,
    a_b_orgnl_mdcr_benes                         = 1,
    a_b_ma_and_oth_benes                         = 1,
    prscrptn_drug_tot_benes                      = 1,
    prscrptn_drug_pdp_benes                      = 1,
    prscrptn_drug_mapd_benes                     = 1,
    prscrptn_drug_deemed_eligible_full_lis_benes = 1,
    prscrptn_drug_full_lis_benes                 = 1,
    prscrptn_drug_partial_lis_benes              = 1,
    prscrptn_drug_no_lis_benes                   = 1)

  y <- dplyr::tibble(year              = 1,
                     period            = 1,
                     level             = 1,
                     state             = 1,
                     state_name        = 1,
                     county            = 1,
                     fips              = 1,
                     bene_total        = 1,
                     bene_orig         = 1,
                     bene_ma_oth       = 1,
                     bene_total_aged   = 1,
                     bene_aged_esrd    = 1,
                     bene_aged_no_esrd = 1,
                     bene_total_dsb    = 1,
                     bene_dsb_esrd     = 1,
                     bene_dsb_no_esrd  = 1,
                     bene_total_ab     = 1,
                     bene_ab_orig      = 1,
                     bene_ab_ma_oth    = 1,
                     bene_total_rx     = 1,
                     bene_rx_pdp       = 1,
                     bene_rx_mapd      = 1,
                     bene_rx_lis_elig  = 1,
                     bene_rx_lis_full  = 1,
                     bene_rx_lis_part  = 1,
                     bene_rx_lis_no    = 1)
  expect_equal(bene_cols(x), y)
})

test_that("betos_cols() works", {
x <- dplyr::tibble(
    hcpcs_cd               = 1,
    rbcs_id                = 1,
    'rbcs_cat'             = 1,
    rbcs_cat_desc          = 1,
    'rbcs_cat_subcat'      = 1,
    rbcs_subcat_desc       = 1,
    'rbcs_fam_numb'        = 1,
    rbcs_family_desc       = 1,
    rbcs_major_ind         = 1,
    hcpcs_cd_add_dt        = 1,
    hcpcs_cd_end_dt        = 1,
    rbcs_assignment_eff_dt = 1,
    rbcs_assignment_end_dt = 1)

  y <- dplyr::tibble(hcpcs            = 1,
                     rbcs_id          = 1,
                     category         = 1,
                     subcategory      = 1,
                     family           = 1,
                     procedure        = 1,
                     hcpcs_start_date = 1,
                     hcpcs_end_date   = 1,
                     rbcs_start_date  = 1,
                     rbcs_end_date    = 1)
  expect_equal(betos_cols(x), y)
})
