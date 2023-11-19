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


  # collect results
  results <- list(
    ccn            = x,
    provider_type  = .pr_type,
    state          = .state,
    cms_type       = .cms_type)

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

  return(
    unname(states[x])
    )
}

#' Return the CCN CMS Provider type
#' @param x CMS Certification Number, of which the third character encodes the provider type.
#' @return character vector of a valid type or NA
#' @autoglobal
#' @noRd
ccn.cms <- function(x) {

  # if numeric, convert to character
  if(is.numeric(x)) x <- as.character(x)

  # split and unlist ccn
  x <- unlist(strsplit(x, ""), use.names = FALSE)

  # take the third character
  x <- x[3]

  # state code = state
  cms <- vctrs::vec_c(
    'P' = 'Medicare Provider (Organ Procurement Organization)',
    'B2' = 'California')

  return(
    unname(cms[x])
  )
}

#' Return the CCN Sequence Number
#' @param x CMS Certification Number, of which, and depending on certain
#'    conditionals, characters 4-10 encode the sequence number.
#' @return character vector of a valid sequence number or NA
#' @autoglobal
#' @noRd
ccn.sequence <- function(x) {

  # numeric -> character
  if(is.numeric(x)) x <- as.character(x)

  # split -> unlist
  x <- unlist(strsplit(x, ""), use.names = FALSE)

  # 3rd == number, include it
  if (grepl("^[[:digit:]]+$", x[3])) x <- x[3:length(x)]

  # 3rd == letter, skip it
  if (!grepl("^[[:digit:]]+$", x[3])) x <- x[4:length(x)]

  # collapse vector
  x <- paste0(x, collapse = "")

  # state code = state
  cms <- vctrs::vec_c(
    'P' = 'Medicare Provider (Organ Procurement Organization)',
    'B2' = 'California')

  return(
    unname(cms[x])
  )
}
