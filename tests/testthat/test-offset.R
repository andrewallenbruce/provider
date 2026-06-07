test_that("offset() works correctly", {
  expect_equal(offset(n = 10000, limit = 50), 201)
  expect_equal(offset(n = 10000, limit = 5000, "seq"), c(0, 5000, 10000))
})

test_that("offset2() works correctly", {
  expect_equal(
    offset2("url-<<i>>", 10000, 5000),
    c("url-0", "url-5000", "url-10000")
  )
})

test_that("offset3() works correctly", {
  expect_equal(
    offset3(
      c(
        "https://example.com/v1/data?offset=<<i>>&first=John",
        "https://example.com/v2/data?offset=<<i>>&first=John"
      ),
      c(10000, 20000),
      5000
    ),
    list(
      c(
        "https://example.com/v1/data?offset=0&first=John",
        "https://example.com/v1/data?offset=5000&first=John",
        "https://example.com/v1/data?offset=10000&first=John"
      ),
      c(
        "https://example.com/v2/data?offset=0&first=John",
        "https://example.com/v2/data?offset=5000&first=John",
        "https://example.com/v2/data?offset=10000&first=John",
        "https://example.com/v2/data?offset=15000&first=John",
        "https://example.com/v2/data?offset=20000&first=John"
      )
    )
  )
})
