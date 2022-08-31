#' Reference Table for Provider Location Data
#'
#' Reference table of valid values for states and countries,
#' per the NPPES API documentation. In addition, features region
#' and division observations for US states.
#'
#' @format A data frame with 295 rows and 6 variables:
#' \describe{
#'   \item{country_abb}{NPPES-approved valid abbreviation value for country}
#'   \item{country_name}{NPPES-approved name value for country}
#'   \item{state_abb}{NPPES-approved valid abbreviation value for state}
#'   \item{state_name}{NPPES-approved valid name value for state}
#'   \item{state_region}{Region state belongs to, taken from base r states dataset}
#'   \item{state_division}{Division state belongs to, taken from base r states dataset}
#'   ...
#' }
#' @source \url{https://npiregistry.cms.hhs.gov/registry/API-State-Abbr}
#' @source \url{https://npiregistry.cms.hhs.gov/registry/API-Country-Abbr}
"nppes_location_reference"
