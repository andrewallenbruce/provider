#' @param title name of the api
#' @return A list of metadata describing each API's dataset
#' @examplesIf interactive()
#' metadata.store("Facility Affiliation Data")
#' metadata.store("National Downloadable File")
#' @autoglobal
#' @noRd
metadata.store <- function(title) {
  #------------------------------------------------
  url.store <- paste0('https://data.cms.gov/',
                      'provider-data/api/1/metastore/',
                      'schemas/dataset/items')

  response <- httr2::request(url.store) |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE)

  results <- response |>
    dplyr::tibble() |>
    dplyr::select(title,
                  issued,
                  modified,
                  released,
                  identifier,
                  landingPage,
                  publisher) |>
    tidyr::unnest(publisher) |>
    dplyr::select(-`@type`) |>
    dplyr::filter(title == {{ title }})

  results$issued   <- lubridate::ymd(results$issued)
  results$modified <- lubridate::ymd(results$modified)
  results$released <- lubridate::ymd(results$released)

  results <- make_interval(results, released)
  results$interval <- NULL
  store <- results

  #------------------------------------------------
  url.schema <- glue::glue('https://data.cms.gov/',
                           'provider-data/api/1/metastore/schemas/',
                           'dataset/items/{results$identifier}',
                           '?show-reference-ids=false')

  response <- httr2::request(url.schema) |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE)

  schema <- dplyr::tibble(
    title             = response$title,
    description       = response$description,
    uuid              = response$identifier,
    identifier        = response$keyword$identifier,
    distribution      = response$distribution$identifier,
    landing_page      = response$landingPage,
    publisher         = response$publisher$data$name,
    contact           = response$contactPoint$hasEmail,
    date_issued       = response$issued,
    date_modified     = response$modified,
    datetime_modified = response$`%modified`,
    date_released     = response$released)

  #------------------------------------------------
  url.query <- glue::glue('https://data.cms.gov/',
                          'provider-data/api/1/datastore/query/',
                          '{schema$distribution[1]}',
                          '?limit=1&offset=0&count=true&results=true',
                          '&schema=true&keys=true&format=json&rowIds=true')

  response <- httr2::request(url.query) |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE)

  query <- dplyr::tibble(
    rows = response$count,
    columns = length(names(response$results)),
    names = list(names(response$results)))

  #------------------------------------------------
  results <- list(
    title           = store$title,
    description     = schema$description[[1]],
    publisher       = store$name,
    uuid            = store$identifier,
    distribution    = schema$distribution[[1]],
    date_issued     = store$issued,
    date_modified   = store$modified,
    date_released   = store$released,
    period          = store$period,
    timelength_days = store$timelength_days,
    dimensions      = paste0(query$columns, ' columns x ', format(query$rows, big.mark = ","), ' rows'),
    fields          = query$names[[1]],
    landing_page    = store$landingPage,
    data_dictionary = "https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf"
  )
  return(results)
}

