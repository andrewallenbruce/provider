describe("S7 Modifier class", {
  describe("greater()", {
    it("is Modifier object", expect_s7_class(greater(500), Modifier))
    it("has expected value", expect_equal(greater(500)@value, 500))
    it("has expected operator", expect_equal(S7_data(greater(500, TRUE)), ">="))
    it("errors with Modifier", expect_error(greater(less(5))))
    it("errors with non-number", expect_error(greater("5")))
    it("errors with no input", expect_error(greater(), "`x` is absent"))
    it("errors with non-bool `equal`", expect_error(greater(5, NULL)))
  })

  describe("less()", {
    it("is Modifier", expect_s7_class(less(500), Modifier))
    it("has expected value", expect_equal(less(500)@value, 500))
    it("has expected operator", expect_equal(S7_data(less(500, TRUE)), "<="))
    it("errors with Modifier", expect_error(less(greater(5))))
    it("errors with non-number", expect_error(less("5")))
    it("errors with no input", expect_error(less()))
    it("errors with non-bool `equal`", expect_error(less(5, NULL)))
  })
})
