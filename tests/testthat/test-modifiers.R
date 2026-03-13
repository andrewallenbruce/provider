describe("Query Modifiers", {
  describe("greater_than()", {
    x <- greater_than(500)
    it("returns a `modifier` object", {
      expect_s3_class(x, "modifier")
    })
  })
})
