#' HRSA Facilities
#'
#' @description
#' Health Resources & Services Administration
#'
#' @details
#' Query modifiers are a small DSL for use in constructing query conditions.
#'
#' @param facility Facility type
#' @name hrsa
#' @returns A list of endpoints.
#' @examples
#' hrsa_items()
#' hrsa_layers()
#' hrsa_fields("snf_all")
#' @source [API: HRSA](https://data.hrsa.gov/tools/web-services/registration#serviceInfo)
NULL

#' @noRd
hrsa_open <- function() {
  # https://data.hrsa.gov/tools/web-services/registration#serviceInfo
  url <- "https://gisportal.hrsa.gov/server/rest/services/FeatureServices/CMSApprovedFacilities_FS/MapServer"
  arcgislayers::arc_open(url)
}

#' @noRd
hrsa_facility <- function(x) {
  switch(
    x,
    hospital = "0",
    cah = "1",
    fqhc = "2",
    rhc = "3",
    hospice = "4",
    icf = "5",
    asc = "6",
    snf_all = "7",
    snf_dual = "8",
    snf_dist = "9",
    nursing = "10",
    cli::cli_abort("{.var {x}} is not a facility.")
  )
}

#' @rdname hrsa
#' @export
hrsa_items <- function() {
  data_frame(arcgislayers::list_items(hrsa_open()))
}

#' @rdname hrsa
#' @export
hrsa_layers <- function() {
  arcgislayers::get_all_layers(hrsa_open())$layers
}

#' @rdname hrsa
#' @export
hrsa_fields <- function(facility) {
  arcgislayers::list_fields(hrsa_layers()[[hrsa_facility(facility)]])
}

#' @rdname hrsa
#' @export
hrsa_select <- function(facility, ...) {
  arcgislayers::arc_select(
    x = hrsa_layers()[[hrsa_facility(facility)]],
    geometry = FALSE,
    ...
  )
}
