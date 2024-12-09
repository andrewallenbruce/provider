# .onLoad <- function(libname, pkgname) {
#   .__distros <<- distributions_cms()
# }
#
# .onUnload <- function(libpath) {
#   remove(".__distros", envir = .GlobalEnv)
# }

#' Main CMS Distributions, datetime last modified
#'
#' @autoglobal
#'
#' @returns description
#'
#' @keywords internal
#'
#' @export
last_dttm <- \() {

  res <- req_perform(
    request("https://data.cms.gov/data.json"))

  c(req = strptime(
      resp_date(res),
      format = "%Y-%m-%d %H:%M:%S",
      tz = "EST"),
    mod = strptime(
      resp_header(res, "Last-Modified"),
      format = "%a, %d %b %Y %H:%M:%S",
      tz = "EST"))
}

#' CMS Dataset Distribution Names
#'
#' @autoglobal
#'
#' @returns description
#'
#' @keywords internal
#'
#' @export
datasets <- \() {
  c(
    # affiliations    = "Facility Affiliation Data",
    # clinicians      = "National Downloadable File",
    # open_payments   = "General Payment Data",
    beneficiaries   = "Medicare Monthly Enrollment",
    crosswalk       = "Medicare Provider and Supplier Taxonomy Crosswalk",
    hospitals       = "Hospital Enrollments",
    laboratories    = "Provider of Services File - Clinical Laboratories",
    outpatient      = c(service = "Medicare Outpatient Hospitals - by Provider and Service", geography = "Medicare Outpatient Hospitals - by Geography and Service"),
    orderrefer      = "Order and Referring",
    pending         = c(physicians = "Pending Initial Logging and Tracking", nonphysicians = "Pending Initial Logging and Tracking Non Physicians"),
    providers       = "Medicare Fee-For-Service  Public Provider Enrollment",
    quality         = "Quality Payment Program Experience",
    rbcs            = "Restructured BETOS Classification System",
    reassignment    = "Revalidation Reassignment List", # Clinic Group Practice Reassignment",
    optout          = "Opt Out Affidavits",
    prescribers     = c(
      provider = "Medicare Part D Prescribers - by Provider",
      drug = "Medicare Part D Prescribers - by Provider and Drug",
      geography = "Medicare Part D Prescribers - by Geography and Drug"
    ),
    utilization     = c(
      provider = "Medicare Physician & Other Practitioners - by Provider",
      service = "Medicare Physician & Other Practitioners - by Provider and Service",
      geography = "Medicare Physician & Other Practitioners - by Geography and Service"
    )
  )
}

#' Main CMS Distributions
#'
#' @param datasets character vector of dataset names
#'
#' @autoglobal
#'
#' @returns description
#'
#' @keywords internal
#'
#' @export
distros_main <- \(datasets = datasets()) {

  main <- arrow::read_json_arrow(
    file = "https://data.cms.gov/data.json",
    col_select = c("dataset"),
    as_data_frame = TRUE)

  main <- main[["dataset"]][[1]][c("title", "modified", "distribution")]

  main <- main |>
    collapse::fsubset(
      grepl(paste0(
        unname(datasets),
        collapse = "|"),
        title, perl = TRUE))

  main |>
    tidyr::unnest(
      cols = distribution,
      names_sep = "_",
      keep_empty = TRUE) |>
    collapse::fsubset(!cheapr::is_na(distribution_format)) |>
    # collapse::fsubset(distribution_format %==% "API") |>
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
    last_modified = last_dttm(),
    distributions = arrow_cms
  )
}

#' Doctors and Clinicians (National Downloadable File) Distributions
#'
#' @autoglobal
#'
#' @returns description
#'
#' @keywords internal
#'
#' @export
distros_dac <- \() {

  ids <- c(affiliations = "27ea-46a8",
           clinicians = "mj5m-pzi6")

  urls <- paste0(
    "https://data.cms.gov/",
    "provider-data/api/1/metastore/",
    "schemas/dataset/items/",
    unname(ids),
    "?show-reference-ids=true")

  resp <- httr2::req_perform_parallel(
    purrr::map(urls, httr2::request),
    on_error = "continue") |>
    setNames(names(ids))

  af <- httr2::resp_body_json(
    collapse::get_elem(resp, "affiliations"),
    simplifyVector = TRUE)

  cl <- httr2::resp_body_json(
    collapse::get_elem(resp, "clinicians"),
    simplifyVector = TRUE)


  affiliations <- list(
    dataset = c(title = af$title,
                description = af$description),
    ids = c(identifier = af$identifier,
            distribution = af$distribution$identifier),
    dates = c(issued = af$issued,
              modified = af$modified,
              released = af$released),
    urls = c(landing = af$landingPage,
             csv = af$distribution$data$downloadURL))

  clinicians <- list(
    dataset = c(title = cl$title,
                description = cl$description),
    ids = c(identifier = cl$identifier,
            distribution = cl$distribution$identifier),
    dates = c(issued = cl$issued,
              modified = cl$modified,
              released = cl$released),
    urls = c(landing = cl$landingPage,
             csv = cl$distribution$data$downloadURL))

  c(affiliations = affiliations,
    clinicians = clinicians)
}

#' Open Payments CMS Distributions
#'
#' @autoglobal
#'
#' @returns description
#'
#' @keywords internal
#'
#' @export
distros_open <- function() {

  url <- paste0(
    "https://openpaymentsdata.cms.gov/",
    "api/1/metastore/schemas/dataset/",
    "items?show-reference-ids")

  resp <- httr2::request(url) |>
    httr2::req_perform() |>
    httr2::resp_body_json(
    check_type = FALSE,
    simplifyVector = TRUE) |>
    dplyr::tibble()

  root <- dplyr::reframe(
    resp,
    title,
    description = strex::str_before_first(description, " \\[") |>
      stringfish::sf_gsub("\n", ". ", fixed = TRUE, nthreads = 4L),
    identifier,
    issued,
    modified,
    temporal,
    periodicity = accrualPeriodicity)

  nests <- dplyr::select(resp, identifier, distribution) |>
    data.table::as.data.table() |>
    mlr3misc::unnest("distribution", prefix = "{col}_") |>
    mlr3misc::unnest("distribution_data", prefix = "{col}_") |>
    # collapse::frename(distribution_data_ref = `distribution_data_%Ref:downloadURL`) |>
    collapse::fselect(
      identifier,
      distribution_identifier,
      distribution_data_title,
      distribution_data_downloadURL,
      distribution_data_describedBy) |>
    dplyr::tibble()

  list(
    root = root,
    nests = nests
  )
}

# url <- paste0("https://data.cms.gov/provider-data/api/1/datastore/sql?query=",
#               "[SELECT * FROM ", id$distribution$identifier, "]",
#               encode_param(args, type = "sql"),
#               "[LIMIT 10000 OFFSET ", offset, "];&show_db_columns")
#
# lastmod <- regmatches(
#   lastmod,
#   regexpr("[0-9]{2} [A-Za-z]{3} [0-9]{4}", lastmod, perl = TRUE)) |>
#   as.Date(format = "%d %b %Y")
#
#   resps <- httr2::req_perform_parallel(
#   purrr::map(urls, httr2::request), on_error = "continue") |>
#   httr2::resps_successes() |>
#   httr2::resps_data(\(resp) httr2::resp_body_json(resp, simplifyVector = TRUE))
