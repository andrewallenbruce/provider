% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format_api_params.R
\name{api_names}
\alias{api_names}
\title{CMS API Dataset Names Lookup}
\usage{
api_names(fn_name = "all")
}
\arguments{
\item{fn_name}{\verb{<chr>} function name, can be a regex pattern; default is \code{"all"}}
}
\value{
\verb{<chr>} API dataset name
}
\description{
CMS API Dataset Names Lookup
}
\examples{
api_names("quality_payment")

api_names("utilization")

api_names("provider")

api_names("provider$")

}
\keyword{internal}
