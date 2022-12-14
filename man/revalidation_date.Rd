% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/revalidation_date.R
\name{revalidation_date}
\alias{revalidation_date}
\title{Search the Medicare Revalidation Due Date List API}
\source{
Centers for Medicare & Medicaid Services
}
\usage{
revalidation_date(
  enroll_id = NULL,
  npi = NULL,
  first_name = NULL,
  last_name = NULL,
  org_name = NULL,
  state = NULL,
  type_code = NULL,
  prov_type = NULL,
  specialty = NULL,
  month = "Latest",
  clean_names = TRUE,
  lowercase = TRUE
)
}
\arguments{
\item{enroll_id}{Enrollment ID}

\item{npi}{National Provider Identifier (NPI)}

\item{first_name}{First name of individual provider}

\item{last_name}{Last name of individual provider}

\item{org_name}{Legal business name of organizational provider}

\item{state}{Enrollment state}

\item{type_code}{Provider enrollment type code (\code{1} if \emph{Part A};
\code{2} if \emph{DME}; \code{3} if \emph{Non-DME Part B})}

\item{prov_type}{Provider type description}

\item{specialty}{Enrollment specialty}

\item{month}{dataset version, \code{Latest} is default; possible months are
\code{Feb}, \code{Apr}, \code{Jun}, \code{Jul}, \code{Aug}, \code{Sep}, \code{Oct}, \code{Nov},\code{Dec}}

\item{clean_names}{Clean column names with {janitor}'s
\code{clean_names()} function; default is \code{TRUE}.}

\item{lowercase}{Convert column names to lowercase; default is \code{TRUE}.}
}
\value{
A \link[tibble:tibble-package]{tibble} containing the search results.
}
\description{
Information on revalidation due dates for Medicare providers.
Medicare Providers must validate their enrollment record every three or
five years. CMS sets every Provider’s Revalidation due date at the end
of a month and posts the upcoming six to seven months of due dates
online. A due date of ‘TBD’ means that CMS has not set the due date yet.
These lists are refreshed every two months and two months’ worth of due
dates are appended to the list
}
\details{
The Revalidation Due Date List dataset contains revalidation due
dates for Medicare providers who are due to revalidate in the following
six months. If a provider's due date does not fall within the ensuing
six months, the due date is marked 'TBD'. In addition the dataset also
includes subfiles with reassignment information for a given provider
as well as due date listings for clinics and group practices and
their providers.
\subsection{Links}{
\itemize{
\item \href{https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list}{Medicare Revalidation Due Date API}
}
}
}
\note{
Update Frequency: \strong{Monthly}
}
\examples{
revalidation_date(enroll_id = "I20031110000070",
                  npi = 1184699621)

revalidation_date(first_name = "Eric",
                  last_name = "Byrd")

revalidation_date(state = "FL",
                  type_code = "3",
                  specialty = "General Practice")

revalidation_date(enroll_id = "O20110620000324",
                  org_name = "Lee Memorial Health System",
                  state = "FL",
                  prov_type = "DME",
                  type_code = "2")
\dontrun{
npi_list <- rep(c(1003026055,
                  1316405939,
                  1720392988,
                  1518184605),
                  each = 8)

months <- rep(c("Nov",
                "Oct",
                "Sep",
                "Aug",
                "Jul",
                "Jun",
                "Apr",
                "Feb"),
                times = 4)

purrr::map2_dfr(npi_list,
                months,
                ~revalidation_date(npi = .x,
                month = .y))
}
}
