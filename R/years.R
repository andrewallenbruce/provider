#' Years Currently Searchable for APIs
#'
#' @returns integer vector of years available to search
#'
#' @examplesIf interactive()
#' # `beneficiaries()`
#' bene_years("year")
#' bene_years("month")
#'
#' # `open_payments()`
#' open_years()
#'
#' # `utilization()`
#' util_years()
#'
#' # `conditions()`
#' cc_years()
#'
#' # `quality_payment()`
#' qpp_years()
#'
#' # `outpatient()`
#' out_years
#'
#' @name years
#' @keywords internal
NULL

#' @rdname years
#' @autoglobal
#' @export
#' @keywords internal
open_years <- function() sort(open_ids("General Payment Data")$year)

#' @rdname years
#' @autoglobal
#' @export
#' @keywords internal
out_years <- function() {
  as.integer(cms_update("Medicare Outpatient Hospitals - by Provider and Service", "years"))
}

#' @rdname years
#' @autoglobal
#' @export
#' @keywords internal
util_years <- function() {
  as.integer(cms_update("Medicare Physician & Other Practitioners - by Provider", "years"))
}

#' @rdname years
#' @autoglobal
#' @export
#' @keywords internal
cc_years <- function() as.integer(cms_update("Specific Chronic Conditions", "years"))

#' @rdname years
#' @autoglobal
#' @export
#' @keywords internal
qpp_years <- function() as.integer(cms_update("Quality Payment Program Experience", "years"))

#' @param period One of `"year"` or `"month"`
#' @rdname years
#' @autoglobal
#' @export
#' @keywords internal
bene_years <- function(period = c("year", "month")) {
  if (period == "year")  {out <- beneficiaries(period = "Year", level = "National")$year}
  if (period == "month") {out <- beneficiaries(period = "January", level = "National")$year}
  return(as.integer(out))
}
