describe("check_modifiers()", {
  it("succeeds with valid input", {
    expect_no_error(
      check_modifiers(
        # FIXME Should duplicate arg names error?
        param_pdc(
          ccn = contains("ASGSAH"),
          facility = starts("sdgdgs"),
          ccn = "ASGSAH",
          facility = "sdgdgs"
        ),
        end = "ENDPOINT"
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
    expect_error(
      check_modifiers(
        param_pdc()
      )
    )
  })
})

describe("url_pdc()", {
  it("succeeds with valid input", {
    expect_equal(
      purrr::map_chr(
        c("affiliations", "clinician", "hospital2", "dialysis"),
        url_pdc
      ),
      c(
        "https://data.cms.gov/provider-data/api/1/datastore/query/27ea-46a8/0?",
        "https://data.cms.gov/provider-data/api/1/datastore/query/mj5m-pzi6/0?",
        "https://data.cms.gov/provider-data/api/1/datastore/query/xubh-q36u/0?",
        "https://data.cms.gov/provider-data/api/1/datastore/query/23ew-n7w9/0?"
      )
    )
  })
  it("errors with incorrect input", {
    expect_error(url_pdc("ENDPOINT"))
  })
})
