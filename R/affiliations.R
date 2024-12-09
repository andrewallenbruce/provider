#' Provider Facility Affiliations
#'
#' @description [affiliations()] allows the user access to data concerning
#'   providers' facility affiliations
#'
#' @section Links:
#'    * [Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'    * [Certification Number (CCN) State Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)
#'
#' *Update Frequency:* **Monthly**
#'
#' @template args-npi
#'
#' @template args-pac
#'
#' @param first,middle,last `<chr>` Individual provider's first/middle/last name
#'
#' @param facility_type `<chr>` Type of facility, one of the following:
#'    * `Hospital` (`hp`)
#'    * `Long-term care hospital` (`ltch`)
#'    * `Nursing home` (`nh`)
#'    * `Inpatient rehabilitation facility` (`irf`)
#'    * `Home health agency` (`hha`)
#'    * `Skilled nursing facility` (`snf`)
#'    * `Hospice` (`hs`)
#'    * `Dialysis facility` (`df`)
#'
#' @param facility_ccn `<chr>` 6-digit CMS Certification Number of facility or
#'   unit within hospital where an individual provider provides service.
#'
#' @param parent_ccn `<int>` 6-digit CMS Certification Number of a sub-unit's
#'   primary hospital, should the provider provide services in said unit.
#'
#' @template args-offset
#'
#' @template args-tidy
#'
#' @template args-narm
#'
#' @template args-dots
#'
#' @template returns
#'
#' @examplesIf interactive()
#' affiliations(parent_ccn = 670055)
#'
#' @autoglobal
#'
#' @export
affiliations <- function(npi = NULL,
                         pac = NULL,
                         first = NULL,
                         middle = NULL,
                         last = NULL,
                         facility_type = NULL,
                         facility_ccn = NULL,
                         parent_ccn = NULL,
                         offset = 0L,
                         tidy = TRUE,
                         na.rm = TRUE,
                         ...) {

  npi          <- npi %nn% validate_npi(npi)
  pac          <- pac %nn% check_pac(pac)
  facility_ccn <- facility_ccn %nn% as.character(facility_ccn)
  parent_ccn   <- parent_ccn %nn% as.character(parent_ccn)

  if (!is.null(facility_type)) {

    facility_type <- dplyr::case_match(
      facility_type,
      "hp"   ~ "Hospital",
      "ltch" ~ "Long-term care hospital",
      "nh"   ~ "Nursing home",
      "irf"  ~ "Inpatient rehabilitation facility",
      "hha"  ~ "Home health agency",
      "snf"  ~ "Skilled nursing facility",
      "hs"   ~ "Hospice",
      "df"   ~ "Dialysis facility",
      .default = facility_type)

    facility_type <- rlang::arg_match0(
      facility_type, c("Hospital",
                       "Long-term care hospital",
                       "Nursing home",
                       "Inpatient rehabilitation facility",
                       "Home health agency",
                       "Skilled nursing facility",
                       "Hospice",
                       "Dialysis facility"))
    }

  args <- dplyr::tribble(
    ~param,                                         ~arg,
    "npi",                                          npi,
    "ind_pac_id",                                   pac,
    "provider_first_name",                          first,
    "provider_middle_name",                         middle,
    "provider_last_name",                           last,
    "facility_type",                                facility_type,
    "facility_affiliations_certification_number",   facility_ccn,
    "facility_type_certification_number",           parent_ccn)

  error_body <- function(response) httr2::resp_body_json(response)$message

  response <- httr2::request(file_url("a", args, offset)) |>
    httr2::req_error(body = error_body) |>
    httr2::req_perform()

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (vctrs::vec_is_empty(results)) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "pac",           pac,
      "first",         first,
      "middle",        middle,
      "last",          last,
      "facility_type", facility_type,
      "facility_ccn",  facility_ccn,
      "parent_ccn",    parent_ccn) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))

  }
  if (tidy) {
    results <- cols_aff(tidyup(results)) |>
      dplyr::mutate(facility_type = fct_fac(facility_type))
    if (na.rm) results <- narm(results)
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_aff <- function(df) {

  cols <- c("npi",
            "pac"          = "ind_pac_id",
            "first"        = "provider_first_name",
            "middle"       = "provider_middle_name",
            "last"         = "provider_last_name",
            "suffix"       = "suff",
            "facility_type",
            "facility_ccn" = "facility_affiliations_certification_number",
            "parent_ccn"   = "facility_type_certification_number")

  df |> dplyr::select(dplyr::any_of(cols))
}

