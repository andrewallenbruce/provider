#' Clinicians Enrolled in Medicare
#'
#' @description `clinicians()` allows you to access information about providers
#' enrolled in Medicare, including the medical school that they attended ant the
#' year they graduated
#'
#' ### Links
#'   - [National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
#'   - [Provider Data Catalog (PDC) Data Dictionary](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi Unique clinician ID assigned by NPPES
#' @param pac_id_ind Unique individual clinician ID assigned by PECOS
#' @param enroll_id_ind Unique ID for the clinician enrollment that is the source
#'   for the data in the observation
#' @param first_name Individual clinician first name
#' @param middle_name Individual clinician middle name
#' @param last_name Individual clinician last name
#' @param gender Individual clinician gender
#' @param school Individual clinician’s medical school
#' @param grad_year Individual clinician’s medical school graduation year
#' @param specialty Primary medical specialty reported by the individual
#'   clinician in the selected enrollment
#' @param facility_name Name of facility associated with the clinician
#' @param pac_id_org description
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
                       pac_id_ind = NULL,
                       enroll_id_ind = NULL,
                       first_name = NULL,
                       middle_name = NULL,
                       last_name = NULL,
                       gender = NULL,
                       school = NULL,
                       grad_year = NULL,
                       specialty = NULL,
                       facility_name = NULL,
                       pac_id_org = NULL,
                       city = NULL,
                       state = NULL,
                       zip = NULL,
                       offset = 0L,
                       tidy = TRUE) {

  if (!is.null(npi))           {npi        <- npi_check(npi)}
  if (!is.null(pac_id_ind))    {pac_id_ind <- pac_check(pac_id_ind)}
  if (!is.null(pac_id_org))    {pac_id_org <- pac_check(pac_id_org)}
  if (!is.null(enroll_id_ind)) {enroll_check(enroll_id_ind)}
  if (!is.null(enroll_id_ind)) {enroll_ind_check(enroll_id_ind)}
  if (!is.null(grad_year))     {grad_year  <- as.character(grad_year)}
  if (!is.null(zip))           {zip        <- as.character(zip)}

  args <- dplyr::tribble(
    ~param,               ~arg,
    "NPI",                npi,
    "Ind_PAC_ID",         pac_id_ind,
    "Ind_enrl_ID",        enroll_id_ind,
    "frst_nm",            first_name,
    "mid_nm",             middle_name,
    "lst_nm",             last_name,
    "gndr",               gender,
    "med_sch",            school,
    "grd_yr",             grad_year,
    "pri_spec",           specialty,
    "facility_name",      facility_name,
    "org_pac_id",         pac_id_org,
    "citytown",           city,
    "state",              state,
    "zip_code",           zip)

  url <- paste0("https://data.cms.gov/provider-data/api/1/datastore/sql?query=",
                "[SELECT * FROM ", drs_clinics_id(), "]",
                encode_param(args, type = "sql"),
                "[LIMIT 10000 OFFSET ", offset, "]")

  error_body <- function(response) {httr2::resp_body_json(response)$message}

  response <- httr2::request(encode_url(url)) |>
    httr2::req_error(body = error_body) |>
    httr2::req_perform()

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (isTRUE(vctrs::vec_is_empty(results))) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "pac_id_ind",    pac_id_ind,
      "enroll_id_ind", enroll_id_ind,
      "first_name",    first_name,
      "middle_name",   middle_name,
      "last_name",     last_name,
      "gender",        gender,
      "school",        school,
      "grad_year",     grad_year,
      "specialty",     specialty,
      "facility_name", facility_name,
      "pac_id_org",    pac_id_org,
      "city",          city,
      "state",         state,
      "zip",           zip) |>
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

  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::tibble() |>
      tidyr::unite("address", adr_ln_1:adr_ln_2,
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    address = stringr::str_squish(address),
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
        facility_name,
        org_pac_id,
        org_members            = num_org_mem,
        address,
        address_id             = adrs_id,
        city                   = city_town,
        state,
        zip                    = zip_code,
        phone                  = telephone_number,
        telehealth             = telehlth,
        assign_ind             = ind_assgn,
        assign_group           = grp_assgn)
    }
  return(results)
}

#' @autoglobal
#' @noRd
drs_clinics_id <- function() {

  response <- httr2::request(
    "https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/mj5m-pzi6?show-reference-ids=true") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE, simplifyVector = TRUE)

  response$distribution |> dplyr::pull(identifier)
}
