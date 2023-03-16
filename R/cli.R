#' provider_progress ------------------------------------------------------
provider_progress <- function() {
  cli::cli_progress_bar("Searching")
  while (TRUE) {
    if (1 < 0.01) break
    Sys.sleep(0.01)
    cli::cli_progress_update()
  }
  cli::cli_progress_update(force = TRUE)
}


#' noresults_cli ------------------------------------------------------------
#' @param apiname Name of API
#' @param url API url landing page
#' @autoglobal
#' @noRd
noresults_cli <- function(apiname, npi) {
    cli::cli_h1("{.api {apiname}}")
    cli::cli_text("NPI: {.npi {npi}}")
  cli::cli_alert_danger("Found 0 results")
}

#' results_cli ------------------------------------------------------------
#' @param apiname Name of API
#' @param url API url landing page
#' @autoglobal
#' @noRd
results_cli <- function(apiname, url, results) {

  if (nrow(results) > 0) {
    cli::cli_h1("{.api {apiname}}")
    cli::cli_text("URL: {.url {url}}")}
  cli::cli_alert_success("Found {nrow(results)} result{?s}")



}

#' provider_cli_2 ------------------------------------------------------------
#' @param apiname Name of API
#' @param resp httr2 response object
#' @param size size of responses downloaded
#' @autoglobal
#' @noRd
provider_cli_2 <- function(apiname, resp, size) {

  res_cnt <- resp$result_count

  if (as.numeric(res_cnt) == 0) {
    cli::cli_h2("Queried {.api {apiname}}")
    cli::cli_alert_warning("Found {res_cnt} result{?s}")
    cli::cli_alert_info("Downloaded {prettyunits::pretty_bytes(size)}")

  } else {
    cli::cli_h2("Queried {.api {apiname}}")
    cli::cli_alert_success("Found {res_cnt} result{?s}")
    cli::cli_alert_info("Downloaded {prettyunits::pretty_bytes(size)}")
  }
}
