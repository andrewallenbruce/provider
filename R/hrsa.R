#' HRSA Facilities
#'
#' @param ms `<MapServer>` String indicating what to retrieve.
#' @param fl `<FeatureLayer>`
#' @param facility Facility type
#' @returns A list of endpoints.
#' @name hrsa
#' @examples
#' (MS <- hrsa_open())
#' hrsa_items(MS)
#' (FL <- hrsa_layers(MS))
#' hrsa_fields("asc", FL)
#' hrsa_select("asc", FL)
#' @autoglobal
#' @export

#' @rdname hrsa
#' @export
hrsa_open <- function() {
  # https://data.hrsa.gov/tools/web-services/registration#serviceInfo
  url <- "https://gisportal.hrsa.gov/server/rest/services/FeatureServices/CMSApprovedFacilities_FS/MapServer"
  arcgislayers::arc_open(url)
}

#' @rdname hrsa
#' @export
hrsa_layers <- function(ms) {
  arcgislayers::get_all_layers(ms)
}

#' @rdname hrsa
#' @export
hrsa_items <- function(ms) {
  arcgislayers::list_items(ms)
}

#' @rdname hrsa
#' @export
hrsa_fields <- function(facility, fl) {
  I <- switch(
    facility,
    hospital = "0",
    cah = "1",
    fqhc = "2",
    rhc = "3",
    hospice = "4",
    icf = "5",
    asc = "6",
    snf = "7",
    snf_dual = "8",
    snf_dist = "9",
    nursing = "10"
  )
  arcgislayers::list_fields(fl$layers[[I]])
}

#' @rdname hrsa
#' @export
hrsa_select <- function(facility, fl) {
  I <- switch(
    facility,
    hospital = "0",
    cah = "1",
    fqhc = "2",
    rhc = "3",
    hospice = "4",
    icf = "5",
    asc = "6",
    snf = "7",
    snf_dual = "8",
    snf_dist = "9",
    nursing = "10"
  )
  arcgislayers::arc_select(fl$layers[[I]], geometry = FALSE)
}
