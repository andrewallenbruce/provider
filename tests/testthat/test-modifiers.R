describe("Query Modifiers", {
  describe("greater_than()", {
    x <- greater_than(500)
    it("returns an S7 `Modifier` object", {
      expect_s7_class(x, Modifier)
    })
  })
})
