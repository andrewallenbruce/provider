#' Format US ZIP codes -----------------------------------------------------
#' @param zip Nine-digit US ZIP code
#' @return ZIP code, hyphenated for ZIP+4 or 5-digit ZIP.
#' @examples
#' format_zipcode(123456789)
#' format_zipcode(12345)
#' @autoglobal
#' @noRd
format_zipcode <- function(zip) {zip <- as.character(zip)
  if (stringr::str_detect(zip, "^[[:digit:]]{9}$") == TRUE) {
  zip <- paste0(stringr::str_sub(zip, 1, 5), "-", stringr::str_sub(zip, 6, 9))
  return(zip)} else {return(zip)}}

#' Remove NULL elements from vector ----------------------------------------
#' @autoglobal
#' @noRd
remove_null <- function(x) {Filter(Negate(is.null), x)}

#' Clean up credentials ----------------------------------------------------
#' @param x Character vector of credentials
#' @return List of cleaned character vectors, with one list element per element
#'   of `x`
#' @autoglobal
#' @noRd
clean_credentials <- function(x) {
  if (!is.character(x)) {stop("x must be a character vector")}
  out <- gsub("\\.", "", x)
  out <- stringr::str_split(out, "[,\\s;]+", simplify = FALSE)
  return(out)
}

#' luhn check npis ---------------------------------------------------------
#' @description checks NPIs against the Luhn algorithm for
#' compliance with the CMS requirements stated in the linked PDF below.
#'
#' # Requirements for NPI Check Digit
#'
#' The National Provider Identifier (NPI) check digit is calculated using
#' the Luhn formula for computing the modulus 10 “double-add-double” check
#' digit. This algorithm is recognized as an ISO standard and is the specified
#' check digit algorithm to be used for the card issuer identifier on a
#' standard health identification card.
#'
#' When an NPI is used as a card issuer identifier on a standard health
#' identification card, it is preceded by the prefix `80840`, in which `80`
#' indicates health applications and `840` indicates the United States.
#'
#' The prefix is required only when the NPI is used as a card issuer
#' identifier. However, in order that any NPI could be used as a card issuer
#' identifier on a standard health identification card, the check digit will
#' always be calculated as if the prefix is present. This is accomplished by
#' adding the constant `24` in step 2 of the check digit calculation (as shown
#' in the second example below) when the NPI is used without the prefix.
#'
#' ## Example NPI Check Digit Calculation (Card Issuer Identifier)
#'
#' Assume that the NPI is `123456789`. If used as a card issuer identifier on
#' a standard health identification card, the full number would be
#' `80840123456789`. Using the Luhn formula on the identifier portion, the
#' check digit is calculated as follows:
#'
#' 1. Card issuer identifier without check digit: `80840123456789`
#' 2. Double the value of alternate digits, beginning with the rightmost
#'    digit: `0 8 2 6 10 14 18`
#' 3. Add the individual digits of products of doubling, plus unaffected
#'    digits:
#'    `8 + 0 + 8 + 8 + 0 + 2 + 2 + 6 + 4 + 1 + 0 + 6 + 1 + 4 + 8 + 1 + 8 = 67`
#' 4. Subtract from next higher number ending in zero: `70 – 67 = 3`
#' 5. The check digit equals 3, thus the card issuer identifier with check
#'    digit is **80840**123456789**3**.
#'
#' ## Example NPI Check Digit Calculation (without Prefix)
#'
#' Assume that the NPI is `123456789`. Using the Luhn formula on the
#' identifier portion, the check digit is calculated as follows:
#'
#' 1. NPI without check digit: `123456789`
#' 2. Double the value of alternate digits, beginning with the rightmost
#'    digit: `2 6 10 14 18`
#' 3. Add constant `24`, to account for the `80840` prefix that would be
#'    present on a card issuer identifier, plus the individual digits of
#'    products of doubling, plus unaffected digits:
#'    `24 + 2 + 2 + 6 + 4 + 1 + 0 + 6 + 1 + 4 + 8 + 1 + 8 = 67`
#' 4. Subtract from next higher number ending in zero: `70 – 67 = 3`
#' 5. The check digit equals **3**, thus the NPI with check digit
#'    is 123456789**3**.
#'
#' ## Links
#'  * [The Luhn Algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm)
#'  * [CMS NPI Standard](https://www.cms.gov/Regulations-and-Guidance/Administrative-Simplification/NationalProvIdentStand/Downloads/NPIcheckdigit.pdf)
#'
#' @param npi 10-digit National Provider Identifier (NPI).
#' @return boolean, `TRUE` or `FALSE`
#' @examples
#' # Valid NPI:
#' luhn_check(npi = 1528060837)
#'
#' # Quoted NPIs are valid:
#' luhn_check(npi = "1528060837")
#'
#' # Invalid NPI (per Luhn algorithm):
#' luhn_check(npi = 1234567891)
#'
#' \dontrun{
#' # NPIs with less than 10 digits throw an error:
#' luhn_check(npi = 123456789)
#'
#' # Inputting letters will throw an error, quoted or not:
#' luhn_check(npi = abcdefghij)
#' luhn_check(npi = "abcdefghij")
#' }
#' @autoglobal
#' @noRd
luhn_check <- function(npi = NULL) {

  # Return FALSE if not a number
  if (!grepl("^[[:digit:]]+$", npi)) {return(FALSE)}

  # Strip whitespace
  npi <- gsub(pattern = " ", replacement = "", npi)

  # Paste 80840 to each NPI number, per CMS documentation
  npi <- paste0("80840", npi)

  # Split string, Convert to list and reverse
  npi <- unlist(strsplit(npi, ""))
  npi <- npi[length(npi):1]
  to_replace <- seq(2, length(npi), 2)
  npi[to_replace] <- as.numeric(npi[to_replace]) * 2

  # Convert to numeric
  npi <- as.numeric(npi)

  # Must be a single digit, any that are > 9, subtract 9
  npi <- ifelse(npi > 9, npi - 9, npi)

  # Check if the sum divides by 10
  ((sum(npi) %% 10) == 0)
}

