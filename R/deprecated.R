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
# nocov start
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

  if (!is.null(npi))    {npi <- check_npi(npi)}
  if (!is.null(enid))   {check_enid(enid)}

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

  if (!is.null(npi)) {check_npi(npi)}
  if (!is.null(enroll_id)) {check_enid(enroll_id)}
  if (!is.null(enroll_id_group)) {check_enid(enroll_id_group)}
  if (!is.null(pac_id_group)) {check_pac(pac_id_group)}

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

  if (!is.null(npi))       {npi <- check_npi(npi)}
  if (!is.null(enroll_id)) {enroll_id <- check_enid(enroll_id)}

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

  if (!is.null(npi))  {npi <- check_npi(npi)}
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

#' @param year < *integer* > // **required** Calendar year of Medicare
#' enrollment, in `YYYY` format. Run [cc_years()] to return a vector of
#' currently available years.
#' @param level < *character* > Geographic level of aggregation
#' + `"national"`
#' + `"state"`
#' + `"county"`
#' @param sublevel < *character* > Beneficiary's state or county
#' @param fips < *character* > Beneficiary's state or county FIPS code
#' @param age < *character* > Age group level of aggregation
#' + `"All"`
#' + `"<65"`
#' + `"65+"`
#' @param demo,subdemo < *character* > Demographic level of aggregation
#' + `"All"`
#' + `"Sex"` /// `"Male"` // `"Female"`
#' + `"Race"` /// `"non-Hispanic White"` // `"non-Hispanic Black"` // `"Asian Pacific Islander"` // `"Hispanic"` // `"Native American"`
#' + `"Dual Status"` /// `"Medicare and Medicaid"` // `"Medicare Only"`
#' @param mcc < *character* > Number of chronic conditions
#' + `"0-1"`
#' + `"2-3"`
#' + `"4-5"`
#' + `"6+"`
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @autoglobal
#' @noRd
cc_multiple <- function(year,
                        level = NULL,
                        sublevel = NULL,
                        fips = NULL,
                        age = NULL,
                        demo = NULL,
                        subdemo = NULL,
                        mcc = NULL,
                        tidy = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, as.character(cc_years()))

  if (!is.null(level)) {
    rlang::arg_match(level, levels())
    level <- stringr::str_to_title(level)
  }
  if (!is.null(age)) {rlang::arg_match(age, ages())}
  if (!is.null(demo)) {rlang::arg_match(demo, demo())}
  if (!is.null(subdemo)) {rlang::arg_match(subdemo, subdemo())}
  if (!is.null(mcc)) {rlang::arg_match(mcc, mcc())}
  if (!is.null(fips)) {fips <- as.character(fips)}

  if (!is.null(sublevel) && (sublevel %in% state.abb)) {
    sublevel <- abb2full(sublevel)
  }

  args <- dplyr::tribble(
    ~param,            ~arg,
    "Bene_Geo_Lvl",     level,
    "Bene_Geo_Desc",    sublevel,
    "Bene_Geo_Cd",      fips,
    "Bene_Age_Lvl",     age,
    "Bene_Demo_Lvl",    demo,
    "Bene_Demo_Desc",   subdemo,
    "Bene_MCC",         mcc)

  id <- api_years("mcc") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "year",         year,
      "level",        level,
      "sublevel",     sublevel,
      "fips",         fips,
      "age",          age,
      "demo",         demo,
      "subdemo",      subdemo,
      "mcc",          mcc) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {results <- cols_cc(tidyup(results, int = c("year"),
                                       dbl = c("prvlnc", "_pc", "er_")))}
  return(results)
}

