describe("Query Modifiers", {

  describe("contains()", {
    it("has expected class/name/value/operator", {
      x <- contains("foo")
      expect_s7_class(x, Modifier)
      expect_equal(S7::S7_data(x), "contains")
      expect_equal(x@value, "foo")
      expect_equal(x@operator, "CONTAINS")
    })
    it("errors with incorrect input", {
      expect_error(contains(less(5))) # nested modifier
      expect_error(contains()) # no input
      expect_error(contains(list(5))) # list
    })
  })

  describe("ends()", {
    it("has expected class/name/value/operator", {
      x <- ends("foo")
      expect_s7_class(x, Modifier)
      expect_equal(S7::S7_data(x), "ends")
      expect_equal(x@value, "foo")
      expect_equal(x@operator, "ENDS WITH")
    })
    it("errors with incorrect input", {
      expect_error(ends(less(5))) # nested modifier
      expect_error(ends()) # no input
      expect_error(ends(list(5))) # list
    })
  })

  describe("excludes()", {
    it("has expected class/name/value/operator", {
      x <- excludes("foo")
      expect_s7_class(x, Modifier)
      expect_equal(S7::S7_data(x), "excludes")
      expect_equal(x@value, "foo")
      expect_equal(x@operator, "NOT+IN")
    })
    it("errors with incorrect input", {
      expect_error(excludes(less(5))) # nested modifier
      expect_error(excludes()) # no input
      expect_error(excludes(list(5))) # list
    })
  })

  describe("not()", {
    it("has expected class/name/value/operator", {
      x <- not("foo")
      expect_s7_class(x, Modifier)
      expect_equal(S7::S7_data(x), "not")
      expect_equal(x@value, "foo")
      expect_equal(x@operator, "<>")
    })
    it("errors with incorrect input", {
      expect_error(not(less(5))) # nested modifier
      expect_error(not()) # no input
      expect_error(not(list(5))) # list
    })
  })

  describe("starts()", {
    it("has expected class/name/value/operator", {
      x <- starts("foo")
      expect_s7_class(x, Modifier)
      expect_equal(S7::S7_data(x), "starts")
      expect_equal(x@value, "foo")
      expect_equal(x@operator, "STARTS WITH")
    })
    it("errors with incorrect input", {
      expect_error(starts(less(5))) # nested modifier
      expect_error(starts()) # no input
      expect_error(starts(list(5))) # list
    })
  })

  describe("greater()", {
    it("has expected class/name/value/operator", {
      x <- greater(5)
      e <- greater(5, equal = TRUE)
      expect_s7_class(x, Modifier)
      expect_equal(S7::S7_data(x), "greater")
      expect_equal(x@value, 5)
      expect_equal(x@operator, ">")
      expect_equal(e@operator, ">=")
    })
    it("errors with incorrect input", {
      expect_error(greater(less(5))) # nested modifier
      expect_error(greater()) # no input
      expect_error(greater(list(5))) # list
      expect_error(greater("5")) # non-numeric input
      expect_error(greater(5, equal = NULL)) # non-bool `equal`
    })
  })

  describe("less()", {
    it("has expected class/name/value/operator", {
      x <- less(5)
      e <- less(5, equal = TRUE)
      expect_s7_class(x, Modifier)
      expect_equal(S7::S7_data(x), "less")
      expect_equal(x@value, 5)
      expect_equal(x@operator, "<")
      expect_equal(e@operator, "<=")
    })
    it("errors with incorrect input", {
      expect_error(less(greater(5))) # nested modifier
      expect_error(less()) # no input
      expect_error(less(list(5))) # list
      expect_error(less("5")) # non-numeric input
      expect_error(less(5, equal = NULL)) # non-bool `equal`
    })
  })

  describe("between()", {
    it("has expected class/name/value/operator", {
      x <- between(5, 10)
      expect_s7_class(x, Modifier)
      expect_equal(S7::S7_data(x), "between")
      expect_equal(x@value, c(5, 10))
      expect_equal(x@operator, "BETWEEN")
    })
    it("errors with incorrect input", {
      expect_error(between(5, greater(10))) # nested modifier
      expect_error(between()) # no input
      expect_error(between(1, list(5))) # list
      expect_error(between(5, "10")) # non-numeric input
      expect_error(between(1, 0)) # x > y
      expect_error(between(1, 1)) # x = y
      expect_error(between(0, 0)) # both zero
      expect_error(between(c(1, 5), 0)) # vector input
      expect_error(between(0, c(1, 5))) # vector input
    })
  })

  describe("is_blank()", {
    it("has expected class/name/value/operator", {
      x <- is_blank()
      expect_s7_class(x, Modifier)
      expect_equal(S7::S7_data(x), "is_blank")
      expect_equal(x@value, "")
      expect_equal(x@operator, "=")
    })
    it("errors with ANY input", {
      expect_error(is_blank("AAA"))
      expect_error(is_blank(""))
    })
  })

  describe("not_blank()", {
    it("has expected class/name/value/operator", {
      x <- not_blank()
      expect_s7_class(x, Modifier)
      expect_equal(S7::S7_data(x), "not_blank")
      expect_equal(x@value, "")
      expect_equal(x@operator, "<>")
    })
    it("errors with ANY input", {
      expect_error(not_blank("AAA"))
      expect_error(not_blank(""))
    })
  })
})
