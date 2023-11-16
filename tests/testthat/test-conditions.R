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

test_that("lookup() works", {expect_equal(lookup(
  c("0-1" = "0 to 1"), "0-1"), "0 to 1")})
test_that("levels() works", {expect_equal(levels(),
                                          c("National", "State", "County"))})
test_that("ages() works", {expect_equal(ages(),
                                        c("All", "<65", "65+"))})
test_that("demo() works", {expect_equal(demo(),
                            c("All", "Dual Status", "Sex", "Race"))})

test_that("mcc() works", {
  expect_equal(mcc(), c("0-1" = "0 to 1",
                        "2-3" = "2 to 3",
                        "4-5" = "4 to 5",
                        "6+"  = "6+"))
  })

test_that("subdemo() works", {
  expect_equal(subdemo(), c("All"      = "All",
                            "Nondual"  = "Medicare Only",
                            "Dual"     = "Medicare and Medicaid",
                            "Female"   = "Female",
                            "Male"     = "Male",
                            "Island"   = "Asian Pacific Islander",
                            "Hispanic" = "Hispanic",
                            "Native"   = "Native American",
                            "Black"    = "non-Hispanic Black",
                            "White"    = "non-Hispanic White"))
})

test_that("spec_cond() works", {
  expect_equal(spec_cond(), c('All'                                         = 'All',
                              'Alcohol Abuse'                               = 'Alcohol Abuse',
                              "Alzheimer's Disease/Dementia"                = "Alzheimer's Disease%2FDementia",
                              'Arthritis'                                   = 'Arthritis',
                              'Asthma'                                      = 'Asthma',
                              'Atrial Fibrillation'                         = 'Atrial Fibrillation',
                              'Autism Spectrum Disorders'                   = 'Autism Spectrum Disorders',
                              'Cancer'                                      = 'Cancer',
                              'Chronic Kidney Disease'                      = 'Chronic Kidney Disease',
                              'COPD'                                        = 'COPD',
                              'Depression'                                  = 'Depression',
                              'Diabetes'                                    = 'Diabetes',
                              'Drug Abuse/Substance Abuse'                  = 'Drug Abuse%2FSubstance Abuse',
                              'Heart Failure'                               = 'Heart Failure',
                              'Hepatitis (Chronic Viral B & C)'             = 'Hepatitis (Chronic Viral B %26 C)',
                              'HIV/AIDS'                                    = 'HIV%2FAIDS',
                              'Hyperlipidemia'                              = 'Hyperlipidemia',
                              'Hypertension'                                = 'Hypertension',
                              'Ischemic Heart Disease'                      = 'Ischemic Heart Disease',
                              'Osteoporosis'                                = 'Osteoporosis',
                              'Schizophrenia and Other Psychotic Disorders' = 'Schizophrenia and Other Psychotic Disorders',
                              'Stroke'                                      = 'Stroke'))
})
