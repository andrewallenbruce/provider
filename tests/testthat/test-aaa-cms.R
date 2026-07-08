describe("url_cms()", {
  it("succeeds with valid input", {
    expect_equal(
      purrr::map_chr(
        c(
          "clia",
          "hospital",
          "opted_out",
          "order_refer",
          "providers",
          "reassigned",
          "revoked",
          "transparency"
        ),
        url_cms
      ),
      c(
        "https://data.cms.gov/data-api/v1/dataset/d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16/data",
        "https://data.cms.gov/data-api/v1/dataset/f6f6505c-e8b0-4d57-b258-e2b94133aaf2/data",
        "https://data.cms.gov/data-api/v1/dataset/9887a515-7552-4693-bf58-735c77af46d7/data",
        "https://data.cms.gov/data-api/v1/dataset/c99b5865-1119-4436-bb80-c5af2773ea1f/data",
        "https://data.cms.gov/data-api/v1/dataset/2457ea29-fc82-48b0-86ec-3b0755de7515/data",
        "https://data.cms.gov/data-api/v1/dataset/20f51cff-4137-4f3a-b6b7-bfc9ad57983b/data",
        "https://data.cms.gov/data-api/v1/dataset/a6496a7d-4e19-479a-a9ad-d4c0a49e07c3/data",
        "https://data.cms.gov/data-api/v1/dataset/6a3aa708-3c9d-411a-a1a4-e046d3ade7ef/data"
      )
    )
  })
  it("errors with incorrect input", {
    expect_error(url_cms("ENDPOINT"))
  })
})
