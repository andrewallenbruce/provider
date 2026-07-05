describe("subgroups()", {
  x <- subgroups(acute = TRUE, other = FALSE)
  it("has expected class/data", {
    expect_s7_class(x, Subgroups)
    expect_true(is_subgroups(x))
    expect_equal(
      S7::S7_data(x),
      list(
        `SUBGROUP %2D ACUTE CARE` = "Y",
        `SUBGROUP %2D OTHER` = "N"
      )
    )
  })
  it("succeeds with valid input", {
    expect_no_error(x)
    expect_no_error(check_subgroups(x))
    expect_no_error(subgroups())
    expect_invisible(x <- subgroups())
    expect_visible(x)
  })
  it("errors with incorrect input", {
    expect_error(subgroups(acute = "true")) # character
    expect_error(subgroups(acute = c(TRUE, FALSE))) # logical vector
    expect_error(subgroups(acute = list())) # empty list
    expect_error(subgroups(cute = TRUE)) # incorrect argument
  })
})
