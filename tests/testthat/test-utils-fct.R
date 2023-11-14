test_that("fct_level() works", {
  x <- c("National", "State", "County", "Provider")
  y <- ordered(x, levels = c("National", "State", "County", "Provider"))
  expect_equal(fct_level(x), y)
})

test_that("fct_period() works", {
  x <- c("Year", "Month", month.name)
  y <- ordered(x, levels = c(
      "Year", "Month", "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"))
  expect_equal(fct_period(x), y)
})

test_that("fct_gen() works", {
  x <- c("M", "F", "9")
  y <- factor(c("Male", "Female", "Unknown"),
              levels = c("Male", "Female", "Unknown"))
  expect_equal(fct_gen(x), y)
})

test_that("fct_stabb() works", {
  x <- c('US', state.abb[1:8], 'DC', state.abb[9:50],
         'AS', 'GU', 'MP', 'PR', 'VI', 'UK')
  y <- ordered(x,
    levels = c(
      "US", "AL", "AK", "AZ", "AR", "CA", "CO", "CT",
      "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN",
      "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI",
      "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
      "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA",
      "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA",
      "WA", "WV", "WI", "WY", "AS", "GU", "MP", "PR",
      "VI", "UK"))
  expect_equal(fct_stabb(x), y)
})

test_that("fct_stname() works", {
  x <- c('National', state.name[1:8], 'District of Columbia', state.name[9:50],
         'American Samoa', 'Guam', 'Northern Mariana Islands', 'Puerto Rico',
         'Virgin Islands', 'Unknown')
  y <- ordered(x,
               levels = c(
          "National", "Alabama", "Alaska", "Arizona", "Arkansas",
          "California", "Colorado", "Connecticut", "Delaware",
          "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho",
          "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana",
          "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota",
          "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada",
          "New Hampshire", "New Jersey", "New Mexico", "New York",
          "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon",
          "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota",
          "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington",
          "West Virginia", "Wisconsin", "Wyoming", "American Samoa", "Guam",
          "Northern Mariana Islands", "Puerto Rico", "Virgin Islands",
          "Unknown"))
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

test_that("fct_pos() works", {
  x <- c("F", "O")
  y <- factor(c("Facility", "Non-facility"))
  expect_equal(fct_pos(x), y)
})

test_that("fct_purp() works", {
  x <- c("PRACTICE", "MAILING", "LOCATION")
  y <- factor(c("Practice", "Mailing", "Location"),
              levels = c("Practice", "Mailing", "Location"))
  expect_equal(fct_purp(x), y)
})

test_that("fct_age() works", {
  x <- c("All", "<65", "65+")
  y <- factor(c("All", "<65", "65+"),
              levels = c("All", "<65", "65+"))
  expect_equal(fct_age(x), y)
})

test_that("fct_demo() works", {
  x <- c("All", "Dual Status", "Sex", "Race")
  y <- factor(c("All", "Dual Status", "Sex", "Race"),
              levels = c("All", "Dual Status", "Sex", "Race"))
  expect_equal(fct_demo(x), y)
})

test_that("fct_subdemo() works", {
  x <- c("All", "Medicare Only", "Medicare and Medicaid", "Female", "Male",
         "Asian Pacific Islander", "Hispanic", "Native American",
         "non-Hispanic Black", "non-Hispanic White")
  y <- factor(c("All", "Medicare Only", "Medicare and Medicaid", "Female",
                "Male", "Asian Pacific Islander", "Hispanic",
                "Native American", "non-Hispanic Black", "non-Hispanic White"),
              levels = c("All", "Medicare Only", "Medicare and Medicaid",
                         "Female", "Male", "Asian Pacific Islander",
                         "Hispanic", "Native American", "non-Hispanic Black",
                         "non-Hispanic White"))
  expect_equal(fct_subdemo(x), y)
})

test_that("fct_mcc() works", {
  x <- c("0 to 1", "2 to 3", "4 to 5", "6+")
  y <- ordered(c("0-1", "2-3", "4-5", "6+"))
  expect_equal(fct_mcc(x), y)
})
