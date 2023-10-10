#' Search the Medicare Revalidation Due Date List API
#'
#' @description Information on revalidation due dates for Medicare providers.
#'    Medicare Providers must validate their enrollment record every three or
#'    five years. CMS sets every Provider’s Revalidation due date at the end
#'    of a month and posts the upcoming six to seven months of due dates
#'    online. A due date of ‘TBD’ means that CMS has not set the due date yet.
#'    These lists are refreshed every two months and two months’ worth of due
#'    dates are appended to the list
#'
#' @details The Revalidation Due Date List dataset contains revalidation due
#'    dates for Medicare providers who are due to revalidate in the following
#'    six months. If a provider's due date does not fall within the ensuing
#'    six months, the due date is marked 'TBD'. In addition the dataset also
#'    includes subfiles with reassignment information for a given provider
#'    as well as due date listings for clinics and group practices and
#'    their providers.
#'
#' Links:
#' * [Medicare Revalidation Due Date API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi < *integer* > 10-digit national provider identifier
#' @param enid < *character* > 15-digit provider enrollment ID
#' @param first,last < *character* > Individual provider's first/last name
#' @param organization < *character* > Organizational provider's legal business name
#' @param state < *character* > Enrollment state
#' @param enrollment_type < *integer* > Provider enrollment type:
#'    * `1`: Part A
#'    * `2`: DME
#'    * `3`: Non-DME Part B
#' @param specialty < *character* > Enrollment specialty
#' @param tidy Tidy output; default is `TRUE`
#' @param na.rm < *boolean* > Remove empty rows and columns; default is `TRUE`
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' revalidation_date(enid = "I20031110000070")
#' revalidation_date(enid = "O20110620000324")
#' revalidation_date(state = "FL", enrollment_type = 3, specialty = "General Practice")
#' @autoglobal
#' @noRd
revalidation_date <- function(npi = NULL,
                              enid = NULL,
                              first = NULL,
                              last = NULL,
                              organization = NULL,
                              state = NULL,
                              enrollment_type = NULL,
                              specialty = NULL,
                              tidy = TRUE,
                              na.rm = TRUE) {

  if (!is.null(npi))    {npi <- npi_check(npi)}
  if (!is.null(enid))   {enroll_check(enid)}

  if (!is.null(enrollment_type)) {
    enrollment_type <- as.character(enrollment_type)
    rlang::arg_match(enrollment_type, as.character(1:3))}

  args <- dplyr::tribble(
    ~param,       ~arg,
    "National Provider Identifier",        npi,
    "Enrollment ID",        enid,
    "First Name",        first,
    "Last Name",        last,
    "Organization Name",        organization,
    "Enrollment State Code",        state,
    "Enrollment Type",        enrollment_type,
    "Enrollment Specialty",        specialty)

  response <- httr2::request(build_url("rdt", args)) |>
    httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,                ~y,
      "npi",             npi,
      "enid",            enid,
      "first",           first,
      "last",            last,
      "organization",    organization,
      "state",           state,
      "enrollment_type", enrollment_type,
      "specialty",       specialty) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(dplyr::across(dplyr::contains("eligible"), yn_logical),
                    dplyr::across(dplyr::contains("date"), anytime::anydate),
                    dplyr::across(dplyr::contains("name"), toupper)) |>
      rdate_cols()

    if (na.rm) {
      results <- janitor::remove_empty(results, which = c("rows", "cols"))}
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
rdate_cols <- function(df) {

  cols <- c('npi' = 'national_provider_identifier',
            'enid' = 'enrollment_id',
            'first' = 'first_name',
            'last' = 'last_name',
            'organization' = 'organization_name',
            'state' = 'enrollment_state_code',
            'enrollment_type' = 'provider_type_text',
            # 'specialty' = 'enrollment_specialty',
            # 'due_date' = 'revalidation_due_date',
            # 'due_date_adj' = 'adjusted_due_date',
            'reassignments' = 'individual_total_reassign_to',
            'associations' = 'receiving_benefits_reassignment')

  df |> dplyr::select(dplyr::all_of(cols))

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

    format_cli(cli_args)

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

#' Search the Ambulatory Surgical Centers and Independent Free Standing
#' Emergency Departments Enrolled in Medicare As Hospital Providers
#'
#' @description Information on Medicare Enrolled Ambulatory Surgical Center
#'    (ASC) Providers and Independent Free Standing Emergency Departments
#'    (IFEDs) during the COVID-19 public health emergency.
#'
#' @details The Ambulatory Surgical Centers (ASCs) and Independent Free
#'    Standing Emergency Departments (IFEDs) Enrolled in Medicare As Hospital
#'    Providers dataset includes all Medicare enrolled Ambulatory Surgical
#'    Centers (ASC) that converted to Hospitals during the COVID-19 public
#'    health emergency. Additionally, this list includes Independent Free
#'    Standing Emergency Departments (IFEDs) that have been temporarily
#'    certified as Hospitals during the COVID-19 public health emergency.
#'
#'   ### Links
#'   * [ASCs and IFEDs Enrolled in Medicare As Hospital Providers](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' @param npi NPI of the Provider
#' @param enroll_id Unique number assigned by PECOS to the provider
#' @param enroll_state State where the provider is enrolled
#' @param enroll_type Type of enrollment - ASC to Hospital OR IFED
#' @param org_name Organizational name of the enrolled provider
#' @param address description
#' @param city City where the enrolled provider is located
#' @param state State where the provider is located
#' @param zip Zip code of the provider's location
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' asc_ifed_enrollment(city = "Atlanta")
#' @autoglobal
#' @noRd
asc_ifed_enrollment <- function(npi            = NULL,
                                enroll_id      = NULL,
                                enroll_state   = NULL,
                                enroll_type    = NULL,
                                org_name       = NULL,
                                address        = NULL,
                                city           = NULL,
                                state          = NULL,
                                zip            = NULL,
                                tidy           = TRUE) {

  if (!is.null(npi))       {npi <- npi_check(npi)}
  if (!is.null(enroll_id)) {enroll_id <- enroll_check(enroll_id)}

  args <- dplyr::tribble(
    ~param,                  ~arg,
    "NPI",                    npi,
    "ENROLLMENT_ID",          enroll_id,
    "ENROLLMENT_STATE",       enroll_state,
    "TYPE",                   enroll_type,
    "ORGANIZATION_NAME",      org_name,
    "LINE_1_ST_ADR",          address,
    "CITY",                   city,
    "STATE",                  state,
    "ZIP CODE",               zip)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                "3f37b54d-eb2d-4266-8c18-ad3ecd0bede3",
                "/data?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,               ~y,
      "npi",            as.character(npi),
      "enroll_id",      as.character(enroll_id),
      "enroll_state",   enroll_state,
      "enroll_type",    enroll_type,
      "org_name",       org_name,
      "address",        address,
      "city",           city,
      "state",          state,
      "zip",            zip) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            as.character(cli_args$y),
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
    return(invisible(NULL))

  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::tibble() |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      tidyr::unite("address",
                   line_1_st_adr:line_2_st_adr,
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      dplyr::select(npi,
                    enroll_id = enrollment_id,
                    enroll_state = enrollment_state,
                    enroll_type = type,
                    organization_name,
                    address,
                    city,
                    state,
                    zip = zip_code)

  }
  return(results)
}

