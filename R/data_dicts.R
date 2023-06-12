
#' readme function table ---------------------------------------------------
#' @autoglobal
#' @noRd
function_tbl    <- function() {
  qpp_func    <- gluedown::md_code("quality_payment()")
  qpp_link    <- gluedown::md_link(
    "CMS Quality Payment Program" = "https://data.cms.gov/quality-of-care/quality-payment-program-experience")
  nppes_func    <- gluedown::md_code("nppes_npi()")
  nppes_link    <- gluedown::md_link(
    "NPPES National Provider Identifier (NPI) Registry" = "https://npiregistry.cms.hhs.gov/search")
  open_func     <- gluedown::md_code("open_payments()")
  open_link     <- gluedown::md_link(
    "CMS Open Payments Program" = "https://openpaymentsdata.cms.gov/dataset/0380bbeb-aea1-58b6-b708-829f92a48202")
  mppe_func     <- gluedown::md_code("provider_enrollment()")
  mppe_link     <- gluedown::md_link(
    "Medicare Fee-For-Service Public Provider Enrollment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment")
  mme_func      <- gluedown::md_code("beneficiary_enrollment()")
  mme_link      <- gluedown::md_link(
    "Medicare Monthly Enrollment" = "https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment")
  miss_func     <- gluedown::md_code("missing_information()")
  miss_link     <- gluedown::md_link(
    "CMS Public Reporting of Missing Digital Contact Information" = "https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information")
  order_func    <- gluedown::md_code("order_refer()")
  order_link    <- gluedown::md_link(
    "Medicare Order and Referring" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring")
  opt_func      <- gluedown::md_code("opt_out()")
  opt_link      <- gluedown::md_link(
    "Medicare Opt Out Affidavits" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits")
  pbp_func      <- gluedown::md_code("physician_by_provider()")
  pbp_link      <- gluedown::md_link(
    "Medicare Physician & Other Practitioners: by Provider" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider")
  pbs_func      <- gluedown::md_code("physician_by_service()")
  pbs_link      <- gluedown::md_link(
    "Medicare Physician & Other Practitioners: by Provider and Service" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service")
  pbg_func      <- gluedown::md_code("physician_by_geography()")
  pbg_link      <- gluedown::md_link(
    "Medicare Physician & Other Practitioners: by Geography and Service" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service")
  redd_func     <- gluedown::md_code("revalidation_date()")
  redd_link     <- gluedown::md_link(
    "Medicare Revalidation Due Date" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list")
  rere_func     <- gluedown::md_code("revalidation_reassign()")
  rere_link     <- gluedown::md_link(
    "Medicare Revalidation Reassignment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list")
  recl_func     <- gluedown::md_code("revalidation_group()")
  recl_link     <- gluedown::md_link(
    "Medicare Revalidation Clinic Group Practice Reassignment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment")
  ccs_func      <- gluedown::md_code("cc_specific()")
  ccs_link      <- gluedown::md_link(
    "Medicare Specific Chronic Conditions" = "https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions")
  ccm_func      <- gluedown::md_code("cc_multiple()")
  ccm_link      <- gluedown::md_link(
    "Medicare Multiple Chronic Conditions" = "https://data.cms.gov/medicare-chronic-conditions/multiple-chronic-conditions")
  clia_func     <- gluedown::md_code("clia_labs()")
  clia_link     <- gluedown::md_link(
    "Medicare Provider of Services File - Clinical Laboratories" = "https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories")
  tax_func      <- gluedown::md_code("taxonomy_crosswalk()")
  tax_link      <- gluedown::md_link(
    "Medicare Provider and Supplier Taxonomy Crosswalk" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk")
  pend_func     <- gluedown::md_code("pending_applications()")
  pend_link     <- gluedown::md_link(
    "Medicare Pending Initial Logging and Tracking" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians")
  affil_func    <- gluedown::md_code("facility_affiliations()")
  affil_link    <- gluedown::md_link(
    "CMS Physician Facility Affiliations" = "https://data.cms.gov/provider-data/dataset/27ea-46a8")
  drclin_func   <- gluedown::md_code("doctors_and_clinicians()")
  drclin_link   <- gluedown::md_link(
    "Doctors and Clinicians National Downloadable File" = "https://data.cms.gov/provider-data/dataset/mj5m-pzi6")
  addph_func   <- gluedown::md_code("addl_phone_numbers()")
  addph_link   <- gluedown::md_link(
    "Physician Additional Phone Numbers" = "https://data.cms.gov/provider-data/dataset/phys-phon")
  hspen_func   <- gluedown::md_code("hospital_enrollment()")
  hspen_link   <- gluedown::md_link(
    "Hospital Enrollments" = "https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments")

  func_tbl <- data.frame(Function = c(nppes_func,
                                      open_func,
                                      mppe_func,
                                      mme_func,
                                      order_func,
                                      opt_func,
                                      pbp_func,
                                      pbs_func,
                                      pbg_func,
                                      redd_func,
                                      recl_func,
                                      rere_func,
                                      ccs_func,
                                      ccm_func,
                                      #clia_func,
                                      tax_func,
                                      miss_func,
                                      pend_func,
                                      affil_func,
                                      drclin_func,
                                      #addph_func,
                                      hspen_func,
                                      qpp_func
  ),
  API      = c(nppes_link,
               open_link,
               mppe_link,
               mme_link,
               order_link,
               opt_link,
               pbp_link,
               pbs_link,
               pbg_link,
               redd_link,
               recl_link,
               rere_link,
               ccs_link,
               ccm_link,
               #clia_link,
               tax_link,
               miss_link,
               pend_link,
               affil_link,
               drclin_link,
               #addph_link,
               hspen_link,
               qpp_link
  ))

  return(func_tbl)
}

#' Search the CMS Physician - Additional Phone Numbers API
#' #### Dataset API no longer available ##################
#' @description Dataset of additional phone numbers when clinicians have more
#'   than one phone number at a single practice address.
#'
#'   ## Links
#'   * [Physician - Additional Phone Numbers](https://data.cms.gov/provider-data/dataset/phys-phon)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param npi Unique clinician ID assigned by NPPES
#' @param pac_id_ind Unique individual clinician ID assigned by PECOS
#' @param pac_id_org Unique group ID assigned by PECOS to the group
#' @param first_name Individual clinician first name
#' @param last_name Individual clinician last name
#' @param middle_name Individual clinician middle name
#' @param city Group or individual's city
#' @param state Group or individual's state
#' @param zip Group or individual's ZIP code (9 digits when available)
#' @param offset offset; API pagination
#' @param clean_names Convert column names to snake case; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' #addl_phone_numbers(npi = 1407263999)
#' #addl_phone_numbers(pac_id_ind = "0042100190")
#' #addl_phone_numbers(pac_id_org = 6608028899)
#' #addl_phone_numbers(city = "Atlanta")
#' addl_phone_numbers(zip = 303421606)
#' }
#' @noRd

addl_phone_numbers <- function(npi           = NULL,
                               pac_id_ind   = NULL,
                               pac_id_org    = NULL,
                               first_name    = NULL,
                               middle_name   = NULL,
                               last_name     = NULL,
                               city          = NULL,
                               state         = NULL,
                               zip           = NULL,
                               offset        = 0,
                               clean_names   = TRUE) {

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,           ~y,
    "npi",        npi,
    "prvdr_id",   pac_id_ind,
    "frst_nm",    first_name,
    "mid_nm",     middle_name,
    "lst_nm",     last_name,
    "cty",        city,
    "st",         state,
    "zip",        zip,
    "org_pac_id", pac_id_org)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |> stringr::str_flatten()

  id <- "a12b0ee3-db05-5603-bd3e-e6f449797cb0"

  id_fmt <- paste0("[SELECT * FROM ", id, "]")

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query="
  post   <- paste0("[LIMIT 10000 OFFSET ", offset, "]&show_db_columns")
  url    <- paste0(http, id_fmt, params_args, post) |>
    param_brackets() |> param_space()

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.numeric(httr2::resp_header(resp, "content-length")) == 0) {
    return(tibble::tibble())
  } else {

    # parse response ---------------------------------------------------------
    results <- tibble::tibble(httr2::resp_body_json(resp,
                                                    check_type = FALSE, simplifyVector = TRUE)) |>
      dplyr::mutate(dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "N/A")))

  }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- dplyr::rename_with(results, str_to_snakecase)}

  return(results)
}
