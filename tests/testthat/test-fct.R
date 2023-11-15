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

## hospitals

test_that("fct_reg() works", {
  x <- c("Non-Profit", "Proprietor")
  expect_equal(fct_reg(x), factor(x))
})

test_that("fct_subgroup() works", {
  x <- c("Acute Care",
         "Alcohol Drug",
         "Childrens' Hospital",
         "General",
         "Long-term",
         "None",
         "Other",
         "Psychiatric",
         "Psychiatric Unit",
         "Rehabilitation",
         "Rehabilitation Unit",
         "Short-Term",
         "Specialty Hospital",
         "Swing-Bed Approved")
  expect_equal(fct_subgroup(x), factor(x))
})

## laboratories fcts

test_that("fct_toa() works", {
  x <- c("1", "2", "3", "4", "5", "8")
  y <- c("Initial", "Recertification", "Termination",
         "Change of Ownership", "Validation", "Full Survey After Complaint")
  expect_equal(fct_toa(x), ordered(y, levels = y))
})

test_that("fct_app() works", {
  x <- c("1", "2", "3", "4", "9")
  y <- c("Compliance", "Waiver", "Accreditation", "PPM", "Registration")
  expect_equal(fct_app(x), ordered(y, levels = y))
})

test_that("fct_stat() works", {
  x <- c("A", "B")
  y <- c("In Compliance", "Not In Compliance")
  expect_equal(fct_stat(x), ordered(y, levels = y))
})

test_that("fct_region() works", {
  x <- c('01', '02', '03', '04', '05', '06', '07', '08', '09', '10')
  y <- c('Boston', 'New York', 'Philadelphia', 'Atlanta', 'Chicago', 'Dallas',
         'Kansas City', 'Denver', 'San Francisco', 'Seattle')
  expect_equal(fct_region(x), factor(y, levels = y))
})

test_that("fct_owner() works", {
  x <- c('01', '02', '03', '04', '05', '06', '07', '08', '09', '10')
  y <- c('Religious Affiliation', 'Private', 'Other', 'Proprietary',
         'Govt: City', 'Govt: County', 'Govt: State', 'Govt: Federal',
         'Govt: Other', 'Unknown')
  expect_equal(fct_owner(x), factor(y, levels = y))
})

test_that("fct_lab() works", {
  x <- c("00", "22", "01", "05", "10")
  y <- c("CLIA Lab", "CLIA Lab", "CLIA88 Lab", "CLIA Exempt Lab", "CLIA VA Lab")
  z <- c("CLIA Lab", "CLIA88 Lab", "CLIA Exempt Lab", "CLIA VA Lab")
  expect_equal(fct_lab(x), factor(y, levels = z))
})

test_that("fct_facility() works", {
  x <- c('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11',
         '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22',
         '23', '24', '25', '26', '27', '28', '29')
  y <- c('Ambulance', 'Ambulatory Surgical Center', 'Ancillary Test Site',
         'Assisted Living Facility', 'Blood Banks', 'Community Clinic',
         'Comprehensive Outpatient Rehab', 'End-Stage Renal Disease Dialysis',
         'Federally Qualified Health Center', 'Health Fair',
         'Health Maintenance Organization', 'Home Health Agency', 'Hospice',
         'Hospital', 'Independent', 'Industrial', 'Insurance',
         'Intermediate Care Facility-Individuals with Intellectual Disabilities',
         'Mobile Lab', 'Pharmacy', 'Physician Office', 'Other Practitioner',
         'Prison', 'Public Health Laboratory', 'Rural Health Clinic',
         'School-Student Health Service', 'Skilled Nursing Facility',
         'Tissue Bank-Repositories', 'Other')
  expect_equal(fct_facility(x), ordered(y, levels = y))
})

test_that("fct_facility() works", {
  x <- c('00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10',
         '11', '12', '13', '14', '15', '16', '17', '20', '33', '80', '99')
  y <- c('Active Provider',
         'Voluntary: Merger, Closure',
         'Voluntary: Dissatisfaction with Reimbursement',
         'Voluntary: Risk of Involuntary Termination',
         'Voluntary: Other Reason for Withdrawal',
         'Involuntary: Failure to Meet Health-Safety Req',
         'Involuntary: Failure to Meet Agreement',
         'Other: Provider Status Change',
         'Nonpayment of Fees (CLIA Only)',
         'Rev/Unsuccessful Participation in PT (CLIA Only)',
         'Rev/Other Reason (CLIA Only)',
         'Incomplete CLIA Application Information (CLIA Only)',
         'No Longer Performing Tests (CLIA Only)',
         'Multiple to Single Site Certificate (CLIA Only)',
         'Shared Laboratory (CLIA Only)',
         'Failure to Renew Waiver PPM Certificate (CLIA Only)',
         'Duplicate CLIA Number (CLIA Only)',
         'Mail Returned No Forward Address Cert Ended (CLIA Only)',
         'Notification Bankruptcy (CLIA Only)',
         'Accreditation Not Confirmed (CLIA Only)',
         'Awaiting State Approval',
         'OIG Action Do Not Activate (CLIA Only)')
  expect_equal(fct_term(x), ordered(y, levels = y))
})
