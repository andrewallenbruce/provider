
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `provider` <img src="man/figures/logo.svg" align="right" height="150" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Project Status: WIP - Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://choosealicense.com/licenses/mit/)
[![code
size](https://img.shields.io/github/languages/code-size/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider)
[![last
commit](https://img.shields.io/github/last-commit/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider/commits/main)
[![Codecov test
coverage](https://codecov.io/gh/andrewallenbruce/provider/branch/main/graph/badge.svg)](https://app.codecov.io/gh/andrewallenbruce/provider?branch=main)
<!-- badges: end -->

The goal of `provider` is to provide performant and reliable open-source
tools to facilitate easy access to [healthcare
provider](https://en.wikipedia.org/wiki/Health_care_provider) data
through publicly available APIs & sources. The current list of supported
APIs are:

<br>

- [NPPES National Provider Identifier (NPI) Registry
  API](https://npiregistry.cms.hhs.gov/search)
- [Medicare Fee-For-Service Public Provider Enrollment
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
- [Medicare Order and Referring
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
- [Medicare Provider and Supplier Taxonomy Crosswalk
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)
- [Medicare Physician & Other Practitioners
  API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
- [Medicare Revalidation Due Date
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
- [Medicare Revalidation Clinic Group Practice Reassignment
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)
- [Medicare Opt Out Affidavits
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
- [Medicare Market Saturation & Utilization State-County
  API](https://data.cms.gov/summary-statistics-on-use-and-payments/program-integrity-market-saturation-by-type-of-service/market-saturation-utilization-state-county)
- [Medicare Provider of Services File - Clinical Laboratories
  API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)
- [CMS Public Reporting of Missing Digital Contact Information
  API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)

<br>

Search for Providers:

- `provider_nppes()` : by NPI, name, location, organization, taxonomy,
  etc.
- `provider_mppe()` : who are actively approved to bill Medicare.
- `provider_moar()` : who are legally eligible to order and refer in the
  Medicare program.
- `provider_mooa()` : that have opted out of Medicare, along with their
  effective dates.
- `provider_mpstc()` : eligible to enroll in Medicare programs with the
  proper provider taxonomy code.
- `provider_mrdd()` : who are due to revalidate in the following six
  months.
- `provider_mpop()` : and their utilization data across three related
  datasets and eight years.
- `provider_promdci()` : who do not have adequate contact information in
  the NPPES system.
- `provider_rcgpr()` : and the group practice they reassign their
  billing to.

## Installation

You can install the development version of `provider` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andrewallenbruce/provider")

# install.packages("remotes")
remotes::install_github("andrewallenbruce/provider")
```

<br>

## Provider Information

These APIs are generally concerned with providing access to up-to-date
information a provider or her associates may need for many aspects of
the transacting of healthcare.

### NPPES NPI Public Registry

<br>

``` r
# Load library
library(provider)

# Define NPI parameter
npi <- 1083879860

# Query the NPPES API by NPI
# and unpack the response
nppes_ex <- provider_nppes(npi) |> 
            provider_unpack()
```

<br>

| npi        | prov_type | first_name  | last_name | sole_proprietor | gender |
|:-----------|:----------|:------------|:----------|:----------------|:-------|
| 1083879860 | NPI-1     | CHRISTOPHER | AARON     | NO              | M      |

| enumeration_date | last_updated | certification_date | status |
|:-----------------|:-------------|:-------------------|:-------|
| 2008-07-22       | 2021-03-25   | 2020-05-01         | A      |

| country_code | address_purpose | address_1           | city    | state | postal_code | telephone_number |
|:-------------|:----------------|:--------------------|:--------|:------|:------------|:-----------------|
| US           | location        | 792 GALLITZIN RD    | CRESSON | PA    | 166302213   | 814-886-8161     |
| US           | mailing         | 10 CASTLE GARDEN CT | OLNEY   | MD    | 208321443   | NA               |

| taxon_code | taxonomy_group | taxon_desc      | taxon_state | taxon_license | taxon_primary |
|:-----------|:---------------|:----------------|:------------|:--------------|:--------------|
| 207Q00000X |                | Family Medicine | PA          | OS019703      | TRUE          |
| 207Q00000X |                | Family Medicine | PA          | OS019703      | TRUE          |

| endpts_endpoint_type | endpts_endpoint_type_description | endpts_endpoint                      |
|:---------------------|:---------------------------------|:-------------------------------------|
| DIRECT               | Direct Messaging Address         | <christopher.l.aaron@upmcdirect.com> |

| endpts_affiliation | endpts_affiliation_name |
|:-------------------|:------------------------|
| Y                  | UPMC                    |

| endpts_address_2 | endpts_city | endpts_state | endpts_postal_code |
|:-----------------|:------------|:-------------|:-------------------|
| Floor 58         | Pittsburgh  | PA           | 152192702          |

<br>

### FFS Public Provider Enrollment

What if you need the provider’s PECOS PAC ID or Enrollment ID? Using the
`provider_mppe()` function, you can search Medicare’s **Fee-For-Service
Public Provider Enrollment API**:

<br>

``` r
mppe_ex <- provider_mppe(npi)
```

<br>

| state_cd | first_name  | mdl_name | last_name | org_name | gndr_sw |
|:---------|:------------|:---------|:----------|:---------|:--------|
| PA       | CHRISTOPHER | L        | AARON     |          | M       |

| npi        | pecos_asct_cntl_id | enrlmt_id       | provider_type_cd | provider_type_desc             |
|:-----------|:-------------------|:----------------|:-----------------|:-------------------------------|
| 1083879860 | 8426328519         | I20200617001010 | 14-08            | PRACTITIONER - FAMILY PRACTICE |

<br>

### Order and Referring

Is a Provider currently eligible to:

    #> Error in md_bullet(list("Make referrals to Medicare Part B or a Home Health Agency (HHA)?", : could not find function "md_bullet"

Search Medicare’s **Order and Referring API** with `order_refer()`:

    #> Error in order_refer(npi): could not find function "order_refer"

<br>

### Taxonomy Crosswalk

You may need to find Medicare’s specialty codes for this provider’s
taxonomies. You can search Medicare’s **Provider and Supplier Taxonomy
Crosswalk API** with `provider_mpstc()`:

<br>

<br>

### Revalidation Due Date

You can check to see if a provider is due to revalidate their Medicare
enrollment by accessing Medicare’s **Revalidation Due Date API** with
`provider_mrdd()`:

<br>

<br>

### Missing Digital Contact Information

Providers may need to update their digital contact information in the
NPPES system. To check, you can access the **CMS Public Reporting of
Missing Digital Contact Information API** with `provider_promdci()`. If
they appear in the search results, it’s time to update their NPPES
contact information:

<br>

<br>

### Opt-Out Affidavits

You can find out if a provider has opted out of Medicare by searching
the **Medicare Opt Out Affidavits API** with `provider_mooa()`:

<br>

<br>

### Revalidation Clinic Group Practice Reassignment

`provider_rcgpr()` accesses **Medicare’s Revalidation Clinic Group
Practice Reassignment API**:

<br>

## Provider Statistics

These APIs are generally concerned with providing access to a provider’s
longitudinal utilization data.

### Physician & Other Practitioners

    #> Error in md_quote("by Provider and Service API"): could not find function "md_quote"

    #> Error in physician_by_service(npi = 1003000126, year = .x): could not find function "physician_by_service"

    #> Error in dplyr::select(serv_ex, year, hcpcs_cd, tot_benes, tot_srvcs, : object 'serv_ex' not found

> 2.  by Geography and Service API:

<br>

> 3.  by Provider API:

<br>

### Medicare Monthly Enrollment

``` r
month_ex <- monthly_enroll(year      = 2018, 
                           month     = "Year", 
                           geo_lvl   = "County", 
                           state_abb = "AL", 
                           county    = "Autauga")
#> Error in monthly_enroll(year = 2018, month = "Year", geo_lvl = "County", : could not find function "monthly_enroll"
```

    #> Error in knitr::kable(x, format = "markdown", ...): object 'month_ex' not found
    #> Error in knitr::kable(x, format = "markdown", ...): object 'month_ex' not found
    #> Error in knitr::kable(x, format = "markdown", ...): object 'month_ex' not found
    #> Error in knitr::kable(x, format = "markdown", ...): object 'month_ex' not found

------------------------------------------------------------------------

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
