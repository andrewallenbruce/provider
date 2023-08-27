#' Doctors and Clinicians National Downloadable File
#'
#' @description `clinicians()` . The Doctors and Clinicians national downloadable file is organized
#'   such that each line is unique at the clinician/enrollment
#'   record/group/address level. Clinicians with multiple Medicare enrollment
#'   records and/or single enrollments linking to multiple practice locations
#'   are listed on multiple lines.
#'
#'   ## Links
#'   - [National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
#'   - [Provider Data Catalog (PDC) Data Dictionary](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi Unique clinician ID assigned by NPPES
#' @param pac_id Unique individual clinician ID assigned by PECOS
#' @param enroll_id Unique ID for the clinician enrollment that is the source
#'   for the data in the observation
#' @param first_name Individual clinician first name
#' @param middle_name Individual clinician middle name
#' @param last_name Individual clinician last name
#' @param gender Individual clinician gender
#' @param school Individual clinician’s medical school
#' @param grad_year Individual clinician’s medical school graduation year
#' @param specialty Primary medical specialty reported by the individual
#'   clinician in the selected enrollment
#' @param city Group or individual's city
#' @param state Group or individual's state
#' @param zip Group or individual's ZIP code
#' @param offset offset; API pagination
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @seealso [hospitals()], [providers()], [affiliations()]
#'
#' @examplesIf interactive()
#' clinicians(enroll_id = "I20081002000549")
#' clinicians(school = "NEW YORK UNIVERSITY SCHOOL OF MEDICINE")
#' @autoglobal
#' @export
clinicians <- function(npi = NULL,
                       pac_id = NULL,
                       enroll_id = NULL,
                       first_name = NULL,
                       middle_name = NULL,
                       last_name = NULL,
                       gender = NULL,
                       school = NULL,
                       grad_year = NULL,
                       specialty = NULL,
                       city = NULL,
                       state = NULL,
                       zip = NULL,
                       offset = 0L,
                       tidy = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}
  if (!is.null(enroll_id)) {enroll_check(enroll_id)}
  if (!is.null(enroll_id)) {enroll_ind_check(enroll_id)}
  if (!is.null(pac_id)) {pac_check(pac_id)}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                   ~y,
    "NPI",                npi,
    "Ind_PAC_ID",         pac_id,
    "Ind_enrl_ID",        enroll_id,
    "frst_nm",            first_name,
    "mid_nm",             middle_name,
    "lst_nm",             last_name,
    "gndr",               gender,
    "Med_sch",            school,
    "Grd_yr",             grad_year,
    "pri_spec",           specialty,
    "cty",                city,
    "st",                 state,
    "zip",                zipcode,
    "ind_assgn",          ind_assn,
    "grp_assgn",          group_assn)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |>
    stringr::str_flatten()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query="
  id     <- paste0("[SELECT * FROM ", drs_clinics_id(), "]")
  post   <- paste0("[LIMIT 10000 OFFSET ", offset, "]&show_db_columns")
  url    <- paste0(http, id, params_args, post) |>
    param_brackets() |>
    param_space()

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- tibble::tribble(
      ~x,              ~y,
      "npi",           as.character(npi),
      "pac_id",        as.character(pac_id),
      "enroll_id",     as.character(enroll_id),
      "first_name",    first_name,
      "middle_name",   middle_name,
      "last_name",     last_name,
      "gender",        gender,
      "school",        school,
      "grad_year",     as.character(grad_year),
      "specialty",     specialty,
      "city",          city,
      "state",         state,
      "zipcode",       zipcode,
      "ind_assn",      ind_assn,
      "group_assn",    group_assn) |>
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

    # parse response ---------------------------------------------------------
    results <- tibble::tibble(httr2::resp_body_json(response,
               check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- janitor::clean_names(results) |>
      tidyr::unite("address",
                   adr_ln_1:adr_ln_2,
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    num_org_mem = as.integer(num_org_mem),
                    grd_yr = as.integer(grd_yr),
                    telehlth = yn_logical(telehlth)) |>
      dplyr::select(
        npi,
        pac_id_ind             = ind_pac_id,
        enroll_id_ind          = ind_enrl_id,
        first_name             = frst_nm,
        middle_name            = mid_nm,
        last_name              = lst_nm,
        suffix                 = suff,
        gender                 = gndr,
        credential             = cred,
        school                 = med_sch,
        grad_year              = grd_yr,
        specialty              = pri_spec,
        specialty_sec          = sec_spec_all,
        organization_name      = org_nm,
        pac_id_org,
        org_members            = num_org_mem,
        address,
        city                   = cty,
        state                  = st,
        zip,
        phone                  = phn_numbr,
        telehealth             = telehlth,
        assign_ind             = ind_assgn,
        assign_group           = grp_assgn)
    }
  return(results)
}

#' @autoglobal
#' @noRd
drs_clinics_id <- function() {

  response <- httr2::request("https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/mj5m-pzi6?show-reference-ids=true") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE, simplifyVector = TRUE)

  response$distribution |> dplyr::pull(identifier)
}
