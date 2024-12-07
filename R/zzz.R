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

  datasets <- c(
    hospitals       = "^Hospital Enrollments",
    providers       = "^Medicare Fee-For-Service  Public Provider Enrollment",
    crosswalk       = "^Medicare Provider and Supplier Taxonomy Crosswalk",
    orderrefer      = "^Order and Referring",
    pending         = "^Pending Initial Logging and Tracking",
    quality_payment = "^Quality Payment Program Experience",
    rbcs            = "^Restructured BETOS Classification System",
    reassignment    = "^Revalidation", # Clinic Group Practice Reassignment",
    optout          = "^Opt Out Affidavits",
    utilization     = "^Medicare Physician & Other Practitioners",
    outpatient      = "^Medicare Outpatient Hospitals",
    laboratories    = "^Provider of Services File - Clinical Laboratories",
    beneficiaries   = "^Medicare Monthly Enrollment",
    prescribers     = "^Medicare Part D Prescribers"
  )

  resp <- httr2::request("https://data.cms.gov/data.json") |>
    httr2::req_perform()

  resp <- as.Date(
    regmatches(resp[["headers"]][["Last-Modified"]],
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
