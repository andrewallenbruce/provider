#' National Registry of Health Care Providers
#'
#' @description
#' [nppes()] allows the user to search the National Plan and Provider
#' Enumeration System (NPPES) NPI Registry, a free directory of all active NPI
#' records.
#'
#' @section __National Provider Identifier (NPI)__:
#' Healthcare providers acquire their unique 10-digit NPIs to identify
#' themselves in a standard way throughout their industry. Once CMS supplies
#' an NPI, they publish the parts of the NPI record that have public relevance,
#' including the provider’s name, taxonomy and practice address.
#'
#' @section __Entity/Enumeration Type__:
#' Two categories of health care providers exist for NPI enumeration purposes:
#'
#' __Type 1__: Individual providers may get an NPI as _Entity Type 1_.
#'
#' _Sole Proprietorship_
#' A sole proprietor is one who does not conduct business as a corporation and,
#' thus, __is not__ an incorporated individual.
#'
#' An __incorporated individual__ is an individual provider who forms and
#' conducts business under a corporation. This provider may have a Type 1 NPI
#' while the corporation has its own Type 2 NPI.
#'
#' A solo practitioner is not necessarily a sole proprietor, and vice versa. The
#' following factors do not affect whether a sole proprietor is a Type 1 entity:
#' + Multiple office locations
#' + Having employees
#' + Having an EIN
#'
#' __Type 2__: Organizational providers are eligible for _Entity Type 2_ NPIs.
#'
#' Organizational or Group providers may have a single employee or thousands of employees.
#' An example is an __incorporated individual__ who is an organization's only
#' employee.
#'
#' Some organization health care providers are made up of parts that work
#' somewhat independently from
#' their parent organization. These parts may offer different types of health
#' care or offer health care in separate physical locations. These parts and
#' their physical locations aren't themselves legal entities but are part of
#' the organization health care provider (which is a legal entity). The NPI
#' Final Rule refers to the parts and locations as sub-parts. An organization
#' health care provider can get its sub-parts their own NPIs. If a sub-part
#' conducts any HIPAA standard transactions on its own (separately from its
#' parent), it must get its own NPI. Sub-part determination makes sure that
#' entities within a covered organization are uniquely identified in HIPAA
#' standard transactions they conduct with Medicare and other covered entities.
#' For example, a hospital offers acute care, laboratory, pharmacy, and
#' rehabilitation services. Each of these sub-parts may need its own NPI because
#' each sends its own standard transactions to one or more health plans. Sub-part
#' delegation doesn't affect Entity Type 1 health care providers. As individuals,
#' these health care providers can't choose sub-parts and are not sub-parts.
#'
#' **Authorized Official** <br>
#' An appointed official (e.g., chief executive officer, chief financial officer,
#' general partner, chairman of the board, or direct owner) to whom the
#' organization has granted the legal authority to enroll it in the Medicare
#' program, to make changes or updates to the organization's status in the
#' Medicare program, and to commit the organization to fully abide by the
#' statutes, regulations, and program instructions of the Medicare program.
#'
#' @section Links:
#' - [NPPES NPI Registry API Documentation](https://npiregistry.cms.hhs.gov/api-page)
#' - [NPPES NPI Registry API Demo](https://npiregistry.cms.hhs.gov/demo-api)
#'
#' @section Trailing Wildcard Entries:
#' Arguments that allow trailing wildcard entries are denoted in the parameter
#' description with __WC__. Wildcard entries require at least two
#' characters to be entered, e.g. `"jo*"`
#'
#' @section Update Frequency: __Weekly__
#'
#' @param npi < *integer | character* > 10-digit Organizational National Provider Identifier
#' @param entype < *character* > Entity/enumeration type _Cannot be the only criteria entered._
#'   * `"I"`: Individual provider (NPI-1)
#'   * `"O"`: Organizational provider (NPI-2)
#' @param first,last < *character* > // __WC__ Individual provider's name
#' @param name_type < *character* > Type of individual the name arguments
#' refer to:
#'   * `"AO"`: search Authorized Officials only
#'   * `"Provider"`: search Individual Providers only
#' @param organization < *character* > // __WC__ Organization's name. Many
#' types of names (LBN, DBA, Former LBN, Other Name) may match. As such, the
#' results might contain a name different from the one entered.
#' @param taxonomy_desc < *character* > Provider's taxonomy description,
#' e.g. `"Pharmacist"`, `"Pediatrics"`
#' @param city < *character* > Provider's city. To search for a military
#' address, enter either `"APO"` or `"FPO"`.
#' @param state < *character* > Provider's state abbreviation. If the only
#' input, one other param besides `entype` and `country` must be input.
#' @param zip < *character* > // __WC__ Provider's zip code
#' @param country < *character* > Provider's country code. Can be used as the
#' only input, as long as the input *is not* `"US"`.
#' @param limit < *integer* > // __default:__ `1200L` Max results to return
#' @param skip < *integer* > // __default:__ `0L` Number of results to skip
#' after those returned
#' @param unnest < *boolean* > // __default:__ `TRUE` Unnest list columns
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @family api
#' @examplesIf interactive()
#' nppes(npi = 1528060837)
#'
#' nppes(city = "CARROLLTON", state = "GA", zip = 301173889, entype = "I")
#' @autoglobal
#' @export
nppes <- function(npi = NULL,
                  entype = NULL,
                  first = NULL,
                  last = NULL,
                  organization = NULL,
                  name_type = NULL,
                  taxonomy_desc  = NULL,
                  city = NULL,
                  state = NULL,
                  zip = NULL,
                  country = NULL,
                  limit = 1200L,
                  skip = 0L,
                  unnest = TRUE,
                  tidy = TRUE,
                  na.rm = TRUE) {

  npi       <- npi %nn% validate_npi(npi)
  name_type <- name_type %nn% rlang::arg_match(name_type, c("AO", "Provider"))
  zip       <- zip %nn% as.character(zip)

  if (!is.null(entype)) {
    entype <- rlang::arg_match(entype, c("I", "O"))
    entype <- dplyr::case_when(entype == "I" ~ "NPI-1", entype == "O" ~ "NPI-2")
  }

  request <- httr2::request("https://npiregistry.cms.hhs.gov/api/?version=2.1") |>
    httr2::req_url_query(number               = npi,
                         enumeration_type     = entype,
                         first_name           = first,
                         last_name            = last,
                         name_purpose         = name_type,
                         organization_name    = organization,
                         taxonomy_description = taxonomy_desc,
                         city                 = city,
                         state                = state,
                         postal_code          = zip,
                         country_code         = country,
                         limit                = limit,
                         skip                 = skip) |>
    httr2::req_perform()

  response <- httr2::resp_body_json(request, simplifyVector = TRUE)
  results  <- response$results

  if (vctrs::vec_is_empty(results)) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "entype",        entype,
      "first",         first,
      "last",          last,
      "name_type",     name_type,
      "organization",  organization,
      "taxonomy_desc", taxonomy_desc,
      "city",          city,
      "state",         state,
      "zip",           zip,
      "country",       country) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  if (unnest) {
    results <- tidyr::unnest(results, c(basic, addresses)) |>
      combine(address, c('address_1', 'address_2')) |>
      cols_nppes() |>
      dplyr::filter(purpose != "MAILING")

    results <- tidyr::unnest_longer(results, tx, keep_empty = TRUE) |>
                               tidyr::unpack(tx, names_sep = ".") |>
                        tidyr::unnest_longer(id, keep_empty = TRUE) |>
                               tidyr::unpack(id, names_sep = ".") |>
                        tidyr::unnest_longer(pr, keep_empty = TRUE) |>
                               tidyr::unpack(pr, names_sep = ".") |>
                        tidyr::unnest_longer(on, keep_empty = TRUE) |>
                               tidyr::unpack(on, names_sep = ".") |>
                        tidyr::unnest_longer(ep, keep_empty = TRUE) |>
                               tidyr::unpack(ep, names_sep = ".")
    if (tidy) {
      results <- tidyup(results,
                        yn = c("sole_prop", "org_part"),
                        cred = "credential",
                        ent = "entity_type") |>
        dplyr::mutate(purpose = dplyr::if_else(purpose == "LOCATION", "PRACTICE", purpose)) |>
        cols_nppes2()

      if (na.rm) results <- narm(results)
    }
  }
  return(results)
}

  # results[apply(results, 2, function(x) lapply(x, length) == 0)] <- NA
  # names(taxonomy) <- c("npi", paste0("taxonomy_", names(taxonomy)[2:length(names(taxonomy))]))

