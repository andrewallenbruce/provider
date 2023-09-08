% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/beneficiaries.R
\name{beneficiaries}
\alias{beneficiaries}
\title{Search the Medicare Monthly Enrollment API}
\source{
Centers for Medicare & Medicaid Services
}
\usage{
beneficiaries(
  year = NULL,
  period = NULL,
  level = NULL,
  state = NULL,
  state_name = NULL,
  county = NULL,
  fips = NULL,
  tidy = TRUE
)
}
\arguments{
\item{year}{Calendar year of Medicare enrollment; current options are
\code{2017 - 2022}}

\item{period}{Time frame of Medicare enrollment; options are \code{Year}, \code{Month} or any
month within the 12-month time span of the month in the data set's version
name (listed \href{https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment/api-docs}{here})}

\item{level}{Geographic level of data; options are \code{National}, \code{State},
or \code{County}}

\item{state}{Two-letter state abbreviation of beneficiary residence}

\item{state_name}{Full state name of beneficiary residence}

\item{county}{County of beneficiary residence}

\item{fips}{FIPS code of beneficiary residence}

\item{tidy}{Tidy output; default is \code{TRUE}.}
}
\value{
A \link[tibble:tibble-package]{tibble} containing the search results.
}
\description{
Current information on the number of Medicare
beneficiaries with hospital/medical coverage and prescription
drug coverage, available for several geographical areas.
}
\details{
The Medicare Monthly Enrollment data provides current
monthly information on the number of Medicare beneficiaries
with hospital/medical coverage and prescription drug coverage,
available for several geographic areas including national,
state/territory, and county. The hospital/medical coverage
data can be broken down further by health care delivery
(Original Medicare versus Medicare Advantage and Other
Health Plans) and the prescription drug coverage data can
be examined by those enrolled in stand-alone Prescription
Drug Plans and those enrolled in Medicare Advantage
Prescription Drug plans. The dataset includes enrollee
counts on a \emph{rolling 12 month basis} and also provides
information on yearly trends. The dataset is based on
information gathered from CMS administrative enrollment
data for beneficiaries enrolled in the Medicare program
available from the CMS Chronic Conditions Data Warehouse.
\subsection{Links}{
\itemize{
\item \href{https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment}{Medicare Monthly Enrollment}
}
}
}
\note{
Update Frequency: \strong{Monthly}
}
\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
beneficiaries(year = NULL,
              period = "Year",
              level = "County",
              state = "AL",
              county = "Autauga")

beneficiaries(year = 2021, level = "County", fips = "01001")

beneficiaries(year = 2022,
                       period = "July",
                       level = "State",
                       state_name = "Georgia")

beneficiaries(level = "State", fips = "10")
\dontshow{\}) # examplesIf}
}