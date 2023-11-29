#' @param ccn CMS Certification Number, either 6 or 10 characters long
#' @return description
#' @autoglobal
#' @noRd
.ccn <- function(x) {

  # ccns must be <= 10 characters
  if (nchar(x) > 10L) {cli::cli_abort(c(
    "A {.strong CCN} cannot be more than {.emph 10 characters long}.",
    "x" = "{.val {x}} is {.val {nchar(x)}} characters long."),
    call = call)}

  # if numeric, convert to character
  if(is.numeric(x)) x <- as.character(x)

  # # step 1: character length encodes type
  .pr_type <- switch(as.character(nchar(x)),
                  "6"  = "Provider",
                  "10" = "Supplier",
                  NA_character_)

  # step 2: first two characters encode state
  .state <- ccn.state(x)

  # step 3: third character
  .third <- ccn.third(x)

  # step 4: sequence number
  .seq_no <- ccn.sequence(x)

  # step 5: facility ranges
  .fac_rng <- ccn.facility_ranges(.seq_no)


  # collect results
  results <- list(
    ccn = x,
    type = .pr_type,
    state = .state,
    third = .third,
    sequence_no = .seq_no,
    facility = .fac_rng
    )

  return(results)

}

#' Return the state where the entity is located
#' @param x CMS Certification Number, of which the first two characters encode the state of the entity's location.
#' @return character vector of a valid state or NA
#' @autoglobal
#' @noRd
ccn.state <- function(x) {

  # if numeric, convert to character
  if(is.numeric(x)) x <- as.character(x)

  # split and unlist ccn
  x <- unlist(strsplit(x, ""), use.names = FALSE)

  # take first two characters and collapse into one vector
  x <- paste0(x[1:2], collapse = "")

  # state code = state
  states <- vctrs::vec_c(
    '00' = 'Arizona',
    '01' = 'Alabama',
    '02' = 'Alaska',
    '03' = 'Arizona',
    '04' = 'Arkansas',
    '05' = 'California',
    '06' = 'Colorado',
    '07' = 'Connecticut',
    '08' = 'Delaware',
    '09' = 'District of Columbia',
    '10' = 'Florida',
    '11' = 'Georgia',
    '12' = 'Hawaii',
    '13' = 'Idaho',
    '14' = 'Illinois',
    '15' = 'Indiana',
    '16' = 'Iowa',
    '17' = 'Kansas',
    '18' = 'Kentucky',
    '19' = 'Louisiana',
    '20' = 'Maine',
    '21' = 'Maryland',
    '22' = 'Massachusetts',
    '23' = 'Michigan',
    '24' = 'Minnesota',
    '25' = 'Mississippi',
    '26' = 'Missouri',
    '27' = 'Montana',
    '28' = 'Nebraska',
    '29' = 'Nevada',
    '30' = 'New Hampshire',
    '31' = 'New Jersey',
    '32' = 'New Mexico',
    '33' = 'New York',
    '34' = 'North Carolina',
    '35' = 'North Dakota',
    '36' = 'Ohio',
    '37' = 'Oklahoma',
    '38' = 'Oregon',
    '39' = 'Pennsylvania',
    '40' = 'Puerto Rico',
    '41' = 'Rhode Island',
    '42' = 'South Carolina',
    '43' = 'South Dakota',
    '44' = 'Tennessee',
    '45' = 'Texas',
    '46' = 'Utah',
    '47' = 'Vermont',
    '48' = 'Virgin Islands',
    '49' = 'Virginia',
    '50' = 'Washington',
    '51' = 'West Virginia',
    '52' = 'Wisconsin',
    '53' = 'Wyoming',
    '54' = 'Idaho',
    '55' = 'California',
    '56' = 'Canada',
    '57' = 'New York',
    '58' = 'West Virginia',
    '59' = 'Mexico',
    '60' = NA,
    '61' = NA,
    '62' = NA,
    '63' = NA,
    '64' = 'American Samoa',
    '65' = 'Guam',
    '66' = 'Northern Marianas Islands',
    '67' = 'Texas',
    '68' = 'Florida',
    '69' = 'Florida',
    '70' = 'Kansas',
    '71' = 'Louisiana',
    '72' = 'Ohio',
    '73' = 'Pennsylvania',
    '74' = 'Texas',
    '75' = 'California',
    '76' = 'Iowa',
    '77' = 'Minnesota',
    '78' = 'Illinois',
    '79' = 'Missouri',
    '80' = 'Maryland',
    '81' = 'Connecticut',
    '82' = 'Massachusetts',
    '83' = 'New Jersey',
    '84' = 'Puerto Rico',
    '85' = 'Georgia',
    '86' = 'North Carolina',
    '87' = 'South Carolina',
    '88' = 'Tennessee',
    '89' = 'Arkansas',
    '90' = 'Oklahoma',
    '91' = 'Colorado',
    '92' = 'California',
    '93' = 'Oregon',
    '94' = 'Washington',
    '95' = 'Louisiana',
    '96' = 'New Mexico',
    '97' = 'Texas',
    '98' = NA,
    '99' = 'Foreign Countries (includes Canada and Mexico)',
    'A0' = 'California',
    'A1' = 'California',
    'A2' = "Florida",
    'A3' = "Louisiana",
    'A4' = 'Michigan',
    'A5' = 'Mississippi',
    'A6' = 'Ohio',
    'A7' = 'Pennsylvania',
    'A8' = 'Tennessee',
    'A9' = 'Texas',
    'B0' = 'Kentucky',
    'B1' = 'West Virginia',
    'B2' = 'California')

  code <- paste0('[', rlang::sym(x), ']')
  state <- unname(states[x])

  return(paste(state, code))
}

