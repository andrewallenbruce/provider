#' Provider Enrollment in Medicare
#'
#' @description `provider_enrollment()` allows you to access enrollment level
#'    data on individual and organizational providers that are actively approved
#'    to bill Medicare.
#'
#' @section Links:
#' - [Provider Enrollment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
#' - [Provider Enrollment Data Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)
#'
#' @section Update Frequency: **Quarterly**
#'
#' @param npi 10-digit National Provider Identifier
#' @param pac_id 10-digit Provider associate level variable. Links all
#'   entity-level information and may be associated with multiple enrollment IDs
#'   if the individual or organization enrolled multiple times.
#' @param enroll_id 15-digit Provider enrollment ID. Assigned to each new
#'    provider enrollment application. Links all enrollment-level information
#'    (enrollment type, state, reassignment of benefits).
#' @param specialty_code Enrollment primary specialty type code.
#' @param specialty Enrollment specialty type description.
#' @param state Enrollment state abbreviation. Since Providers enroll at the state level,
#'    a PAC ID can be associated with multiple enrollment IDs and states.
#' @param first_name Individual provider first name
#' @param middle_name Individual provider middle name
#' @param last_name Individual provider last name
#' @param organization_name Organizational provider name
#' @param gender Individual provider gender:
#'    * `F`: Female
#'    * `M`: Male
#'    * `9`: Unknown (or Organizational provider)
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return [tibble][tibble::tibble-package] containing the search results.
#'
#' @seealso [order_refer()], [opt_out()], [pending_applications()]
#'
#' @examplesIf interactive()
#' provider_enrollment(npi = 1417918293, specialty_code = "14-41")
#' provider_enrollment(first_name = "DEBRA", last_name = "FROMER")
#' provider_enrollment(specialty = "PRACTITIONER - ENDOCRINOLOGY", state = "AK", gender = "F")
#' provider_enrollment(pac_id = 2860305554, gender = "9")
#' @autoglobal
#' @export
provider_enrollment <- function(npi                = NULL,
                                pac_id             = NULL,
                                enroll_id          = NULL,
                                specialty_code     = NULL,
                                specialty          = NULL,
                                state              = NULL,
                                first_name         = NULL,
                                middle_name        = NULL,
                                last_name          = NULL,
                                organization_name  = NULL,
                                gender             = NULL,
                                tidy               = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}
  if (!is.null(enroll_id)) {enroll_check(enroll_id)}
  if (!is.null(pac_id)) {pac_check(pac_id)}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                        ~x,  ~y,
                          "NPI", npi,
           "PECOS_ASCT_CNTL_ID", pac_id,
                    "ENRLMT_ID", enroll_id,
             "PROVIDER_TYPE_CD", specialty_code,
           "PROVIDER_TYPE_DESC", specialty,
                     "STATE_CD", state,
                   "FIRST_NAME", first_name,
                     "MDL_NAME", middle_name,
                    "LAST_NAME", last_name,
                     "ORG_NAME", organization_name,
                      "GNDR_SW", gender)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # update distribution id -------------------------------------------------
  id <- cms_update("Medicare Fee-For-Service  Public Provider Enrollment",
                   "id") |>
    dplyr::slice_head() |>
    dplyr::pull(distro)

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- tibble::tribble(
      ~x,                 ~y,
      "npi",               as.character(npi),
      "pac_id",            as.character(pac_id),
      "enroll_id",         as.character(enroll_id),
      "specialty_code",    as.character(specialty_code),
      "specialty",         specialty,
      "state",             state,
      "first_name",        first_name,
      "middle_name",       middle_name,
      "last_name",         last_name,
      "organization_name", organization_name,
      "gender",            gender) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)


    return(invisible(NULL))

  }

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
                          check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      dplyr::select(npi,
                    pac_id            = pecos_asct_cntl_id,
                    enroll_id         = enrlmt_id,
                    specialty_code    = provider_type_cd,
                    specialty         = provider_type_desc,
                    state             = state_cd,
                    organization_name = org_name,
                    first_name,
                    middle_name       = mdl_name,
                    last_name,
                    gender            = gndr_sw) |>
      janitor::remove_empty(which = c("rows", "cols"))
  }
  return(results)
}
