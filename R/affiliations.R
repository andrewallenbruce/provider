#' Facility Affiliations
#'
#' @description
#'
#' [affiliations()] allows you to access information concerning providers'
#' facility affiliations
#'
#' Links:
#'
#'  - [Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'  - [Certification Number (CCN) State Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi < *integer|character* > 10-digit Individual National Provider Identifier
#' @param pac < *integer|character* > 10-digit Individual PECOS Associate Control ID
#' @param first,middle,last < *character* > Individual provider's name
#' @param facility_type < *character* >
#' + `"Hospital"` or `"hp"`
#' + `"Long-term care hospital"` or `"ltch"`
#' + `"Nursing home"` or `"nh"`
#' + `"Inpatient rehabilitation facility"` or `"irf"`
#' + `"Home health agency"` or `"hha"`
#' + `"Skilled nursing facility"` or `"snf"`
#' + `"Hospice"` or `"hs"`
#' + `"Dialysis facility"` or `"df"`
#' @param facility_ccn < *integer|character* > 6-digit CMS Certification Number of
#' facility or unit within hospital where an individual provider provides service
#' @param parent_ccn < *integer* > 6-digit CMS Certification Number of a
#' sub-unit's primary hospital, should the provider provide services in said unit
#' @param offset < *integer* > // __default:__ `0L` API pagination
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param na.rm < *boolean* > // __default:__ `TRUE` Remove empty rows and columns
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**       |**Description**                   |
#' |:---------------|:---------------------------------|
#' |`npi`           |10-digit NPI                      |
#' |`pac`           |10-digit individual PAC ID        |
#' |`first`         |Individual provider's first name  |
#' |`middle`        |Individual provider's middle name |
#' |`last`          |Individual provider's last name   |
#' |`suffix`        |Individual provider's suffix      |
#' |`facility_type` |Category of facility              |
#' |`facility_ccn`  |Facility's 6-digit CCN            |
#' |`parent_ccn`    |Primary facility's 6-digit CCN    |
#'
#' @seealso [clinicians()], [providers()], [hospitals()]
#'
#' @examplesIf interactive()
#' affiliations(parent_ccn = 670055)
#' @autoglobal
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
                         na.rm = TRUE) {

  if (!is.null(npi))           {npi          <- npi_check(npi)}
  if (!is.null(pac))           {pac          <- pac_check(pac)}
  if (!is.null(facility_ccn))  {facility_ccn <- as.character(facility_ccn)}
  if (!is.null(parent_ccn))    {parent_ccn   <- as.character(parent_ccn)}

  if (!is.null(facility_type)) {
    facility_type <- dplyr::case_match(facility_type,
                                       "hp" ~ "Hospital",
                                       "ltch" ~ "Long-term care hospital",
                                       "nh" ~ "Nursing home",
                                       "irf" ~ "Inpatient rehabilitation facility",
                                       "hha" ~ "Home health agency",
                                       "snf" ~ "Skilled nursing facility",
                                       "hs" ~ "Hospice",
                                       "df" ~ "Dialysis facility",
                                       .default = facility_type)

    rlang::arg_match(facility_type, c("Hospital",
                                      "Long-term care hospital",
                                      "Nursing home",
                                      "Inpatient rehabilitation facility",
                                      "Home health agency",
                                      "Skilled nursing facility",
                                      "Hospice",
                                      "Dialysis facility"))}

  args <- dplyr::tribble(
    ~param,                                         ~arg,
    "npi",                                          npi,
    "ind_pac_id",                                   pac,
    "frst_nm",                                      first,
    "mid_nm",                                       middle,
    "lst_nm",                                       last,
    "facility_type",                                facility_type,
    "facility_affiliations_certification_number",   facility_ccn,
    "facility_type_certification_number",           parent_ccn)

  error_body <- function(response) {httr2::resp_body_json(response)$message}

  response <- httr2::request(file_url("a", args, offset)) |>
    httr2::req_error(body = error_body) |>
    httr2::req_perform()

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (isTRUE(vctrs::vec_is_empty(results))) {

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

  if (tidy) {results <- tidyup(results) |> aff_cols()
  if (na.rm) {
    results <- janitor::remove_empty(results, which = c("rows", "cols"))}
  }

  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
aff_cols <- function(df) {

  cols <- c("npi",
            "pac"          = "ind_pac_id",
            "first"        = "frst_nm",
            "middle"       = "mid_nm",
            "last"         = "lst_nm",
            "suffix"       = "suff",
            "facility_type",
            "facility_ccn" = "facility_affiliations_certification_number",
            "parent_ccn"   = "facility_type_certification_number")

  df |> dplyr::select(dplyr::any_of(cols))

}
