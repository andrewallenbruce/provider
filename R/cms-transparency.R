#' Hospital Price Transparency
#'
#' @description
#' Eligibility to order and refer within Medicare
#'
#' @references
#'    - [API: Medicare Order and Referring](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)
#'    - [CMS: Ordering & Certifying](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/chain-ownership-system-pecos/ordering-certifying)
#'
#' @param name `<chr>` Hospital name
#' @param address `<chr>` Hospital address
#' @param city `<chr>` Hospital city
#' @param state `<chr>` Hospital state
#' @param action `<chr>` Action taken by CMS following a Hospital Price Transparency Compliance Review
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' transparency(count = TRUE)
#' transparency(state = "GA", city = "Valdosta")
#' @autoglobal
#' @export
transparency <- function(
  name = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  action = NULL,
  count = FALSE
) {
  exec_cms(
    END = rlang::call_name(rlang::call_match()),
    COUNT = count,
    ARG = params(
      Hosp_Name = name,
      Hosp_Address = address,
      City = city,
      State = state,
      Action = action
    )
  )
}
