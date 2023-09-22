#' Clinicians Enrolled in Medicare
#'
#' @description
#'
#' `clinicians()` allows you to access information about providers enrolled in
#' Medicare, including the medical school that they attended and the year they graduated
#'
#' Links:
#'   - [National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
#'   - [Provider Data Catalog (PDC) Data Dictionary](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi < *integer* > 10-digit national provider identifier
#' @param pac_id_ind < *integer* > 10-digit individual provider associate-level
#' control identifier
#' @param enroll_id_ind < *character* > 15-digit individual provider Medicare
#' enrollment identifier; begins with capital "I"
#' @param first,middle,last < *character* > Individual provider's first,
#' middle, or last name
#' @param gender < *character* > Individual provider's gender; `"F"` (Female)
#' or `"M"` (Male)
#' @param school < *character* > Individual provider’s medical school
#' @param grad_year < *integer* > Individual provider’s graduation year
#' @param specialty < *character* > Individual provider’s primary medical
#' specialty reported in the selected enrollment
#' @param facility_name < *character* > Name of facility associated with the
#' individual provider
#' @param pac_id_org < *integer* > 10-digit organizational/group provider
#' associate-level control identifier
#' @param city < *character* > Provider's city
#' @param state < *character* > Provider's state
#' @param zip < *character* > Provider's ZIP code
#' @param offset < *integer* > offset; API pagination
#' @param tidy < *boolean* > Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**       |**Description**                                       |
#' |:---------------|:-----------------------------------------------------|
#' |`npi`           |10-digit individual NPI                               |
#' |`pac_id_ind`    |10-digit individual PAC ID                            |
#' |`enroll_id_ind` |15-digit individual enrollment ID                     |
#' |`first`         |Provider's first name                                 |
#' |`middle`        |Provider's middle name                                |
#' |`last`          |Provider's last name                                  |
#' |`suffix`        |Provider's name suffix                                |
#' |`gender`        |Provider's gender                                     |
#' |`credential`    |Provider's credential                                 |
#' |`school`        |Provider's medical school                             |
#' |`grad_year`     |Provider's graduation year                            |
#' |`specialty`     |Provider's primary specialty                          |
#' |`specialty_sec` |Provider's secondary specialty                        |
#' |`facility_name` |Facility associated with provider                     |
#' |`pac_id_org`    |Facility's 10-digit PAC ID                            |
#' |`members`       |Number of providers associated with facility's PAC ID |
#' |`address`       |Provider's street address                             |
#' |`city`          |Provider's city                                       |
#' |`state`         |Provider's state                                      |
#' |`zip`           |Provider's zip code                                   |
#' |`phone`         |Provider's phone number                               |
#' |`telehealth`    |Indicates if provider offers telehealth services      |
#' |`assign_ind`    |Indicates if provider accepts Medicare assignment     |
#' |`assign_group`  |Indicates if facility accepts Medicare assignment     |
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
                       first = NULL,
                       middle = NULL,
                       last = NULL,
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
  if (!is.null(gender))        {rlang::arg_match(gender, c("F", "M"))}

  args <- dplyr::tribble(
    ~param,               ~arg,
    "NPI",                npi,
    "Ind_PAC_ID",         pac_id_ind,
    "Ind_enrl_ID",        enroll_id_ind,
    "frst_nm",            first,
    "mid_nm",             middle,
    "lst_nm",             last,
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
                "[SELECT * FROM ", clinic_id(), "]",
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
      "first",         first,
      "middle",        middle,
      "last",          last,
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
    results <- tidyup(results) |>
      tidyr::unite("address", adr_ln_1:adr_ln_2,
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      dplyr::mutate(address = stringr::str_squish(address),
                    num_org_mem = as.integer(num_org_mem),
                    grd_yr = as.integer(grd_yr),
                    telehlth = yn_logical(telehlth)) |>
      dplyr::select(
        npi,
        pac_id_ind = ind_pac_id,
        enroll_id_ind = ind_enrl_id,
        first = frst_nm,
        middle = mid_nm,
        last = lst_nm,
        suffix = suff,
        gender = gndr,
        credential = cred,
        school = med_sch,
        grad_year = grd_yr,
        specialty = pri_spec,
        specialty_sec = sec_spec_all,
        facility_name,
        pac_id_org = org_pac_id,
        members = num_org_mem,
        address,
        # address_id = adrs_id,
        city = city_town,
        state,
        zip = zip_code,
        phone = telephone_number,
        telehealth = telehlth,
        assign_ind = ind_assgn,
        assign_group = grp_assgn)
    }
  return(results)
}

#' @autoglobal
#' @noRd
clinic_id <- function() {

  response <- httr2::request(
    "https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/mj5m-pzi6?show-reference-ids=true") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE, simplifyVector = TRUE)

  return(response$distribution$identifier)
}