#' @param year < *integer* > // **required** Calendar year of Medicare
#' enrollment, in `YYYY` format. Run [cc_years()] to return a vector of
#' currently available years.
#' @param level < *character* > Geographic level of aggregation: `"national"`, `"state"`, or `"county"`
#' @param sublevel < *character* > Beneficiary's state or county
#' @param fips < *character* > Beneficiary's state or county FIPS code
#' @param age < *character* > Age level of aggregation: `"all"`, `"<65"`, or `"65+"`
#' @param demo,subdemo < *character* > Demographic level of aggregation
#' + __`"All"`__
#' + __`"Sex"`__: `"Male"`, `"Female"`
#' + __`"Race"`__: `"non-Hispanic White"`, `"non-Hispanic Black"`, `"Asian Pacific Islander"`, `"Hispanic"`, `"Native American"`
#' + __`"Dual Status"`__: `"Medicare and Medicaid"`, `"Medicare Only"`
#' @param condition < *character* > Chronic condition for which the prevalence
#' and utilization is compiled
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @autoglobal
#' @noRd
cc_specific <- function(year,
                        condition = NULL,
                        sublevel = NULL,
                        level = NULL,
                        fips = NULL,
                        age = NULL,
                        demo = NULL,
                        subdemo = NULL,
                        tidy = TRUE) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, as.character(cc_years()))

  if (!is.null(level)) {
    rlang::arg_match(level, levels())
    level <- stringr::str_to_title(level)
  }

  if (!is.null(age)) {
    rlang::arg_match(age, ages())
    if (age == "all") {age <- "All"}
  }

  if (!is.null(demo)) {
    rlang::arg_match(demo, demo())
    demo <- demo_convert(demo)
  }

  if (!is.null(subdemo)) {
    rlang::arg_match(subdemo, subdemo())
    subdemo <- subdemo_convert(subdemo)
  }

  if (!is.null(sublevel) && (sublevel %in% state.abb)) {
    sublevel <- abb2full(sublevel)
  }

  if (!is.null(fips)) {fips <- as.character(fips)}

  args <- dplyr::tribble(
    ~param,            ~arg,
    "Bene_Geo_Lvl",     level,
    "Bene_Geo_Desc",    sublevel,
    "Bene_Geo_Cd",      fips,
    "Bene_Age_Lvl",     age,
    "Bene_Demo_Lvl",    demo,
    "Bene_Demo_Desc",   subdemo,
    "Bene_Cond",        condition)

  id <- api_years("scc") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "year",         year,
      "level",        level,
      "sublevel",     sublevel,
      "fips",         fips,
      "age",          age,
      "demo",         demo,
      "subdemo",      subdemo,
      "condition",    condition) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {results <- cols_cc(tidyup(results, int = c("year"),
                                       dbl = c("prvlnc", "_pc", "er_")))}
  return(results)
}

