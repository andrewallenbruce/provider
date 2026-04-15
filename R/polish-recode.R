#' @noRd
#' @autoglobal
RC_providers <- function(x) {
  collapse::mtt(
    x,
    npi = as.integer(npi),
    multi = bin_(multi)
  )
}

#' @noRd
#' @autoglobal
RC_pending <- function(x) {
  collapse::mtt(
    x,
    prov_type = as.character(prov_type),
    npi = as.integer(npi)
  )
}

#' @noRd
#' @autoglobal
RC_opt_out <- function(x) {
  collapse::mtt(
    x,
    npi = as.integer(npi),
    start_date = as_date(start_date, fmt = "%m/%d/%Y"),
    end_date = as_date(end_date, fmt = "%m/%d/%Y"),
    updated = as_date(updated, fmt = "%m/%d/%Y"),
    address = combine_(add_1, add_2),
    order_refer = bin_(order_refer),
    add_1 = NULL,
    add_2 = NULL
  )
}

#' @noRd
#' @autoglobal
RC_clinicians <- function(x) {
  collapse::mtt(
    x,
    npi = as.integer(npi),
    grad_year = as.integer(grad_year),
    specialty = combine_(specialty, spec_other),
    org_add = combine_(add_1, add_2),
    spec_other = NULL,
    add_1 = NULL,
    add_2 = NULL,
    ind = NULL,
    org = NULL,
    tlh = NULL
  )
}

#' @noRd
#' @autoglobal
RC_order_refer <- function(x) {
  collapse::mtt(
    x,
    npi = as.integer(npi),
    part_b = bin_(part_b),
    dme = bin_(dme),
    hha = bin_(hha),
    pmd = bin_(pmd),
    hospice = bin_(hospice)
  )
}

#' @noRd
#' @autoglobal
RC_transparency <- function(x) {
  collapse::mtt(
    x,
    id = as.integer(id),
    action_date = as_date(action_date)
  )
}
