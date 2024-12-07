.onLoad <- function(libname, pkgname) {
  .__distros <<- cms_distributions()
}

.onUnload <- function(libpath) {
  remove(".__distros", envir = .GlobalEnv)
}

#' Retrieve the latest CMS distributions
#'
#' @autoglobal
#'
#' @keywords internal
#'
#' @export
cms_distributions <- \() {

  datasets <- vctrs::vec_c(
    # affiliations    = "Facility Affiliation Data",
    # clinicians      = "National Downloadable File",
    # open_payments   = "General Payment Data",
    beneficiaries   = "Medicare Monthly Enrollment",
    crosswalk       = "Medicare Provider and Supplier Taxonomy Crosswalk",
    hospitals       = "Hospital Enrollments",
    laboratories    = "Provider of Services File - Clinical Laboratories",
    outpatient      = c(service = "Medicare Outpatient Hospitals - by Provider and Service",
                        geography = "Medicare Outpatient Hospitals - by Geography and Service"),
    orderrefer      = "Order and Referring",
    pending         = c(physicians = "Pending Initial Logging and Tracking",
                        nonphysicians = "Pending Initial Logging and Tracking Non Physicians"),
    providers       = "Medicare Fee-For-Service  Public Provider Enrollment",
    quality         = "Quality Payment Program Experience",
    rbcs            = "Restructured BETOS Classification System",
    reassignment    = "Revalidation Reassignment List", # Clinic Group Practice Reassignment",
    optout          = "Opt Out Affidavits",
    prescribers     = c(provider = "Medicare Part D Prescribers - by Provider",
                        drug = "Medicare Part D Prescribers - by Provider and Drug",
                        geography = "Medicare Part D Prescribers - by Geography and Drug"),
    utilization     = c(provider = "Medicare Physician & Other Practitioners - by Provider",
                        service = "Medicare Physician & Other Practitioners - by Provider and Service",
                        geography = "Medicare Physician & Other Practitioners - by Geography and Service"),
    .name_spec = "{outer}_{inner}"
  )

  resp <- httr2::request("https://data.cms.gov/data.json") |>
    httr2::req_perform()

  resp <- as.Date(
    regmatches(
      resp[["headers"]][["Last-Modified"]],
      regexpr("[0-9]{2} [A-Za-z]{3} [0-9]{4}",
              resp[["headers"]][["Last-Modified"]],
              perl = TRUE)),
    format = "%d %b %Y")

  arrow_cms <- arrow::read_json_arrow(
    file = "https://data.cms.gov/data.json",
    col_select = c("dataset"),
    as_data_frame = TRUE)

  arrow_cms <- arrow_cms[["dataset"]][[1]][
    c("title", "modified", "distribution")] |>
    collapse::fsubset(
      grepl(
        paste0(
          unname(datasets),
          collapse = "|"),
        title,
        perl = TRUE
      )
    ) |>
    tidyr::unnest(
      cols = distribution,
      names_sep = "_",
      keep_empty = TRUE) |>
    collapse::fsubset(
      distribution_format %==% "API") |>
    collapse::fcompute(
      year = as.integer(
        regmatches(
          distribution_title,
          regexpr(
            "\\d{4}(?=-\\d{2}-\\d{2})",
            distribution_title,
            perl = TRUE))),
      modified = as.Date.character(distribution_modified),
      distribution = regmatches(
        distribution_accessURL,
        regexpr(
          "(?<=dataset/).*?(?=/data)",
          distribution_accessURL,
          perl = TRUE)),
      keep = "title") |>
    collapse::fsubset(
      data.table::rleid(
        title,
        year,
        modified) != collapse::flag(
          data.table::rleid(
            title,
            year,
            modified
          ),
          -1)
    )

  list(
    last_modified = resp,
    distributions = arrow_cms
  )
}
