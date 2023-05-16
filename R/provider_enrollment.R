#' Search the Medicare Fee-For-Service Public Provider Enrollment API
#'
#' @description Information on a point in time snapshot of enrollment
#'    level data for providers actively enrolled in Medicare.
#'
#' @details The Medicare Fee-For-Service Public Provider Enrollment dataset
#'    includes information on providers who are actively approved to bill
#'    Medicare or have completed the 855O at the time the data was pulled
#'    from the Provider Enrollment and Chain Ownership System (PECOS). The
#'    release of this provider enrollment data is not related to other
#'    provider information releases such as Physician Compare or Data
#'    Transparency.
#'
#' ## Links
#' * [Medicare Fee-For-Service Public Provider Enrollment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Quarterly**
#' @param npi An NPI is a 10-digit unique numeric identifier that all providers
#'    must obtain before enrolling in Medicare. It is assigned to health care
#'    providers upon application through the National Plan and Provider
#'    Enumeration System (NPPES).
#' @param pac_id Provider associate level variable (PAC ID) from PECOS
#'    database used to link across tables. A PAC ID is a 10-digit unique
#'    numeric identifier that is assigned to each individual or organization
#'    in PECOS. All entity-level information (e.g., tax identification numbers
#'    and organizational names) is linked through the PAC ID. A PAC ID may be
#'    associated with multiple Enrollment IDs if the individual or
#'    organization enrolled multiple times under different circumstances.
#' @param enroll_id Provider enrollment ID from PECOS database used to link
#'    across tables. An Enrollment ID is a 15-digit unique alphanumeric
#'    identifier that is assigned to each new provider enrollment application.
#'    All enrollment-level information (e.g., enrollment type, enrollment
#'    state, provider specialty and reassignment of benefits) is linked
#'    through the Enrollment ID.
#' @param specialty_code Provider enrollment application and enrollment
#'    specialty type. This field shows the provider’s primary specialty code.
#'    For practitioners and DME suppliers, please see the Secondary Specialty
#'    file for a list of secondary specialties (when applicable). Only about
#'    20% of practitioners and DME suppliers have at least one secondary
#'    specialty.
#' @param specialty_desc Provider enrollment application and enrollment
#'    specialty type description
#' @param state Provider enrollment state, abbreviated location. Providers
#'    enroll at the state level, so one PAC ID may be associated with multiple
#'    ENRLMT_IDs and multiple STATE_CD values.
#' @param first_name Individual provider first name
#' @param middle_name Individual provider middle name
#' @param last_name Individual provider last name
#' @param org_name Organizational provider name
#' @param gender Individual provider gender: `F` (female), `M` (male), `9` (unknown)
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' provider_enrollment(npi = 1417918293, specialty_code = "14-41")
#'
#' provider_enrollment(first_name = "DEBRA",
#'                     middle_name = "L",
#'                     last_name = "FROMER")
#'
#' provider_enrollment(org_name = "ELIZABETHTOWN COMMUNITY HOSPITAL",
#'                     state = "NY",
#'                     specialty_code = "00-85")
#'
#' provider_enrollment(specialty_desc = "PRACTITIONER - ENDOCRINOLOGY",
#'                     state = "AK",
#'                     gender = "F")
#'
#'
#' provider_enrollment(pac_id = 2860305554,
#'                     enroll_id = "I20031110000120",
#'                     gender = "9")
#' prven <- tibble::tribble(
#' ~fn,         ~params,
#' "provider_enrollment", list(npi = 1083879860),
#' "provider_enrollment", list(first_name = "MICHAEL",
#'                             middle_name = "K",
#'                             last_name = "GREENBERG",
#'                             state = "MD"),
#' "provider_enrollment", list(org_name = "LUMINUS DIAGNOSTICS LLC",
#'                             state = "GA"))
#'
#' purrr::invoke_map_dfr(prven$fn, prven$params)
#' @autoglobal
#' @export
provider_enrollment <- function(npi                = NULL,
                                pac_id             = NULL,
                                enroll_id          = NULL,
                                specialty_code     = NULL,
                                specialty_desc     = NULL,
                                state              = NULL,
                                first_name         = NULL,
                                middle_name        = NULL,
                                last_name          = NULL,
                                org_name           = NULL,
                                gender             = NULL,
                                tidy               = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                        ~x,  ~y,
                          "NPI", npi,
           "PECOS_ASCT_CNTL_ID", pac_id,
                    "ENRLMT_ID", enroll_id,
             "PROVIDER_TYPE_CD", specialty_code,
           "PROVIDER_TYPE_DESC", specialty_desc,
                     "STATE_CD", state,
                   "FIRST_NAME", first_name,
                     "MDL_NAME", middle_name,
                    "LAST_NAME", last_name,
                     "ORG_NAME", org_name,
                      "GNDR_SW", gender)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "2457ea29-fc82-48b0-86ec-3b0755de7515"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) == 0) {

    cli_args <- tibble::tribble(
      ~x,                 ~y,
      "npi",              as.character(npi),
      "pac_id",           as.character(pac_id),
      "enroll_id",        as.character(enroll_id),
      "specialty_code",   as.character(specialty_code),
      "specialty_desc",   specialty_desc,
      "state",            state,
      "first_name",       first_name,
      "middle_name",      middle_name,
      "last_name",        last_name,
      "org_name",         org_name,
      "gender",           gender) |>
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
    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "N/A"))) |>
      dplyr::select(npi,
                    pac_id         = pecos_asct_cntl_id,
                    enroll_id      = enrlmt_id,
                    specialty_code = provider_type_cd,
                    specialty_desc = provider_type_desc,
                    state          = state_cd,
                    org_name,
                    first_name,
                    middle_name    = mdl_name,
                    last_name,
                    gender         = gndr_sw)
  }
  return(results)
}
