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

describe("uuid_pdc()", {
  it("succeeds with valid input", {
    expect_equal(uuid_pdc("affiliations"), "27ea-46a8")
    expect_equal(uuid_pdc("clinicians"), "mj5m-pzi6")
    expect_equal(uuid_pdc("hospitals2"), "xubh-q36u")
    expect_equal(uuid_pdc("dialysis"), "23ew-n7w9")
  })
  it("errors with incorrect input", {
    expect_error(uuid_pdc("ENDPOINT"))
  })
})
