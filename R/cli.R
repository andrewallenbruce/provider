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
cli_results <- function(x, endpoint) {
  msg <- c(
    "{.strong {endpoint}} returned ",
    "{.strong {mark(x)}} ",
    "{cli::qty(x)}result{?s}."
  )
  if (x == 0L) {
    cli::cli_alert_warning(msg)
  } else {
    cli::cli_alert_success(msg)
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