#' param_format ------------------------------------------------------------
#' @param param API parameter
#' @param arg API function arg
#' @return formatted API filters
#' @autoglobal
#' @noRd
param_format <- function(param, arg) {if (is.null(arg)) {param <- NULL}
  else {paste0("filter[", param, "]=", arg, "&")}}

#' param_space --------------------------------------------------------------
#' Some API parameters have spaces, these must be converted to "%20".
#' @param param parameter with a space
#' @return parameter formatted with "%20" in lieu of a space
#' @autoglobal
#' @noRd
param_space <- function(param) {gsub(" ", "%20", param)}

#' param_brackets -----------------------------------------------------------
#' Some API parameters have spaces, these must be converted to "%20".
#' @param param parameter with a space
#' @return parameter formatted with "%20" in lieu of a space
#' @autoglobal
#' @noRd
param_brackets <- function(param,
                           right = TRUE,
                           left = TRUE,
                           asterisk = TRUE) {
  param <- gsub("[", "%5B", param, fixed = TRUE)
  param <- gsub("*", "%2A", param, fixed = TRUE)
  param <- gsub("]", "%5D", param, fixed = TRUE)
  return(param)
}

#' sql_format ------------------------------------------------------------
#' @param param API parameter
#' @param arg API function arg
#' @return formatted API filters
#' @autoglobal
#' @noRd
sql_format <- function(param, arg) {
  if (is.null(arg)) {param <- NULL} else {
    paste0("[WHERE ", param, " = ", "%22", arg, "%22", "]")}}

#' str_to_snakecase --------------------------------------------------------
#' @param string string
#' @return string formatted to snakecase
#' @autoglobal
#' @noRd
str_to_snakecase <- function(string) {

  string |>
    purrr::map_chr(function(string) {
      string |> stringr::str_to_lower() |>
                stringr::str_c(collapse = "_")}) |>
    stringr::str_remove("^_") |>
    stringr::str_replace_all(c(" " = "_",
                               "/" = "_",
                               "-" = "_",
                               "__" = "_",
                               ":" = ""))
}

