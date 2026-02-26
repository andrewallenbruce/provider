# Provider Utilization & Demographics by Year

Access information on services and procedures provided to Original
Medicare (fee-for-service) Part B beneficiaries by physicians and other
healthcare professionals; aggregated by provider, service and geography.

## Usage

``` r
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
```

## Arguments

- year:

  `<int>` // **required** Year data was reported, in `YYYY` format. Run
  [`util_years()`](https://andrewallenbruce.github.io/provider/reference/years.md)
  to return a vector of the years currently available.

- type:

  `<chr>` // **required** dataset to query, `"Provider"`, `"Service"`,
  `"Geography"`

- npi:

  `<int>` 10-digit national provider identifier

- first, last, organization:

  `<chr>` Individual/Organizational provider's name

- credential:

  `<chr>` Individual provider's credentials

- gender:

  `<chr>` Individual provider's gender; `"F"` (Female), `"M"` (Male)

- entype:

  `<chr>` Provider entity type; `"I"` (Individual), `"O"` (Organization)

- city:

  `<chr>` City where provider is located

- state:

  `<chr>` State where provider is located

- zip:

  `<chr>` Provider’s zip code

- fips:

  `<chr>` Provider's state's FIPS code

- ruca:

  `<chr>` Provider’s RUCA code

- country:

  `<chr>` Country where provider is located

- specialty:

  `<chr>` Provider specialty code reported on the largest number of
  claims submitted

- par:

  `<lgl>` Identifies whether the provider participates in Medicare
  and/or accepts assignment of Medicare allowed amounts

- level:

  `<chr>` Geographic level by which the data will be aggregated:

  - `"State"`: Data is aggregated for each state

  - `"National"`: Data is aggregated across all states for a given HCPCS
    Code

- hcpcs:

  `<chr>` HCPCS code used to identify the specific medical service
  furnished by the provider

- drug:

  `<lgl>` Identifies whether the HCPCS code is listed in the Medicare
  Part B Drug Average Sales Price (ASP) File

- pos:

  `<chr>` Identifies whether the Place of Service (POS) submitted on the
  claims is a:

  - Facility (`"F"`): Hospital, Skilled Nursing Facility, etc.

  - Non-facility (`"O"`): Office, Home, etc.

- tidy:

  `<lgl>` // **default:** `TRUE` Tidy output

- nest:

  `<lgl>` // **default:** `TRUE` Nest `performance`, `demographics` and
  `conditions` columns

- detailed:

  `<lgl>` // **default:** `FALSE` Include nested `medical` and `drug`
  columns

- rbcs:

  `<lgl>` // **default:** `TRUE` Add Restructured BETOS Classifications
  to HCPCS codes

- na.rm:

  `<lgl>` // **default:** `TRUE` Remove empty rows and columns

- ...:

  Pass arguments to utilization().

## By Provider

**type =**`"Provider"`:

The **Provider** dataset allows the user access to data such as services
and procedures performed; charges submitted and payment received; and
beneficiary demographic and health characteristics for providers
treating Original Medicare (fee-for-service) Part B beneficiaries,
aggregated by year.

## By Provider and Service

**type =**`"Service"`:

The **Provider and Service** dataset is aggregated by:

1.  Rendering provider's NPI

2.  Healthcare Common Procedure Coding System (HCPCS) code

3.  Place of Service (Facility or Non-facility)

There can be multiple records for a given NPI based on the number of
distinct HCPCS codes that were billed and where the services were
provided. Data have been aggregated based on the place of service
because separate fee schedules apply depending on whether the place of
service submitted on the claim is facility or non-facility.

## By Geography and Service

**type =**`"Geography"`:

The **Geography and Service** dataset contains information on
utilization, allowed amount, Medicare payment, and submitted charges
organized nationally and state-wide by HCPCS code and place of service.

## Links

- [Medicare Physician & Other Practitioners: by Provider
  API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)

- [Medicare Physician & Other Practitioners: by Provider and Service
  API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)

- [Medicare Physician & Other Practitioners: by Geography and Service
  API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service)

*Update Frequency:* **Annually**

## Examples

``` r
if (FALSE) { # interactive()
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
}
```
