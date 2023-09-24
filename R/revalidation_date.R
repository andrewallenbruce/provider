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
#' ### Links
#' * [Medicare Revalidation Due Date API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi National Provider Identifier (NPI)
#' @param enroll_id Enrollment ID
#' @param first First name of individual provider
#' @param last Last name of individual provider
#' @param organization Legal business name of organizational provider
#' @param state Enrollment state
#' @param enroll_code,enroll_desc Provider enrollment type code or description:
#'    * `1` = `"Part A"`
#'    * `2` = `"DME"`
#'    * `3` = `"Non-DME Part B"`
#' @param specialty Enrollment specialty
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' revalidation_date(enroll_id = "I20031110000070")
#' revalidation_date(enroll_id = "O20110620000324")
#' revalidation_date(state = "FL", enroll_code = 3, specialty = "General Practice")
#' @autoglobal
#' @export
revalidation_date <- function(npi = NULL,
                              enroll_id = NULL,
                              first = NULL,
                              last = NULL,
                              organization = NULL,
                              state = NULL,
                              enroll_code = NULL,
                              enroll_desc = NULL,
                              specialty = NULL,
                              tidy = TRUE) {

  if (!is.null(npi))         {npi <- npi_check(npi)}
  if (!is.null(enroll_id))   {enroll_check(enroll_id)}
  if (!is.null(enroll_desc)) {
    rlang::arg_match(enroll_desc, c("Part A", "DME", "Non-DME Part B"))}
  if (!is.null(enroll_code)) {
    enroll_code <- as.character(enroll_code)
    rlang::arg_match(enroll_code, as.character(1:3))}

  args <- dplyr::tribble(
                            ~param,       ~arg,
    "National Provider Identifier",        npi,
                   "Enrollment ID",        enroll_id,
                      "First Name",        first,
                       "Last Name",        last,
               "Organization Name",        organization,
           "Enrollment State Code",        state,
                 "Enrollment Type",        enroll_code,
              "Provider Type Text",        enroll_desc,
            "Enrollment Specialty",        specialty)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                cms_update("Revalidation Due Date List", "id")$distro[1],
                "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "enroll_id",     enroll_id,
      "first",         first,
      "last",          last,
      "organization",  organization,
      "state",         state,
      "enroll_code",   enroll_code,
      "enroll_desc",   enroll_desc,
      "specialty",     specialty) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(dplyr::across(dplyr::contains("eligible"), yn_logical),
                    dplyr::across(dplyr::contains("date"), ~anytime::anydate(.))) |>
      dplyr::select(npi = national_provider_identifier,
                    enroll_id = enrollment_id,
                    first = first_name,
                    last = last_name,
                    organization = organization_name,
                    enroll_state = enrollment_state_code,
                    enroll_desc = provider_type_text,
                    enroll_specialty = enrollment_specialty,
                    enroll_code = enrollment_type,
                    group_reassignments = individual_total_reassign_to,
                    ind_associations = receiving_benefits_reassignment,
                    revalidation_due_date,
                    adjusted_due_date)
    }
  return(results)
}
