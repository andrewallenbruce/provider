#' readme function table ---------------------------------------------------
#' @autoglobal
#' @noRd
function_tbl    <- function() {
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

  func_tbl <- gluedown::md_table(data.frame(Function = c(nppes_func,
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
                                                         clia_func,
                                                         tax_func,
                                                         miss_func,
                                                         pend_func,
                                                         affil_func,
                                                         drclin_func
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
                                                         clia_link,
                                                         tax_link,
                                                         miss_link,
                                                         pend_link,
                                                         affil_link,
                                                         drclin_link
                                                         )))

  return(func_tbl)
}