#' @param x vector
#' @autoglobal
#' @noRd
entype_arg <- function(x) {

  x <- if (is.integer(x)) as.character(x)

  dplyr::case_match(
    x,
    c("I", "i", "Ind", "ind", "1") ~ "NPI-1",
    c("O", "o", "Org", "org", "2") ~ "NPI-2")
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_nppes <- function(df) {

  cols <- c('npi'          = 'number',
            'entity_type'  = 'enumeration_type',
            'enum_date'    = 'enumeration_date',
            'cert_date'    = 'certification_date',
            'last_update'  = 'last_updated',
            'status',
            'tx'           = 'taxonomies',
            'id'           = 'identifiers',
            'pr'           = 'practiceLocations',
            'on'           = 'other_names',
            'ep'           = 'endpoints',
            'prefix'       = 'name_prefix',
            'first'        = 'first_name',
            'middle'       = 'middle_name',
            'last'         = 'last_name',
            'gender',
            'credential',
            'sole_prop'    = 'sole_proprietor',
            'organization' = 'organization_name',
            'org_parent'   = 'parent_organization_legal_business_name',
            'org_part'     = 'organizational_subpart',
            'ao_prefix'    = 'authorized_official_name_prefix',
            'ao_first'     = 'authorized_official_first_name',
            'ao_middle'    = 'authorized_official_middle_name',
            'ao_last'      = 'authorized_official_last_name',
            'ao_suffix'    = 'authorized_official_name_suffix',
            'ao_title'     = 'authorized_official_title_or_position',
            'ao_phone'     = 'authorized_official_telephone_number',
            'ao_fax'       = 'authorized_official_fax_number',
            'purpose'      = 'address_purpose',
            'address',
            'city',
            'state',
            'zip'          = 'postal_code',
            'country'      = 'country_code',
            'phone'        = 'telephone_number',
            'fax'          = 'fax_number')

  df |> dplyr::select(dplyr::any_of(cols))

}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_nppes2 <- function(df) {

  cols <- c('npi',
            'entity_type',
            'enum_date',
            'cert_date',
            'last_update',
            'status',
            'prefix',
            'first',
            'middle',
            'last',
            'gender',
            'credential',
            'sole_prop',
            'organization',
            'org_parent',
            'org_part',
            'purpose',
            'address',
            'city',
            'state',
            'zip',
            'country',
            'phone',
            'fax',
            'ao_prefix',
            'ao_first',
            'ao_middle',
            'ao_last',
            'ao_suffix',
            'ao_title',
            'ao_phone',
            'ao_fax',
            'tx_code',
            'tx_primary',
            'tx_group'      = 'tx_taxonomy_group',
            'tx_desc',
            'tx_license',
            'tx_state',
            'id_code',
            'id_desc',
            'id_state',
            'id_issuer',
            'id_state',
            'id_identifier',
            'pr_country'    = 'pr_country_code',
            'pr_purpose'    = 'pr_address_purpose',
            'pr_address'    = 'pr_address_1',
            'pr_city',
            'pr_state',
            'pr_zip'        = 'pr_postal_code',
            'pr_phone'      = 'pr_telephone_number',
            'pr_fax'        = 'pr_fax_number',
            'on_type',
            'on_code',
            'on_org_name'   = 'on_organization_name')

  df |> dplyr::select(dplyr::any_of(cols))
}
