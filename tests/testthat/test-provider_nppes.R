httptest2::with_mock_dir("nppes", {
  test_that("`provider_nppes` works", {

    nppes_test <- tibble::tibble(
      datetime = as.POSIXct(lubridate::now()),
      outcome = "results",
      data_lists = list(
        as.data.frame(tibble::tibble(
          created_epoch = "1117219216000",
          enumeration_type = "NPI-1",
          last_updated_epoch = "1354659522000",
          number = "1760485387",
          addresses = list(
            data.frame(
              country_code = c("US", "US"),
              country_name = c("United States", "United States"),
              address_purpose = c("MAILING", "LOCATION"),
              address_type = c("DOM", "DOM"),
              address_1 = c("4570 CTY. HWY. 61", "4570 CTY. HWY. 61"),
              city = c("MOOSE LAKE", "MOOSE LAKE"),
              state = c("MN", "MN"),
              postal_code = c("55767", "55767"),
              telephone_number = c("218-485-4491", "218-485-4491"),
              fax_number = c("218-485-4724", "218-485-4724")
            )
          ),
          practiceLocations = list(list()),
          basic = data.frame(
            first_name = "PAUL",
            last_name = "DEWEY",
            middle_name = "R.",
            credential = "M.D.",
            sole_proprietor = "NO",
            gender = "M",
            enumeration_date = "2005-05-27",
            last_updated = "2012-12-04",
            status = "A",
            name_prefix = "Dr.",
            name_suffix = "--"
          ),
          taxonomies = list(
            data.frame(
              code = c("207R00000X", "208000000X"),
              taxonomy_group = c("", ""),
              desc = c("Internal Medicine", "Pediatrics"),
              state = c("MN", "MN"),
              license = c("43634", "43634"),
              primary = c(TRUE, FALSE)
            )
          ),
          identifiers = list(
            data.frame(
              code = c("04", "08", "05", "02"),
              desc = c(
                "MEDICARE ID-Type Unspecified", "MEDICARE PIN", "MEDICAID",
                "MEDICARE UPIN"
              ),
              issuer = c(NA, NA, NA, NA),
              identifier = c("110007804", "110007804", "792640500", "H31384"),
              state = c("MN", "MN", "MN", "MN")
            )
          ),
          endpoints = list(list()),
          other_names = list(list())
        ))
      ),
    )
    expect_equal(provider_nppes(npi = 1760485387), nppes_test)
  })
})

httptest2::without_internet({
  test_that("`provider_nppes` works", {
    httptest2::expect_GET(
      provider_nppes(first = "paul", last = "dewey", state = "MN", country = "US"),
      'https://npiregistry.cms.hhs.gov/api/?version=2.1&first_name=paul&last_name=dewey&state=MN&country_code=US&limit=10'
    )
  })
})
