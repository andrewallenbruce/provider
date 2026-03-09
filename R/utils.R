#' @autoglobal
rename_ <- function(x, NM) {
  collapse::setrename(x, NM, .nse = FALSE)
  collapse::gv(x, unlist_(NM))
}

#' @autoglobal
api_provider <- function() {
  rex <- paste0(
    c(
      "Facility Affiliation Data",
      "National Downloadable File"
    ),
    collapse = "|"
  )

  RcppSimdJson::fload(
    "https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items"
  ) |>
    collapse::sbt(stringr::str_which(title, rex)) |>
    collapse::gv(c(
      "title",
      "released",
      "description",
      "identifier",
      "landingPage",
      "nextUpdateDate"
    )) |>
    collapse::roworderv(c("title", "released")) |>
    fastplyr::as_tbl()
}

#' @autoglobal
api_medicare <- function() {
  rex <- paste0(
    c(
      "Public Provider Enrollment",
      "Order and Refer",
      "Opt Out Affidavits",
      "Hospital Enrollment",
      "Clinical Laboratories",
      "Pending Initial",
      "Revalidation",
      "Medicare Physician & Other Practitioners",
      "Medicare Part D Prescribers",
      "Quality Payment Program Experience",
      "Rural Health Clinic",
      "Revoked Medicare Providers and Suppliers",
      "Hospital Price Transparency Enforcement Activities and Outcomes",
      "Federally Qualified Health Center"
    ),
    collapse = "|"
  )

  RcppSimdJson::fload(
    json = "https://data.cms.gov/data.json",
    query = "/dataset"
  ) |>
    collapse::sbt(stringr::str_which(title, rex)) |>
    collapse::gv(c("title", "modified", "description", "identifier")) |>
    collapse::roworderv(c("title", "modified")) |>
    fastplyr::as_tbl()
}

# state_recode(c("GA", "FL"))
# state_recode(c("Georgia", "Florida"), "abbr")
#' @autoglobal
#' @noRd
state_recode <- function(x, to = "full") {
  states <- switch(
    to,
    full = rlang::set_names(state.abb, state.name),
    abbr = rlang::set_names(state.name, state.abb)
  )

  rlang::names2(states)[collapse::fmatch(x, states)]
}


# set_args(providers)
#' @noRd
set_args <- function(fn) {
  rlang::fn_fmls(fn) |>
    as.list() |>
    list2env(envir = .GlobalEnv)
}

#' @noRd
map_na_if <- function(i) {
  purrr::modify_if(i, is.character, function(x) {
    vctrs::vec_slice(x, vctrs::vec_in(x, haystack = "")) <- NA_character_
    x
  })
}

#' @noRd
search_in <- function(x, column, what) {

  search_in_impl <- function(x, column, what) {
    vctrs::vec_slice(x, vctrs::vec_in(x[[column]], collapse::funique(what)))
  }

  if (is.null(what)) {
    return(x)
  }
  search_in_impl(x, column, what)
}

#' @noRd
unlist_ <- function(x) {
  unlist(x, use.names = FALSE)
}

#' @noRd
has_letter <- function(x) {
  grepl("[A-Z]", x, ignore.case = TRUE, perl = TRUE)
}

#' @noRd
is_numeric <- function(x) {
  !has_letter(x)
}
