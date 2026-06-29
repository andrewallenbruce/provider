#' @param entity `<chr>` Entity type; `1` (Individual) or `2` (Organization)
#' @param specialty `<chr>` Provider's specialty
#' @param ind_type `<chr>` Type of individual `first`/`last` refers to:
#'    `AO` (Authorized Official) or `Provider` (Individual Provider).
#' @param first,last `<chr>` __WC__ Individual provider's name
#' @param use_alias `<lgl>` Use first name alias
#' @param org_name `<chr>` __WC__ Organization's name
#' @param add_type `<enum>` Address type
#' @param city `<chr>` City; For military addresses, search `"APO"`/`"FPO"`.
#' @param state `<chr>` State abbreviation. If the only input, one other
#'    parameter besides `entity` or `country` is required.
#' @param zip `<chr>` __WC__ 5-9 digit zip code, no hyphen.
#' @param country `<chr>` Country abbreviation. Can be the only input if
#'    it *is not* `"US"`.
#' @export
#' @rdname nppes
nppes2 <- function(
  npi = NULL,
  entity = NULL,
  specialty = NULL,
  ind_type = NULL,
  first = NULL,
  use_alias = NULL,
  last = NULL,
  org_name = NULL,
  add_type = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  country = NULL
) {
  req <- httr2::request("https://npiregistry.cms.hhs.gov/api/?") |>
    httr2::req_url_query(
      version = "2.1",
      number = npi,
      enumeration_type = entity, # c("NPI-1", "NPI-2")
      taxonomy_description = specialty,
      name_purpose = ind_type, # c("AO", "Provider")
      first_name = first, # wildcard
      use_first_name_alias = use_alias, # c("true", "false")
      last_name = last, # wildcard
      organization_name = org_name, # wildcard
      address_purpose = add_type, # c("true", "false")
      city = city, # wildcard
      state = state,
      postal_code = zip,
      country_code = country,
      limit = 200L,
      skip = 0L, # max = 1000
      pretty = "on" #on/off
    )

  httr2::req_perform(req) |>
    parse_string(query = "results") |>
    data_frame()
}
