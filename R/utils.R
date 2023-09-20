#' Format US ZIP codes
#' @param zip Nine-digit US ZIP code
#' @return ZIP code, hyphenated for ZIP+4 or 5-digit ZIP.
#' @examples
#' format_zipcode(123456789)
#' format_zipcode(12345)
#' @autoglobal
#' @noRd
format_zipcode <- function(zip) {
  zip <- as.character(zip)

  if (stringr::str_detect(zip, "^[[:digit:]]{9}$") == TRUE) {

    zip <- paste0(stringr::str_sub(zip, 1, 5), "-",
                  stringr::str_sub(zip, 6, 9))

    return(zip)

    } else {

      return(zip)
  }
}

#' Remove NULL elements from vector
#' @autoglobal
#' @noRd
remove_null <- function(x) {Filter(Negate(is.null), x)}

#' Clean up credentials
#' @param x Character vector of credentials
#' @return List of cleaned character vectors, with one list element per element
#'   of `x`
#' @autoglobal
#' @noRd
clean_credentials <- function(x) {

  if (!is.character(x)) {stop("x must be a character vector")}

  out <- gsub("\\.", "", x)

  return(out)
}

#' Convert True/False char values to logical
#' @param x vector
#' @autoglobal
#' @noRd
tf_logical <- function(x) {

  dplyr::case_when(
    x == "True" ~ as.logical(TRUE),
    x == "False" ~ as.logical(FALSE),
    .default = NA)
}

#' Convert empty char values to NA
#' @param x vector
#' @autoglobal
#' @noRd
na_blank <- function(x) {dplyr::na_if(x, "")}

#' Convert "*" char values to NA
#' @param x vector
#' @autoglobal
#' @noRd
na_star <- function(x) {dplyr::na_if(x, "*")}

#' Convert Y/N char values to logical
#' @param x vector
#' @autoglobal
#' @noRd
yn_logical <- function(x) {

  dplyr::case_match(
    x,
    c("Y", "YES", "Yes", "yes", "y", "True") ~ TRUE,
    c("N", "NO", "No", "no", "n", "False") ~ FALSE,
    .default = NA
  )
}

#' Convert TRUE/FALSE values to Y/N
#' @param x vector
#' @autoglobal
#' @noRd
tf_2_yn <- function(x) {

  dplyr::case_match(
    x,
    c(TRUE) ~ "Y",
    c(FALSE) ~ "N",
    .default = NULL
  )
}

#' Convert Place of Service values
#' @param x vector
#' @autoglobal
#' @noRd
pos_char <- function(x) {

    dplyr::case_match(x,
      c("facility", "Facility", "F", "f") ~ "F",
      c("office", "Office", "O", "o") ~ "O",
      .default = NULL)
  }

#' display_long
#' @param df data frame
#' @autoglobal
#' @noRd
display_long <- function(df) {

  df |> dplyr::mutate(dplyr::across(dplyr::everything(),
                                    as.character)) |>
        tidyr::pivot_longer(dplyr::everything())
}

#' creates a boilerplate tribble based on provided names
#' @param names column names
#' @param nrows fake data number of rows
#' @noRd
# create_tribble <- function(names = c("param", "arg"), nrows = 4){
#
#   header <- paste(paste(paste0("~", names), collapse = ", "), "\n")
#   base_val <- rep(NA, length(names))
#
#   row_vals <- dplyr::tibble(placeholder = rep(base_val, nrows)) |>
#     tibble::rowid_to_column() |>
#     dplyr::mutate(
#       placeholder = dplyr::case_when(rowid != max(rowid, na.rm = TRUE) ~ paste0(placeholder, ","), TRUE ~ placeholder),
#       placeholder = dplyr::case_when(rowid %% length(names) == 0 ~ paste0(placeholder, "\n\n"), TRUE ~ placeholder)) |>
#     dplyr::pull(placeholder) |>
#     paste(collapse = "")
#
#   out <- glue::glue("tribble(\n", paste0(header, ","), row_vals, ")") |> styler::style_text()
#
#   clipr::write_clip(out)
#   writeLines(out)
#   invisible(out)
#
# }


# tidyup <- function(df) {
#
#   janitor::clean_names(df) |>
#     dplyr::tibble() |>
#     dplyr::mutate(
#       dplyr::across(dplyr::where(is.character), na_blank),
#       dplyr::across(dplyr::where(is.character), na_star),
#
#       dplyr::across(dplyr::contains(c("date", "dt")), anytime::anydate),
#
#       dplyr::across(dplyr::contains(c("pac_id", "npi", "enroll_id")), as.character),
#
#       dplyr::across(dplyr::contains(c("tot_", "_hcpcs_cds", "_benes", "_srvcs", "_cnt", "num_org_mem", "grd_yr", "practice_size",
#                                       "years_in_medicare",
#                                       "medicare_patients",
#                                       "services")), as.integer),
#       dplyr::across(dplyr::contains(c("avg_", "amt", "chrg", "pct", "dollars", "prvlnc", "tot_mdcr_stdzd_pymt_pc", "tot_mdcr_pymt_pc", "hosp_readmsn_rate", "er_visits_per_1000_benes", "allowed_charges",
#                                       "payment_adjustment_percentage",
#                                       dplyr::contains("_score"),
#                                       "complex_patient_bonus",
#                                       "quality_improvement_bonus")), as.double),
#
#       dplyr::across(dplyr::any_of(c("entype", "rndrng_prvdr_ent_cd")), entype_char),
#       dplyr::across(dplyr::any_of("place_of_srvc"), pos_char),
#
#       dplyr::across(dplyr::contains(c("flag", "subgroup", "propriet", "subpart", "_ind", "telehlth", "partb", "hha", "dme", "pmd", "_sw", "eligible", "engaged",
#                                       "opted_into_mips",
#                                       "small_practitioner",
#                                       "rural_clinician",
#                                       "hpsa_clinician",
#                                       "ambulatory_surgical_center",
#                                       "hospital_based_clinician",
#                                       "non_patient_facing",
#                                       "facility_based",
#                                       "extreme_hardship",
#                                       "extreme_hardship_quality",
#                                       "quality_bonus",
#                                       "extreme_hardship_pi",
#                                       "pi_hardship",
#                                       "pi_reweighting",
#                                       "pi_bonus",
#                                       "extreme_hardship_ia",
#                                       "ia_study",
#                                       "extreme_hardship_cost")), yn_logical)
#     )
# }
