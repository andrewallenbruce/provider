test_that("fct_level() works", {
  x <- c("National", "State", "County", "Provider")
  y <- ordered(x, levels = x)
  expect_equal(fct_level(x), y)
})

test_that("fct_period() works", {
  x <- c("Year", "Month", month.name)
  y <- ordered(x, levels = x)
  expect_equal(fct_period(x), y)
})

test_that("fct_gen() works", {
  x <- c("M", "F", "9")
  y <- c("Male", "Female", "Unknown")
  z <- factor(y, levels = y)
  expect_equal(fct_gen(x), z)
})

test_that("fct_stabb() works", {
  x <- c('US', state.abb[1:8], 'DC', state.abb[9:50],
         'AS', 'GU', 'MP', 'PR', 'VI', 'UK')
  y <- ordered(x, levels = x)
  expect_equal(fct_stabb(x), y)
})

test_that("fct_stname() works", {
  x <- c('National', state.name[1:8], 'District of Columbia', state.name[9:50],
         'American Samoa', 'Guam', 'Northern Mariana Islands', 'Puerto Rico',
         'Virgin Islands', 'Unknown')
  y <- ordered(x, levels = x)
  expect_equal(fct_stname(x), y)
})

test_that("fct_enum() works", {
  x <- c("NPI-1", "NPI-2")
  y <- factor(c("Individual", "Organization"))
  expect_equal(fct_enum(x), y)
})

test_that("fct_ent() works", {
  x <- c("I", "O")
  y <- factor(c("Individual", "Organization"))
  expect_equal(fct_ent(x), y)
})

test_that("fct_entype() works", {
  x <- c(1, 2)
  y <- factor(c("Individual", "Organization"))
  expect_equal(fct_entype(x), y)
})

test_that("fct_pos() works", {
  x <- c("F", "O")
  y <- factor(c("Facility", "Non-facility"))
  expect_equal(fct_pos(x), y)
})

test_that("fct_purp() works", {
  x <- c("PRACTICE", "MAILING", "LOCATION")
  y <- c("Practice", "Mailing", "Location")
  z <- factor(y, levels = y)
  expect_equal(fct_purp(x), z)
})

test_that("fct_age() works", {
  x <- c("All", "<65", "65+")
  y <- factor(x, levels = x)
  expect_equal(fct_age(x), y)
})

test_that("fct_demo() works", {
  x <- c("All", "Dual Status", "Sex", "Race")
  y <- factor(x, levels = x)
  expect_equal(fct_demo(x), y)
})

test_that("fct_subdemo() works", {
  x <- c("All", "Medicare Only", "Medicare and Medicaid", "Female",
         "Male", "Asian Pacific Islander", "Hispanic", "Native American",
         "non-Hispanic Black", "non-Hispanic White")
  y <- factor(x, levels = x)
  expect_equal(fct_subdemo(x), y)
})

test_that("fct_mcc() works", {
  x <- c("0 to 1", "2 to 3", "4 to 5", "6+")
  y <- ordered(c("0-1", "2-3", "4-5", "6+"))
  expect_equal(fct_mcc(x), y)
})

test_that("fct_part() works", {
  x <- c("Group", "Individual", "MIPS APM")
  y <- factor(c("Group", "Individual", "MIPS APM"))
  expect_equal(fct_part(x), y)
})

test_that("fct_status() works", {
  x <- c("engaged", "opted_into_mips", "small_practitioner", "rural",
         "hpsa", "ambulatory_surgical_center", "hospital_based_clinician",
         "non_patient_facing", "facility_based", "extreme_hardship",
         "extreme_hardship_quality", "quality_bonus", "extreme_hardship_pi",
         "pi_hardship", "pi_reweighting", "pi_bonus", "extreme_hardship_ia",
         "ia_study", "extreme_hardship_cost")
  y <- c("Engaged", "Opted into MIPS", "Small Practitioner", "Rural Clinician",
         "HPSA Clinician", "Ambulatory Surgical Center",
         "Hospital-Based Clinician", "Non-Patient Facing", "Facility-Based",
         "Extreme Hardship", "Extreme Hardship (Quality)", "Quality Bonus",
         "Extreme Hardship (PI)", "PI Hardship", "PI Reweighting", "PI Bonus",
         "Extreme Hardship (IA)", "IA Study", "Extreme Hardship (Cost)")
  z <- factor(y, levels = y)
  expect_equal(fct_status(x), z)
})

test_that("fct_measure() works", {
  x <- c("quality", "pi", "ia", "cost")
  y <- c("Quality", "Promoting Interoperability",
         "Improvement Activities", "Cost")
  z <- factor(y, levels = y)
  expect_equal(fct_measure(x), z)
})
