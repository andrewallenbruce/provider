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
  # cli::cat_rule(left = cli::style_bold(endpoint), width = 10)
  msg <- c(
    "{.strong {.arg {endpoint}}} returned ",
    "{.strong {nump(x)}} ",
    "{cli::qty(x)}result{?s}."
  )

  if (!x) {
    cli::cli_alert_warning(msg)
  } else {
    cli::cli_alert_success(msg)
  }
}

#' @noRd
cli_results2 <- function(x, endpoint) {
  cli_results(x = collapse::fsum(x), endpoint)

  cli::cat_bullet(
    paste0(
      cli::col_yellow(format(names(x), justify = "left")),
      cli::col_silver(" : "),
      format(nump(unname(x)), justify = "left")
    ),
    bullet_col = "silver"
  )
}

#' @noRd
cli_pages <- function(x, limit, endpoint) {
  cli_results(x, endpoint)
  PAGE <- offset(n = x, limit = limit)
  cli::cli_alert_info("Retrieving {.strong {PAGE}} page{?s}...")
}

#' @noRd
cli_pages2 <- function(x, limit, endpoint) {
  cli_results2(x, endpoint)
  PAGE <- collapse::fsum(cheapr::seq_size(0L, unlist_(x), limit))
  cli::cli_alert_info("Retrieving {.strong {PAGE}} page{?s}...")
}
