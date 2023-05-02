#' Search the CMS Doctors and Clinicians National Downloadable File API
#'
#' @description Dataset of providers' facility affiliations
#'
#' @details The Doctors and Clinicians national downloadable file is organized
#'   such that each line is unique at the clinician/enrollment
#'   record/group/address level. Clinicians with multiple Medicare enrollment
#'   records and/or single enrollments linking to multiple practice locations
#'   are listed on multiple lines.
#'
#'   ## Links
#'   * [Doctors and Clinicians National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param npi Unique clinician ID assigned by NPPES
#' @param pac_id Unique individual clinician ID assigned by PECOS
#' @param enroll_id Unique ID for the clinician enrollment that is the source
#'   for the data in the observation
#' @param first_name Individual clinician first name
#' @param middle_name Individual clinician middle name
#' @param last_name Individual clinician last name
#' @param gender Individual clinician gender
#' @param school Individual clinician’s medical school
#' @param grad_year Individual clinician’s medical school graduation year
#' @param specialty Primary medical specialty reported by the individual
#'   clinician in the selected enrollment
#' @param city Group or individual's city
#' @param state Group or individual's state
#' @param zipcode Group or individual's ZIP code (9 digits when available)
#' @param ind_assign Indicator for whether clinician accepts Medicare approved
#'   amount as payment in full. `Y` = Clinician accepts Medicare approved amount
#'   as payment in full. `M` = Clinician may accept Medicare Assignment.
#' @param group_assign Indicator for whether group accepts Medicare approved
#'   amount as payment in full. `Y` = Clinician accepts Medicare approved amount
#'   as payment in full. `M` = Clinician may accept Medicare Assignment.
#' @param offset offset; API pagination
#' @param clean_names Convert column names to snakecase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' doctors_and_clinicians(npi = 1407263999)
#' doctors_and_clinicians(enroll_id = "I20081002000549")
#' \dontrun{
#' doctors_and_clinicians(first_name = "John")
#' doctors_and_clinicians(school = "NEW YORK UNIVERSITY SCHOOL OF MEDICINE")
#' doctors_and_clinicians(grad_year = 2003)
#' }
#' @autoglobal
#' @export

doctors_and_clinicians <- function(npi           = NULL,
                                   pac_id        = NULL,
                                   enroll_id     = NULL,
                                   first_name    = NULL,
                                   middle_name   = NULL,
                                   last_name     = NULL,
                                   gender        = NULL,
                                   school        = NULL,
                                   grad_year     = NULL,
                                   specialty     = NULL,
                                   city          = NULL,
                                   state         = NULL,
                                   zipcode       = NULL,
                                   ind_assign    = NULL,
                                   group_assign  = NULL,
                                   offset        = 0,
                                   clean_names   = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                   ~y,
    "NPI",                npi,
    "Ind_PAC_ID",         pac_id,
    "Ind_enrl_ID",        enroll_id,
    "frst_nm",            first_name,
    "mid_nm",             middle_name,
    "lst_nm",             last_name,
    "gndr",               gender,
    "Med_sch",            school,
    "Grd_yr",             grad_year,
    "pri_spec",           specialty,
    "cty",                city,
    "st",                 state,
    "zip",                zipcode,
    "ind_assgn",          ind_assign,
    "grp_assgn",          group_assign)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |> stringr::str_flatten()

  id_res <- httr2::request("https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/mj5m-pzi6?show-reference-ids=true") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE, simplifyVector = TRUE)

  id <- paste0("[SELECT * FROM ", id_res$distribution$identifier, "]")

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query="
  post   <- paste0("[LIMIT 10000 OFFSET ", offset, "]&show_db_columns")
  url    <- paste0(http, id, params_args, post) |>
    param_brackets() |> param_space()

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (httr2::resp_header(response, "content-length") == "28") {

    cli_args <- tibble::tribble(
      ~x,              ~y,
      "npi",           as.character(npi),
      "pac_id",        as.character(pac_id),
      "enroll_id",     enroll_id,
      "first_name",    first_name,
      "middle_name",   middle_name,
      "last_name",     last_name,
      "gender",        gender,
      "school",        school,
      "grad_year",     as.character(grad_year),
      "specialty",     specialty,
      "city",          city,
      "state",         state,
      "zipcode",       zipcode,
      "ind_assign",    ind_assign,
      "group_assign",  group_assign) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    return(cli::cli_alert_danger("No results for {.val {cli_args}}",
                                 wrap = TRUE))

  }

    # parse response ---------------------------------------------------------
    results <- tibble::tibble(httr2::resp_body_json(response,
               check_type = FALSE, simplifyVector = TRUE)) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "N/A")))

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {
    results <- dplyr::rename_with(results, str_to_snakecase) |>
      tidyr::unite("address",
                   adr_ln_1:adr_ln_2,
                   remove = TRUE, na.rm = TRUE) |>
      dplyr::mutate(num_org_mem = as.integer(num_org_mem),
                    grd_yr = as.integer(grd_yr),
                    telehlth = yn_logical(telehlth)) |>
      dplyr::select(
        npi,
        pac_id = ind_pac_id,
        enroll_id = ind_enrl_id,
        first_name = frst_nm,
        middle_name = mid_nm,
        last_name = lst_nm,
        suffix = suff,
        gender = gndr,
        credential = cred,
        school = med_sch,
        grad_year = grd_yr,
        specialty = pri_spec,
        specialty_sec = sec_spec_all,
        telehealth = telehlth,
        org_name = org_nm,
        org_pac_id,
        org_members = num_org_mem,
        address,
        city = cty,
        state = st,
        zipcode = zip,
        phone_number = phn_numbr,
        ind_assign = ind_assgn,
        group_assign = grp_assgn)
    }

  return(results)
}

