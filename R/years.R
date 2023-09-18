#' Years Currently Searchable for APIs
#'
#' @returns integer vector of years available to search
#'
#' @seealso [open_payments()], [by_geography()], [by_provider()], [by_service()], [quality_payment()], [quality_eligibility()], [quality_stats()], [beneficiaries()]
#'
#' @examplesIf interactive()
#' bene_years("year")
#' bene_years("month")
#' open_years()
#' prac_years()
#' cc_years()
#' quality_years()
#' @name years
NULL

#' @rdname years
#' @autoglobal
#' @export
open_years <- function() {sort(open_ids("General Payment Data")$year)}

#' @rdname years
#' @autoglobal
#' @export
prac_years <- function() {
  as.integer(cms_update("Medicare Physician & Other Practitioners - by Geography and Service", "years"))
}

#' @rdname years
#' @autoglobal
#' @export
cc_years <- function() {
  as.integer(cms_update("Specific Chronic Conditions", "years"))
}

#' @autoglobal
#' @rdname years
#' @export
quality_years <- function() {
  as.integer(cms_update("Quality Payment Program Experience", "years"))
}

#' @param period One of `"year"` or `"month"`
#' @rdname years
#' @autoglobal
#' @export
bene_years <- function(period = c("year", "month")) {

  if (period == "year") {
    return(beneficiaries(period = "Year",
                         level = "National")$year)}

  if (period == "month") {
    return(beneficiaries(period = "January",
                         level = "National")$year)}
}
