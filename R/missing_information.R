#' Search the CMS Public Reporting of Missing Digital Contact Information API
#'
#' @description Information on providers missing digital contact information
#'    in NPPES.
#'
#' @details In the May 2020 CMS Interoperability and Patient Access final rule,
#'    CMS finalized the policy to publicly report the names and NPIs of those
#'    providers who do not have digital contact information included in the
#'    NPPES system (85 FR 25584). This data includes the NPI and provider
#'    name of providers and clinicians without digital contact
#'    information in NPPES.
#'
#' ## Links
#' * [CMS Public Reporting of Missing Digital Contact Information API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Quarterly**
#'
#' @param npi The provider’s National Provider Identifier
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' missing_information(npi = 1134122013)
#' @autoglobal
#' @export

missing_information <- function(npi         = NULL,
                                clean_names = TRUE,
                                lowercase   = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(~x,             ~y,
                          "NPI",          npi)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "63a83bb1-4c02-43b3-8ef4-e3d3c6cf62fa"
  post   <- "/data?"
  #post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ------------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  res <- tibble::tibble(httr2::resp_body_json(resp,
         check_type = FALSE, simplifyVector = TRUE))

  if (isTRUE(is_empty_list2(res))) {
    results <- tibble::tribble(
      ~npi, ~last_name, ~first_name,
       npi,  "NA",      "NA")
    } else {
      # separate provider_name into last & first cols -----------------------
      results <- tidyr::separate(res, col = " Provider Name",
                 into = c("last_name", "first_name"), sep = ",")
      }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
