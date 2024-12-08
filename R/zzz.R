.onLoad <- function(libname, pkgname) {
  .__distros <<- distributions_cms()
}

.onUnload <- function(libpath) {
  remove(".__distros", envir = .GlobalEnv)
}

#' Main CMS Distributions
#'
#' @autoglobal
#'
#' @returns description
#'
#' @keywords internal
#'
#' @export
distributions_cms <- \() {

  datasets <- c(
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
                        geography = "Medicare Physician & Other Practitioners - by Geography and Service")
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

#' Doctors and Clinicians (National Downloadable File) Distributions
#'
#' @autoglobal
#'
#' @returns description
#'
#' @keywords internal
#'
#' @export
distributions_natl <- \() {

  id <- c(
    affiliations = "27ea-46a8",
    clinicians = "mj5m-pzi6")

  urls <- glue::glue(
    "https://data.cms.gov/",
    "provider-data/api/1/metastore/",
    "schemas/dataset/items/",
    "{unname(id)}?show-reference-ids=true")

  reqs <- list(
    httr2::request(urls[1]),
    httr2::request(urls[2]))

  resps <- httr2::req_perform_parallel(reqs, on_error = "continue")

  af <- httr2::resp_body_json(resps[[1]], simplifyVector = TRUE)
  cl <- httr2::resp_body_json(resps[[2]], simplifyVector = TRUE)

  list(
    identifier = af$identifier,
    description = af$description,
    title = af$title,
    distribution = af$distribution$identifier,
    landing = af$landingPage,
    issued = af$issued,
    modified = af$modified,
    released = af$released,
    csv_url = af$distribution$data$downloadURL
    )

  list(
    identifier = cl$identifier,
    description = cl$description,
    title = cl$title,
    distribution = cl$distribution$identifier,
    landing = cl$landingPage,
    issued = cl$issued,
    modified = cl$modified,
    released = cl$released,
    csv_url = cl$distribution$data$downloadURL
  )
}

# url <- paste0("https://data.cms.gov/provider-data/api/1/datastore/sql?query=",
#               "[SELECT * FROM ", id$distribution$identifier, "]",
#               encode_param(args, type = "sql"),
#               "[LIMIT 10000 OFFSET ", offset, "];&show_db_columns")

#' Open Payments CMS Distributions
#'
#' @autoglobal
#'
#' @returns description
#'
#' @keywords internal
#'
#' @export
distributions_open <- function() {

  url <- paste0(
    "https://openpaymentsdata.cms.gov/",
    "api/1/metastore/schemas/dataset/",
    "items?show-reference-ids")

  httr2::request(url) |>
    httr2::req_perform() |>
    httr2::resp_body_json(
    response,
    check_type = FALSE,
    simplifyVector = TRUE) |>
    dplyr::tibble() # |>
    # dplyr::select(title, modified, distribution) |>
    # tidyr::unnest(cols = distribution) |>
    # tidyr::unnest(cols = data,
    #               names_sep = ".") |>
    # dplyr::arrange(dplyr::desc(title)) |>
    # dplyr::mutate(set  = strex::str_after_first(title, " "), .before = 1) |>
    # dplyr::select(set, identifier)
}
