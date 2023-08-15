#' Search the Medicare Revalidation Reassignment List API
#'
#' @description Reassignments of Providers who are due for Revalidation.
#'
#' @details The Revalidation Reassignment List dataset provides information on
#'    reassignments of providers who are due for revalidation.
#'
#' ## Links
#' * [Medicare Revalidation Reassignment List API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#' @param npi NPI of provider who is reassigning their benefits or is an
#'    employee
#' @param enroll_id Enrollment ID of provider reassigning their benefits or is an employee
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
#' revalidation_reassign(enroll_id = "I20200929003184",
#'                    npi = 1962026229,
#'                    first_name = "Rashadda",
#'                    last_name = "Wong",
#'                    state = "CT",
#'                    specialty = "Physician Assistant")
#'
#' revalidation_reassign(pac_id_group = 9436483807,
#'                    enroll_id_group = "O20190619002165",
#'                    business_name = "1st Call Urgent Care",
#'                    state_group = "FL",
#'                    record_type = "Reassignment")
#' @autoglobal
#' @export
revalidation_reassign <- function(npi             = NULL,
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

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                                 ~y,
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

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # update distribution id -------------------------------------------------
  id <- cms_update("Revalidation Reassignment List", "id") |>
    dplyr::slice_head() |>
    dplyr::pull(distro)

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ------------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- tibble::tribble(
      ~x,                 ~y,
      "npi",              as.character(npi),
      "enroll_id",        as.character(enroll_id),
      "first_name",       first_name,
      "last_name",        last_name,
      "state",            state,
      "specialty",        specialty,
      "pac_id_group",     as.character(pac_id_group),
      "enroll_id_group",  as.character(enroll_id_group),
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

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
             check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {

    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "N/A")),
                    dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                    dplyr::across(dplyr::contains("date"), ~lubridate::ymd(.)),
                    group_pac_id = as.character(group_pac_id),
                    individual_pac_id = as.character(individual_pac_id),
                    individual_npi = as.character(individual_npi)) |>
      dplyr::select(
        npi = individual_npi,
        pac_id = individual_pac_id,
        enroll_id = individual_enrollment_id,
        first_name = individual_first_name,
        last_name = individual_last_name,
        enroll_state = individual_state_code,
        enroll_specialty = individual_specialty_description,
        revalidation_due_date = individual_due_date,
        ind_associations = individual_total_employer_associations,
        group_pac_id,
        group_enroll_id = group_enrollment_id,
        group_legal_business_name,
        group_state = group_state_code,
        group_due_date,
        group_reassignments = group_reassignments_and_physician_assistants,
        record_type)

    }
  return(results)
}
