% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/affiliations.R
\name{affiliations}
\alias{affiliations}
\title{Provider Facility Affiliations}
\usage{
affiliations(
  npi = NULL,
  pac = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  facility_type = NULL,
  facility_ccn = NULL,
  parent_ccn = NULL,
  offset = 0L,
  tidy = TRUE,
  na.rm = TRUE,
  ...
)
}
\arguments{
\item{npi}{\verb{<chr>} Unique 10-digit National Provider Identifier number issued
by CMS to US healthcare providers through NPPES.}

\item{pac}{\verb{<int>} Unique 10-digit Provider Associate-level Control ID (PAC),
assigned to each individual or organization in PECOS. The PAC ID links all
entity-level information (e.g., tax identification numbers and
organizational names) and may be associated with multiple enrollment IDs if
the individual or organization enrolled multiple times under different
circumstances.}

\item{first, middle, last}{\verb{<chr>} Individual provider's first/middle/last name}

\item{facility_type}{\verb{<chr>} Type of facility, one of the following:
\itemize{
\item \code{Hospital} (\code{hp})
\item \verb{Long-term care hospital} (\code{ltch})
\item \verb{Nursing home} (\code{nh})
\item \verb{Inpatient rehabilitation facility} (\code{irf})
\item \verb{Home health agency} (\code{hha})
\item \verb{Skilled nursing facility} (\code{snf})
\item \code{Hospice} (\code{hs})
\item \verb{Dialysis facility} (\code{df})
}}

\item{facility_ccn}{\verb{<chr>} 6-digit CMS Certification Number of facility or
unit within hospital where an individual provider provides service.}

\item{parent_ccn}{\verb{<int>} 6-digit CMS Certification Number of a sub-unit's
primary hospital, should the provider provide services in said unit.}

\item{offset}{\verb{<int>} API pagination, \strong{default} is \code{0L}}

\item{tidy}{\verb{<lgl>} Tidy output; \strong{default} is \code{TRUE}}

\item{na.rm}{\verb{<lgl>} Remove empty rows and columns; \strong{default} is \code{TRUE}}

\item{...}{Empty dots}
}
\value{
A \link[tibble:tibble-package]{tibble} containing the search results.
}
\description{
\code{\link[=affiliations]{affiliations()}} allows the user access to data concerning
providers' facility affiliations
}
\section{Links}{

\itemize{
\item \href{https://data.cms.gov/provider-data/dataset/27ea-46a8}{Physician Facility Affiliations}
\item \href{https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf}{Certification Number (CCN) State Codes}
}

\emph{Update Frequency:} \strong{Monthly}
}

\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
affiliations(parent_ccn = 670055)
\dontshow{\}) # examplesIf}
}
