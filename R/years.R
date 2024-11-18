#' Years Currently Searchable for APIs
#'
#' @returns integer vector of years available to search
#'
#' @examples
#' # `beneficiaries()`
#' bene_years(period = "Year")
#'
#' bene_years(period = "Month")
#'
#' # `open_payments()`
#' open_years()
#'
#' # `utilization()`
#' util_years()
#'
#' # `conditions()`
#' # cc_years()
#'
#' # `quality_payment()`
#' qpp_years()
#'
#' # `outpatient()`
#' out_years()
#'
#' # `prescribers()`
#' rx_years()
#'
#' @name years
#'
#' @keywords internal
#'
NULL

#' @rdname years
#'
#' @keywords internal
#'
#' @autoglobal
#'
#' @export
open_years <- function() {
  sort(
    open_ids(
      "General Payment Data")$year
  )
}

#' @rdname years
#'
#' @keywords internal
#'
#' @autoglobal
#'
#' @export
out_years <- function() {
  as.integer(
    cms_update(
      "Medicare Outpatient Hospitals - by Provider and Service",
      "years"
      )
    )
}

#' @rdname years
#'
#' @keywords internal
#'
#' @autoglobal
#'
#' @export
rx_years <- function() {
  as.integer(
    cms_update(
      "Medicare Part D Prescribers - by Provider",
      "years"
      )
    )
}

#' @rdname years
#'
#' @keywords internal
#'
#' @autoglobal
#'
#' @export
util_years <- function() {
  as.integer(
    cms_update(
      "Medicare Physician & Other Practitioners - by Provider",
      "years"
      )
    )
}

#' @rdname years
#'
#' @keywords internal
#'
#' @autoglobal
#'
#' @export
qpp_years <- function() {
  as.integer(
    cms_update(
      "Quality Payment Program Experience",
      "years"
    )
  )
}

#' @param period `<chr>` One of `"Year"` or `"Month"`
#'
#' @rdname years
#'
#' @keywords internal
#'
#' @autoglobal
#'
#' @export
bene_years <- function(period = c("Year", "Month")) {

  period <- match.arg(period)

  if (period == "Year") { # NOT WORKING
      out <- beneficiaries(
        period = "Year",
        level  = "National",
        tidy   = FALSE)$YEAR
    }

  if (period == "Month") {
      out <- beneficiaries(
        period = "January",
        level  = "National",
        tidy   = FALSE)$YEAR
  }
  return(as.integer(out))
}