#' Provider Utilization & Demographics Individual Functions
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' These functions allow the user access to information on services and
#' procedures provided to Original Medicare (fee-for-service) Part B
#' beneficiaries by physicians and other healthcare professionals; aggregated
#' by provider, service and geography.
#'
#' @section `by_provider()`:
#'
#' The **Provider** dataset allows the user access to data such as
#' services and procedures performed; charges submitted and payment received;
#' and beneficiary demographic and health characteristics for providers
#' treating Original Medicare (fee-for-service) Part B beneficiaries,
#' aggregated by year.
#'
#' @section `by_service()`:
#'
#' The **Provider and Service** dataset is aggregated by:
#'
#'    1. Rendering provider's NPI
#'    2. Healthcare Common Procedure Coding System (HCPCS) code
#'    3. Place of Service (Facility or Non-facility)
#'
#' There can be multiple records for a given NPI based on the number of
#' distinct HCPCS codes that were billed and where the services were
#' provided. Data have been aggregated based on the place of service
#' because separate fee schedules apply depending on whether the place
#' of service submitted on the claim is facility or non-facility.
#'
#' @section `by_geography()`:
#'
#' The **Geography and Service** dataset contains information on utilization,
#' allowed amount, Medicare payment, and submitted charges organized nationally
#' and state-wide by HCPCS code and place of service.
#'
#' @section Rural-Urban Commuting Area Codes (RUCA):
#'
#' + **Metro Area Core**
#'   + `"1"`: Primary flow within Urbanized Area (UA)
#'   + `"1.1"`: Secondary flow 30-50% to larger UA
#' + **Metro Area High Commuting**
#'   + `"2"`: Primary flow 30% or more to UA
#'   + `"2.1"`: Secondary flow 30-50% to larger UA
#' + **Metro Area Low Commuting**
#'   + `"3"`: Primary flow 10-30% to UA
#' + **Micro Area Core**
#'   + `"4"`: Primary flow within large Urban Cluster (10k - 49k)
#'   + `"4.1"`: Secondary flow 30-50% to UA
#' + **Micro High Commuting**
#'   + `"5"`: Primary flow 30% or more to large UC
#'   + `"5.1"`: Secondary flow 30-50% to UA
#' + **Micro Low Commuting**
#'   + `"6"`: Primary flow 10-30% to large UC
#' + **Small Town Core**
#'   + `"7"`: Primary flow within small UC (2.5k - 9.9k)
#'   + `"7.1"`: Secondary flow 30-50% to UA
#'   + `"7.2"`: Secondary flow 30-50% to large UC
#' + **Small Town High Commuting**
#'   + `"8"`: Primary flow 30% or more to small UC
#'   + `"8.1"`: Secondary flow 30-50% to UA
#'   + `"8.2"`: Secondary flow 30-50% to large UC
#' + **Small Town Low Commuting**
#'   + `"9"`: Primary flow 10-30% to small UC
#' + **Rural Areas**
#'   + `"10"`: Primary flow to tract outside a UA or UC
#'   + `"10.1"`: Secondary flow 30-50% to UA
#'   + `"10.2"`: Secondary flow 30-50% to large UC
#'   + `"10.3"`: Secondary flow 30-50% to small UC
#' + `"99"`: Zero population and no rural-urban identifier information
#'
#' @section Links:
#' + [Medicare Physician & Other Practitioners: by Provider API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)
#' + [Medicare Physician & Other Practitioners: by Provider and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
#' + [Medicare Physician & Other Practitioners: by Geography and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service)
#'
#' *Update Frequency:* **Annually**
#'
#' @examplesIf interactive()
#' by_provider(year = 2020, npi = 1003000423)
#'
#' by_service(year = 2019, npi = 1003000126)
#'
#' by_geography(year = 2020, hcpcs_code = "0002A")
#'
#' # Use the years helper function to retrieve results for every year:
#' pop_years() |>
#' map(\(x) by_provider(year = x, npi = 1043477615)) |>
#' list_rbind()
#'
#' @returns
#' `by_provider()` returns a [tibble][tibble::tibble-package] with the columns:
#' |**Field**        |**Description**                                                                                         |
#' |:----------------|:-------------------------------------------------------------------------------------------------------|
#' |`year`           |Year data was reported                                                                                  |
#' |`npi`            |10-digit national provider identifier                                                                   |
#' |`entity_type`    |Provider's entity/enumeration type                                                                      |
#' |`first`          |Individual provider's first name                                                                        |
#' |`middle`         |Individual provider's middle name                                                                       |
#' |`last`           |Individual provider's last name/Organization's name                                                     |
#' |`gender`         |Individual provider's gender                                                                            |
#' |`credential`     |Individual provider's credential                                                                        |
#' |`specialty`      |Provider's specialty                                                                                    |
#' |`address`        |Provider's street address                                                                               |
#' |`city`           |Provider's city                                                                                         |
#' |`state`          |Provider's state                                                                                        |
#' |`zip`            |Provider's zip code                                                                                     |
#' |`fips`           |Provider's state's FIPS code                                                                            |
#' |`ruca`           |Provider's RUCA code                                                                                    |
#' |`country`        |Provider's country                                                                                      |
#' |`par`            |Indicates if provider participates in and/or accepts Medicare assignment                                |
#' |`tot_hcpcs`      |Total number of *unique* HCPCS codes submitted                                                          |
#' |`tot_benes`      |Total Medicare beneficiaries receiving services from the provider                                       |
#' |`tot_srvcs`      |Total services provided to beneficiaries by the provider                                                |
#' |`tot_charges`    |Total charges that the provider submitted for all services                                              |
#' |`tot_allowed`    |Total allowed amount for all services; the sum of Medicare reimbursement, deductible, coinsurance, etc. |
#' |`tot_payment`    |Total amount Medicare paid, less any deductible and coinsurance                                         |
#' |`tot_std_pymt`   |Total amount Medicare paid, standardized to account for geographic differences                          |
#' |`hcc_risk_avg`   |Average Hierarchical Condition Category (HCC) risk score of beneficiaries                               |
#' |`hcpcs_detailed` |Nested list columns `drug` & `medical`, offering further detail about the HCPCS codes submitted         |
#' |`demographics`   |Nested list column containing demographic data about the beneficiaries seen by the provider             |
#' |`conditions`     |Nested list column containing data about beneficiaries' chronic conditions                              |
#'
#' `by_service()` returns a [tibble][tibble::tibble-package] with the columns:
#' |**Field**        |**Description**                                                                                  |
#' |:----------------|:------------------------------------------------------------------------------------------------|
#' |`year`           |Year data was reported                                                                           |
#' |`npi`            |10-digit national provider identifier                                                            |
#' |`level`          |Data aggregation level, will always be "Provider" here                                           |
#' |`entity_type`    |Provider's entity/enumeration type                                                               |
#' |`first`          |Individual provider's first name                                                                 |
#' |`middle`         |Individual provider's middle name                                                                |
#' |`last`           |Individual provider's last name/Organization's name                                              |
#' |`gender`         |Individual provider's gender                                                                     |
#' |`credential`     |Individual provider's credential                                                                 |
#' |`specialty`      |Provider's specialty                                                                             |
#' |`address`        |Provider's street address                                                                        |
#' |`city`           |Provider's city                                                                                  |
#' |`state`          |Provider's state                                                                                 |
#' |`zip`            |Provider's zip code                                                                              |
#' |`fips`           |Provider's state's FIPS code                                                                     |
#' |`ruca`           |Provider's RUCA code                                                                             |
#' |`country`        |Provider's country                                                                               |
#' |`par`            |Indicates if the provider participates in and/or accepts Medicare assignment                     |
#' |`hcpcs_code`     |HCPCS code used to identify the specific medical service furnished by the provider               |
#' |`hcpcs_desc`     |Consumer Friendly Description of the HCPCS code                                                  |
#' |`category`       |Restructured BETOS Classification System Category                                                |
#' |`subcategory`    |Restructured BETOS Classification System Subcategory                                             |
#' |`family`         |Restructured BETOS Classification System Family                                                  |
#' |`procedure`      |Restructured BETOS Classification System Major Procedure Indicator                               |
#' |`drug`           |Indicates if the HCPCS code is listed in the Medicare Part B Drug Average Sales Price (ASP) File |
#' |`pos`            |Identifies the Place of Service (POS) submitted on the claim                                     |
#' |`tot_benes`      |Distinct number of Medicare beneficiaries for each HCPCS code/POS combination                    |
#' |`tot_srvcs`      |Number of services provided for each HCPCS code/POS combination                                  |
#' |`tot_day`        |Number of distinct Medicare beneficiary/per day services for each HCPCS code/POS combination     |
#' |`avg_charge`     |Average charge that the provider submitted for the service                                       |
#' |`avg_allowed`    |Average of the Medicare allowed amount for the service                                           |
#' |`avg_payment`    |Average amount Medicare paid, less any deductible and coinsurance                                |
#' |`avg_std_pymt`   |Average amount Medicare paid, standardized to account for geographic differences                 |
#'
#' `by_geography()` returns a [tibble][tibble::tibble-package] with the columns:
#' |**Field**        |**Description**                                                                                  |
#' |:----------------|:------------------------------------------------------------------------------------------------|
#' |`year`           |Year data was reported                                                                           |
#' |`level`          |Data aggregation level, either "National" or "State"                                             |
#' |`state`          |Provider's state                                                                                 |
#' |`fips`           |Provider's state's FIPS code                                                                     |
#' |`hcpcs_code`     |HCPCS code used to identify the specific medical service furnished                               |
#' |`hcpcs_desc`     |Consumer Friendly Description of the HCPCS code                                                  |
#' |`category`       |Restructured BETOS Classification System Category                                                |
#' |`subcategory`    |Restructured BETOS Classification System Subcategory                                             |
#' |`family`         |Restructured BETOS Classification System Family                                                  |
#' |`procedure`      |Restructured BETOS Classification System Major Procedure Indicator                               |
#' |`drug`           |Indicates if the HCPCS code is listed in the Medicare Part B Drug Average Sales Price (ASP) File |
#' |`pos`            |Identifies the Place of Service (POS) submitted on the claim                                     |
#' |`tot_provs`      |Number of providers that submitted each HCPCS code/POS combination                               |
#' |`tot_benes`      |Distinct number of Medicare beneficiaries for each HCPCS code/POS combination                    |
#' |`tot_srvcs`      |Number of services provided for each HCPCS code/POS combination                                  |
#' |`tot_day`        |Number of distinct Medicare beneficiary/per day services for each HCPCS code/POS combination     |
#' |`avg_charge`     |Average charge submitted for the service                                                         |
#' |`avg_allowed`    |Average of the Medicare allowed amount for the service                                           |
#' |`avg_payment`    |Average amount Medicare paid, less any deductible and coinsurance                                |
#' |`avg_std_pymt`   |Average amount Medicare paid, standardized to account for geographic differences                 |
#'
#' @name by_
NULL

