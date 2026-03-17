#' @noRd
nump <- function(x) {
  prettyNum(x, big.mark = ",")
}

#' @noRd
cli_no_query <- function() {
  cli::cli_alert_warning(c(
    "{.emph No Query} ",
    cli::symbol$arrow_right,
    " Returning first {.strong 10} rows."
  ))
}

#' @noRd
cli_results <- function(x, endpoint) {
  cli::cli_alert_success(c(
    "{.strong {.arg {endpoint}}} returned ",
    "{.strong {nump(x)}} ",
    "{cli::qty(x)}result{?s}."
  ))
}

#' @noRd
cli_pages <- function(x, limit, endpoint) {
  cli_results(x, endpoint)
  cli::cli_alert_info(c(
    "Retrieving {.strong {offset(n = x, limit = limit)}} page{?s}..."
  ))
}

#' @noRd
cli_hybrid <- function(x, endpoint) {
  TOTAL <- collapse::fsum(x)

  cli::cli_alert_success(c(
    "{.strong {.arg {endpoint}}} returned ",
    "{.strong {nump(TOTAL)}} ",
    "{cli::qty(TOTAL)}result{?s}."
  ))
  cli::cat_bullet(
    paste0(
      format(names(x), justify = "left"),
      cli::col_silver(" : "),
      format(nump(unname(x)), justify = "left")
    ),
    bullet = "radio_on",
    bullet_col = "silver"
  )
}

#' @noRd
cli_hybrid_pages <- function(x, limit, endpoint) {
  PAGE <- collapse::fsum(cheapr::seq_size(0L, unlist_(x), limit))
  cli_hybrid(x, endpoint)
  cli::cli_alert_info("Retrieving {.strong {PAGE}} page{?s}...")
}
