#' Providers with Pending Medicare Enrollment Applications
#'
#' @description
#' `pending()` allows you to search for physicians & non-physicians with
#' pending Medicare enrollment applications.
#'
#' ### Links:
#'  - [Medicare Pending Initial Logging and Tracking Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)
#'  - [Medicare Pending Initial Logging and Tracking Non-Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)
#'
#' *Update Frequency:* **Weekly**
#'
#' @param npi National Provider Identifier (NPI) number
#' @param last_name Last name of provider
#' @param first_name First name of provider
#' @param type `physician` or `non-physician`
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' pending(last_name = "Smith", type = "non-physician")
#' pending(first_name = "John", type = "physician")
#'
#' @autoglobal
#' @export
pending <- function(type,
                    npi         = NULL,
                    last_name   = NULL,
                    first_name  = NULL,
                    tidy        = TRUE) {

  type <- rlang::arg_match(type, c("physician", "non-physician"))
  if (!is.null(npi)) {npi <- npi_check(npi)}

  # args tribble
  args <- dplyr::tribble(
    ~param,       ~args,
    "NPI",        npi,
    "LAST_NAME",  last_name,
    "FIRST_NAME", first_name)

  url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                id, "/data.json?", encode_param(args))

  if (type == "physician") {
    response <- httr2::request(build_url("ppe", args)) |> httr2::req_perform()}
  if (type == "non-physician") {
    response <- httr2::request(build_url("npe", args)) |> httr2::req_perform()}

  if (isTRUE(vctrs::vec_is_empty(response$body))) {

    cli_args <- dplyr::tribble(
      ~x,               ~y,
      "npi",            npi,
      "last_name",      last_name,
      "first_name",     first_name,
      "type",           type) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)

    return(invisible(NULL))
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(type = toupper(type))
    }
  return(results)
}
