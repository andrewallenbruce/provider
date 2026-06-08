describe("url_cms_list()", {
  it("succeeds with valid input", {
    expect_equal(
      purrr::map(
        c(
          "pending",
          "facility",
          "owner"
        ),
        url_cms_list
      ),
      list(
        list(
          Physician = "https://data.cms.gov/data-api/v1/dataset/6bd6b1dd-208c-4f9c-88b8-b15fec6db548/data",
          `Non-Physician` = "https://data.cms.gov/data-api/v1/dataset/261b83b6-b89f-43ad-ae7b-0d419a3bc24b/data"
        ),
        list(
          HHA = "https://data.cms.gov/data-api/v1/dataset/15f64ab4-3172-4a27-b589-ebd67a6d28aa/data",
          RHC = "https://data.cms.gov/data-api/v1/dataset/3b7e7659-067e-41ea-8e36-f9ee2036e1f6/data",
          FQHC = "https://data.cms.gov/data-api/v1/dataset/4bcae866-3411-439a-b762-90a6187c194b/data",
          SNF = "https://data.cms.gov/data-api/v1/dataset/5f2c306f-3b1c-42cd-b037-187b2ce22126/data",
          Hospice = "https://data.cms.gov/data-api/v1/dataset/25704213-e833-4b8b-9dbc-58dd17149209/data"
        ),
        list(
          HHA = "https://data.cms.gov/data-api/v1/dataset/fc009b2d-7846-44b1-b4a1-692f0c143879/data",
          RHC = "https://data.cms.gov/data-api/v1/dataset/ab03c9bc-0c22-4ca4-b032-21dd3408210d/data",
          FQHC = "https://data.cms.gov/data-api/v1/dataset/ed289c89-0bb8-4221-a20a-85776066381b/data",
          SNF = "https://data.cms.gov/data-api/v1/dataset/a4358712-e910-4eaf-8f24-5e90ba3cf8d0/data",
          Hospice = "https://data.cms.gov/data-api/v1/dataset/e983965e-1603-4cb8-82b5-c40090e380d1/data",
          Hospital = "https://data.cms.gov/data-api/v1/dataset/60625dc8-b621-45f0-9423-077fd133b13e/data"
        )
      )
    )
  })
  it("errors with incorrect input", {
    expect_error(url_cms_list("ENDPOINT"))
  })
})
