describe("Query Modifiers", {
  describe("is_blank()", {
    it("has expected class, value & operator", {
      x <- is_blank()
      expect_s7_class(x, Modifier)
      expect_equal(x@value, "")
      expect_equal(x@operator, "=")
    })
    it("errors with input", expect_error(is_blank("AAA")))
  })

  describe("not_blank()", {
    it("has expected class, value & operator", {
      x <- not_blank()
      expect_s7_class(x, Modifier)
      expect_equal(x@value, "")
      expect_equal(x@operator, "<>")
    })
    it("errors with input", expect_error(not_blank("AAA")))
  })

  describe("greater()", {
    it("has expected class, value & operator", {
      x <- greater(5)
      expect_s7_class(x, Modifier)
      expect_equal(x@value, 5)
      expect_equal(x@operator, ">")
      expect_equal(greater(5, equal = TRUE)@operator, ">=")
    })
    it("errors with nested Modifier", expect_error(greater(less(5))))
    it("errors with no input", expect_error(greater()))
    it("errors with non-numeric input", expect_error(greater("5")))
    it(
      "errors with non-bool `equal` input",
      expect_error(greater(5, equal = NULL))
    )
  })

  describe("less()", {
    it("has expected class, value & operator", {
      x <- less(5)
      expect_s7_class(x, Modifier)
      expect_equal(x@value, 5)
      expect_equal(x@operator, "<")
      expect_equal(less(5, equal = TRUE)@operator, "<=")
    })
    it("errors with nested Modifier", expect_error(less(greater(5))))
    it("errors with no input", expect_error(less()))
    it("errors with non-numeric input", expect_error(less("5")))
    it(
      "errors with non-bool `equal` input",
      expect_error(less(5, equal = NULL))
    )
  })

  describe("between()", {
    it("has expected class, value & operator", {
      x <- between(5, 10)
      expect_s7_class(x, Modifier)
      expect_equal(x@value, c(5, 10))
      expect_equal(x@operator, "BETWEEN")
    })
    it("errors with nested Modifier", expect_error(between(5, greater(10))))
    it("errors with no input", expect_error(between()))
    it("errors with non-numeric input", expect_error(between(5, "10")))
    it("errors when `x` >= `y`", {
      expect_error(between(1, 0))
      expect_error(between(1, 1))
      expect_error(between(0, 0))
    })
    it("errors with vector input", {
      expect_error(between(c(1, 5), 0))
      expect_error(between(0, c(1, 5)))
    })
  })
})
