describe("count_set()", {
  it("succeeds with valid input", {
    expect_equal(count_set(count = TRUE, set = FALSE), "count")
    expect_equal(count_set(count = FALSE, set = TRUE), "set")
    expect_equal(count_set(count = FALSE, set = FALSE), "")
  })
  it("errors with incorrect input", {
    expect_error(count_set())
    expect_error(count_set(count = TRUE, set = TRUE))
    expect_error(count_set(count = TRUE))
    expect_error(count_set(set = TRUE))
  })
})
