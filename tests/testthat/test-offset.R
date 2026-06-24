test_that("offset() works correctly", {
  expect_equal(offset(10000L, 50L), 201L)
  expect_equal(offset(0L, 50L), 0L)
  expect_equal(offset(10000L, 5000L, "seq"), c(0L, 5000L, 10000L))

  expect_error(offset(-1L, 0L))
  expect_error(offset(1L, 0L))
  expect_error(offset(0L, 0L))
})

test_that("offset2() works correctly", {
  expect_equal(
    offset2("url-<<i>>", 10000L, 5000L),
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
      c(10000L, 20000L),
      5000L
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
