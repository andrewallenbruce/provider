% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nppes_npi.R
\name{nppes_npi}
\alias{nppes_npi}
\title{Search the NPPES National Provider Identifier Registry API}
\source{
Centers for Medicare & Medicaid Services
}
\usage{
nppes_npi(
  npi = NULL,
  prov_type = NULL,
  first = NULL,
  last = NULL,
  org_name = NULL,
  taxonomy = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  country = NULL,
  limit = 200,
  skip = NULL
)
}
\arguments{
\item{npi}{10-digit National Provider Identifier (NPI).}

\item{prov_type}{The Read API can be refined to retrieve only Individual
Providers (\code{NPI-1} or Type 1) or Organizational Providers (\code{NPI-2} or
Type 2.) When not specified, both Type 1 and Type 2 NPIs will be
returned. When using the Enumeration Type, it cannot be the only
criteria entered. Additional criteria must also be entered as well.}

\item{first}{Provider's first name. Applies to
\strong{Individual Providers (NPI-1)} only. Trailing wildcard entries are
permitted requiring at least two characters to be entered (e.g. "jo*" ).
This field allows the following special characters: ampersand(\code{&}),
apostrophe(\verb{,}), colon(\code{:}), comma(\verb{,}), forward slash(\code{/}),
hyphen(\code{-}), left and right parentheses(\verb{()}), period(\code{.}),
pound sign(\verb{#}), quotation mark(\verb{"}), and semi-colon(\verb{;}).}

\item{last}{Provider's last name. Applies to
\strong{Individual Providers (NPI-1)} only. Trailing wildcard entries are
permitted requiring at least two characters to be entered (e.g. "jo*" ).
This field allows the following special characters: ampersand(\code{&}),
apostrophe(\verb{,}), colon(\code{:}), comma(\verb{,}), forward slash(\code{/}),
hyphen(\code{-}), left and right parentheses(\verb{()}), period(\code{.}),
pound sign(\verb{#}), quotation mark(\verb{"}), and semi-colon(\verb{;}).}

\item{org_name}{Healthcare organization's name. Applies to
\strong{Organizational Providers (NPI-2)} only. Trailing wildcard entries are
permitted requiring at least two characters to be entered. All types of
Organization Names (LBN, DBA, Former LBN, Other Name) associated with an
NPI are examined for matching contents, therefore, the results might
contain an organization name different from the one entered in the
Organization Name criterion. This field allows the following special
characters: ampersand, apostrophe, "at" sign, colon, comma, forward
slash, hyphen, left and right parentheses, period, pound sign, quotation
mark, and semi-colon.}

\item{taxonomy}{Search for providers by their taxonomy by entering the
taxonomy description.}

\item{city}{City associated with the provider's address. To search for a
Military Address, enter either \code{APO} or \code{FPO} into the City field.
This field allows the following special characters: ampersand,
apostrophe, colon, comma, forward slash, hyphen, left and right
parentheses, period, pound sign, quotation mark, and semi-colon.}

\item{state}{State abbreviation associated with the provider's address.
This field \strong{cannot} be used as the only input criterion. If this
field is used, at least one other field, besides the \code{prov_type} and
\code{country}, must be populated. Valid values for state abbreviations:
\url{https://npiregistry.cms.hhs.gov/help-api/state}.}

\item{zip}{The Postal Code associated with the provider's address
identified in Address Purpose. If you enter a 5 digit postal code, it
will match any appropriate 9 digit (zip+4) codes in the data. Trailing
wildcard entries are permitted requiring at least two characters to be
entered (e.g., "21*").}

\item{country}{Country abbreviation associated with the provider's
address. This field \strong{can} be used as the only input criterion, as long
as the value selected \emph{is not} \strong{US} (United States). Valid values for
country abbreviations:
\url{https://npiregistry.cms.hhs.gov/help-api/country}.}

\item{limit}{Maximum number of results to return;
default is 200, maximum is 1200.}

\item{skip}{Number of results to skip after searching
the previous number; set in \code{limit}.}
}
\value{
A \link[tibble:tibble-package]{tibble} containing the search results.
}
\description{
\code{provider_nppes()} allows you to search the NPPES NPI
Registry's public API by many of the parameters defined in the
API's documentation.
}
\details{
The NPPES NPI Registry Public Search is a free directory of all
active National Provider Identifier (NPI) records. Healthcare providers
acquire their unique 10-digit NPIs to identify themselves in a standard
way throughout their industry. After CMS supplies an NPI, they publish
the parts of the NPI record that have public relevance, including the
provider???s name, taxonomy and practice address. It enables you to search
for providers in the NPPES (National Plan and Provider Enumeration
System.) All information produced by the NPI Registry is provided in
accordance with the NPPES Data Dissemination Notice. There is no charge
to use the NPI Registry.
\subsection{Links}{
\itemize{
\item \href{https://npiregistry.cms.hhs.gov/api-page}{NPPES NPI Registry API Documentation}
\item \href{https://npiregistry.cms.hhs.gov/demo-api}{NPPES NPI Registry API Demo}
}
}
}
\note{
Update Frequency: \strong{Weekly}
}
\examples{
\dontrun{
### Single NPI
nppes_npi(npi = 1528060837)

### City, state, country
nppes_npi(city = "Atlanta",
          state = "GA",
          country = "US")

### First name, city, state
nppes_npi(first = "John",
          city = "Baltimore",
          state = "MD")

nppes_npi(npi = 1336413418) # NPI-2
nppes_npi(npi = 1710975040) # NPI-1
nppes_npi(npi = 1659781227) # Deactivated

### List of NPIs
npi_list <- c(1003026055,
              1710983663,
              1316405939,
              1720392988,
              1518184605,
              1922056829,
              1083879860)

npi_list |>
purrr::map_dfr(nppes_npi) |>
dplyr::group_split(outcome)

### Data frame of NPIs
npi_df <- data.frame(npi = c(1710983663,
                             1003026055,
                             1316405939,
                             1720392988,
                             1518184605,
                             1922056829,
                             1083879860))
npi_df |>
tibble::deframe() |>
purrr::map_dfr(nppes_npi)

###Tribble example
tribble <- tibble::tribble(
~fn,         ~params,
"nppes_npi", list(1336413418),
"nppes_npi", list(1710975040),
"nppes_npi", list(1659781227),
"nppes_npi", list(first = "John", city = "Baltimore", state = "MD"),
"nppes_npi", list(first = "Andrew", city = "Atlanta", state = "GA"))

purrr::invoke_map_dfr(tribble$fn, tribble$params)
}
}
