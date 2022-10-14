#' Search the National Library of Medicine's ICD-10-CM API
#'
#' @description [provider_icd10()] allows you to search the NLM's ICD-10-CM
#'    API by code or associated term.
#'
#' # NLM's Clinical Table Search Service ICD-10-CM API
#'
#' ICD-10-CM (International Classification of Diseases, 10th Revision,
#' Clinical Modification) is a medical coding system for classifying
#' diagnoses and reasons for visits in U.S. health care settings.
#' [Learn more about ICD-10-CM.](http://www.cdc.gov/nchs/icd/icd10cm.htm)
#'
#' ## Current Version
#' ICD-10-CM 2023
#'
#' ## Data Source
#' National Institute of Health/National Library of Medicine
#'
#' ## Links
#'  * [NIH NLM Clinical Table Service ICD-10-CM API](https://clinicaltables.nlm.nih.gov/apidoc/icd10cm/v3/doc.html)
#'
#' @param code All or part of an ICD-10-CM code
#' @param term Associated term describing an ICD-10 code
#' @param field options are "code" or "both"; default is "both"
#' @param limit API limit is 500; defaults to 10
#'
#' @return A [tibble()] containing the search results.
#'
#'
#' @examples
#' # Returns the seven codes beginning with "A15"
#'
#' provider_icd10(code = "A15")
#'
#' # Returns the first 20 codes associated with tuberculosis
#'
#' provider_icd10(term = "tuber", limit = 20)
#'
#' # Returns the two codes associated with pleurisy
#'
#' provider_icd10(term = "pleurisy")
#'
#' # If you're searching for codes beginning with a certain letter, you
#' # must set the `field` param to "code" or it will search for terms as well:
#'
#' # Returns terms containing the letter "Z"
#'
#' provider_icd10(code = "z")
#'
#' # Returns codes beginning with "Z"
#' provider_icd10(code = "z", field = "code")
#' @export

provider_icd10 <- function(code = NULL,
                           term = NULL,
                           field = "both",
                           limit = 10
) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # NIH Clinical Table Search Service ICD-10-CM API
  icd_url <- "https://clinicaltables.nlm.nih.gov/api/icd10cm/v3/search?"

  # Create request
  req <- httr2::request(icd_url)

  if (!is.null(field)) {

    # "code" allows searching for all codes by a single letter
    # "code,name" does not
    switch(field,
           "code" = field <- "code",
           "both" = field <- "code,name",
           stop("field must be either `code` or `both`.")
           )
    }

  # Create list of arguments
  arg <- stringr::str_c(c(code = code, term = term), collapse = ",")

  # Send and save response
  resp <- req |>
    httr2::req_url_query(terms = arg,
                         maxList = limit,
                         sf = field
                         ) |>
    httr2::req_perform()

  # Save time of API query
  datetime <- resp |> httr2::resp_date()

  # Parse JSON response and save results
  results <- resp |> httr2::resp_body_json(
    check_type = TRUE,
    simplifyVector = TRUE,
    simplifyMatrix = TRUE)

  results <- results[[4]]

  results <- results |> as.data.frame() |>
    dplyr::rename(icd_10_cm_code = V1,
                  icd_10_cm_term = V2) |>
    tibble::tibble()

  return(results)

}
