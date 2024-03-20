#' Restructured BETOS Classification for HCPCS
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [betos()] allows the user to group HCPCS codes into clinically
#' meaningful categories based on the original _Berenson-Eggers Type of Service_
#' (BETOS) classification.
#'
#' @section From BETOS to RBCS:
#'
#' The Restructured BETOS Classification System (RBCS) is a taxonomy that allows
#' researchers to group Medicare Part B healthcare service codes into clinically
#' meaningful categories and subcategories.
#'
#' Based on the original Berenson-Eggers Type of Service (BETOS) classification
#' created in the 1980s, it includes notable updates such as Part B non-physician
#' services and undergoes annual updates by a technical expert panel of
#' researchers and clinicians.
#'
#' The general framework for grouping service codes into the new RBCS taxonomy
#' largely follows the same structure of BETOS. Like BETOS, the RBCS groups
#' HCPCS codes into categories, subcategories, and families – with categories
#' as the most aggregate level and families as the more granular level.
#'
#' All Medicare Part B service codes, including non-physician services, are
#' assigned to a 6-character RBCS taxonomy code.
#'
#' @section Links:
#'
#' + [Restructured BETOS Classification System](https://data.cms.gov/provider-summary-by-type-of-service/provider-service-classifications/restructured-betos-classification-system)
#' + [RBCS Data Dictionary](https://data.cms.gov/resources/restructured-betos-classification-system-data-dictionary)
#'
#' @section Update Frequency: Annually
#'
#' @param hcpcs < *character* > HCPCS or CPT code
#' @param rbcs < *character* > RBCS ID
#' @param category < *character* > RBCS Category Description, e.g.
#' + Anesthesia
#' + DME
#' + E&M
#' + Imaging
#' + Other
#' + Procedure
#' + Test
#' + Treatment
#' @param subcategory < *character* > RBCS Subcategory Description
#' @param family < *character* > RBCS Family Description
#' @param procedure < *character* > Whether the HCPCS code is a Major (`"M"`),
#' Other (`"O"`), or Non-Procedure code (`"N"`).
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param ... Empty
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**          |**Description**                              |
#' |:------------------|:--------------------------------------------|
#' |`hcpcs`            |HCPCS or CPT code                            |
#' |`rbcs_id`          |RBCS Identifier                              |
#' |`category`         |RBCS Category                                |
#' |`subcategory`      |RBCS Subcategory                             |
#' |`family`           |RBCS Family                                  |
#' |`procedure`        |RBCS Major Procedure Indicator               |
#' |`hcpcs_start_date` |Date HCPCS Code was added                    |
#' |`hcpcs_end_date`   |Date HCPCS Code was no longer effective      |
#' |`rbcs_start_date`  |Earliest Date that the RBCS ID was effective |
#' |`rbcs_end_date`    |Latest Date that the RBCS ID can be applied  |
#'
#' @examplesIf interactive()
#' betos(hcpcs = "0001U")
#' betos(category = "Test")
#' betos(subcategory = "General Laboratory")
#' betos(family = "Immunoassay")
#' betos(procedure = "M")
#' betos(family = "No RBCS Family")
#' betos(rbcs = "TL001N")
#' @autoglobal
#' @export
betos <- function(hcpcs = NULL,
                  rbcs = NULL,
                  category = NULL,
                  subcategory = NULL,
                  family = NULL,
                  procedure = NULL,
                  tidy = TRUE,
                  ...) {

  args <- dplyr::tribble(
    ~param,             ~arg,
    "HCPCS_Cd",         hcpcs,
    "RBCS_ID",          rbcs,
    "RBCS_Cat_Desc",    category,
    "RBCS_Subcat_Desc", subcategory,
    "RBCS_Family_Desc", family,
    "RBCS_Major_Ind",   procedure)

  response <- httr2::request(build_url("bet", args)) |>
    httr2::req_perform()

  if (vctrs::vec_is_empty(response$body)) {

    cli_args <- dplyr::tribble(
      ~x,             ~y,
      "hcpcs",        hcpcs,
      "rbcs",         rbcs,
      "category",     category,
      "subcategory",  subcategory,
      "family",       family,
      "procedure",    procedure) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))

  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (tidy) {
    results <- tidyup(results, dtype = 'mdy', dt = 'dt') |>
      dplyr::mutate(rbcs_major_ind = fct_maj(rbcs_major_ind)) |>
      cols_betos()
  }
  return(results)
}

#' @autoglobal
#' @noRd
fct_maj <- function(x) {
  factor(x, levels = c("N", "M", "O"),
         labels = c("Non-procedure", "Major", "Other"))
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_betos <- function(df) {

  cols <- c('hcpcs'            = 'hcpcs_cd',
            'rbcs_id',
            # 'rbcs_cat',
            'category'         = 'rbcs_cat_desc',
            # 'rbcs_cat_subcat',
            'subcategory'      = 'rbcs_subcat_desc',
            # 'rbcs_fam_numb',
            'family'           = 'rbcs_family_desc',
            'procedure'        = 'rbcs_major_ind',
            'hcpcs_start_date' = 'hcpcs_cd_add_dt',
            'hcpcs_end_date'   = 'hcpcs_cd_end_dt',
            'rbcs_start_date'  = 'rbcs_assignment_eff_dt',
            'rbcs_end_date'    = 'rbcs_assignment_end_dt')

  df |> dplyr::select(dplyr::any_of(cols))
}

#' @param df data frame
#' @autoglobal
#' @noRd
rbcs_util <- function(df) {

  rbcs <- df |>
    dplyr::distinct(hcpcs) |>
    dplyr::pull(hcpcs) |>
    purrr::map(\(x) betos(hcpcs = x)) |>
    purrr::list_rbind()

  if (vctrs::vec_is_empty(rbcs)) {

    return(df)

  } else {
    rbcs <- dplyr::select(rbcs, hcpcs, category, subcategory, family, procedure)
    cols_util(dplyr::full_join(df, rbcs, by = dplyr::join_by(hcpcs)), "rbcs")
  }
}
