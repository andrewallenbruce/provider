#' Medical Equipment Suppliers
#'
#' @description A list of Suppliers that indicates the supplies carried at that
#'   location and the supplier's Medicare participation status.
#'
#' @source
#'    * [API: Medical Equipment Suppliers](https://data.cms.gov/provider-data/dataset/ct36-nrcq)
#'
#' @param id `<chr>` provider identifier
#' @param par `<lgl>` description
#' @param org_dba `<chr>` desc
#' @param org_name `<chr>` desc
#' @param city,state,zip `<chr>` desc
#' @param specialty description
#' @param prov_type description
#' @param supplies `<int>` desc
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' supplier(count = TRUE)
#' supplier(state = "GA")
#' @export
supplier <- function(
  id = NULL,
  par = NULL,
  org_dba = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  specialty = NULL,
  prov_type = NULL,
  supplies = NULL,
  count = FALSE
) {
  x <- end_pdc(
    count = count,
    set = FALSE,
    provider_id = id,
    acceptsassignement = tag_bool(par),
    businessname = org_dba,
    practicename = org_name,
    practicecity = city,
    practicestate = state,
    practicezip9code = zip,
    specialitieslist = specialty,
    providertypelist = prov_type,
    supplieslist = supplies
  )

  x <- execute(x)

  polish(x)
}
