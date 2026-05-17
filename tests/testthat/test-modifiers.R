describe("S7 numeric Modifiers", {
  describe("greater()", {
    it("has Modifier class", expect_s7_class(greater(500), Modifier))
    it("has expected value", expect_equal(greater(500)@value, 500))
    it("has expected operator", expect_equal(greater(500, TRUE)@operator, ">="))
    it("errors with nested Modifier", expect_error(greater(less(5))))
    it("errors with no input", expect_error(greater()))
    it("errors with non-bool `equal`", expect_error(greater(5, NULL)))
    it("errors with non-number", expect_error(greater("5")))
  })

  describe("less()", {
    it("has Modifier class", expect_s7_class(less(500), Modifier))
    it("has expected value", expect_equal(less(500)@value, 500))
    it("has expected operator", expect_equal(less(500, TRUE)@operator, "<="))
    it("errors with nested Modifier", expect_error(less(greater(5))))
    it("errors with no input", expect_error(less()))
    it("errors with non-bool `equal`", expect_error(less(5, NULL)))
    it("errors with non-number", expect_error(less("5")))
  })

  describe("between()", {
    it("has Modifier class", expect_s7_class(between(500, 1000), Modifier))
    it(
      "has expected value",
      expect_equal(between(500, 1000)@value, c(500, 1000))
    )
    it(
      "has expected operator",
      expect_equal(between(500, 1000)@operator, "BETWEEN")
    )
    it("errors with nested Modifier", expect_error(between(500, greater(500))))
    it("errors with no input", expect_error(between()))
    it("errors with non-number", expect_error(between(1, "5")))
    it("errors when `x` is greater than `y`", expect_error(between(1, 0)))
    it("errors with two zeroes", expect_error(between(0, 0)))
  })
})
