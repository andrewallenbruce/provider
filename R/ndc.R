#' National Drug Code (NDC) Lookup
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' @section NDC:
#' A National Drug Code (NDC) is a unique 10- or 11-digit, 3-segment numeric
#' identifier assigned to each medication listed under Section 510 of the US
#' Federal Food, Drug, and Cosmetic Act.
#'
#' @section RxCUI:
#' An RxCUI is a machine-readable code or identifier that points to the common
#' meaning shared by the various source names grouped and assigned to a particular concept.
#'
#' RxNorm provides normalized names for clinical drugs and links its names to
#' many of the drug vocabularies commonly used in pharmacy management and drug
#' interaction software, including those of First Databank, Micromedex, Multum,
#' and Gold Standard Drug Database. By providing links between these vocabularies,
#' RxNorm can mediate messages between systems not using the same software and vocabulary.
#'
#' @section ATC:
#' ATC classifies drugs at five different levels. Each level is a different
#' grouping of drugs. Groupings of active substances include the organ or system
#' on which the drug acts as well as therapeutic, pharmacological, and chemical
#' properties of the drug.
#'
#' The Anatomical Therapeutic Chemical (ATC) classification was developed as a
#' modification and extension of the EphMRA classification system. In the ATC
#' classification system, the active substances are classified in a hierarchy
#' with five different levels.
#'
#' The system has fourteen main anatomical/pharmacological groups or
#' __1st Levels__.
#'
#' Each ATC main group is divided into __2nd Levels__ which could be either
#' pharmacological or therapeutic groups.
#'
#' The __3rd and 4th Levels__ are chemical, pharmacological or therapeutic
#' subgroups and the __5th Level__ is the chemical substance.
#'
#' The 2nd, 3rd and 4th levels are often used to identify pharmacological
#' subgroups when that is considered more appropriate than therapeutic or
#' chemical subgroups.
#'
#' @section Links:
#' + [ATCs](https://www.whocc.no/atc/structure_and_principles/)
#' + [RxNorm](https://www.nlm.nih.gov/research/umls/rxnorm/overview.html)
#'
#' @examples
#' ndc_lookup("0002-1433-80")
#'
#' @examplesIf interactive()
#' medline("0002-1433-80")
#' rxnorm("0002-1433-80")
#'
#' @param ndc < *character* > // **required** 10- to 11-digit National Drug Code
#' @return A [tibble][tibble::tibble-package] with the columns:
#' @autoglobal
#' @export
ndc_lookup <- function(ndc) {

  med <- ndc |>
    purrr::map(\(x) medline(ndc = x)) |>
    purrr::list_rbind()

  rx <- ndc |>
    purrr::map(\(x) rxnorm(ndc = x)) |>
    purrr::list_rbind()

  rx |>
    dplyr::full_join(med, by = "ndc") |>
    dplyr::arrange(ndc)
}

#' Medline Plus API
#' @param ndc < *character* > // **required** 10- to 11-digit National Drug Code
#' @return A [tibble][tibble::tibble-package] with the columns:
#' @autoglobal
#' @export
#' @keywords internal
medline <- function(ndc) {

  http <- "https://connect.medlineplus.gov/service?"
  cd   <- glue::glue("mainSearchCriteria.v.c={ndc}")
  sys  <- "mainSearchCriteria.v.cs=2.16.840.1.113883.6.69"
  fmt  <- "knowledgeResponseType=application/json"

  request <- httr2::request(
    glue::glue("{http}{cd}&{sys}&{fmt}")) |>
    httr2::req_perform()

  response <- httr2::resp_body_json(request, simplifyVector = TRUE)

  if (vctrs::vec_is_empty(response$feed$entry)) {
    cli_args <- dplyr::tibble(x = "NDC", y = ndc) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  results <- response$feed$entry |>
    tidyr::unnest(c(title, summary), names_sep = ".") |>
    dplyr::select(subject = title._value,
                  summary = summary._value) |>
    dplyr::mutate(ndc = ndc, .before = 1) |>
    dplyr::mutate(summary = stringr::str_squish(summary),
                  html = stringr::str_detect(summary, "<.*?>")) |>
    dplyr::filter(html == FALSE) |>
    dplyr::mutate(html = NULL)

  return(results)
}

#' RxNorm API
#' @param ndc < *character* > // **required** 10- to 11-digit National Drug Code
#' @return A [tibble][tibble::tibble-package] with the columns:
#' @autoglobal
#' @export
#' @keywords internal
rxnorm <- function(ndc) {

  rxcui      <- rxnorm::from_ndc(ndc)
  ndc_status <- rxnorm::get_ndc_status(ndc)
  drug_name  <- rxnorm::get_rx(rxcui)
  brand_name <- rxnorm::get_bn(rxcui)
  atc        <- rxnorm::get_atc(rxcui)
  atc_first  <- rxnorm::get_atc(rxcui, "first")
  atc_second <- rxnorm::get_atc(rxcui, "second")
  atc_third  <- rxnorm::get_atc(rxcui, "third")
  atc_fourth <- rxnorm::get_atc(rxcui, "fourth")

  dplyr::tibble(ndc        = ndc,
                rxcui      = rxcui,
                atc        = atc,
                status     = ndc_status,
                brand_name = brand_name,
                drug_name  = drug_name,
                atc_first  = atc_first,
                atc_second = atc_second,
                atc_third  = atc_third,
                atc_fourth = atc_fourth)
}
