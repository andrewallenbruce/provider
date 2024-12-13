% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reassignments.R
\name{reassignments}
\alias{reassignments}
\title{Reassignment of Benefits}
\usage{
reassignments(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  last = NULL,
  state = NULL,
  specialty = NULL,
  organization = NULL,
  pac_org = NULL,
  enid_org = NULL,
  state_org = NULL,
  entry = NULL,
  tidy = TRUE,
  na.rm = TRUE,
  ...
)
}
\arguments{
\item{npi}{\verb{<chr>} \strong{Individual} 10-digit National Provider Identifier}

\item{pac}{\verb{<chr>} \strong{Individual} 10-digit PECOS Associate Control ID}

\item{enid}{\verb{<chr>} \strong{Individual} 15-digit Medicare Enrollment ID}

\item{first, last}{\verb{<chr>} \strong{Individual} Provider's name}

\item{state}{\verb{<chr>} \strong{Individual} Enrollment state abbreviation}

\item{specialty}{\verb{<chr>} \strong{Individual} Enrollment specialty}

\item{organization}{\verb{<chr>} \strong{Organizational} Legal business name}

\item{pac_org}{\verb{<chr>} \strong{Organizational} 10-digit PECOS Associate Control ID}

\item{enid_org}{\verb{<chr>} \strong{Organizational} 15-digit Medicare Enrollment ID}

\item{state_org}{\verb{<chr>} \strong{Organizational} Enrollment state abbreviation}

\item{entry}{\verb{<chr>} Entry type, reassignment (\code{"R"}) or employment (\code{"E"})}

\item{tidy}{\verb{<lgl>} // \strong{default:} \code{TRUE} Tidy output}

\item{na.rm}{\verb{<chr>} // \strong{default:} \code{TRUE} Remove empty rows and columns}

\item{...}{Empty}
}
\value{
A \link[tibble:tibble-package]{tibble} with the columns:\tabular{ll}{
   \strong{Field} \tab \strong{Description} \cr
   \code{npi} \tab \emph{Individual} National Provider Identifier \cr
   \code{pac} \tab \emph{Individual} PECOS Associate Control ID \cr
   \code{enid} \tab \emph{Individual} Medicare Enrollment ID \cr
   \code{first} \tab \emph{Individual} Provider's First Name \cr
   \code{last} \tab \emph{Individual} Provider's Last Name \cr
   \code{associations} \tab Number of Organizations \emph{Individual} Reassigns Benefits To \cr
   \code{pac_org} \tab \emph{Organization's} PECOS Associate Control ID \cr
   \code{enid_org} \tab \emph{Organization's} Medicare Enrollment ID \cr
   \code{state_org} \tab State \emph{Organization} Enrolled in Medicare \cr
   \code{reassignments} \tab Number of Individuals the \emph{Organization} Accepts Reassignment From \cr
   \code{entry} \tab Whether Entry is for \emph{Reassignment} or \emph{Employment} \cr
}
}
\description{
Returns information about:
\itemize{
\item Individual providers who are reassigning benefits or are an employee of
\item Organizational/Group providers who are receiving reassignment of benefits from or are the employer of the individual provider
}

It provides information regarding the physician and the group practice they
reassign their billing to, including individual employer association counts.
}
\section{Links}{

\itemize{
\item \href{https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list}{Medicare Revalidation Reassignment List API}
}

\emph{Update Frequency:} \strong{Monthly}
}

\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
reassignments(enid = "I20200929003184")

reassignments(pac = 9830437441)

reassignments(pac_org = 3173525888)
\dontshow{\}) # examplesIf}
}
