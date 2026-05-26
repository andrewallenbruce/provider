test_that("check_modifiers() works", {
  expect_error(
    check_modifiers(
      param_pdc(
        first = "ANDREW",
        ccn = excludes("ASGSAH"),
        facility = ends("sdgdgs")
      ),
      "ENDPOINT"
    )
  )
})

test_that("uuid_pdc() works", {
  expect_error(
    uuid_pdc("ENDPOINT")
  )
  expect_equal(
    uuid_pdc("affiliations"),
    "27ea-46a8"
  )
  expect_equal(
    uuid_pdc("clinicians"),
    "mj5m-pzi6"
  )
  expect_equal(
    uuid_pdc("hospitals2"),
    "xubh-q36u"
  )
  expect_equal(
    uuid_pdc("dialysis"),
    "23ew-n7w9"
  )
})
