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
distros_main <- \(datasets = api_names("main")) {

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

  resp <- req_perform_parallel(
    map(urls, request),
    on_error = "continue") |>
    setNames(names(ids))

  af <- resp_body_json(getelem(resp, "affiliations"), simplifyVector = TRUE)

  cl <- resp_body_json(getelem(resp, "clinicians"), simplifyVector = TRUE)


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

  resp <- request(url) |>
    req_perform() |>
    resp_body_json(
    check_type = FALSE,
    simplifyVector = TRUE) |>
    as.data.table() |>
    fmutate(
      year = strex::str_before_first(temporal, "-"),
    description = stringfish::sf_gsub(
      strex::str_before_first(
        description, " \\["),
      "\n", ". ",
      fixed = TRUE,
      nthreads = 4L)) |>
    fselect(
      year,
      title,
      identifier,
      issued,
      modified,
      distribution,
      periodicity = accrualPeriodicity)

  nests <- fselect(resp, year, identifier, distribution) |>
    mlr3misc::unnest("distribution", prefix = "{col}_") |>
    mlr3misc::unnest("distribution_data", prefix = "{col}_") |>
    fselect(
      year,
      identifier,
      distro_id = distribution_identifier,
      distro_title = distribution_data_title,
      distro_csv = distribution_data_downloadURL)

  list(
    root = resp,
    nests = nests
  )
}

# url <- paste0("https://data.cms.gov/provider-data/api/1/datastore/sql?query=",
#               "[SELECT * FROM ", id$distribution$identifier, "]",
#               encode_param(args, type = "sql"),
#               "[LIMIT 10000 OFFSET ", offset, "];&show_db_columns")