#' Return the CCN CMS Provider type
#' @param x CMS Certification Number, of which the third character encodes the provider type.
#' @return character vector of a valid type or NA
#' @autoglobal
#' @noRd
ccn.third <- function(x) {

  # if numeric, convert to character
  if(is.numeric(x)) x <- as.character(x)

  # split and unlist ccn
  x <- unlist(strsplit(x, ""), use.names = FALSE)

  return(x[3])
}

#' Return the CCN Sequence Number
#' @param x CMS Certification Number, of which, and depending on certain
#'    conditionals, characters 4-10 encode the sequence number.
#' @return character vector of a valid sequence number or NA
#' @autoglobal
#' @noRd
ccn.sequence <- function(x) {

  # numeric -> character
  if(is.character(x)) x <- as.integer(x)

  # split -> unlist
  x <- unlist(strsplit(as.character(x), ""), use.names = FALSE)

  # 3rd == number, include it
  if (grepl("^[[:digit:]]+$", x[3])) x <- x[3:length(x)]

  # 3rd == letter, skip it
  if (!grepl("^[[:digit:]]+$", x[3])) x <- x[4:length(x)]

  # collapse vector
  x <- paste0(x, collapse = "")

  x <- as.integer(x)

  return(x)
}

#' Return CCN Facility Ranges Information
#' @autoglobal
#' @noRd
ccn.facility_ranges <- function(code) {

  if (nchar(code) != 4 && isTRUE(grepl("^[[:digit:]]+$", code))) return("Invalid Code")

  code <- as.numeric(code)
  code_sym <- rlang::sym(as.character(code))

  ranges <- vctrs::vec_rbind(
    dplyr::tibble(type = "Short-term (General and Specialty) Hospital", start = 1L, end = 880L),
    dplyr::tibble(type = "Hospital participating in ORD demonstration project", start = 880L, end = 900L),
    dplyr::tibble(type = rep("Federally Qualified Health Center", 2), start = c(1000L, 1800L), end = c(1200L, 1990L)),
    dplyr::tibble(type = "Medical Assistance Facility", start = 1225L, end = 1300L),
    dplyr::tibble(type = "Critical Access Hospital", start = 1300L, end = 1400L),
    dplyr::tibble(type = rep("Community Mental Health Center", 3), start = c(1400L, 4600L, 4900L), end = c(1500L, 4800L, 5000L)),
    dplyr::tibble(type = "Hospice", start = 1500L, end = 1800L),
    dplyr::tibble(type = "Religious Non-medical Health Care Institution", start = 1990L, end = 2000L),
    dplyr::tibble(type = "Long-Term Care Hospital", start = 2000L, end = 2300L),
    dplyr::tibble(type = "Hospital-based Renal Dialysis Facility", start = 2300L, end = 2500L),
    dplyr::tibble(type = "Independent Renal Dialysis Facility", start = 2500L, end = 2900L),
    dplyr::tibble(type = "Independent Special Purpose Renal Dialysis Facility", start = 2900L, end = 3000L),
    dplyr::tibble(type = "Rehabilitation Hospital", start = 3025L, end = 3100L),
    dplyr::tibble(type = rep("Home Health Agency", 3), start = c(3100L, 7000L, 9000L), end = c(3200L, 8500L, 9800L)),
    dplyr::tibble(type = "Children's Hospital", start = 3300L, end = 3400L),
    dplyr::tibble(type = rep("Rural Health Clinic (Provider-based)", 3), start = c(3400L, 3975L, 8500L), end = c(3500L, 4000L, 8900L)),
    dplyr::tibble(type = rep("Rural Health Clinic (Free-standing)", 2), start = c(3800L, 8900L), end = c(3975L, 9000L)),
    dplyr::tibble(type = "Hospital-based Satellite Renal Dialysis Facility", start = 3500L, end = 3700L),
    dplyr::tibble(type = "Hospital-based Special Purpose Renal Dialysis Facility", start = 3700L, end = 3800L),
    dplyr::tibble(type = "Psychiatric Hospital", start = 4000L, end = 4500L),
    dplyr::tibble(type = rep("Comprehensive Outpatient Rehabilitation Facility", 3), start = c(3200L, 4500L, 4800L), end = c(3300L, 4600L, 4900L)),
    dplyr::tibble(type = "Skilled Nursing Facility", start = 5000L, end = 6500L),
    dplyr::tibble(type = "Outpatient Physical Therapy Services", start = 6500L, end = 6990L),
    dplyr::tibble(type = "Transplant Center", start = 9800L, end = 9900L),
    dplyr::tibble(type = "Number Reserved (formerly Christian Science Skilled Nursing)", start = 6990L, end = 7000L),
    dplyr::tibble(type = "Reserved for Future Use", start = 9900L, end = 10000L),
    dplyr::tibble(type = "Multiple Hospital Component in a Medical Complex (Number Retired)", start = 900L, end = 1000L),
    dplyr::tibble(type = "Alcohol/Drug Hospital (Number Retired)", start = 1200L, end = 1225L),
    dplyr::tibble(type = "Tuberculosis Hospital (Number Retired)", start = 3000L, end = 3025L)) |>
    dplyr::arrange(start) |>
    dplyr::mutate(range = ivs::iv(start, end), .keep = "unused")

  results <- ranges |>
    dplyr::mutate(is_between = ivs::iv_includes(range, {{ code }})) |>
    dplyr::filter(is_between == TRUE)

  if (vctrs::vec_is_empty(results)) {

    results <- dplyr::tibble(
      type = NA_character_,
      range = NA_integer_,
      is_between = NA_character_)

    start <- NA_integer_
    end <- NA_integer_

    results <- list(
      code = paste0('[', code_sym, ']'),
      type = results$type,
      range = paste0('[', start, ", ", end, ')'),
      text = paste0(results$type, " ",
             paste0('[', code_sym, ']'), ", in range ",
             paste0('[', start, ", ", end, ')')))
    return(results)
  }

  start <- ivs::iv_start(results$range)
  end <- ivs::iv_end(results$range)

  results <- list(
    code = paste0('[', code_sym, ']'),
    type = results$type,
    range = paste0('[', start, ", ", end, ')'),
    text = paste0(results$type, " ",
           paste0('[', code_sym, ']'), ", in range ",
           paste0('[', start, ", ", end, ')'))
  )
  return(results)
}
