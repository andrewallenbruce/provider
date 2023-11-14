httptest2::without_internet({
  test_that("conditions(set = 'Specific') returns correct request URL", {
    httptest2::expect_GET(
      conditions(year      = 2018,
                 set       = "Specific",
                 level     = "State",
                 sublevel  = "CA",
                 demo      = "Sex",
                 subdemo   = "Female",
                 age       = "65+",
                 condition = "Asthma",
                 fips      = "06"),
      'https://data.cms.gov/data.json')
  })
})

test_that("cols_cc() works", {
  x <- dplyr::tibble(
    year                     = 1,
    bene_geo_lvl             = 1,
    bene_geo_desc            = 1,
    bene_geo_cd              = 1,
    bene_age_lvl             = 1,
    bene_demo_lvl            = 1,
    bene_demo_desc           = 1,
    bene_mcc                 = 1,
    bene_cond                = 1,
    prvlnc                   = 1,
    tot_mdcr_pymt_pc         = 1,
    tot_mdcr_stdzd_pymt_pc   = 1,
    hosp_readmsn_rate        = 1,
    er_visits_per_1000_benes = 1)

  y <- dplyr::tibble(
    year                = 1,
    level               = 1,
    sublevel            = 1,
    fips                = 1,
    age                 = 1,
    demographic         = 1,
    subdemo             = 1,
    mcc                 = 1,
    condition           = 1,
    prevalence          = 1,
    tot_pymt_percap     = 1,
    tot_std_pymt_percap = 1,
    hosp_readmit_rate   = 1,
    er_visits_per_1k    = 1)

  expect_equal(cols_cc(x), y)
})
