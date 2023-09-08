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
#' @param first_name First name of individual provider
#' @param last_name Last name of individual provider
#' @param org_name Legal business name of organizational provider
#' @param state Enrollment state
#' @param enroll_type Provider enrollment type code (`1` if _Part A_;
#'    `2` if _DME_; `3` if _Non-DME Part B_)
#' @param enroll_desc Provider type description
#' @param specialty Enrollment specialty
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' revalidation_date(enroll_id = "I20031110000070")
#' revalidation_date(enroll_id = "O20110620000324")
#' revalidation_date(state = "FL", enroll_type = 3, specialty = "General Practice")
#' @autoglobal
#' @export
revalidation_date <- function(npi              = NULL,
                              enroll_id        = NULL,
                              first_name       = NULL,
                              last_name        = NULL,
                              org_name         = NULL,
                              state            = NULL,
                              enroll_type      = NULL,
                              enroll_desc      = NULL,
                              specialty        = NULL,
                              tidy             = TRUE) {

  if (!is.null(npi))         {npi <- npi_check(npi)}
  if (!is.null(enroll_id))   {enroll_check(enroll_id)}
  if (!is.null(enroll_desc)) {
    rlang::arg_match(enroll_desc, c("Part A", "DME", "Non-DME Part B"))}
  if (!is.null(enroll_type)) {
    enroll_type <- as.character(enroll_type)
    rlang::arg_match(enroll_type, as.character(1:3))}

  args <- dplyr::tribble(
                            ~param,              ~arg,
    "National Provider Identifier",               npi,
                   "Enrollment ID",         enroll_id,
                      "First Name",        first_name,
                       "Last Name",         last_name,
               "Organization Name",          org_name,
           "Enrollment State Code",             state,
                 "Enrollment Type",       enroll_type,
              "Provider Type Text",       enroll_desc,
            "Enrollment Specialty",         specialty)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                cms_update("Revalidation Due Date List", "id")$distro[1],
                "/data.json?", encode_param(args))

  response <- httr2::request(url) |> httr2::req_perform()

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "enroll_id",     enroll_id,
      "first_name",    first_name,
      "last_name",     last_name,
      "org_name",      org_name,
      "state",         state,
      "enroll_type",   enroll_type,
      "enroll_desc",   enroll_desc,
      "specialty",     specialty) |>
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
    results <- janitor::clean_names(results) |>
      dplyr::tibble() |>
      dplyr::mutate(dplyr::across(dplyr::contains("eligible"), yn_logical),
                    dplyr::across(dplyr::contains("date"), ~anytime::anydate(.)),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      dplyr::select(npi = national_provider_identifier,
                    enroll_id = enrollment_id,
                    first_name,
                    last_name,
                    organization_name,
                    enroll_state = enrollment_state_code,
                    enroll_desc = provider_type_text,
                    enroll_specialty = enrollment_specialty,
                    enroll_type = enrollment_type,
                    group_reassignments = individual_total_reassign_to,
                    ind_associations = receiving_benefits_reassignment,
                    revalidation_due_date,
                    adjusted_due_date)
    }
  return(results)
}