#' @param title name of the api
#' @param first only need the first row
#' @return A [tibble()] containing the updated ids.
#' @examplesIf interactive()
#' metadata.json("Medicare Fee-For-Service  Public Provider Enrollment")
#' metadata.json("Provider of Services File - Clinical Laboratories")
#' @autoglobal
#' @noRd
metadata.json <- function(title, first = TRUE) {

  resp <- httr2::request("https://data.cms.gov/data.json") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE, simplifyVector = TRUE)

  resp <- resp$dataset |>
    dplyr::tibble() |>
    dplyr::select(title,
                  description,
                  describedBy,
                  distribution,
                  landingPage,
                  modified,
                  references,
                  accrualPeriodicity,
                  temporal) |>
    dplyr::filter(title == {{ title }}) |>
    tidyr::unnest(references)

  dst <- resp |>
    dplyr::select(title,
                  distribution) |>
    tidyr::unnest(cols = distribution, names_sep = "_") |>
    #dplyr::filter(distribution_format == "API") |>
    dplyr::select(title,
                  distribution_title,
                  distribution_modified,
                  distribution_accessURL) |>
    dplyr::mutate(distribution_accessURL = strex::str_after_last(distribution_accessURL, "dataset/"),
                  distribution_accessURL = strex::str_before_last(distribution_accessURL, "/data")) |>
    dplyr::rename(distribution = distribution_accessURL)

  resp$distribution <- NULL

  results <- dplyr::left_join(resp, dst, by = dplyr::join_by(title)) |>
    dplyr::select(-title) |>
    dplyr::select(title = distribution_title,
                  description,
                  dictionary = describedBy,
                  methodology = references,
                  landing_page = landingPage,
                  distribution,
                  modified = distribution_modified,
                  accrualPeriodicity) |>
    dplyr::mutate(modified = lubridate::ymd(modified)) |>
    provider::make_interval(start = modified) |>
    tidyr::separate_wider_delim(title, delim = " : ", names = c("title", NA))

  results$interval <- NULL

  if (first) results <- dplyr::slice_head(results)

  url <- glue::glue('https://data.cms.gov/',
                    'data-api/v1/dataset/',
                    '{results$distribution}',
                    '/data-viewer?offset=0&size=1')

  response <- httr2::request(url) |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE)

  rows <- response$meta$total_rows
  cols <- response$meta$headers

  iso_8601 <- function(x) {
    dplyr::case_match(
      x,
      "R/P10Y" ~ "Decennial",
      "R/P4Y" ~ "Quadrennial",
      "R/P1Y" ~ "Annual",
      c("R/P2M", "R/P0.5M") ~ "Bimonthly",
      "R/P3.5D" ~ "Semiweekly",
      "R/P1D" ~ "Daily",
      c("R/P2W", "R/P0.5W") ~ "Biweekly",
      "R/P6M" ~ "Semiannual",
      "R/P2Y" ~ "Biennial",
      "R/P3Y" ~ "Triennial",
      "R/P0.33W" ~ "Three Times a Week",
      "R/P0.33M" ~ "Three Times a Month",
      "R/PT1S" ~ "Continuously Updated",
      "R/P1M" ~ "Monthly",
      "R/P3M" ~ "Quarterly",
      "R/P0.5M" ~ "Semimonthly",
      "R/P4M" ~ "Three Times a Year",
      "R/P1W" ~ "Weekly",
      "R/PT1H" ~ "Hourly")
  }

  results <- list(
    title           = results$title,
    description     = results$description,
    publisher       = " ",
    distribution    = results$distribution,
    update_schedule = iso_8601(results$accrualPeriodicity),
    date_modified   = results$modified,
    period          = results$period,
    timelength_days = results$timelength_days,
    dimensions      = paste0(length(cols), ' columns x ', format(rows, big.mark = ","), ' rows'),
    fields          = cols,
    landing_page    = results$landing_page,
    data_dictionary = results$dictionary,
    methodology     = results$methodology)

  return(results)
}

#' @param uuid distribution id of the api
#' @return A numeric vector containing the total rows in the dataset.
#' @examplesIf interactive()
#' metadata.rows('2457ea29-fc82-48b0-86ec-3b0755de7515') # providers()
#' metadata.rows('a85fa452-dee9-4c8f-8156-665238b8492f') # hospitals()
#' @autoglobal
#' @noRd
metadata.rows <- function(uuid) {

  url <- glue::glue('https://data.cms.gov/',
                    'data-api/v1/dataset/',
                    '{uuid}/data-viewer/stats')

  response <- httr2::request(url) |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE)

  return(as.integer(response$data$total_rows))
}

#' @param uuid distribution id of the api
#' @return A list containing the total columns and rows in the dataset,
#' as well as the column names.
#' @examplesIf interactive()
#' metadata.viewer('2457ea29-fc82-48b0-86ec-3b0755de7515') # providers()
#' metadata.viewer('a85fa452-dee9-4c8f-8156-665238b8492f') # hospitals()
#' @autoglobal
#' @noRd

metadata.viewer <- function(uuid) {

  url <- glue::glue('https://data.cms.gov/',
                    'data-api/v1/dataset/',
                    '{uuid}/data-viewer?offset=0&size=1')

  response <- httr2::request(url) |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE)

  rows <- response$meta$total_rows
  cols <- response$meta$headers

  list(
    dimensions = paste0(length(cols), ' columns x ', format(rows, big.mark = ","), ' rows'),
    fields = cols
  )
}
