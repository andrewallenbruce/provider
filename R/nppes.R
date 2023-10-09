#' National Registry of All Health Care Providers
#'
#' @description
#' `nppes()` allows you to search the National Plan and Provider Enumeration
#' System (NPPES) NPI Registry's public API, a free directory of all active
#' National Provider Identifier (NPI) records.
#'
#' **National Provider Identifier** <br>
#' Healthcare providers acquire their unique 10-digit NPIs to identify
#' themselves in a standard way throughout their industry. Once CMS supplies
#' an NPI, they publish the parts of the NPI record that have public relevance,
#' including the provider’s name, taxonomy and practice address.
#'
#' **Enumeration Type** <br>
#' Two categories of health care providers exist for NPI enumeration purposes:
#'
#' **Entity Type 1** <br>
#' Individual health care providers (including sole proprietors) may get an
#' NPI as **Entity Type 1**. As a sole proprietor, they must apply for the NPI
#' using their own SSN, not an Employer Identification Number (EIN) even if
#' they have an EIN. As a sole proprietor, they may get only one NPI, just like
#' any other individual. The following factors **do not** affect whether a sole
#' proprietor is an Entity Type 1:
#'
#'    - Number of different office locations
#'    - Whether they have employees
#'    - Whether the IRS issued them an EIN
#'
#' An **incorporated individual** is a single health care provider who forms
#' and conducts business under a corporation. A sole proprietor **is not** an
#' incorporated individual because the sole proprietor didn't form a
#' corporation. If you're a sole/solo practitioner, it doesn't necessarily mean
#' you're a sole proprietor, and vice versa. If you're an individual health care
#' provider who's incorporated, you may need to get an NPI for yourself
#' (Entity Type 1) and an NPI for your corporation or LLC (Entity Type 2).
#'
#' <br>
#'
#' **Entity Type 2** <br>
#' Organizational health care providers are group health care providers eligible
#' for NPIs as Entity Type 2. Organization health care providers may have a
#' single employee or thousands of employees. An example is an incorporated
#' individual who is an organization's only employee. Some organization health
#' care providers are made up of parts that work somewhat independently from
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
#' **Links**
#' - [NPPES NPI Registry API Documentation](https://npiregistry.cms.hhs.gov/api-page)
#' - [NPPES NPI Registry API Demo](https://npiregistry.cms.hhs.gov/demo-api)
#'
#' **Trailing Wildcard Entries**
#' Arguments that allow trailing wildcard entries are denoted in the parameter
#' description with _Trailing Wildcard Allowed_. Wildcard entries require at
#' least two characters to be entered, e.g. `"jo*"`
#'
#' *Update Frequency:* **Weekly**
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param entype Entity/enumeration type
#' . _Cannot be the only criteria entered._
#'   * `"I"`: Individual provider (NPI-1)
#'   * `"O"`: Organizational provider (NPI-2)
#' @param first,last Individual provider's first/last name.
#' _Trailing Wildcard Allowed_
#' @param alias `"TRUE"`/`"FALSE"`. Applies to authorized officials and individual providers when
#' not doing a wildcard search. When set to `"TRUE"`, the results will include
#' providers with similar first names.
#' @param name_type Type of name the `first`/`last` arguments pertain to:
#'   * `"AO"`: search Authorized Officials only
#'   * `"Provider"`: search Individual Providers only _(default)_
#' @param organization Healthcare organization's name. Many types of names (LBN,
#' DBA, Former LBN, Other Name) may match. As such, the results might contain a
#'  name different from the one entered. _Trailing Wildcard Allowed_
#' @param taxonomy_desc Provider's taxonomy description, e.g. `"Pharmacist"`,
#' `"Pediatrics"`
#' @param address_type Address type of provider; options are:
#'    * `"location"` (Practice location)
#'    * `"mailing"`
#'    * `"primary"`
#'    * `"secondary"`
#' @param city City associated with the provider's address. To search for a
#'    military address, enter either `"APO"` or `"FPO"`.
#' @param state State abbreviation associated with the provider's address. If
#' this field is used, at least one other field, besides the `entype` and
#' `country`, must be populated.
#' @param zip Zip code associated with the provider's address. If a 5 digit zip
#' is entered, it will be matched to any appropriate 9 digit (zip+4) codes in
#' the data. _Trailing Wildcard Allowed_
#' @param country Country abbreviation associated with the provider's
#' address. **Can** be used as the only input criterion, as long as the value
#' selected *is not* `"US"` (United States).
#' @param limit Maximum number of results to return; default is `1200`.
#' @param skip Number of results to skip after those set in `limit`.
#' @param unnest Unnest output; default is `TRUE`.
#' @param tidy Tidy output; default is `TRUE`.
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' nppes(npi = 1528060837, tidy = FALSE)
#' @autoglobal
#' @export
nppes <- function(npi = NULL,
                  entype = NULL,
                  first = NULL,
                  last = NULL,
                  alias = TRUE,
                  organization = NULL,
                  name_type = NULL,
                  taxonomy_desc  = NULL,
                  address_type = NULL,
                  city = NULL,
                  state = NULL,
                  zip = NULL,
                  country = NULL,
                  limit = 1200,
                  skip = NULL,
                  unnest = TRUE,
                  tidy = TRUE,
                  na.rm = TRUE) {

  if (!is.null(npi))       {npi <- npi_check(npi)}
  if (!is.null(name_type)) {rlang::arg_match(name_type, c("AO", "Provider"))}
  if (!is.null(zip))       {zip <- as.character(zip)}
  if (!is.null(alias) && isTRUE(alias))  {alias <- "True"}
  if (!is.null(alias) && isFALSE(alias)) {alias <- "False"}

  if (!is.null(address_type)) {
    rlang::arg_match(address_type,
    c("LOCATION", "MAILING", "PRIMARY", "SECONDARY"))
    address_type <- toupper(address_type)}

  if (!is.null(entype)) {
    rlang::arg_match(entype, c("I", "O"))
    entype <- entype_arg(entype)}

  request <- httr2::request("https://npiregistry.cms.hhs.gov/api/?version=2.1") |>
    httr2::req_url_query(number               = npi,
                         enumeration_type     = entype,
                         first_name           = first,
                         last_name            = last,
                         use_first_name_alias = alias,
                         name_purpose         = name_type,
                         organization_name    = organization,
                         taxonomy_description = taxonomy_desc,
                         address_purpose      = address_type,
                         city                 = city,
                         state                = state,
                         postal_code          = zip,
                         country_code         = country,
                         limit                = limit,
                         skip                 = skip) |>
    httr2::req_perform()

  response <- httr2::resp_body_json(request, simplifyVector = TRUE)
  results  <- response$results

  if (isTRUE(vctrs::vec_is_empty(results))) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "entype",        entype,
      "first",         first,
      "last",          last,
      "alias",         alias,
      "name_type",     name_type,
      "organization",  organization,
      "taxonomy_desc", taxonomy_desc,
      "address_type",  address_type,
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
      tidyr::unite("address",
                   dplyr::any_of(c("address_1", "address_2")),
                   remove = TRUE,
                   na.rm = TRUE,
                   sep = " ") |>
      nppes_cols() |>
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

      results <- tidyup(results) |>
        dplyr::mutate(dplyr::across(dplyr::contains("date"), anytime::anydate),
                      dplyr::across(dplyr::where(is.character), clean_credentials),
                      entity_type = entype_char(entity_type),
                      purpose = dplyr::if_else(purpose == "LOCATION", "PRACTICE", purpose),
                      dplyr::across(dplyr::any_of(c("sole_prop", "org_subpart")), yn_logical))

      if (na.rm) {

        results <- janitor::remove_empty(results, which = c("rows", "cols"))
      }
    }
  }
  return(results)
}




  # results[apply(results, 2, function(x) lapply(x, length) == 0)] <- NA
  #
  #
  #   key <- dplyr::join_by(npi)
  #
  #   # basic ------------------------------------------------------------------
  #   basic <- results |>
  #     dplyr::select(!c(addresses,
  #                      taxonomy,
  #                      identifiers,
  #                      endpoints,
  #                      practice_locations,
  #                      other_names))
  #
  #   # addresses --------------------------------------------------------------
  #   address <- results |>
  #     dplyr::select(npi, addresses) |>
  #     tidyr::unnest(c(addresses)) |>
  #     dplyr::mutate(address_type = NULL,
  #                   country_name = NULL) |>
  #     dplyr::rename(country = country_code,
  #                   phone = telephone_number,
  #                   zip = postal_code,
  #                   purpose = address_purpose) |>
  #     dplyr::mutate(purpose = dplyr::if_else(purpose == "LOCATION",
  #                                            "PRACTICE",
  #                                            purpose))
  #
  #
  #   # practice locations ------------------------------------------------------
  #   pracloc <- results |>
  #     dplyr::select(npi, practice_locations) |>
  #     tidyr::unnest(c(practice_locations))
  #
  #   if (ncol(pracloc) > 2) {
  #
  #     pracloc <- pracloc |>
  #       dplyr::mutate(address_type = NULL,
  #                     country_name = NULL) |>
  #       dplyr::rename(country = country_code,
  #                     phone = telephone_number,
  #                     zip = postal_code,
  #                     purpose = address_purpose,
  #                     street = address_1)
  #
  #     address <- dplyr::bind_rows(address, pracloc)
  #   }
  #
  #   final <- dplyr::left_join(basic, address, key)
  #
  #   # taxonomy ----------------------------------------------------------------
  #   taxonomy <- results |>
  #     dplyr::select(npi, taxonomy) |>
  #     tidyr::unnest(c(taxonomy))
  #
  #   if (ncol(taxonomy) > 2) {
  #
  #     taxonomy <- taxonomy |>
  #       dplyr::select(npi,
  #                     code,
  #                     desc,
  #                     group = taxonomy_group,
  #                     state,
  #                     license,
  #                     primary)
  #
  #     names(taxonomy) <- c("npi",
  #           paste0("taxonomy_", names(taxonomy)[2:length(names(taxonomy))]))
  #
  #     final <- dplyr::left_join(final, taxonomy, key)
  #   }
  #
  #   # identifiers -------------------------------------------------------------
  #   identifiers <- results |>
  #     dplyr::select(npi, identifiers) |>
  #     tidyr::unnest(c(identifiers))
  #
  #   if (ncol(identifiers) > 2) {
  #
  #     identifiers <- identifiers |>
  #       dplyr::select(npi,
  #                     id_desc = desc,
  #                     id_issuer = issuer,
  #                     id_identifier = identifier,
  #                     id_state = state)
  #
  #     final <- dplyr::left_join(final, identifiers, key)
  #   }
  #
  #   # endpoints ---------------------------------------------------------------
  #   endpoints <- results |>
  #     dplyr::select(npi, endpoints) |>
  #     tidyr::unnest(c(endpoints))
  #
  #   if (ncol(endpoints) > 2) {
  #
  #     endpoints <- endpoints |>
  #       tidyr::unite("street",
  #                    dplyr::any_of(c("address_1", "address_2")),
  #                    remove = TRUE,
  #                    na.rm = TRUE,
  #                    sep = " ")
  #
  #     names(endpoints) <- c("npi",
  #           paste0("end_", names(endpoints)[2:length(names(endpoints))]))
  #
  #     final <- dplyr::left_join(final, endpoints, key)
  #   }
  #
  #   # other names -------------------------------------------------------------
  #   other <- results |>
  #     dplyr::select(npi, other_names) |>
  #     tidyr::unnest(c(other_names))
  #
  #   if (ncol(other) > 2) {
  #
  #     names(other) <- c("npi",
  #          paste0("other_", names(other)[2:length(names(other))]))
  #
  #     final <- dplyr::left_join(final, other, key)
  #   }

