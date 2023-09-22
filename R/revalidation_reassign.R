#' Search the Medicare Revalidation Reassignment List API
#'
#' @description Reassignments of Providers who are due for Revalidation.
#'
#' @details The Revalidation Reassignment List dataset provides information on
#'    reassignments of providers who are due for revalidation.
#'
#' ### Links
#' * [Medicare Revalidation Reassignment List API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi NPI of provider who is reassigning their benefits or is an
#'    employee
#' @param pac_id_ind PAC ID of provider reassigning their benefits or
#'    is an employee
#' @param enroll_id_ind Enrollment ID of provider reassigning their benefits or
#'    is an employee
#' @param first,last First and/or last name of provider who is reassigning their benefits
#'    or is an employee
#' @param state_ind Enrollment state of provider who is reassigning their
#'    benefits or is an employee
#' @param specialty Enrollment specialty of the provider who is
#'    reassigning their benefits or is an employee
#' @param pac_id_org PAC ID of provider who is receiving reassignment or is
#'    the employer.
#' @param enroll_id_org Enrollment ID of provider who is receiving
#'    reassignment or is the employer
#' @param state_org Enrollment state of provider who is receiving
#'    reassignment or is the employer
#' @param business_name Legal business name of provider who is receiving
#'    reassignment or is the employer
#' @param record_type Identifies whether the record is for a reassignment
#'    (`Reassignment`) or employment (`Physician Assistant`)
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' revalidation_reassign(enroll_id_ind = "I20200929003184")
#' revalidation_reassign(pac_id_ind = 9830437441)
#' revalidation_reassign(pac_id_org = 3173525888)
#' @autoglobal
#' @export
revalidation_reassign <- function(npi = NULL,
                                  pac_id_ind = NULL,
                                  enroll_id_ind = NULL,
                                  first = NULL,
                                  last = NULL,
                                  state_ind = NULL,
                                  specialty = NULL,
                                  pac_id_org = NULL,
                                  enroll_id_org = NULL,
                                  state_org = NULL,
                                  business_name = NULL,
                                  record_type = NULL,
                                  tidy = TRUE) {

  if (!is.null(npi)) {npi <- npi_check(npi)}
  if (!is.null(pac_id_ind)) {pac_id_ind <- pac_check(pac_id_ind)}
  if (!is.null(pac_id_org)) {pac_id_org <- pac_check(pac_id_org)}

  if (!is.null(enroll_id_ind)) {
    enroll_check(enroll_id_ind)
    enroll_ind_check(enroll_id_ind)}

  if (!is.null(enroll_id_org)) {
    enroll_check(enroll_id_org)
    enroll_org_check(enroll_id_org)}

  if (!is.null(record_type)) {
    rlang::arg_match(record_type, c("Physician Assistant", "Reassignment"))}

  args <- dplyr::tribble(
    ~param,                            ~arg,
    "Individual NPI",                   npi,
    "Individual PAC ID",                pac_id_ind,
    "Individual Enrollment ID",         enroll_id_ind,
    "Individual First Name",            first,
    "Individual Last Name",             last,
    "Individual State Code",            state_ind,
    "Individual Specialty Description", specialty,
    "Group PAC ID",                     pac_id_org,
    "Group Enrollment ID",              enroll_id_org,
    "Group Legal Business Name",        business_name,
    "Group State Code",                 state_org,
    "Record Type",                      record_type)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                cms_update("Revalidation Reassignment List", "id")$distro[1],
                "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                 ~y,
      "npi",              npi,
      "pac_id_ind",       pac_id_ind,
      "enroll_id_ind",    enroll_id_ind,
      "first",       first,
      "last",        last,
      "state_ind",        state_ind,
      "specialty",        specialty,
      "pac_id_org",       pac_id_org,
      "enroll_id_org",    enroll_id_org,
      "state_org",        state_org,
      "business_name",    business_name,
      "record_type",      record_type) |>
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

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(dplyr::across(dplyr::contains("date"), ~anytime::anydate(.)),
                    group_pac_id = as.character(group_pac_id),
                    individual_pac_id = as.character(individual_pac_id),
                    individual_npi = as.character(individual_npi)) |>
      dplyr::select(
        npi                   = individual_npi,
        pac_id_ind            = individual_pac_id,
        enroll_id_ind         = individual_enrollment_id,
        first                 = individual_first_name,
        last                  = individual_last_name,
        state_ind             = individual_state_code,
        enroll_specialty_ind  = individual_specialty_description,
        ind_associations      = individual_total_employer_associations,
        pac_id_org            = group_pac_id,
        enroll_id_org         = group_enrollment_id,
        business_name         = group_legal_business_name,
        state_org             = group_state_code,
        group_reassignments   = group_reassignments_and_physician_assistants,
        record_type,
        revalidation_date_ind = individual_due_date,
        revalidation_date_org = group_due_date)

    }
  return(results)
}


