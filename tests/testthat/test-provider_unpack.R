test_that("provider_unpack works", {

  unpack_ex <- tibble::tibble(
    npi = c(
      "1528060837", "1528060837", "1528060837", "1528060837", "1528060837",
      "1528060837", "1528060837", "1528060837", "1528060837", "1528060837",
      "1528060837", "1528060837", "1528060837", "1528060837", "1528060837",
      "1528060837", "1528060837", "1528060837", "1528060837", "1528060837"
    ),
    prov_type = c(
      "NPI-1", "NPI-1", "NPI-1", "NPI-1", "NPI-1", "NPI-1", "NPI-1",
      "NPI-1", "NPI-1", "NPI-1", "NPI-1", "NPI-1", "NPI-1", "NPI-1",
      "NPI-1", "NPI-1", "NPI-1", "NPI-1", "NPI-1", "NPI-1"
    ),
    first_name = c(
      "JOHN", "JOHN", "JOHN", "JOHN", "JOHN", "JOHN", "JOHN", "JOHN",
      "JOHN", "JOHN", "JOHN", "JOHN", "JOHN", "JOHN", "JOHN", "JOHN",
      "JOHN", "JOHN", "JOHN", "JOHN"
    ),
    last_name = c(
      "SARGEANT", "SARGEANT", "SARGEANT", "SARGEANT", "SARGEANT",
      "SARGEANT", "SARGEANT", "SARGEANT", "SARGEANT", "SARGEANT", "SARGEANT",
      "SARGEANT", "SARGEANT", "SARGEANT", "SARGEANT", "SARGEANT", "SARGEANT",
      "SARGEANT", "SARGEANT", "SARGEANT"
    ),
    middle_name = c(
      "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B",
      "B", "B", "B", "B", "B", "B", "B", "B"
    ),
    credential = c(
      "PT", "PT", "PT", "PT", "PT", "PT", "PT", "PT", "PT", "PT",
      "PT", "PT", "PT", "PT", "PT", "PT", "PT", "PT", "PT", "PT"
    ),
    sole_proprietor = c(
      "NO", "NO", "NO", "NO", "NO", "NO", "NO", "NO", "NO", "NO",
      "NO", "NO", "NO", "NO", "NO", "NO", "NO", "NO", "NO", "NO"
    ),
    gender = c(
      "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M",
      "M", "M", "M", "M", "M", "M", "M", "M"
    ),
    enumeration_date = c(
      "2005-06-01", "2005-06-01", "2005-06-01", "2005-06-01", "2005-06-01",
      "2005-06-01", "2005-06-01", "2005-06-01", "2005-06-01", "2005-06-01",
      "2005-06-01", "2005-06-01", "2005-06-01", "2005-06-01", "2005-06-01",
      "2005-06-01", "2005-06-01", "2005-06-01", "2005-06-01", "2005-06-01"
    ),
    last_updated = c(
      "2007-07-09", "2007-07-09", "2007-07-09", "2007-07-09", "2007-07-09",
      "2007-07-09", "2007-07-09", "2007-07-09", "2007-07-09", "2007-07-09",
      "2007-07-09", "2007-07-09", "2007-07-09", "2007-07-09", "2007-07-09",
      "2007-07-09", "2007-07-09", "2007-07-09", "2007-07-09", "2007-07-09"
    ),
    status = c(
      "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A",
      "A", "A", "A", "A", "A", "A", "A", "A"
    ),
    name_prefix = c(
      "Mr.", "Mr.", "Mr.", "Mr.", "Mr.", "Mr.", "Mr.", "Mr.", "Mr.",
      "Mr.", "Mr.", "Mr.", "Mr.", "Mr.", "Mr.", "Mr.", "Mr.", "Mr.",
      "Mr.", "Mr."
    ),
    name_suffix = c(
      "--", "--", "--", "--", "--", "--", "--", "--", "--", "--",
      "--", "--", "--", "--", "--", "--", "--", "--", "--", "--"
    ),
    country_code = c(
      "US", "US", "US", "US", "US", "US", "US", "US", "US", "US",
      "US", "US", "US", "US", "US", "US", "US", "US", "US", "US"
    ),
    address_purpose = c(
      "mailing", "mailing", "mailing", "mailing", "mailing", "mailing",
      "mailing", "mailing", "mailing", "mailing", "location", "location",
      "location", "location", "location", "location", "location", "location",
      "location", "location"
    ),
    address_1 = c(
      "1939 OLD ANNAPOLIS RD", "1939 OLD ANNAPOLIS RD", "1939 OLD ANNAPOLIS RD",
      "1939 OLD ANNAPOLIS RD", "1939 OLD ANNAPOLIS RD", "1939 OLD ANNAPOLIS RD",
      "1939 OLD ANNAPOLIS RD", "1939 OLD ANNAPOLIS RD", "1939 OLD ANNAPOLIS RD",
      "1939 OLD ANNAPOLIS RD", "6000 EXECUTIVE BLVD", "6000 EXECUTIVE BLVD",
      "6000 EXECUTIVE BLVD", "6000 EXECUTIVE BLVD", "6000 EXECUTIVE BLVD",
      "6000 EXECUTIVE BLVD", "6000 EXECUTIVE BLVD", "6000 EXECUTIVE BLVD",
      "6000 EXECUTIVE BLVD", "6000 EXECUTIVE BLVD"
    ),
    city = c(
      "WOODBINE", "WOODBINE", "WOODBINE", "WOODBINE", "WOODBINE",
      "WOODBINE", "WOODBINE", "WOODBINE", "WOODBINE", "WOODBINE", "ROCKVILLE",
      "ROCKVILLE", "ROCKVILLE", "ROCKVILLE", "ROCKVILLE", "ROCKVILLE",
      "ROCKVILLE", "ROCKVILLE", "ROCKVILLE", "ROCKVILLE"
    ),
    state = c(
      "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD",
      "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD"
    ),
    postal_code = c(
      "217978201", "217978201", "217978201", "217978201", "217978201",
      "217978201", "217978201", "217978201", "217978201", "217978201",
      "208523803", "208523803", "208523803", "208523803", "208523803",
      "208523803", "208523803", "208523803", "208523803", "208523803"
    ),
    telephone_number = c(
      "301-854-6748", "301-854-6748", "301-854-6748", "301-854-6748",
      "301-854-6748", "301-854-6748", "301-854-6748", "301-854-6748",
      "301-854-6748", "301-854-6748", "301-816-0020", "301-816-0020",
      "301-816-0020", "301-816-0020", "301-816-0020", "301-816-0020",
      "301-816-0020", "301-816-0020", "301-816-0020", "301-816-0020"
    ),
    address_2 = c(
      NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "STE 201", "STE 201",
      "STE 201", "STE 201", "STE 201", "STE 201", "STE 201", "STE 201",
      "STE 201", "STE 201"
    ),
    fax_number = c(
      NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "301-816-0334", "301-816-0334",
      "301-816-0334", "301-816-0334", "301-816-0334", "301-816-0334",
      "301-816-0334", "301-816-0334", "301-816-0334", "301-816-0334"
    ),
    taxon_code = c(
      "225100000X", "225100000X", "225100000X", "225100000X", "225100000X",
      "225100000X", "225100000X", "225100000X", "225100000X", "225100000X",
      "225100000X", "225100000X", "225100000X", "225100000X", "225100000X",
      "225100000X", "225100000X", "225100000X", "225100000X", "225100000X"
    ),
    taxonomy_group = c(
      "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
      "", "", "", "", ""
    ),
    taxon_desc = c(
      "Physical Therapist", "Physical Therapist", "Physical Therapist",
      "Physical Therapist", "Physical Therapist", "Physical Therapist",
      "Physical Therapist", "Physical Therapist", "Physical Therapist",
      "Physical Therapist", "Physical Therapist", "Physical Therapist",
      "Physical Therapist", "Physical Therapist", "Physical Therapist",
      "Physical Therapist", "Physical Therapist", "Physical Therapist",
      "Physical Therapist", "Physical Therapist"
    ),
    taxon_state = c(
      "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD",
      "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD", "MD"
    ),
    taxon_license = c(
      "14262", "14262", "14262", "14262", "14262", "14262", "14262",
      "14262", "14262", "14262", "14262", "14262", "14262", "14262",
      "14262", "14262", "14262", "14262", "14262", "14262"
    ),
    taxon_primary = c(
      TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE,
      TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE
    ),
    ident_code = c(
      "01", "01", "01", "01", "01", "01", "04", "01", "02", "01",
      "01", "01", "01", "01", "01", "01", "04", "01", "02", "01"
    ),
    ident_desc = c(
      "Other (non-Medicare)", "Other (non-Medicare)", "Other (non-Medicare)",
      "Other (non-Medicare)", "Other (non-Medicare)", "Other (non-Medicare)",
      "MEDICARE ID-Type Unspecified", "Other (non-Medicare)", "MEDICARE UPIN",
      "Other (non-Medicare)", "Other (non-Medicare)", "Other (non-Medicare)",
      "Other (non-Medicare)", "Other (non-Medicare)", "Other (non-Medicare)",
      "Other (non-Medicare)", "MEDICARE ID-Type Unspecified", "Other (non-Medicare)",
      "MEDICARE UPIN", "Other (non-Medicare)"
    ),
    ident_issuer = c(
      "Aetna HMO", "DOL/OWCP", "United Healthcare", "MDIPA/Alliance/MLH/OC",
      "Cigna", "Aetna PPO", "MCR Provider#", "MCR Railroad retiremnt",
      NA, "BC/BS Non Provider#", "Aetna HMO", "DOL/OWCP", "United Healthcare",
      "MDIPA/Alliance/MLH/OC", "Cigna", "Aetna PPO", "MCR Provider#",
      "MCR Railroad retiremnt", NA, "BC/BS Non Provider#"
    ),
    identifier = c(
      "0129008", "146574500", "230033", "38311", "4074069", "4296824",
      "575182E20", "650003825", "R23823", "k366", "0129008", "146574500",
      "230033", "38311", "4074069", "4296824", "575182E20", "650003825",
      "R23823", "k366"
    ),
    ident_state = c(
      "MD", "MD", "MD", "MD", "MD", "MD", "DC", "DC", "DC", "MD",
      "MD", "MD", "MD", "MD", "MD", "MD", "DC", "DC", "DC", "MD"
    ),
  )
  expect_equal(provider_nppes(npi = 1528060837) |> provider_unpack(), unpack_ex)
})


