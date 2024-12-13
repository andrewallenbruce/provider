% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/years.R
\name{years}
\alias{years}
\alias{open_years}
\alias{out_years}
\alias{rx_years}
\alias{util_years}
\alias{qpp_years}
\alias{bene_years}
\title{Years Currently Searchable for APIs}
\usage{
open_years()

out_years()

rx_years()

util_years()

qpp_years()

bene_years(period = c("Year", "Month"))
}
\arguments{
\item{period}{\verb{<chr>} One of \code{"Year"} or \code{"Month"}}
}
\value{
integer vector of years available to search
}
\description{
Years Currently Searchable for APIs
}
\examples{
# `beneficiaries()`
bene_years(period = "Year")

bene_years(period = "Month")

# `open_payments()`
open_years()

# `utilization()`
util_years()

# `quality_payment()`
qpp_years()

# `outpatient()`
out_years()

# `prescribers()`
rx_years()

}
\keyword{internal}
