#' @noRd
cli_red <- cli::combine_ansi_styles("red", "bold")

#' @noRd
left <- function(x, ...) {
  format(x, justify = "left", ...)
}

#' @noRd
cli_no_query <- function(endpoint) {
  # endpoint <- cli::cat_rule(left = cli_red(endpoint), width = 10)
  cli::cli_alert_warning(
    " {.strong {endpoint}} {cli::symbol$cross} {.emph No Query}"
  )
  cli::cli_alert_info("Returning first {.strong 10} rows...")
}

#' @noRd
cli_total <- function(x, endpoint) {
  msg <- c(
    "{.strong {endpoint}} has ",
    "{.strong {mark(x)}} total ",
    "{cli::qty(x)}row{?s}."
  )
  cli::cli_alert_info(msg)
}

#' @noRd
cli_total2 <- function(x, endpoint) {
  cli_total(x = sum2(x), endpoint)

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

  if (!x) {
    cli::cli_alert_warning(msg)
  } else {
    cli::cli_alert_success(msg)
  }
}

#' @noRd
cli_results2 <- function(x, endpoint) {
  cli_results(x = sum2(x), endpoint)

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
cli_pages <- function(x, limit, endpoint) {
  cli_results(x, endpoint)
  PAGE <- offset(n = x, limit = limit)
  cli::cli_alert_info("Retrieving {.strong {PAGE}} page{?s}...")
}

#' @noRd
cli_pages2 <- function(x, limit, endpoint) {
  cli_results2(x, endpoint)
  PAGE <- sum2(cheapr::seq_size(0L, unlist_(x), limit))
  cli::cli_alert_info("Retrieving {.strong {PAGE}} page{?s}...")
}
