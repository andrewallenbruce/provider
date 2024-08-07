% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utilization.R
\name{utilization}
\alias{utilization}
\alias{utilization_}
\title{Provider Utilization & Demographics by Year}
\usage{
utilization(
  year,
  type,
  npi = NULL,
  first = NULL,
  last = NULL,
  organization = NULL,
  credential = NULL,
  gender = NULL,
  entype = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  fips = NULL,
  ruca = NULL,
  country = NULL,
  specialty = NULL,
  par = NULL,
  level = NULL,
  hcpcs = NULL,
  drug = NULL,
  pos = NULL,
  tidy = TRUE,
  nest = TRUE,
  detailed = FALSE,
  rbcs = TRUE,
  na.rm = TRUE,
  ...
)

utilization_(year = util_years(), ...)
}
\arguments{
\item{year}{\verb{<int>} // \strong{required} Year data was reported, in \code{YYYY} format.
Run \code{\link[=util_years]{util_years()}} to return a vector of the years currently available.}

\item{type}{\verb{<chr>} // \strong{required} dataset to query, \code{"Provider"},
\code{"Service"}, \code{"Geography"}}

\item{npi}{\verb{<int>} 10-digit national provider identifier}

\item{first, last, organization}{\verb{<chr>} Individual/Organizational provider's
name}

\item{credential}{\verb{<chr>} Individual provider's credentials}

\item{gender}{\verb{<chr>} Individual provider's gender; \code{"F"} (Female), \code{"M"}
(Male)}

\item{entype}{\verb{<chr>} Provider entity type; \code{"I"} (Individual), \code{"O"}
(Organization)}

\item{city}{\verb{<chr>} City where provider is located}

\item{state}{\verb{<chr>} State where provider is located}

\item{zip}{\verb{<chr>} Provider’s zip code}

\item{fips}{\verb{<chr>} Provider's state's FIPS code}

\item{ruca}{\verb{<chr>} Provider’s RUCA code}

\item{country}{\verb{<chr>} Country where provider is located}

\item{specialty}{\verb{<chr>} Provider specialty code reported on the largest
number of claims submitted}

\item{par}{\verb{<lgl>} Identifies whether the provider participates in Medicare
and/or accepts assignment of Medicare allowed amounts}

\item{level}{\verb{<chr>} Geographic level by which the data will be aggregated:
\itemize{
\item \code{"State"}: Data is aggregated for each state
\item \code{"National"}: Data is aggregated across all states for a given HCPCS Code
}}

\item{hcpcs}{\verb{<chr>} HCPCS code used to identify the specific medical service
furnished by the provider}

\item{drug}{\verb{<lgl>} Identifies whether the HCPCS code is listed in the
Medicare Part B Drug Average Sales Price (ASP) File}

\item{pos}{\verb{<chr>} Identifies whether the Place of Service (POS) submitted on
the claims is a:
\itemize{
\item Facility (\code{"F"}): Hospital, Skilled Nursing Facility, etc.
\item Non-facility (\code{"O"}): Office, Home, etc.
}}

\item{tidy}{\verb{<lgl>} // \strong{default:} \code{TRUE} Tidy output}

\item{nest}{\verb{<lgl>} // \strong{default:} \code{TRUE} Nest \code{performance}, \code{demographics}
and \code{conditions} columns}

\item{detailed}{\verb{<lgl>} // \strong{default:} \code{FALSE} Include nested \code{medical} and
\code{drug} columns}

\item{rbcs}{\verb{<lgl>} // \strong{default:} \code{TRUE} Add Restructured BETOS
Classifications to HCPCS codes}

\item{na.rm}{\verb{<lgl>} // \strong{default:} \code{TRUE} Remove empty rows and columns}

\item{...}{Pass arguments to \code{\link[=utilization]{utilization()}}.}
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

\code{\link[=utilization]{utilization()}} allows access to information on services and
procedures provided to Original Medicare (fee-for-service) Part B
beneficiaries by physicians and other healthcare professionals; aggregated
by provider, service and geography.
}
\section{By Provider}{

\strong{type =}\code{"Provider"}:

The \strong{Provider} dataset allows the user access to data such as
services and procedures performed; charges submitted and payment received;
and beneficiary demographic and health characteristics for providers
treating Original Medicare (fee-for-service) Part B beneficiaries,
aggregated by year.
}

\section{By Provider and Service}{

\strong{type =}\code{"Service"}:

The \strong{Provider and Service} dataset is aggregated by:
\enumerate{
\item Rendering provider's NPI
\item Healthcare Common Procedure Coding System (HCPCS) code
\item Place of Service (Facility or Non-facility)
}

There can be multiple records for a given NPI based on the number of
distinct HCPCS codes that were billed and where the services were
provided. Data have been aggregated based on the place of service
because separate fee schedules apply depending on whether the place
of service submitted on the claim is facility or non-facility.
}

\section{By Geography and Service}{

\strong{type =}\code{"Geography"}:

The \strong{Geography and Service} dataset contains information on utilization,
allowed amount, Medicare payment, and submitted charges organized nationally
and state-wide by HCPCS code and place of service.
}

\section{Links}{

\itemize{
\item \href{https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider}{Medicare Physician & Other Practitioners: by Provider API}
\item \href{https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service}{Medicare Physician & Other Practitioners: by Provider and Service API}
\item \href{https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service}{Medicare Physician & Other Practitioners: by Geography and Service API}
}

\emph{Update Frequency:} \strong{Annually}
}

\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
utilization(year = 2020,
            type = 'Provider',
            npi = 1003000423)

utilization(year = 2019,
            type = 'Service',
            npi = 1003000126)

utilization(year = 2020,
            type = 'Geography',
            hcpcs = '0002A')

# Use the years helper function to
# retrieve results for every year:
util_years() |>
map(\(x) utilization(year = x,
                     type = 'Provider',
                     npi = 1043477615)) |>
list_rbind()

# Parallelized version
utilization_(type = 'Provider',
             npi = 1043477615)

utilization_(type = 'Service',
             npi = 1043477615)

utilization_(type = 'Geography',
             hcpcs = '0002A')
\dontshow{\}) # examplesIf}
}
