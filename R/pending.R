#' Pending Medicare Enrollment Applications
#'
#' @description
#' Search for providers with pending Medicare enrollment applications.
#'
#' @references
#'    * [Medicare Pending Initial Logging and Tracking Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)
#'    * [Medicare Pending Initial Logging and Tracking Non-Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)
#'
#' @section Update Frequency:
#' __QUARTERLY__
#'
#' @param type < `character` > // __default:__ `"P"`
#'
#' Physician (`P`) or Non-physician (`N`)
#'
#' @param npi < `integer` >
#'
#' 10-digit National Provider Identifier
#'
#' @param first,last < `character` >
#'
#' Provider's name
#'
#' @param tidy < `boolean` > // __default:__ `TRUE`
#'
#' Tidy output
#'
#' @param ... Empty
#'
#' @return A [tibble()] with the columns:
#'
#' |**Field** |**Description**         |
#' |:---------|:-----------------------|
#' |`npi`     |10-digit individual NPI |
#' |`first`   |Provider's first name   |
#' |`last`    |Provider's last name    |
#' |`type`    |Type of Provider        |
#'
#' @examplesIf interactive()
#'
#' pending(type = "P", first = "John")
#'
#' pending(type = "N", last = "Smith")
#'
#' @autoglobal
#' @export
pending <- function(
  type = c("P", "N"),
  npi = NULL,
  first = NULL,
  last = NULL,
  tidy = TRUE,
  ...
) {
  type <- match.arg(type)

  args <- dplyr::tribble(
    ~param       , ~arg  ,
    "NPI"        , npi   ,
    "LAST_NAME"  , last  ,
    "FIRST_NAME" , first
  )
}
