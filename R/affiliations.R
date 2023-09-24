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
#' @param npi < *integer* > 10-digit national provider identifier
#' @param pac_id_ind < *integer* > 10-digit individual provider associate level variable
#' Links all entity-level information and may be associated with multiple
#' enrollment IDs if the individual or organization enrolled multiple times
#' @param first,middle,last < *character* > Individual provider's first, middle,
#' or last name
#' @param facility_type < *character* >
#'    - `"Hospital"` or `"hp"`
#'    - `"Long-term care hospital"` or `"ltch"`
#'    - `"Nursing home"` or `"nh"`
#'    - `"Inpatient rehabilitation facility"` or `"irf"`
#'    - `"Home health agency"` or `"hha"`
#'    - `"Skilled nursing facility"` or `"snf"`
#'    - `"Hospice"` or `"hs"`
#'    - `"Dialysis facility"` or `"df"`
#' @param facility_ccn < *character* > 6-digit CMS Certification Number of
#' facility or unit within hospital where an individual provider provides service
#' @param parent_ccn < *integer* > 6-digit CMS Certification Number of a
#' sub-unit's primary hospital, should the provider provide services in said unit
#' @param offset < *integer* > offset; API pagination
#' @param tidy < *boolean* > Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**       |**Description**                   |
#' |:---------------|:---------------------------------|
#' |`npi`           |10-digit NPI                      |
#' |`pac_id_ind`    |10-digit individual PAC ID        |
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
                         pac_id_ind = NULL,
                         first = NULL,
                         middle = NULL,
                         last = NULL,
                         facility_type = NULL,
                         facility_ccn = NULL,
                         parent_ccn = NULL,
                         offset = 0L,
                         tidy = TRUE) {

  if (!is.null(npi))           {npi          <- npi_check(npi)}
  if (!is.null(pac_id_ind))    {pac_id_ind   <- pac_check(pac_id_ind)}
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
    "ind_pac_id",                                   pac_id_ind,
    "frst_nm",                                      first,
    "mid_nm",                                       middle,
    "lst_nm",                                       last,
    "facility_type",                                facility_type,
    "facility_affiliations_certification_number",   facility_ccn,
    "facility_type_certification_number",           parent_ccn)

  url <- paste0("https://data.cms.gov/provider-data/api/1/datastore/sql?query=",
                "[SELECT * FROM ", aff_id(), "]",
                encode_param(args, type = "sql"),
                "[LIMIT 10000 OFFSET ", offset, "]")

  error_body <- function(response) {httr2::resp_body_json(response)$message}

  response <- httr2::request(encode_url(url)) |>
    httr2::req_error(body = error_body) |>
    httr2::req_perform()

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (isTRUE(vctrs::vec_is_empty(results))) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "pac_id_ind",    pac_id_ind,
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

  if (tidy) {results <- tidyup(results) |> aff_cols()}

  return(results)
}

#' @autoglobal
#' @noRd
aff_id <- function() {

  response <- httr2::request("https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/27ea-46a8?show-reference-ids=true") |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE)

  return(response$distribution$identifier)
}

#' @param df data frame
#' @autoglobal
#' @noRd
aff_cols <- function(df) {

  cols <- c("npi",
            "pac_id_ind"   = "ind_pac_id",
            "first"        = "frst_nm",
            "middle"       = "mid_nm",
            "last"         = "lst_nm",
            "suffix"       = "suff",
            "facility_type",
            "facility_ccn" = "facility_affiliations_certification_number",
            "parent_ccn"   = "facility_type_certification_number")

  df |> dplyr::select(dplyr::all_of(cols))

}