#' Providers Missing Endpoints in NPPES
#'
#' @description
#' `missing_endpoints()` allows you to search for providers with missing
#' digital contact information in NPPES.
#'
#' ## NPPES Endpoints
#' Digital contact information, also known as [endpoints](https://nppes.cms.hhs.gov/webhelp/nppeshelp/HEALTH%20INFORMATION%20EXCHANGE.html),
#' provides a secure way for health care entities to send authenticated,
#' encrypted health information to trusted recipients over the internet.
#'
#' Health care organizations seeking to engage in electronic health information
#' exchange need accurate information about the electronic addresses (e.g.,
#' Direct address, FHIR server URL, query endpoint, or other digital contact
#' information) of potential exchange partners to facilitate this information exchange.
#'
#' ### Links:
#'  - [CMS Public Reporting of Missing Digital Contact Information API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)
#'  - [Endpoints Information](https://nppes.cms.hhs.gov/webhelp/nppeshelp/HEALTH%20INFORMATION%20EXCHANGE.html)
#'  - [Methodology & Policy](https://data.cms.gov/sites/default/files/2021-12/8eb2b4bf-6e5f-4e05-bcdb-39c07ad8f77a/Missing_Digital_Contact_Info_Methods%20.pdf)
#'
#' *Update Frequency:* **Quarterly**
#'
#' @param npi The provider’s National Provider Identifier
#' @param name Provider's full name, in the form "last, first"
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @seealso [nppes()]
#'
#' @examplesIf interactive()
#' # A provider that appears in the search results
#' # of the Missing Information API has no Endpoints
#' # entered into the NPPES NPI Registry and vice versa.
#'
#' ## Appears
#' missing_endpoints(name = "Clouse, John")
#'
#' ## No Endpoints in NPPES
#' nppes(npi = 1144224569,
#'       tidy = FALSE) |>
#'       dplyr::select(endpoints)
#'
#' ## Does Not Appear
#' missing_endpoints(npi = 1003000423)
#'
#' ## Has Endpoints in NPPES
#' nppes(npi = 1003000423, tidy = FALSE) |>
#' dplyr::select(endpoints) |>
#' tidyr::unnest(cols = c(endpoints)) |>
#' janitor::clean_names() |>
#' dplyr::select(dplyr::contains("endpoint"))
#' @autoglobal
#' @noRd
missing_endpoints <- function(npi  = NULL,
                              name = NULL,
                              tidy = TRUE) {

  if (!is.null(npi))  {npi <- npi_check(npi)}
  if (!is.null(name)) {name <- stringr::str_replace(name, " ", "")}

  args <- dplyr::tribble(
    ~param,          ~arg,
    "NPI",            npi,
    "Provider Name",  name)

  response <- httr2::request(build_url("end", args)) |> httr2::req_perform()

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (isTRUE(vctrs::vec_is_empty(results))) {

    cli_args <- dplyr::tribble(
      ~x,            ~y,
      "npi",         npi,
      "name",        name) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  if (tidy) {
    results <- tidyup(results) |>
      tidyr::separate_wider_delim("Provider Name", ",",
                                  names = c("last_name", "first_name")) |>
      miss_cols()
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
miss_cols <- function(df) {

  cols <- c("npi"   = "NPI",
            "first" = "first_name",
            "last"  = "last_name")

  df |> dplyr::select(dplyr::all_of(cols))

}
