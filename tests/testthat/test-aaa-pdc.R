describe("check_modifiers()", {
  it("succeeds with valid input", {
    expect_no_error(
      check_modifiers(
        param_pdc(ccn = contains("ASGSAH"), facility = starts("sdgdgs")),
        end = "ENDPOINT"
      )
    )
    expect_no_error(
      check_modifiers(
        param_pdc(ccn = "ASGSAH", facility = "sdgdgs"),
        end = "ENDPOINT"
      )
    )
    # FIXME Should this error?
    # -> No `end` argument supplied to `check_modifiers`
    # -> Because `end` is never evaluated
    # -> In the cli::abort message since there are no modifiers to check
    expect_no_error(
      check_modifiers(
        param_pdc()
      )
    )
  })
  it("errors with incorrect input", {
    expect_error(
      check_modifiers(
        param_pdc(ccn = excludes("ASGSAH"), facility = starts("sdgdgs")),
        end = "ENDPOINT"
      )
    )
    expect_error(
      check_modifiers(
        param_pdc(excludes("sdfg")),
        end = "ENDPOINT"
      )
    )
  })
})

describe("url_pdc()", {
  it("succeeds with valid input", {
    expect_equal(url_pdc("affiliations"), "https://data.cms.gov/provider-data/api/1/datastore/query/27ea-46a8/0?")
    expect_equal(url_pdc("clinicians"), "https://data.cms.gov/provider-data/api/1/datastore/query/mj5m-pzi6/0?")
    expect_equal(url_pdc("hospitals2"), "https://data.cms.gov/provider-data/api/1/datastore/query/xubh-q36u/0?")
    expect_equal(url_pdc("dialysis"), "https://data.cms.gov/provider-data/api/1/datastore/query/23ew-n7w9/0?")
  })
  it("errors with incorrect input", {
    expect_error(url_pdc("ENDPOINT"))
  })
})
