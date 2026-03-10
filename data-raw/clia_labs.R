## code to prepare `cdc_labs` dataset goes here
cdc_labs <- cheapr::fast_df(
  laboratory = c(
    "Artic Envestigations Program Laboratory",
    "Dengue Laboratory",
    "CDC/CGH/DGHA International Laboratory",
    "Infectious Diseases Laboratory",
    "National Center for Environmental Health, Division of Laboratory Science",
    "Vector-Borne Diseases Laboratory"
  ),
  ccn = c(
    "02D0873639",
    "40D0869394",
    "11D1061576",
    "11D0668319",
    "11D0668290",
    "06D0880233"
  ),
  city = c(
    "Anchorage",
    "San Juan",
    "Atlanta",
    "Atlanta",
    "Atlanta",
    "Fort Collins"
  ),
  state = c("AK", "PR", "GA", "GA", "GA", "CO")
) |>
  fastplyr::as_tbl()

usethis::use_data(cdc_labs, overwrite = TRUE, internal = TRUE)

#' # Wiregrass Georgia Tech College Student Health Center, Valdosta, GA
#' laboratories(ccn = "11D2306220")
#'
#' laboratories(ccn = "11D0265516")
