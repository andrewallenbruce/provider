#' @noRd
cli_Pmsg <- function(PAGE) {
  cli::cli_alert_info("Retrieving {.strong {PAGE}} page{?s}...")
}

#' @noRd
cli_apis <- function(x) {
  cli::cat_bullet(
    paste0(
      cli::col_yellow(left(names(x))),
      cli::col_silver(" : "),
      left(mark(unname(x)))
    ),
    bullet_col = "silver"
  )
}

#' @noRd
cli_empty <- function(endpoint) {
  cli::cli_alert_warning(c(
    "{.strong {endpoint}} ",
    "{cli::symbol$pointer} ",
    "{.emph No Query}"
  ))
  cli::cli_alert_info("Returning first {.strong 10} rows...")
}

#' @noRd
cli_total <- function(x, endpoint) {
  cli::cli_alert_info(c(
    "{.strong {endpoint}} has ",
    "{.strong {mark(x)}} ",
    "{cli::qty(x)}row{?s}."
  ))
}

#' @noRd
cli_total2 <- function(x, endpoint) {
  cli_total(x = sum2(x), endpoint)
  cli_apis(x)
}

#' @noRd
cli_results <- function(x, endpoint) {
  if (x == 0L) {
    cli::cli_alert_warning(c(
      "{.strong {endpoint}} returned ",
      "{.strong {mark(x)}} ",
      "{cli::qty(x)}result{?s}."
    ))
  } else {
    cli::cli_alert_success(c(
      "{.strong {endpoint}} returned ",
      "{.strong {mark(x)}} ",
      "{cli::qty(x)}result{?s}."
    ))
  }
}

#' @noRd
cli_results2 <- function(x, endpoint) {
  cli_results(x = sum2(x), endpoint)
  cli_apis(x)
}

#' @noRd
cli_pages <- function(x, limit, endpoint) {
  cli_results(x, endpoint)
  cli_Pmsg(offset(n = x, limit = limit))
}

#' @noRd
cli_pages2 <- function(x, limit, endpoint) {
  cli_results2(x, endpoint)
  cli_Pmsg(sum2(cheapr::seq_size(0L, unlist_(x), limit)))
}
