describe("Modifiers", {
  describe("greater()", {
    x <- greater(500)
    it("returns an S7 `Modifier` object", {
      expect_s7_class(x, Modifier)
    })
  })
})
