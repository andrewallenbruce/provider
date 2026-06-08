# Linking Providers

``` r

library(provider)
```

> NPIs, PACs, ENIDs, CCNs, CLIAs and Many More

#### Individual Provider

``` r

pac <- affiliations(pac = 7810891009)
#> Error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.
list(
  individual = as.data.frame(t(unique(pac[1:5]))),
  organization = pac[6:8])
#> Error:
#> ! object 'pac' not found
```

``` r

ccn <- hospitals(ccn = pac$prov_ccn)
#> Error:
#> ! object 'pac' not found
ccn |> str()
#> Error:
#> ! object 'ccn' not found
```

#### Organizational Provider

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r

providers(org_name = "Elizabethtown Community Hospital")
#> Error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.
hospitals(org_name = "Elizabethtown Community Hospital")
#> Error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.
clinicians(org_name = "Elizabethtown Community Hospital")
#> Error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.
reassignments(org_name = "Elizabethtown Community Hospital")
#> Error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.
```

The **Hospital Enrollment** API includes only Medicare Part A (hospital)
providers, so we only get two rows back, but those include a new data
point: two facility CCNs. Plugging those into the **Facility
Affiliations** API, we can retrieve information on the individual
providers practicing at this hospital. First, the all-numeric CCN
(`331302`):

``` r

ccn <- affiliations(facility_ccn = 331302)
#> Error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.
list(
  organization = as.data.frame(t(unique(ccn[6:8]))),
  individual = unique(ccn[1:5]))
#> Error:
#> ! object 'ccn' not found
```

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r

ccn2 <- affiliations(facility_ccn = "33Z302")
#> Error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.
list(
  organization = as.data.frame(t(unique(ccn2[6:8]))), 
  individual = unique(ccn2[1:5]))
#> Error:
#> ! object 'ccn2' not found
```

That returns more affiliated individual providers that practice in the
Hospital’s nursing home.

> An *alphanumeric* CCN represents a `sub-unit` of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
