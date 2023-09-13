#' Taxonomy to Medicare Specialty Crosswalk
#'
#' @description
#' `taxonomy_crosswalk()` allows you to search the types of providers and
#' suppliers eligible for Medicare programs by taxonomy code or Medicare
#' specialty type code.
#'
#' ## Taxonomy Codes
#' The **Healthcare Provider Taxonomy Code Set** is a hierarchical HIPAA
#' standard code set designed to categorize the type, classification, and
#' specialization of health care providers. It consists of two sections:
#'
#'    1. Individuals and Groups of Individuals
#'    1. Non-Individuals
#'
#' When applying for an NPI, a provider must report the taxonomy that most
#' closely describes their type/classification/specialization. In some
#' situations, a provider may need to report more than one taxonomy but must
#' indicate one of them as the primary. The codes selected may not be the same
#' as categorizations used by Medicare for enrollment.
#'
#' ### Links
#' - [Provider and Supplier Taxonomy Crosswalk](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)
#' - [Taxonomy Crosswalk Methodology](https://data.cms.gov/resources/medicare-provider-and-supplier-taxonomy-crosswalk-methodology)
#' - [Find Your Taxonomy Code](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/health-care-taxonomy)
#'
#' *Update Frequency:* **Weekly**
#'
#' @param taxonomy_code Provider's taxonomy code
#' @param taxonomy_description Provider's taxonomy description
#' @param medicare_code Medicare specialty code
#' @param medicare_type Medicare provider/supplier type
#' @param keyword_search Search term to use for quick full-text search.
#' @param tidy Tidy output; default is `TRUE`
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' taxonomy_crosswalk(keyword_search = "B4")
#' taxonomy_crosswalk(keyword_search = "Histocompatibility")
#' taxonomy_crosswalk(medicare_type = "Rehabilitation Agency")
#' taxonomy_crosswalk(taxonomy_code = "2086S0102X")
#' @autoglobal
#' @export
taxonomy_crosswalk <- function(taxonomy_code         = NULL,
                               taxonomy_description  = NULL,
                               medicare_code         = NULL,
                               medicare_type         = NULL,
                               keyword_search        = NULL,
                               tidy                  = TRUE) {

  if (!is.null(keyword_search)) {

    url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                  cms_update("Medicare Provider and Supplier Taxonomy Crosswalk",
                  "id")$distro[1], "/data?keyword=", keyword_search)
    } else {

      args <- dplyr::tribble(
      ~param,                                                                ~arg,
      "MEDICARE SPECIALTY CODE",                                             medicare_code,
      "MEDICARE PROVIDER%2FSUPPLIER TYPE",                                   medicare_type,
      "PROVIDER TAXONOMY CODE",                                              taxonomy_code,
      "PROVIDER TAXONOMY DESCRIPTION%3A TYPE CLASSIFICATION SPECIALIZATION", taxonomy_description)

      url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
             cms_update("Medicare Provider and Supplier Taxonomy Crosswalk",
             "id")$distro[1], "/data?", encode_param(args))
  }

  response <- httr2::request(url) |> httr2::req_perform()
  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (isTRUE(vctrs::vec_is_empty(results))) {

    cli_args <- dplyr::tribble(
      ~x,                     ~y,
      "medicare_code",        medicare_code,
      "medicare_type",        medicare_type,
      "taxonomy_code",        taxonomy_code,
      "taxonomy_description", taxonomy_description,
      "keyword_search",       keyword_search) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)

    return(invisible(NULL))

  }

  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::tibble() |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~stringr::str_squish(.))) |>
      dplyr::select(medicare_code = medicare_specialty_code,
                    medicare_type = medicare_provider_supplier_type,
                    taxonomy_code = provider_taxonomy_code,
                    taxonomy_description = provider_taxonomy_description_type_classification_specialization)
  }
  return(results)
}

#' 002  Categories
#' 029  Groupings
#' 245  Classifications
#' 474  Specializations
#' 874  Taxonomies
#' @autoglobal
#' @noRd
download_nucc <- function() {

  url <- "https://www.nucc.org"

  x <- rvest::session(url) |>
       rvest::session_follow_link("Code Sets") |>
       rvest::session_follow_link("Taxonomy") |>
       rvest::session_follow_link("CSV") |>
       rvest::html_elements("a") |>
       rvest::html_attr("href") |>
       stringr::str_subset("taxonomy") |>
       stringr::str_subset("csv")

  x <- rvest::session(paste0(url, x)) |>
       rvest::session_follow_link("Version")

  x <- x$response$url

  x <- data.table::fread(x) |>
    dplyr::tibble() |>
    janitor::clean_names() |>
    dplyr::mutate(
      dplyr::across(
        dplyr::everything(), ~dplyr::na_if(., "")),
      dplyr::across(
        dplyr::everything(), ~stringr::str_squish(.))) |>
    dplyr::select(category = section,
                  grouping,
                  classification,
                  specialization,
                  #display_name, definition,
                  taxonomy = code)
  return(x)
}
