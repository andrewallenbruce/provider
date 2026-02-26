# api_url <- list(
#   care = "https://data.cms.gov/data.json",
#   prov = "https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items",
#   open = "https://openpaymentsdata.cms.gov/api/1/metastore/schemas/dataset/items"
# )

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
#' @param first,middle,last `<chr>` Individual provider's name(s)
#'
#' @param type `<chr>` Type of facility, one of the following:
#'    * `"hp"` = Hospital
#'    * `"lt"` = Long-term care hospital
#'    * `"nh"` = Nursing home
#'    * `"irf"` = Inpatient rehabilitation facility
#'    * `"hha"` = Home health agency
#'    * `"snf"` = Skilled nursing facility
#'    * `"hs"` = Hospice
#'    * `"df"` = Dialysis facility
#'
#' @param ccn_unit `<chr>` 6-digit CCN of facility or unit within hospital
#'   where an individual provider provides service.
#'
#' @param ccn_parent `<int>` 6-digit CCN of a sub-unit's
#'   primary hospital, should the provider provide services in said unit.
#'
# @template args-offset
#'
#' @template args-tidy
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
affiliations <- function(
  npi = NULL,
  pac = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  type = NULL,
  ccn_unit = NULL,
  ccn_parent = NULL,
  tidy = TRUE,
  ...
) {
  if (!is.null(type)) {
    enum <- list(
      hp = "Hospital",
      lt = "Long-term care hospital",
      nh = "Nursing home",
      irf = "Inpatient rehabilitation facility",
      hha = "Home health agency",
      snf = "Skilled nursing facility",
      hs = "Hospice",
      df = "Dialysis facility"
    )

    type <- rlang::arg_match0(type, names(enum))
    type <- type[match(type, enum)]
  }

  arg <- purrr::compact(list(
    npi = npi,
    ind_pac_id = pac,
    provider_first_name = first,
    provider_middle_name = middle,
    provider_last_name = last,
    facility_type = type,
    facility_affiliations_certification_number = ccn_unit,
    facility_type_certification_number = ccn_parent
  ))

  err <- function(resp) httr2::resp_body_json(resp)$message

  resp <- httr2::request(file_url("a", args, offset)) |>
    httr2::req_error(body = err) |>
    httr2::req_perform()

  res <- httr2::resp_body_json(resp, simplifyVector = TRUE)

  if (vctrs::vec_is_empty(res)) {
    cli_args <- dplyr::tribble(
      ~x              , ~y            ,
      "npi"           , npi           ,
      "pac"           , pac           ,
      "first"         , first         ,
      "middle"        , middle        ,
      "last"          , last          ,
      "facility_type" , facility_type ,
      "facility_ccn"  , facility_ccn  ,
      "parent_ccn"    , parent_ccn
    ) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  if (tidy) {
    results <- cols_aff(tidyup(results))
  }

  return(results)
}

#' @autoglobal
#' @noRd
get_pro_api <- function() {
  RcppSimdJson::fload(
    json = "https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items"
  ) |>
    collapse::sbt(
      title %iin% c("Facility Affiliation Data", "National Downloadable File")
    ) |>
    collapse::slt(
      title,
      url = landingPage,
      released,
      nextUpdateDate,
      identifier
    )
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_aff <- function(df) {
  cols <- c(
    "npi",
    "pac" = "ind_pac_id",
    "first" = "provider_first_name",
    "middle" = "provider_middle_name",
    "last" = "provider_last_name",
    "suffix" = "suff",
    "facility_type",
    "facility_ccn" = "facility_affiliations_certification_number",
    "parent_ccn" = "facility_type_certification_number"
  )

  df |> dplyr::select(dplyr::any_of(cols))
}