#' Convert Y/N char values to logical ----------------------
#' @param x vector
#' @autoglobal
#' @noRd
yn_logical <- function(x){
  dplyr::case_when(
    x == as.character("Y") ~ as.logical(TRUE),
    x == as.character("N") ~ as.logical(FALSE),
    TRUE ~ NA)
}


#' display_long ------------------------------------------------------------
#' @param df data frame
#' @autoglobal
#' @noRd
display_long <- function(df){

  df |> dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) |>
        tidyr::pivot_longer(dplyr::everything())
}


#' gt functions --------------------------------------------------------------
#' @param data data frame
#' @autoglobal
#' @noRd
gt_theme_provider <- function(data,...){
  data |>
    gt::opt_all_caps() |>
    gt::opt_row_striping() |>
    gt::opt_table_font(
      font = list(
        gt::google_font("Chivo"),
        gt::default_fonts())) |>
    gt::tab_style(
      style = gt::cell_borders(
        sides = "bottom",
        color = "transparent",
        weight = gt::px(2)),
      locations = gt::cells_body(
        columns = dplyr::everything(),
        rows = nrow(data$`_data`)))  |>
    gt::tab_options(
      footnotes.multiline = FALSE,
      footnotes.font.size = 12,
      footnotes.padding = gt::px(3),
      row_group.as_column = FALSE,
      row.striping.background_color = "#fafafa",
      table_body.hlines.color = "#f6f7f7",
      table.border.top.width = gt::px(3),
      table.border.top.color = "gray",
      table.border.bottom.color = "gray",
      table.border.bottom.width = gt::px(3),
      column_labels.border.top.width = gt::px(3),
      column_labels.border.top.color = "gray",
      column_labels.border.bottom.width = gt::px(3),
      column_labels.border.bottom.color = "#440D0D",
      column_labels.background.color = "#FDD4D0",
      data_row.padding = gt::px(3),
      source_notes.multiline = FALSE,
      source_notes.font.size = 12,
      source_notes.border.bottom.color = "#440D0D",
      source_notes.border.bottom.width = gt::px(3),
      table.font.size = 16,
      heading.background.color = "#FDD4D0",
      heading.align = "left",
      heading.title.font.size = 16,
      heading.title.font.weight = "bold",
      heading.subtitle.font.size = 14,
      heading.subtitle.font.weight = NULL,
      heading.padding = NULL,
      heading.padding.horizontal = NULL,
      heading.border.bottom.style = NULL,
      heading.border.bottom.width = NULL,
      heading.border.bottom.color = NULL,
      heading.border.lr.style = NULL,
      heading.border.lr.width = NULL,
      heading.border.lr.color = NULL,
      ...)
}

#' @noRd
gt_add_badge <- function(x){
  add_color <- if (x == "Individual") {
    "background: hsl(116, 60%, 90%); color: hsl(116, 30%, 25%);"
  } else if (x == "Organization") {
    "background: hsl(350, 70%, 90%); color: hsl(350, 45%, 30%);"
  } else if (x != "Individual" | x != "Organization") { x
  }
  div_out <- htmltools::div(
    style = paste("display: inline-block; padding: 2px 12px; border-radius: 15px; font-weight: 600; font-size: 16px;", add_color), x)
  as.character(div_out) |> gt::html()
}

#' @noRd
gt_check_xmark <- function(x) {
  add_checkx <- if (x == TRUE) {
    fontawesome::fa("circle-check", prefer_type = "solid", fill = "#F24141", height = "1.5em", width = "1.5em")
  } else if (x == "FALSE") {
    fontawesome::fa("circle-xmark", prefer_type = "solid", fill = "#F54444")
  } else if (x != "Individual" | x != "Organization") {
    x
  }
  div_out <- htmltools::div(style = paste("display: inline-block; padding: 2px 12px; border-radius: 15px; font-weight: 600; font-size: 16px;", add_checkx), x)
  as.character(div_out) |> gt::html()
}


