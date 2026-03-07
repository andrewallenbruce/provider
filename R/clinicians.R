#' Clinicians Enrolled in Medicare
#'
#' @description Access information about providers enrolled in Medicare,
#' including the medical school that they attended and the year they graduated
#'
#' @section Links:
#'
#'    * [National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
#'    * [Provider Data Catalog (PDC) Data Dictionary](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)
#'
#' @param npi `<int>` Provider's NPI
#' @param pac `<int>` Provider's PECOS Associate Control ID
#' @param enid `<chr>` Provider's Medicare Enrollment ID
#' @param first,middle,last,suffix `<chr>` Provider's name
#' @param gender `<chr>` Provider's gender; `"F"` (Female), `"M"` (Male), or `"U"` (Unknown)
#' @param credential `<chr>` Provider’s credential, i.e. "MD"
#' @param city,state,zip `<chr>` Provider's city, state, zip
#' @param grad_school `<chr>` Medical school provider graduated from
#' @param grad_year `<int>` Provider’s graduation year; YYYY
#' @param specialty `<chr>` Provider’s primary medical specialty
#' @param facility_name `<chr>` Facility associated with Provider
#' @param facility_pac `<int>` Facility's PECOS Associate Control ID
#'
#' @returns A [tibble][tibble::tibble-package] with the columns:
#'
#'   |**Field**       |**Description**                                       |
#'   |:---------------|:-----------------------------------------------------|
#'   |`npi`           |10-digit individual NPI                               |
#'   |`pac`           |10-digit individual PAC ID                            |
#'   |`enid`          |15-digit individual enrollment ID                     |
#'   |`first`         |Provider's first name                                 |
#'   |`middle`        |Provider's middle name                                |
#'   |`last`          |Provider's last name                                  |
#'   |`suffix`        |Provider's name suffix                                |
#'   |`gender`        |Provider's gender                                     |
#'   |`credential`    |Provider's credential                                 |
#'   |`school`        |Provider's medical school                             |
#'   |`grad_year`     |Provider's graduation year                            |
#'   |`specialty`     |Provider's primary specialty                          |
#'   |`specialty_sec` |Provider's secondary specialty                        |
#'   |`facility_name` |Facility associated with provider                     |
#'   |`pac_org`       |Facility's 10-digit PAC ID                            |
#'   |`members`       |Number of providers associated with facility's PAC ID |
#'   |`address`       |Provider's street address                             |
#'   |`city`          |Provider's city                                       |
#'   |`state`         |Provider's state                                      |
#'   |`zip`           |Provider's zip code                                   |
#'   |`phone`         |Provider's phone number                               |
#'   |`telehealth`    |Indicates if provider offers telehealth services      |
#'   |`assign_ind`    |Indicates if provider accepts Medicare assignment     |
#'   |`assign_org`    |Indicates if facility accepts Medicare assignment     |
#'
#' @examples
#' clinicians()
#'
#' clinicians(enid = "I20081002000549")
#'
#' clinicians(first = "ETAN")
#'
#' @autoglobal
#' @export
clinicians <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  suffix = NULL,
  gender = NULL,
  credential = NULL,
  grad_school = NULL,
  grad_year = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  specialty = NULL,
  facility_name = NULL,
  facility_pac = NULL
) {
  args <- parameters(
    npi = npi,
    ind_pac_id = pac,
    ind_enrl_id = enid,
    provider_last_name = last,
    provider_first_name = first,
    provider_middle_name = middle,
    suff = suffix,
    gndr = gender,
    cred = credential,
    med_sch = grad_school,
    grd_yr = grad_year,
    pri_spec = specialty,
    facility_name = facility_name,
    org_pac_id = facility_pac,
    citytown = city,
    state = state,
    zip_code = zip
  )

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(args)) {
    cli_no_query()

    url <- flatten_url(
      base_url("clinicians"),
      opts = set_opts(
        count = "false",
        results = "true",
        schema = "false",
        limit = 10L
      )
    )

    res <- bare_request(url, "results") |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_clinicians()

    return(res)
  }
  # Valid Query: Flatten & Request Result Count =====================
  url <- flatten_url(
    base_url("clinicians"),
    opts = set_opts(
      count = "true",
      results = "false",
      schema = "false",
      offset = 0,
      limit = 1500
    ),
    query = flatten_query(args)
  )

  N <- bare_request(url, "count")

  # Query Returned Nothing: Alert & Exit =====================
  if (N == 0L) {
    cli::cli_alert_danger("Query returned {N} result{?s}.")
    return(invisible(NULL))
  }

  # Count is Within API Limit: Request & Return Results
  if (N <= 1500L) {
    cli::cli_alert_success("Query returned {N} result{?s}.")

    url <- flatten_url(
      base_url("clinicians"),
      opts = set_opts(
        count = "false",
        results = "true",
        schema = "false",
        offset = 0,
        limit = 1500
      ),
      query = flatten_query(args)
    )

    res <- bare_request(url, "results") |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_clinicians()

    return(res)
  }

  # Count Above API Limit: Alert & Return Results =====================
  cli::cli_alert_success("Query returned {format(N, big.mark = ',')} results.")
  cli::cli_alert_info("Retrieving {offset(N, 1500L)} page{?s}...")

  url <- flatten_url(
    base_url("clinicians"),
    opts = set_opts(
      count = "false",
      results = "true",
      schema = "false",
      limit = 1500,
      offset = "<<i>>"
    ),
    query = flatten_query(args)
  )

  urls <- offset(N, 1500L, "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = url, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })

  parallel_request(urls, "results") |>
    collapse::rowbind() |>
    fastplyr::as_tbl() |>
    map_na_if() |>
    rename_clinicians()
}

#' @autoglobal
#' @noRd
rename_clinicians <- function(x) {
  NM <- c(
    npi = "npi",
    ind_pac_id = "pac",
    ind_enrl_id = "enid",
    provider_last_name = "last",
    provider_first_name = "first",
    provider_middle_name = "middle",
    suff = "suffix",
    gndr = "gender",
    cred = "credential",
    med_sch = "grad_school",
    grd_yr = "grad_year",
    pri_spec = "specialty",
    sec_spec_all = "spec_other",
    telehlth = "telehealth",
    facility_name = "facility_name",
    org_pac_id = "org_pac",
    num_org_mem = "org_mem",
    adr_ln_1 = "add_1",
    adr_ln_2 = "add_2",
    citytown = "city",
    state = "state",
    zip_code = "zip",
    telephone_number = "phone",
    ind_assgn = "ind_par",
    grp_assgn = "grp_par"
  )

  collapse::setrename(x, NM, .nse = FALSE)

  collapse::gv(x, unlist_(NM))
}