#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run [pop_years()] to return a vector of the years currently available.
#' @param npi < *integer* > 10-digit national provider identifier
#' @param first,last,organization < *character* > Individual/Organizational
#' provider's name
#' @param credential < *character* > Individual provider's credentials
#' @param gender < *character* > Individual provider's gender; `"F"` (Female),
#' `"M"` (Male)
#' @param entype < *character* > Provider entity type; `"I"` (Individual),
#' `"O"` (Organization)
#' @param city < *character* > City where provider is located
#' @param state < *character* > State where provider is located
#' @param fips < *character* > Provider's state's FIPS code
#' @param zip < *character* > Provider’s zip code
#' @param ruca < *character* > Provider’s RUCA code
#' @param country < *character* > Country where provider is located
#' @param specialty < *character* > Provider specialty code reported on the
#' largest number of claims submitted
#' @param par < *boolean* > Identifies whether the provider participates in
#' Medicare and/or accepts assignment of Medicare allowed amounts
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param nest < *boolean* > // __default:__ `TRUE` Nest `demographics` and `conditions`
#' @param detailed < *boolean* > // __default:__ `FALSE` Include `detailed` column
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#' @param ... description
#' @rdname by_
#' @autoglobal
#' @export
#' @keywords internal
by_provider <- function(year,
                        npi = NULL,
                        first = NULL,
                        last = NULL,
                        organization = NULL,
                        credential  = NULL,
                        gender = NULL,
                        entype = NULL,
                        city = NULL,
                        state = NULL,
                        zip = NULL,
                        fips = NULL,
                        ruca = NULL,
                        country = NULL,
                        specialty = NULL,
                        par = NULL,
                        tidy = TRUE,
                        nest = TRUE,
                        detailed = FALSE,
                        na.rm = TRUE,
                        ...) {

  rlang::check_required(year)
  year <- as.character(year)
  year <- rlang::arg_match(year, as.character(pop_years()))
  npi  <- npi %nn% validate_npi(npi)
  zip  <- zip %nn% as.character(zip)
  fips <- fips %nn% as.character(fips)
  ruca <- ruca %nn% as.character(ruca)
  par  <- par %nn% tf_2_yn(par)

  args <- dplyr::tribble(
    ~param,                           ~arg,
    "Rndrng_NPI",                     npi,
    "Rndrng_Prvdr_First_Name",        first,
    "Rndrng_Prvdr_Last_Org_Name",     last,
    "Rndrng_Prvdr_Last_Org_Name",     organization,
    "Rndrng_Prvdr_Crdntls",           credential,
    "Rndrng_Prvdr_Gndr",              gender,
    "Rndrng_Prvdr_Ent_Cd",            entype,
    "Rndrng_Prvdr_City",              city,
    "Rndrng_Prvdr_State_Abrvtn",      state,
    "Rndrng_Prvdr_State_FIPS",        fips,
    "Rndrng_Prvdr_Zip5",              zip,
    "Rndrng_Prvdr_RUCA",              ruca,
    "Rndrng_Prvdr_Cntry",             country,
    "Rndrng_Prvdr_Type",              specialty,
    "Rndrng_Prvdr_Mdcr_Prtcptg_Ind",  par)

  id <- api_years("prv") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "year",         year,
      "npi",          npi,
      "first",        first,
      "last",         last,
      "organization", organization,
      "credential",   credential,
      "gender",       gender,
      "entype",       entype,
      "city",         city,
      "state",        state,
      "fips",         fips,
      "zip",          zip,
      "ruca",         ruca,
      "country",      country,
      "specialty",    specialty,
      "par",          par) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results$year <- year
    results <- janitor::clean_names(results) |>
      cols_prov() |>
      tidyup(yn = "par",
             int = c("year", "_hcpcs", "bene", "_srvcs"),
             dbl = c("pay", "pymt", "charges", "allowed", "cc_", "hcc"),
             cred = "credential",
             ent = "entity_type",
             yr = 'year') |>
      combine(address, c('rndrng_prvdr_st1', 'rndrng_prvdr_st2')) |>
      dplyr::mutate(specialty = correct_specialty(specialty))

    if (nest) {
      results <- tidyr::nest(results,
                             demographics   = dplyr::starts_with("bene_"),
                             conditions     = dplyr::starts_with("cc_"))
    }
    if (detailed) {
      results <- tidyr::nest(results,
                             medical = dplyr::starts_with("med_"),
                             drug = dplyr::starts_with("drug_")) |>
        tidyr::nest(results,
                    detailed = c(medical, drug))
    } else {
      results <- dplyr::select(results,
                               -dplyr::starts_with("med_"),
                               -dplyr::starts_with("drug_"))
    }
    if (na.rm) results <- narm(results)
  }
  class(results) <- c("provider_by_prov", class(results))
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_prov <- function(df) {

  cols <- c("year",
            "npi"            = "rndrng_npi",
            "entity_type"    = "rndrng_prvdr_ent_cd",
            "first"          = "rndrng_prvdr_first_name",
            "middle"         = "rndrng_prvdr_mi",
            "last"           = "rndrng_prvdr_last_org_name",
            "gender"         = "rndrng_prvdr_gndr",
            "credential"     = "rndrng_prvdr_crdntls",
            "specialty"      = "rndrng_prvdr_type",
            'rndrng_prvdr_st1',
            'rndrng_prvdr_st2',
            "city"           = "rndrng_prvdr_city",
            "state"          = "rndrng_prvdr_state_abrvtn",
            "zip"            = "rndrng_prvdr_zip5",
            "fips"           = "rndrng_prvdr_state_fips",
            "ruca"           = "rndrng_prvdr_ruca",
            "country"        = "rndrng_prvdr_cntry",
            "par"            = "rndrng_prvdr_mdcr_prtcptg_ind",
            "tot_hcpcs"      = "tot_hcpcs_cds",
            "tot_benes",
            "tot_srvcs",
            "tot_charges"    = "tot_sbmtd_chrg",
            "tot_allowed"    = "tot_mdcr_alowd_amt",
            "tot_payment"    = "tot_mdcr_pymt_amt",
            "tot_std_pymt"   = "tot_mdcr_stdzd_amt",
            "drug_hcpcs"     = "drug_tot_hcpcs_cds",
            "drug_benes"     = "drug_tot_benes",
            "drug_srvcs"     = "drug_tot_srvcs",
            "drug_charges"   = "drug_sbmtd_chrg",
            "drug_allowed"   = "drug_mdcr_alowd_amt",
            "drug_payment"   = "drug_mdcr_pymt_amt",
            "drug_std_pymt"  = "drug_mdcr_stdzd_amt",
            "med_hcpcs"      = "med_tot_hcpcs_cds",
            "med_benes"      = "med_tot_benes",
            "med_srvcs"      = "med_tot_srvcs",
            "med_charges"    = "med_sbmtd_chrg",
            "med_allowed"    = "med_mdcr_alowd_amt",
            "med_payment"    = "med_mdcr_pymt_amt",
            "med_std_pymt"   = "med_mdcr_stdzd_amt",
            "bene_age_avg"   = "bene_avg_age",
            "bene_age_lt65"  = "bene_age_lt_65_cnt",
            "bene_age_65_74" = "bene_age_65_74_cnt",
            "bene_age_75_84" = "bene_age_75_84_cnt",
            "bene_age_gt84"  = "bene_age_gt_84_cnt",
            "bene_gen_female"    = "bene_feml_cnt",
            "bene_gen_male"      = "bene_male_cnt",
            "bene_race_wht"  = "bene_race_wht_cnt",
            "bene_race_blk"  = "bene_race_black_cnt",
            "bene_race_api"  = "bene_race_api_cnt",
            "bene_race_hisp" = "bene_race_hspnc_cnt",
            "bene_race_nat"  = "bene_race_nat_ind_cnt",
            "bene_race_oth"  = "bene_race_othr_cnt",
            "bene_dual"      = "bene_dual_cnt",
            "bene_ndual"     = "bene_ndual_cnt",
            "cc_af"          = "bene_cc_af_pct",
            "cc_alz"         = "bene_cc_alzhmr_pct",
            "cc_asth"        = "bene_cc_asthma_pct",
            "cc_canc"        = "bene_cc_cncr_pct",
            "cc_chf"         = "bene_cc_chf_pct",
            "cc_ckd"         = "bene_cc_ckd_pct",
            "cc_copd"        = "bene_cc_copd_pct",
            "cc_dep"         = "bene_cc_dprssn_pct",
            "cc_diab"        = "bene_cc_dbts_pct",
            "cc_hplip"       = "bene_cc_hyplpdma_pct",
            "cc_hpten"       = "bene_cc_hyprtnsn_pct",
            "cc_ihd"         = "bene_cc_ihd_pct",
            "cc_opo"         = "bene_cc_opo_pct",
            "cc_raoa"        = "bene_cc_raoa_pct",
            "cc_sz"          = "bene_cc_sz_pct",
            "cc_strk"        = "bene_cc_strok_pct",
            "hcc_risk_avg"   = "bene_avg_risk_scre")

  df |> dplyr::select(dplyr::any_of(cols))
}

