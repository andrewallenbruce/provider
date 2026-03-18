#' 2021 Quality Payment Performance
#'
#' @description
#'
#' Performance information for Merit-Based Incentive Payment System (MIPS)
#' submitted by groups.
#'
#' @param npi < *integer* > __Individual__ 10-digit National Provider Identifier
#' assigned to the clinician when they enrolled in Medicare. Multiple rows for
#' the same NPI indicate multiple TIN/NPI combinations.
#' @param pac_ind < *integer* > __Individual__ 10-digit PECOS Associate Control ID
#' @param pac_org < *integer* > __Organizational__ 10-digit PECOS Associate Control ID
#' @param facility < *character* > __Organizational__ Facility name
#' @param first,last < *character* > __Individual__ Provider's name
#' @param offset offset; API pagination
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#' @param ... Empty
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' mips_2021(pac_org = 4789842956)
#'
#' mips_2021(npi = 1316172182)
#' @autoglobal
#' @noRd
# nocov start
mips_2021 <- function(npi      = NULL,
                      pac_ind  = NULL,
                      pac_org  = NULL,
                      facility = NULL,
                      first    = NULL,
                      last     = NULL,
                      offset   = 0L,
                      tidy     = TRUE,
                      na.rm    = TRUE,
                      ...) {

  if (all(is.null(c(npi, pac_ind, pac_org, first, last, facility)))) {
    cli::cli_abort("A non-NULL argument is required")
  }

  npi <- npi %nn% validate_npi(npi)
  pac_ind <- pac_ind %nn% check_pac(pac_ind)
  pac_org <- pac_org %nn% check_pac(pac_org)

  if (any(!is.null(c(npi, pac_ind, first, last)))) {
    facility <- NULL; pac_org <- NULL
    id <- mips_2021_id("ind")
  }

  if (any(!is.null(c(facility, pac_org)))) {
    npi        <- NULL; pac_id_ind <- NULL
    first_name <- NULL; last_name  <- NULL
    id <- mips_2021_id("group")
  }

  # args <- dplyr::tribble(
  #   ~param,            ~arg,
  #   "npi",             npi,
  #   "ind_pac_id",      pac_ind,
  #   "org_pac_id",      pac_org,
  #   "facility_name",   facility,
  #   "frst_name",       first,
  #   "lst_name",        last)

  args <- dplyr::tribble(
    ~param,               ~arg,
    "NPI",                 npi,
    "Ind_PAC_ID",          pac_ind,
    "Org_PAC_ID",          pac_org,
    "facility_name",       facility,
    "Provider First Name", first,
    "Provider Last Name",  last)

  url <- paste0("https://data.cms.gov/provider-data/api/1/datastore/sql?query=",
                "[SELECT * FROM ", id, "]",
                encode_param(args, type = "sql"),
                "[LIMIT 10000 OFFSET ", offset, "]")

  error_body <- function(resp) httr2::resp_body_json(resp)$message

  response <- httr2::request(encode_url(url)) |>
    httr2::req_error(body = error_body) |>
    httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,         ~y,
      "npi",      npi,
      "facility", facility,
      "pac_org",  pac_org,
      "pac_ind",  pac_ind,
      "last",     last,
      "first",    first) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results,
                      yn = c('invs_msr',
                             'attestation_value',
                             'ccxp_ind'),
                      int = c('prf_rate',
                              'patient_count',
                              'star_value',
                              'five_star_benchmark'))

    if (any(!is.null(c(facility, pac_org)))) {
      results <- dplyr::select(results,
                               pac_org              = org_pac_id,
                               facility             = facility_name,
                               aco_id_1,
                               aco_name_1           = aco_nm_1,
                               aco_id_2,
                               aco_name_2           = aco_nm_2,
                               measure_code         = measure_cd,
                               measure_title,
                               measure_inverse      = invs_msr,
                               attestation_value,
                               performance_rate     = prf_rate,
                               patient_count,
                               stars                = star_value,
                               five_star_benchmark,
                               collection_type,
                               measure_care_compare = ccxp_ind,
                               dplyr::everything())
    }

    if (any(!is.null(c(npi, pac_ind, first, last)))) {
      results <- dplyr::select(results,
                               npi,
                               pac_ind              = ind_pac_id,
                               first                = provider_first_name,
                               last                 = provider_last_name,
                               apm_1                = apm_affl_1,
                               apm_2                = apm_affl_2,
                               apm_3                = apm_affl_3,
                               measure_code         = measure_cd,
                               measure_title,
                               measure_inverse      = invs_msr,
                               attestation_value,
                               performance_rate     = prf_rate,
                               patient_count,
                               stars                = star_value,
                               five_star_benchmark,
                               collection_type,
                               measure_care_compare = ccxp_ind,
                               dplyr::everything())
    }
   if (na.rm) results <- narm(results)
  }
  return(results)
}


#' @autoglobal
#' @noRd
mips_2021_id <- function(type = c("ind", "group")) {

  if (type == "ind")   {uuid <- "7d6a-e7a6"}
  if (type == "group") {uuid <- "0ba7-2cb0"}

  url <- glue::glue("https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/{uuid}?show-reference-ids=true")

  response <- httr2::request(url) |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE)

  return(response$distribution$identifier)
}
# nocov end
