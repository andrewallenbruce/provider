#' National Registry of Health Care Providers
#'
#' @description Search the National Plan and Provider Enumeration System (NPPES)
#'    NPI Registry, a free directory of all active NPI records.
#'
#' @section __National Provider Identifier (NPI)__: Healthcare providers acquire
#'   their unique 10-digit NPIs to identify themselves in a standard way
#'   throughout their industry. Once CMS supplies an NPI, they publish the parts
#'   of the NPI record that have public relevance, including the provider’s
#'   name, taxonomy and practice address.
#'
#' @section __Entity/Enumeration Type__: Two categories of health care providers
#'   exist for NPI enumeration purposes:
#'
#'   __Type 1__: Individual providers may get an NPI as _Entity Type 1_.
#'
#'   _Sole Proprietorship_ A sole proprietor is one who does not conduct
#'   business as a corporation and, thus, __is not__ an incorporated individual.
#'
#'   An __incorporated individual__ is an individual provider who forms and
#'   conducts business under a corporation. This provider may have a Type 1 NPI
#'   while the corporation has its own Type 2 NPI.
#'
#'   A solo practitioner is not necessarily a sole proprietor, and vice versa.
#'   The following factors do not affect whether a sole proprietor is a Type 1
#'   entity: + Multiple office locations + Having employees + Having an EIN
#'
#'   __Type 2__: Organizational providers are eligible for _Entity Type 2_ NPIs.
#'
#'   Organizational or Group providers may have a single employee or thousands
#'   of employees. An example is an __incorporated individual__ who is an
#'   organization's only employee.
#'
#'   Some organization health care providers are made up of parts that work
#'   somewhat independently from their parent organization. These parts may
#'   offer different types of health care or offer health care in separate
#'   physical locations. These parts and their physical locations aren't
#'   themselves legal entities but are part of the organization health care
#'   provider (which is a legal entity).
#'
#'   The NPI Final Rule refers to the parts and locations as sub-parts. An
#'   organization health care provider can get its sub-parts their own NPIs.
#'   If a sub-part conducts any HIPAA standard transactions on its own
#'   (separately from its parent), it must get its own NPI. Sub-part
#'   determination makes sure that entities within a covered organization are
#'   uniquely identified in HIPAA standard transactions they conduct with
#'   Medicare and other covered entities.
#'
#'   For example, a hospital offers acute care, laboratory, pharmacy, and
#'   rehabilitation services. Each of these sub-parts may need its own NPI
#'   because each sends its own standard transactions to one or more health
#'   plans. Sub-part delegation doesn't affect Entity Type 1 health care
#'   providers. As individuals, these health care providers can't choose
#'   sub-parts and are not sub-parts.
#'
#' **Authorized Official** <br>
#'   An appointed official (e.g., chief executive officer, chief financial
#'   officer, general partner, chairman of the board, or direct owner) to whom
#'   the organization has granted the legal authority to enroll it in the
#'   Medicare program, to make changes or updates to the organization's status
#'   in the Medicare program, and to commit the organization to fully abide by
#'   the statutes, regulations, and program instructions of the Medicare
#'   program.
#'
#' @references
#'    - [NPPES NPI Registry API](https://npiregistry.cms.hhs.gov/api-page)
#'
#' @param npi `<int>` National Provider Identifier
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
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' nppes(npi = 1528060837)
#' @export
nppes <- function(
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

#' Wildcards
#'
#' @description
#' Trailing Wildcard Entries
#'
#' Arguments that allow trailing wildcard entries are denoted in the parameter
#' description with `<WC>`. Wildcard entries require at least two characters to
#' be entered, e.g. `"jo*"`
#'
#' @param x `<chr>` input
#' @returns A `<wildcard>` object
#' @examples
#' wildcard("Jo")
#' @rdname nppes
#' @export
wildcard <- function(x) {
  if (length(x) > 1L) {
    cli::cli_abort("Wildcards must be length 1.")
  }
  if (nchar(x) <= 1L) {
    cli::cli_abort(c("Wildcards must be more than 2 characters."))
  }

  structure(paste0(x, "*"), class = "wildcard")
}

# results[apply(results, 2, function(x) lapply(x, length) == 0)] <- NA
# names(taxonomy) <- c("npi", paste0("taxonomy_",
# names(taxonomy)[2:length(names(taxonomy))]))