#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run [pop_years()] to return a vector of the years currently available.
#' @param npi < *integer* > 10-digit national provider identifier
#' @param first,last,organization < *character* > Individual/Organizational
#' provider's name
#' @param credential < *character* > Individual provider's credentials
#' @param gender < *character* > Individual provider's gender; `"F"` (Female),
#' `"M"` (Male)
#' @param entype < *character* > Provider entity type; `"I"` (Individual),
#' `"O"` (Organization)
#' @param city < *character* > City where provider is located
#' @param state < *character* > State where provider is located
#' @param fips < *character* > Provider's state FIPS code
#' @param zip < *character* > Provider’s zip code
#' @param ruca < *character* > Provider’s RUCA code
#' @param country < *character* > Country where provider is located
#' @param specialty < *character* > Provider specialty code reported on the
#' largest number of claims submitted
#' @param par < *boolean* > Identifies whether the provider participates in
#' Medicare and/or accepts assignment of Medicare allowed amounts
#' @param hcpcs_code < *character* > HCPCS code used to identify the specific
#' medical service furnished by the provider
#' @param drug < *boolean* > Identifies whether the HCPCS code is listed in the
#' Medicare Part B Drug Average Sales Price (ASP) File
#' @param pos < *character* > Identifies whether the Place of Service (POS)
#' submitted on the claims is a:
#'    + Facility (`"F"`): Hospital, Skilled Nursing Facility, etc.
#'    + Non-facility (`"O"`): Office, Home, etc.
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param rbcs < *boolean* > // __default:__ `TRUE` Add Restructured BETOS
#' Classifications to HCPCS codes
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#' @param ... description
#' @rdname by_
#' @autoglobal
#' @export
#' @keywords internal
by_service <- function(year,
                       npi = NULL,
                       first = NULL,
                       last = NULL,
                       organization = NULL,
                       credential = NULL,
                       gender = NULL,
                       entype = NULL,
                       city = NULL,
                       state = NULL,
                       zip = NULL,
                       fips = NULL,
                       ruca = NULL,
                       country = NULL,
                       specialty = NULL,
                       par = NULL,
                       hcpcs_code = NULL,
                       drug = NULL,
                       pos = NULL,
                       tidy = TRUE,
                       rbcs = TRUE,
                       na.rm = TRUE,
                       ...) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, as.character(pop_years()))

  npi   <- npi %nn% validate_npi(npi)
  zip   <- zip %nn% as.character(zip)
  fips  <- fips %nn% as.character(fips)
  ruca  <- ruca %nn% as.character(ruca)
  par   <- par %nn% tf_2_yn(par)
  hcpcs_code <- hcpcs_code %nn% as.character(hcpcs_code)
  drug  <- drug %nn% tf_2_yn(drug)
  pos   <- pos %nn% pos_char(pos)


  args <- dplyr::tribble(
    ~param,  ~arg,
    "Rndrng_NPI",   npi,
    "Rndrng_Prvdr_First_Name",   first,
    "Rndrng_Prvdr_Last_Org_Name",   last,
    "Rndrng_Prvdr_Last_Org_Name",   organization,
    "Rndrng_Prvdr_Crdntls",   credential,
    "Rndrng_Prvdr_Gndr",   gender,
    "Rndrng_Prvdr_Ent_Cd",   entype,
    "Rndrng_Prvdr_City",   city,
    "Rndrng_Prvdr_State_Abrvtn",   state,
    "Rndrng_Prvdr_State_FIPS",   fips,
    "Rndrng_Prvdr_Zip5",   zip,
    "Rndrng_Prvdr_RUCA",   ruca,
    "Rndrng_Prvdr_Cntry",   country,
    "Rndrng_Prvdr_Type",   specialty,
    "Rndrng_Prvdr_Mdcr_Prtcptg_Ind",   par,
    "HCPCS_Cd",   hcpcs_code,
    "HCPCS_Drug_Ind",   drug,
    "Place_Of_Srvc",   pos)

  id <- api_years("srv") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "year",         year,
      "npi",          npi,
      "first",        first,
      "last",         last,
      "organization", organization,
      "credential",   credential,
      "gender",       gender,
      "entype",       entype,
      "city",         city,
      "state",        state,
      "fips",         fips,
      "zip",          zip,
      "ruca",         ruca,
      "country",      country,
      "specialty",    specialty,
      "par",          par,
      "hcpcs_code",   hcpcs_code,
      "drug",         drug,
      "pos",          pos) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results$year <- year
    results$level <- "Provider"

    results <- tidyup(results,
                      yn = "_ind",
                      int = c("year", "tot_"),
                      dbl = "avg_",
                      yr = 'year') |>
      combine(address, c('rndrng_prvdr_st1', 'rndrng_prvdr_st2')) |>
      cols_serv() |>
      dplyr::mutate(specialty = correct_specialty(specialty))

    if (rbcs)  results <- rbcs_util(results)
    if (na.rm) results <- narm(results)
  }
  class(results) <- c("provider_by_serv", class(results))
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
rbcs_util <- function(df) {

  rbcs <- df |>
    dplyr::distinct(hcpcs_code) |>
    dplyr::pull(hcpcs_code) |>
    purrr::map(\(x) betos(hcpcs_code = x)) |>
    purrr::list_rbind()

  if (vctrs::vec_is_empty(rbcs)) {

    return(df)

  } else {

    rbcs <- dplyr::select(rbcs,
                          hcpcs_code,
                          category,
                          subcategory,
                          family,
                          procedure)

    cols_util(dplyr::full_join(df, rbcs, by = dplyr::join_by(hcpcs_code)), "rbcs")
  }
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_serv <- function(df) {

  cols <- c('year',
            'npi'          = 'rndrng_npi',
            'level',
            'entity_type'  = 'rndrng_prvdr_ent_cd',
            'first'        = 'rndrng_prvdr_first_name',
            'middle'       = 'rndrng_prvdr_mi',
            'last'         = 'rndrng_prvdr_last_org_name',
            'gender'       = 'rndrng_prvdr_gndr',
            'credential'   = 'rndrng_prvdr_crdntls',
            'specialty'    = 'rndrng_prvdr_type',
            'address',
            'city'         = 'rndrng_prvdr_city',
            'state'        = 'rndrng_prvdr_state_abrvtn',
            'zip'          = 'rndrng_prvdr_zip5',
            'fips'         = 'rndrng_prvdr_state_fips',
            'ruca'         = 'rndrng_prvdr_ruca',
            # 'ruca_desc'  = 'rndrng_prvdr_ruca_desc',
            'country'      = 'rndrng_prvdr_cntry',
            'par'          = 'rndrng_prvdr_mdcr_prtcptg_ind',
            'hcpcs_code'   = 'hcpcs_cd',
            'hcpcs_desc',
            'category',
            'subcategory',
            'family',
            'procedure',
            'drug'         = 'hcpcs_drug_ind',
            'pos'          = 'place_of_srvc',
            'tot_benes',
            'tot_srvcs',
            'tot_day'      = 'tot_bene_day_srvcs',
            'avg_charge'   = 'avg_sbmtd_chrg',
            'avg_allowed'  = 'avg_mdcr_alowd_amt',
            'avg_payment'  = 'avg_mdcr_pymt_amt',
            'avg_std_pymt' = 'avg_mdcr_stdzd_amt')

  df |> dplyr::select(dplyr::any_of(cols))
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_rbcs <- function(df) {

  cols <- c('year',
            'npi',
            'level',
            'entype',
            'first',
            'middle',
            'last',
            'gender',
            'credential',
            'specialty',
            'address',
            'city',
            'state',
            'zip',
            'fips',
            'ruca',
            'country',
            'par',
            'hcpcs_code',
            'hcpcs_desc',
            'category',
            'subcategory',
            'family',
            'procedure',
            'drug',
            'pos',
            'tot_provs',
            'tot_benes',
            'tot_srvcs',
            'tot_day',
            'avg_charge',
            'avg_allowed',
            'avg_payment',
            'avg_std_pymt')

  df |> dplyr::select(dplyr::any_of(cols))
}

#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run [pop_years()] to return a vector of the years currently available.
#' @param level < *character* > Geographic level by which the data will be
#' aggregated:
#' + `"State"`: Data is aggregated for each state
#' + `National`: Data is aggregated across all states for a given HCPCS Code
#' @param state < *character* > State where provider is located
#' @param fips < *character* > Provider's state FIPS code
#' @param hcpcs_code < *character* > HCPCS code used to identify the specific
#' medical service furnished by the provider
#' @param drug < *boolean* > Identifies whether the HCPCS code is listed in the
#' Medicare Part B Drug Average Sales Price (ASP) File
#' @param pos < *character* > Identifies whether the Place of Service (POS)
#' submitted on the claims is a:
#' + Facility (`"F"`): Hospital, Skilled Nursing Facility, etc.
#' + Non-facility (`"O"`): Office, Home, etc.
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param rbcs < *boolean* > // __default:__ `TRUE` Add Restructured BETOS
#' Classifications to HCPCS codes
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#' @param ... description
#' @rdname by_
#' @autoglobal
#' @export
#' @keywords internal
by_geography <- function(year,
                         state = NULL,
                         hcpcs_code = NULL,
                         pos = NULL,
                         level = NULL,
                         fips = NULL,
                         drug = NULL,
                         tidy = TRUE,
                         rbcs = TRUE,
                         na.rm = TRUE,
                         ...) {

  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, as.character(pop_years()))

  level      <- level %nn% rlang::arg_match(level, c("National", "State"))
  fips       <- fips %nn% as.character(fips)
  hcpcs_code <- hcpcs_code %nn% as.character(hcpcs_code)
  drug       <- drug %nn% tf_2_yn(drug)

  if (!is.null(pos)) {
    pos <- pos_char(pos)
    rlang::arg_match(pos, c("F", "O"))
  }

  if (!is.null(state) && (state %in% state.abb)) state <- abb2full(state)

  args <- dplyr::tribble(
    ~param,                  ~arg,
    "Rndrng_Prvdr_Geo_Lvl",  level,
    "Rndrng_Prvdr_Geo_Desc", state,
    "Rndrng_Prvdr_Geo_Cd",   fips,
    "HCPCS_Cd",              hcpcs_code,
    "HCPCS_Drug_Ind",        drug,
    "Place_Of_Srvc",         pos)

  id <- api_years("geo") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,               ~y,
      "year",           year,
      "level",          level,
      "state",          state,
      "fips",           fips,
      "hcpcs_code",     hcpcs_code,
      "drug",           drug,
      "pos",            pos) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results$year <- year
    results <- tidyup(results,
                      yn = "_ind",
                      int = c("year", "tot_"),
                      dbl = "avg_",
                      yr = 'year') |>
      dplyr::mutate(place_of_srvc  = pos_char(place_of_srvc)) |>
      cols_geo()

    if (rbcs)  results <- rbcs_util(results)
    if (na.rm) results <- narm(results)
  }
  class(results) <- c("provider_by_geo", class(results))
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_geo <- function(df) {

  cols <- c("year",
            "level"        = "rndrng_prvdr_geo_lvl",
            "state"        = "rndrng_prvdr_geo_desc",
            "fips"         = "rndrng_prvdr_geo_cd",
            "hcpcs_code"   = "hcpcs_cd",
            "hcpcs_desc",
            "drug"         = "hcpcs_drug_ind",
            "pos"          = "place_of_srvc",
            "tot_provs"    = "tot_rndrng_prvdrs",
            "tot_benes",
            "tot_srvcs",
            "tot_day"      = "tot_bene_day_srvcs",
            "avg_charge"   = "avg_sbmtd_chrg",
            "avg_allowed"  = "avg_mdcr_alowd_amt",
            "avg_payment"  = "avg_mdcr_pymt_amt",
            "avg_std_pymt" = "avg_mdcr_stdzd_amt")

  df |> dplyr::select(dplyr::any_of(cols))
}
# nocov end