#' readme function table ---------------------------------------------------
#' @autoglobal
#' @noRd
function_tbl    <- function() {
  nppes_func    <- gluedown::md_code("nppes_npi()")
  nppes_link    <- gluedown::md_link(
    "NPPES National Provider Identifier (NPI) Registry" = "https://npiregistry.cms.hhs.gov/search")
  open_func     <- gluedown::md_code("open_payments()")
  open_link     <- gluedown::md_link(
    "CMS Open Payments Program" = "https://openpaymentsdata.cms.gov/dataset/0380bbeb-aea1-58b6-b708-829f92a48202")
  mppe_func     <- gluedown::md_code("provider_enrollment()")
  mppe_link     <- gluedown::md_link(
    "Medicare Fee-For-Service Public Provider Enrollment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment")
  mme_func      <- gluedown::md_code("beneficiary_enrollment()")
  mme_link      <- gluedown::md_link(
    "Medicare Monthly Enrollment" = "https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment")
  miss_func     <- gluedown::md_code("missing_information()")
  miss_link     <- gluedown::md_link(
    "CMS Public Reporting of Missing Digital Contact Information" = "https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information")
  order_func    <- gluedown::md_code("order_refer()")
  order_link    <- gluedown::md_link(
    "Medicare Order and Referring" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring")
  opt_func      <- gluedown::md_code("opt_out()")
  opt_link      <- gluedown::md_link(
    "Medicare Opt Out Affidavits" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits")
  pbp_func      <- gluedown::md_code("physician_by_provider()")
  pbp_link      <- gluedown::md_link(
    "Medicare Physician & Other Practitioners: by Provider" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider")
  pbs_func      <- gluedown::md_code("physician_by_service()")
  pbs_link      <- gluedown::md_link(
    "Medicare Physician & Other Practitioners: by Provider and Service" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service")
  pbg_func      <- gluedown::md_code("physician_by_geography()")
  pbg_link      <- gluedown::md_link(
    "Medicare Physician & Other Practitioners: by Geography and Service" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service")
  redd_func     <- gluedown::md_code("revalidation_date()")
  redd_link     <- gluedown::md_link(
    "Medicare Revalidation Due Date" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list")
  rere_func     <- gluedown::md_code("revalidation_reassign()")
  rere_link     <- gluedown::md_link(
    "Medicare Revalidation Reassignment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list")
  recl_func     <- gluedown::md_code("revalidation_group()")
  recl_link     <- gluedown::md_link(
    "Medicare Revalidation Clinic Group Practice Reassignment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment")
  ccs_func      <- gluedown::md_code("cc_specific()")
  ccs_link      <- gluedown::md_link(
    "Medicare Specific Chronic Conditions" = "https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions")
  ccm_func      <- gluedown::md_code("cc_multiple()")
  ccm_link      <- gluedown::md_link(
    "Medicare Multiple Chronic Conditions" = "https://data.cms.gov/medicare-chronic-conditions/multiple-chronic-conditions")
  clia_func     <- gluedown::md_code("clia_labs()")
  clia_link     <- gluedown::md_link(
    "Medicare Provider of Services File - Clinical Laboratories" = "https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories")
  tax_func      <- gluedown::md_code("taxonomy_crosswalk()")
  tax_link      <- gluedown::md_link(
    "Medicare Provider and Supplier Taxonomy Crosswalk" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk")
  pend_func     <- gluedown::md_code("pending_applications()")
  pend_link     <- gluedown::md_link(
    "Medicare Pending Initial Logging and Tracking" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians")
  affil_func    <- gluedown::md_code("facility_affiliations()")
  affil_link    <- gluedown::md_link(
    "CMS Physician Facility Affiliations" = "https://data.cms.gov/provider-data/dataset/27ea-46a8")
  drclin_func   <- gluedown::md_code("doctors_and_clinicians()")
  drclin_link   <- gluedown::md_link(
    "Doctors and Clinicians National Downloadable File" = "https://data.cms.gov/provider-data/dataset/mj5m-pzi6")
  addph_func   <- gluedown::md_code("addl_phone_numbers()")
  addph_link   <- gluedown::md_link(
    "Physician Additional Phone Numbers" = "https://data.cms.gov/provider-data/dataset/phys-phon")
  hspen_func   <- gluedown::md_code("hospital_enrollment()")
  hspen_link   <- gluedown::md_link(
    "Hospital Enrollments" = "https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments")

  func_tbl <- data.frame(Function = c(nppes_func,
                                      open_func,
                                      mppe_func,
                                      mme_func,
                                      order_func,
                                      opt_func,
                                      pbp_func,
                                      pbs_func,
                                      pbg_func,
                                      redd_func,
                                      recl_func,
                                      rere_func,
                                      ccs_func,
                                      ccm_func,
                                      #clia_func,
                                      tax_func,
                                      miss_func,
                                      pend_func,
                                      affil_func,
                                      drclin_func,
                                      #addph_func,
                                      hspen_func
  ),
  API      = c(nppes_link,
               open_link,
               mppe_link,
               mme_link,
               order_link,
               opt_link,
               pbp_link,
               pbs_link,
               pbg_link,
               redd_link,
               recl_link,
               rere_link,
               ccs_link,
               ccm_link,
               #clia_link,
               tax_link,
               miss_link,
               pend_link,
               affil_link,
               drclin_link,
               #addph_link,
               hspen_link
  ))

  return(func_tbl)
}


#' Search the CMS Physician - Additional Phone Numbers API
#' #### Dataset API no longer available ##################
#' @description Dataset of additional phone numbers when clinicians have more
#'   than one phone number at a single practice address.
#'
#'   ## Links
#'   * [Physician - Additional Phone Numbers](https://data.cms.gov/provider-data/dataset/phys-phon)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param npi Unique clinician ID assigned by NPPES
#' @param pac_id_ind Unique individual clinician ID assigned by PECOS
#' @param pac_id_org Unique group ID assigned by PECOS to the group
#' @param first_name Individual clinician first name
#' @param last_name Individual clinician last name
#' @param middle_name Individual clinician middle name
#' @param city Group or individual's city
#' @param state Group or individual's state
#' @param zip Group or individual's ZIP code (9 digits when available)
#' @param offset offset; API pagination
#' @param clean_names Convert column names to snake case; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' #addl_phone_numbers(npi = 1407263999)
#' #addl_phone_numbers(pac_id_ind = "0042100190")
#' #addl_phone_numbers(pac_id_org = 6608028899)
#' #addl_phone_numbers(city = "Atlanta")
#' addl_phone_numbers(zip = 303421606)
#' }
#' @noRd

addl_phone_numbers <- function(npi           = NULL,
                               pac_id_ind   = NULL,
                               pac_id_org    = NULL,
                               first_name    = NULL,
                               middle_name   = NULL,
                               last_name     = NULL,
                               city          = NULL,
                               state         = NULL,
                               zip           = NULL,
                               offset        = 0,
                               clean_names   = TRUE) {

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,           ~y,
    "npi",        npi,
    "prvdr_id",   pac_id_ind,
    "frst_nm",    first_name,
    "mid_nm",     middle_name,
    "lst_nm",     last_name,
    "cty",        city,
    "st",         state,
    "zip",        zip,
    "org_pac_id", pac_id_org)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |> stringr::str_flatten()

  id <- "a12b0ee3-db05-5603-bd3e-e6f449797cb0"

  id_fmt <- paste0("[SELECT * FROM ", id, "]")

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query="
  post   <- paste0("[LIMIT 10000 OFFSET ", offset, "]&show_db_columns")
  url    <- paste0(http, id_fmt, params_args, post) |>
    param_brackets() |> param_space()

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.numeric(httr2::resp_header(resp, "content-length")) == 0) {
    return(tibble::tibble())
  } else {

    # parse response ---------------------------------------------------------
    results <- tibble::tibble(httr2::resp_body_json(resp,
                                                    check_type = FALSE, simplifyVector = TRUE)) |>
      dplyr::mutate(dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "N/A")))

  }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- dplyr::rename_with(results, str_to_snakecase)}

  return(results)
}