#' Search the Medicare Revalidation Clinic Group Practice Reassignment API
#'
#' @description Information on clinic group practice revalidation for Medicare
#'    enrollment.
#'
#' @details The Revalidation Clinic Group Practice Reassignment dataset
#'    provides information between the physician and the group practice they
#'    reassign their billing to. It also includes individual employer
#'    association counts and the revalidation dates for the individual
#'    physician as well as the clinic group practice.
#'
#' ## Links
#' * [Medicare Revalidation Clinic Group Practice Reassignment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#' @param npi NPI of provider who is reassigning their benefits or is an
#'    employee
#' @param enroll_id Enrollment ID of provider reassigning their benefits or is
#'    an employee
#' @param first_name First name of provider who is reassigning their benefits
#'    or is an employee
#' @param last_name Last name of provider who is reassigning their benefits or
#'    is an employee
#' @param state Enrollment state of provider who is reassigning their
#'    benefits or is an employee
#' @param specialty Enrollment specialty of the provider who is
#'    reassigning their benefits or is an employee
#' @param pac_id_group PAC ID of provider who is receiving reassignment or is
#'    the employer. Providers enroll at the state level, so one PAC ID may be
#'    associated with multiple Enrollment IDs.
#' @param enroll_id_group Enrollment ID of provider who is receiving
#'    reassignment or is the employer
#' @param business_name Legal business name of provider who is receiving
#'    reassignment or is the employer
#' @param state_group Enrollment state of provider who is receiving
#'    reassignment or is the employer
#' @param record_type Identifies whether the record is for a reassignment
#'    (`Reassignment`) or employment (`Physician Assistant`)
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' revalidation_group(enroll_id = "I20200929003184",
#'                    npi = 1962026229,
#'                    first_name = "Rashadda",
#'                    last_name = "Wong",
#'                    state = "CT",
#'                    specialty = "Physician Assistant")
#'
#' revalidation_group(pac_id_group = 9436483807,
#'                    enroll_id_group = "O20190619002165",
#'                    business_name = "1st Call Urgent Care",
#'                    state_group = "FL",
#'                    record_type = "Reassignment")
#' @autoglobal
#' @noRd
revalidation_group <- function(npi             = NULL,
                               enroll_id       = NULL,
                               first_name      = NULL,
                               last_name       = NULL,
                               state           = NULL,
                               specialty       = NULL,
                               pac_id_group    = NULL,
                               enroll_id_group = NULL,
                               business_name   = NULL,
                               state_group     = NULL,
                               record_type     = NULL,
                               tidy            = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}
  if (!is.null(enroll_id)) {enroll_check(enroll_id)}
  if (!is.null(enroll_id_group)) {enroll_check(enroll_id_group)}
  if (!is.null(pac_id_group)) {pac_check(pac_id_group)}

  args <- dplyr::tribble(
    ~param,                             ~arg,
    "Individual NPI",                   npi,
    "Individual Enrollment ID",         enroll_id,
    "Individual First Name",            first_name,
    "Individual Last Name",             last_name,
    "Individual State Code",            state,
    "Individual Specialty Description", specialty,
    "Group PAC ID",                     pac_id_group,
    "Group Enrollment ID",              enroll_id_group,
    "Group Legal Business Name",        business_name,
    "Group State Code",                 state_group,
    "Record Type",                      record_type)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                cms_update("Revalidation Clinic Group Practice Reassignment",
                "id")$distro[1], "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                 ~y,
      "npi",              npi,
      "enroll_id",        enroll_id,
      "first_name",       first_name,
      "last_name",        last_name,
      "state",            state,
      "specialty",        specialty,
      "pac_id_group",     pac_id_group,
      "enroll_id_group",  enroll_id_group,
      "business_name",    business_name,
      "state_group",      state_group,
      "record_type",      record_type) |>
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

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(dplyr::across(dplyr::contains("date"), ~anytime::anydate(.)),
                    group_pac_id = as.character(group_pac_id),
                    individual_npi = as.character(individual_npi)) |>
      dplyr::select(
        npi = individual_npi,
        enroll_id_ind = individual_enrollment_id,
        first_name = individual_first_name,
        last_name = individual_last_name,
        enroll_state_ind = individual_state_code,
        enroll_specialty_ind = individual_specialty_description,
        ind_associations = individual_total_employer_associations,
        pac_id_org = group_pac_id,
        enroll_id_org = group_enrollment_id,
        business_name = group_legal_business_name,
        state_org = group_state_code,
        group_reassignments = group_reassignments_and_physician_assistants,
        revalidation_date_ind = individual_due_date,
        revalidation_date_org = group_due_date,
        record_type)

  }
  return(results)
}
