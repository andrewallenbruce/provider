#' @autoglobal
#' @noRd
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
    collapse::roworder(title, released) |>
    fastplyr::as_tbl()
}

#' @autoglobal
#' @noRd
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
    collapse::roworder(title, modified) |>
    fastplyr::as_tbl()
}

# state_recode(c("GA", "FL"))
# state_recode(c("Georgia", "Florida"), "abbr")
#' @autoglobal
#' @noRd
state_recode <- function(x, to = "full") {
  states <- switch(
    match.arg(to, c("full", "abbr")),
    full = rlang::set_names(state.abb, state.name),
    abbr = rlang::set_names(state.name, state.abb)
  )

  rlang::names2(states)[collapse::fmatch(x, states)]
}


# set_args(providers)
#' @autoglobal
#' @noRd
set_args <- function(fn) {
  rlang::fn_fmls(fn) |>
    as.list() |>
    list2env(envir = .GlobalEnv)
}

#' @autoglobal
#' @noRd
na_if <- function(x, y = "") {
  vctrs::vec_slice(
    x,
    vctrs::vec_in(x, y, needles_arg = "x", haystack_arg = "y")
  ) <- NA
  x
}

#' @autoglobal
#' @noRd
map_na_if <- function(i) {
  purrr::modify_if(i, is.character, function(x) na_if(x, y = ""))
}

#' @noRd
search_in <- function(x, column, what) {
  if (is.null(what)) {
    return(x)
  }
  search_in_impl(x, column, what)
}

#' @noRd
search_in_impl <- function(x, column, what) {
  vctrs::vec_slice(x, vctrs::vec_in(x[[column]], collapse::funique(what)))
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

#' @noRd
`%nn%` <- function(x, y) if (!is.null(x)) y else x #nocov

#' @noRd
yn_logical <- function(x) {
  dplyr::case_match(
    x,
    c("Y", "YES", "Yes", "yes", "y", "True") ~ TRUE,
    c("N", "NO", "No", "no", "n", "False") ~ FALSE,
    .default = NA
  )
}

#' @noRd
tf_2_yn <- function(x) {
  dplyr::case_match(
    x,
    TRUE ~ "Y",
    FALSE ~ "N",
    .default = NA_character_
  )
}

#' @autoglobal
#' @noRd
abb2full <- function(
  abb,
  arg = rlang::caller_arg(abb),
  call = rlang::caller_env()
) {
  results <- dplyr::tibble(
    x = c(
      state.abb[1:8],
      'DC',
      state.abb[9:50],
      'AS',
      'GU',
      'MP',
      'PR',
      'VI',
      'UK'
    ),
    y = c(
      state.name[1:8],
      'District of Columbia',
      state.name[9:50],
      'American Samoa',
      'Guam',
      'Northern Mariana Islands',
      'Puerto Rico',
      'Virgin Islands',
      'Unknown'
    )
  ) |>
    dplyr::filter(x == abb) |>
    dplyr::pull(y)

  if (vctrs::vec_is_empty(results)) {
    cli::cli_abort(
      c("{.arg {arg}} is not a valid state abbreviation."), # nolint
      arg = arg,
      call = call
    )
  }
  return(results)
}

#' Pivot data frame to long format for easy printing
#' @param df data frame
#' @param cols columns to pivot long, default is [dplyr::everything()]
#' @autoglobal
#' @export
#' @keywords internal
display_long <- function(df, cols = dplyr::everything()) {
  df |>
    dplyr::mutate(
      dplyr::across(
        dplyr::everything(),
        as.character
      )
    ) |>
    tidyr::pivot_longer({{ cols }})
}

#' Convert data.frame cols to character
#' @param df data frame
#' @autoglobal
#' @export
#' @keywords internal
df2chr <- function(df) {
  df |>
    dplyr::mutate(
      dplyr::across(
        dplyr::where(is.numeric),
        as.character
      )
    )
}

#' Tidy a Data Frame
#' @param df data frame
#' @param dtype `mdy` or `ymd`
#' @param dt convert to date, default is 'date'
#' @param yn convert to logical
#' @param int convert to integer
#' @param dbl convert to double
#' @param chr convert to character
#' @param up convert to upper case
#' @param cred remove periods
#' @param zip normalize zip code
#' @param lgl convert to logical
#' @param cma remove commas
#' @returns tidy data frame
#' @autoglobal
#' @export
#' @keywords internal
tidyup <- function(
  df,
  dtype = NULL,
  dt = "date",
  yn = NULL,
  int = NULL,
  dbl = NULL,
  chr = NULL,
  up = NULL,
  cred = NULL,
  zip = NULL,
  lgl = NULL,
  cma = NULL
) {
  x <- janitor::clean_names(df) |>
    dplyr::tibble() |>
    dplyr::mutate(
      dplyr::across(dplyr::everything(), stringr::str_squish),
      dplyr::across(dplyr::where(is.character), na_blank)
    )

  if (!is.null(dtype)) {
    if (dtype == 'mdy') {
      x <- dplyr::mutate(
        x,
        dplyr::across(dplyr::contains(dt), ~ lubridate::mdy(.x, quiet = TRUE))
      )
    }
    if (dtype == 'ymd') {
      x <- dplyr::mutate(
        x,
        dplyr::across(dplyr::contains(dt), ~ lubridate::ymd(.x, quiet = TRUE))
      )
    }
  }

  if (!is.null(cma)) {
    x <- dplyr::mutate(x, dplyr::across(dplyr::contains(cma), clean_dollars))
  }
  if (!is.null(yn)) {
    x <- dplyr::mutate(x, dplyr::across(dplyr::contains(yn), yn_logical))
  }
  if (!is.null(int)) {
    x <- dplyr::mutate(x, dplyr::across(dplyr::contains(int), as.integer))
  }
  if (!is.null(dbl)) {
    x <- dplyr::mutate(x, dplyr::across(dplyr::contains(dbl), as.double))
  }
  if (!is.null(chr)) {
    x <- dplyr::mutate(x, dplyr::across(dplyr::contains(chr), as.character))
  }
  if (!is.null(up)) {
    x <- dplyr::mutate(x, dplyr::across(dplyr::contains(up), toupper))
  }
  if (!is.null(cred)) {
    x <- dplyr::mutate(
      x,
      dplyr::across(dplyr::contains(cred), clean_credentials)
    )
  }
  if (!is.null(zip)) {
    x <- x
  } # dplyr::mutate(x, dplyr::across(dplyr::contains(zip),  format_zipcode))
  if (!is.null(lgl)) {
    x <- dplyr::mutate(x, dplyr::across(dplyr::contains(lgl), as.logical))
  }

  return(x)
}

#' @noRd
combine <- function(df, nm, cols, sep = " ") {
  tidyr::unite(
    df,
    col = {{ nm }},
    dplyr::any_of(cols),
    remove = TRUE,
    na.rm = TRUE,
    sep = sep
  )
}

#' @noRd
narm <- function(df) {
  janitor::remove_empty(df, which = c("rows", "cols"))
}

#' @noRd
format_cli <- function(df) {
  x <- purrr::map2(
    df$x,
    df$y,
    stringr::str_c,
    sep = " = ",
    collapse = ""
  )

  cli::cli_alert_danger(
    "No results for {.val {x}}",
    wrap = TRUE
  )
}
