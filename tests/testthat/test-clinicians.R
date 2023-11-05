httptest2::without_internet({
  test_that("clinicians() returns correct request URL", {
    httptest2::expect_GET(
      clinicians(npi           = 1457433005,
                 pac           = '0042104788',
                 first         = 'JOSEPH',
                 last          = 'LOWRY',
                 gender        = 'M',
                 credential    = 'MD',
                 school        = 'NEW YORK UNIVERSITY SCHOOL OF MEDICINE',
                 grad_year     = 1978,
                 specialty     = 'DIAGNOSTIC RADIOLOGY',
                 facility_name = 'NORTH SHORE - LIJ MEDICAL PC',
                 pac_org       = 3375701568,
                 city          = 'STATEN ISLAND',
                 state         = 'NY',
                 zip           = '103053436'),
      'https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/mj5m-pzi6?show-reference-ids=true')
  })
})

test_that("cols_clin() works", {

  x <- dplyr::tibble(
    npi                  = 1,
    ind_pac_id           = 1,
    ind_enrl_id          = 1,
    provider_first_name  = 1,
    provider_middle_name = 1,
    provider_last_name   = 1,
    suff                 = 1,
    gndr                 = 1,
    cred                 = 1,
    med_sch              = 1,
    grd_yr               = 1,
    pri_spec             = 1,
    sec_spec_all         = 1,
    facility_name        = 1,
    org_pac_id           = 1,
    num_org_mem          = 1,
    address              = 1,
    citytown             = 1,
    state                = 1,
    zip_code             = 1,
    telephone_number     = 1,
    adrs_id              = 1,
    telehlth             = 1,
    ind_assgn            = 1,
    grp_assgn            = 1)

  y <- dplyr::tibble(
    npi           = 1,
    pac           = 1,
    enid          = 1,
    first         = 1,
    middle        = 1,
    last          = 1,
    suffix        = 1,
    gender        = 1,
    credential    = 1,
    school        = 1,
    grad_year     = 1,
    specialty     = 1,
    specialty_sec = 1,
    facility_name = 1,
    pac_org       = 1,
    members_org   = 1,
    address_org   = 1,
    city_org      = 1,
    state_org     = 1,
    zip_org       = 1,
    phone_org     = 1)
  expect_equal(cols_clin(x), y)
})
