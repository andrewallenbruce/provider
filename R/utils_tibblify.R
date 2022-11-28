
# nppes_npi specs ---------------------------------------------------------
spec_npi <- tibblify::tspec_df(
  npi                = tibblify::tib_chr("number"),
  enumeration_type   = tibblify::tib_chr("enumeration_type"),
  created_epoch      = tibblify::tib_chr("created_epoch"),
  last_updated_epoch = tibblify::tib_chr("last_updated_epoch"))

spec_addresses <- tibblify::tspec_df(
  address_purpose      = tibblify::tib_chr("address_purpose"),
  address_type         = tibblify::tib_chr("address_type"),
  address_1            = tibblify::tib_chr("address_1"),
  address_2            = tibblify::tib_chr("address_2", required = FALSE),
  address_city         = tibblify::tib_chr("city"),
  address_state        = tibblify::tib_chr("state"),
  postal_code          = tibblify::tib_chr("postal_code"),
  address_phone        = tibblify::tib_chr("telephone_number"),
  address_fax          = tibblify::tib_chr("fax_number", required = FALSE),
  address_country_code = tibblify::tib_chr("country_code"),
  address_country_name = tibblify::tib_chr("country_name"))

spec_basic <- tibblify::tspec_row(
  basic_prefix           = tibblify::tib_chr("name_prefix"),
  basic_first_name       = tibblify::tib_chr("first_name"),
  basic_middle_name      = tibblify::tib_chr("middle_name"),
  basic_last_name        = tibblify::tib_chr("last_name"),
  basic_suffix           = tibblify::tib_chr("name_suffix"),
  basic_credential       = tibblify::tib_chr("credential"),
  basic_sole_proprietor  = tibblify::tib_chr("sole_proprietor"),
  basic_gender           = tibblify::tib_chr("gender"),
  basic_enumeration_date = tibblify::tib_chr_date("enumeration_date"),
  basic_last_updated     = tibblify::tib_chr_date("last_updated"),
  basic_status           = tibblify::tib_chr("status"))

spec_taxonomies <- tibblify::tspec_df(
  taxonomy_code    = tibblify::tib_chr("code"),
  taxonomy_group   = tibblify::tib_chr("taxonomy_group"),
  taxonomy_desc    = tibblify::tib_chr("desc"),
  taxonomy_state   = tibblify::tib_chr("state"),
  taxonomy_license = tibblify::tib_chr("license"),
  taxonomy_primary = tibblify::tib_lgl("primary"))

spec_identifiers <- tibblify::tspec_df(
  identifiers_code   = tibblify::tib_chr("code"),
  identifiers_desc   = tibblify::tib_chr("desc"),
  identifiers_issuer = tibblify::tib_chr("issuer"),
  identifiers_id     = tibblify::tib_chr("identifier"),
  identifiers_state  = tibblify::tib_chr("state"))

spec_endpoints <- tibblify::tspec_df(
  endpoint                  = tibblify::tib_chr("endpoint"),
  endpoint_type             = tibblify::tib_chr("endpointType"),
  endpoint_desc             = tibblify::tib_chr("endpointTypeDescription"),
  endpoint_affiliation      = tibblify::tib_chr("affiliation"),
  endpoint_affiliation_name = tibblify::tib_chr("affiliationName"),
  endpoint_use_desc         = tibblify::tib_chr("useDescription"),
  endpoint_content_desc     = tibblify::tib_chr("contentTypeDescription"),
  endpoint_country_code     = tibblify::tib_chr("country_code"),
  endpoint_country_name     = tibblify::tib_chr("country_name"),
  endpoint_address_type     = tibblify::tib_chr("address_type"),
  endpoint_address_1        = tibblify::tib_chr("address_1"),
  endpoint_address_2        = tibblify::tib_chr("address_2", required = FALSE),
  endpoint_city             = tibblify::tib_chr("city"),
  endpoint_state            = tibblify::tib_chr("state"),
  endpoint_postal_code      = tibblify::tib_chr("postal_code"))
