#' Search the CMS Doctors and Clinicians National Downloadable File API
#'
#' @description Dataset of providers' facility affiliations
#'
#' @details The Doctors and Clinicians national downloadable file is organized
#'   such that each line is unique at the clinician/enrollment
#'   record/group/address level. Clinicians with multiple Medicare enrollment
#'   records and/or single enrollments linking to multiple practice locations
#'   are listed on multiple lines.
#'
#'   ## Links
#'   * [Doctors and Clinicians National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#' @param org_pac_id Unique individual clinician ID assigned by PECOS
#' @param org_name Individual clinician first name
#' @param offset offset; API pagination
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' mips_group_2021(org_pac_id = 4789842956)
#' @autoglobal
#' @noRd
mips_group_2021 <- function(facility_name = NULL,
                            org_pac_id = NULL,
                            offset = 0L,
                            tidy = TRUE) {

  if (!is.null(org_pac_id)) {org_pac_id <- pac_check(org_pac_id)}

  args <- dplyr::tribble(
    ~x,                   ~y,
    "facility_name",      org_name,
    "org_pac_id",         org_pac_id)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |>
    stringr::str_flatten()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query="
  id     <- paste0("[SELECT * FROM ", mips_group_2021_id(), "]")
  post   <- paste0("[LIMIT 10000 OFFSET ", offset, "]&show_db_columns")
  url    <- paste0(http, id, params_args, post) |>
    param_brackets() |>
    param_space()

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "org_pac_id", as.character(org_pac_id),
      "facility_name",     facility_name) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}",
                          wrap = TRUE)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- results |>
      dplyr::tibble() |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      dplyr::select(
        facility_name,
        org_pac_id,
        aco_id_1,
        aco_nm_1,
        aco_id_2,
        aco_nm_2,
        measure_code = measure_cd,
        measure_title,
        measure_inverse = invs_msr,
        attestation_value,
        performance_rate = prf_rate,
        patient_count,
        star_value,
        five_star_benchmark,
        collection_type,
        measure_care_compare = ccxp_ind)
  }
  return(results)
}

#' @autoglobal
#' @noRd
mips_group_2021_id <- function() {

  response <- httr2::request("https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/0ba7-2cb0?show-reference-ids=true") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE, simplifyVector = TRUE)

  response$distribution |> dplyr::pull(identifier)
}


#' @param npi Unique clinician ID assigned by NPPES
#' @param pac_id_ind Unique individual clinician ID assigned by PECOS
#' @param first_name Individual clinician first name
#' @param last_name Individual clinician last name
#' @param offset offset; API pagination
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' mips_clinician_2021(npi = 1316172182)
#' @autoglobal
#' @noRd
mips_clinician_2021 <- function(npi = NULL,
                                pac_id_ind = NULL,
                                first_name = NULL,
                                last_name = NULL,
                                offset = 0L,
                                tidy = TRUE) {

  if (!is.null(npi)) {npi <- npi_check(npi)}
  if (!is.null(pac_id_ind)) {pac_id_ind <- pac_check(pac_id_ind)}

  # args tribble ------------------------------------------------------------
  args <- dplyr::tribble(
    ~x,               ~y,
    "npi",            npi,
    "ind_pac_id",     pac_id_ind,
    "lst_name",       last_name,
    "frst_name",      first_name
    )

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |>
    stringr::str_flatten()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query="
  id     <- paste0("[SELECT * FROM ", mips_ind_2021_id(), "]")
  post   <- paste0("[LIMIT 10000 OFFSET ", offset, "]&show_db_columns")
  url    <- paste0(http, id, params_args, post) |>
    param_brackets() |>
    param_space()

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- dplyr::tribble(
      ~x,            ~y,
      "npi",         npi,
      "pac_id",      pac_id_ind,
      "last_name",   last_name,
      "first_name",  first_name) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}",
                          wrap = TRUE)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- results |>
      dplyr::tibble() |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      dplyr::select(
        npi,
        pac_id_ind = ind_pac_id,
        last_name = lst_nm,
        first_name = frst_nm,
        apm_affl_1,
        apm_affl_2,
        apm_affl_3,
        measure_code = measure_cd,
        measure_title,
        measure_inverse = invs_msr,
        attestation_value,
        performance_rate = prf_rate,
        patient_count,
        star_value,
        five_star_benchmark,
        collection_type,
        measure_care_compare = ccxp_ind)
  }
  return(results)
}

#' @autoglobal
#' @noRd
mips_ind_2021_id <- function() {

  response <- httr2::request("https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/7d6a-e7a6?show-reference-ids=true") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE, simplifyVector = TRUE)

  response$distribution |> dplyr::pull(identifier)
}