#' @param x vector
#' @autoglobal
#' @noRd
entype_arg <- function(x) {

  x <- if (is.numeric(x)) as.character(x)

  dplyr::case_match(
    x,
    c("I", "i", "Ind", "ind", "1") ~ "NPI-1",
    c("O", "o", "Org", "org", "2") ~ "NPI-2",
    .default = NULL
  )
}

#' @param x vector
#' @autoglobal
#' @noRd
entype_char <- function(x) {

  dplyr::case_match(
    x,
    c("NPI-1", "I") ~ "Individual",
    c("NPI-2", "O") ~ "Organization",
    .default = x
  )
}

#' @param df data frame
#' @autoglobal
#' @noRd
nppes_cols <- function(df) {

  cols <- c('npi' = 'number',
            'entity_type' = 'enumeration_type',
            'enum_date' = 'enumeration_date',
            'cert_date' = 'certification_date',
            'last_update' = 'last_updated',
            'status',

            # 'basic',
            # 'addresses',
            'tx' = 'taxonomies',
            'id' = 'identifiers',
            'pr' = 'practiceLocations',
            'on' = 'other_names',
            'ep' = 'endpoints',

            'prefix' = 'name_prefix',
            'first' = 'first_name',
            'middle' = 'middle_name',
            'last' = 'last_name',
            'gender',
            'credential',
            'sole_prop' = 'sole_proprietor',

            'organization' = 'organization_name',
            'org_parent_name' = 'parent_organization_legal_business_name',
            'org_subpart' = 'organizational_subpart',
            'org_ao_prefix' = 'authorized_official_name_prefix',
            'org_ao_first' = 'authorized_official_first_name',
            'org_ao_middle' = 'authorized_official_middle_name',
            'org_ao_last' = 'authorized_official_last_name',
            'org_ao_suffix' = 'authorized_official_name_suffix',
            'org_ao_title' = 'authorized_official_title_or_position',
            'org_ao_phone' = 'authorized_official_telephone_number',
            'org_ao_fax' = 'authorized_official_fax_number',

            # 'country_name',
            'purpose' = 'address_purpose',
            # 'address_type',
            'address',
            'city',
            'state',
            'zip' = 'postal_code',
            'country' = 'country_code',
            'phone' = 'telephone_number',
            'fax' = 'fax_number'

            )

  df |> dplyr::select(dplyr::any_of(cols))

}
