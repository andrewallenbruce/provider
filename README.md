
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `provider` <img src="man/figures/logo.svg" align="right" height="300" />

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
<!-- badges: end -->

The goal of `provider` is to provide performant and reliable open-source
tools to facilitate easy access to [healthcare
provider](https://en.wikipedia.org/wiki/Health_care_provider) data
through publicly available APIs & sources. The current list of supported
APIs are:

<br>

-   [NPPES National Provider Identifier (NPI) Registry
    API](https://npiregistry.cms.hhs.gov/search)
-   [Medicare Fee-For-Service Public Provider Enrollment
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
-   [Medicare Order and Referring
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
-   [Medicare Provider and Supplier Taxonomy
    Crosswalk](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)
-   [Medicare Physician & Other Practitioners - by Provider and Service
    API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
-   [Medicare Revalidation Due Date
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
-   [Medicare Revalidation Clinic Group Practice Reassignment
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)
-   [Medicare Opt Out Affidavits
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
-   [Medicare Market Saturation & Utilization
    State-County](https://data.cms.gov/summary-statistics-on-use-and-payments/program-integrity-market-saturation-by-type-of-service/market-saturation-utilization-state-county)
-   [CMS Public Reporting of Missing Digital Contact Information
    API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)

<br>

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

<br>

## Motivating Example

You’re billing for a healthcare provider and receive a `CO-8` denial on
a claim and you need to confirm whether or not the correct taxonomy code
was entered on the claim. Armed with the provider’s NPI, you can search
the **NPPES NPI Registry API** with the `provider_nppes()` function:

<br>

``` r
# Load library
library(provider)

# Query the NPPES API
nppes_ex <- provider_nppes(npi = 1760485387)
```

<br>

    #> # A tibble: 1 × 3
    #>   datetime            outcome data_lists   
    #>   <dttm>              <chr>   <list>       
    #> 1 2022-09-28 12:27:39 results <df [1 × 11]>

<br>

Unpack the API response with the `provider_unpack()` function:

<br>

``` r
nppes_ex <- provider_unpack(nppes_ex)
```

<br>

``` r
nppes_ex
#> # A tibble: 16 × 32
#>    npi    prov_…¹ first…² last_…³ middl…⁴ crede…⁵ sole_…⁶ gender enume…⁷ last_…⁸
#>    <chr>  <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>  <chr>   <chr>  
#>  1 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#>  2 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#>  3 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#>  4 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#>  5 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#>  6 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#>  7 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#>  8 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#>  9 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#> 10 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#> 11 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#> 12 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#> 13 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#> 14 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#> 15 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#> 16 17604… NPI-1   PAUL    DEWEY   R.      M.D.    NO      M      2005-0… 2012-1…
#> # … with 22 more variables: status <chr>, name_prefix <chr>, name_suffix <chr>,
#> #   country_code <chr>, address_purpose <chr>, address_1 <chr>, city <chr>,
#> #   state <chr>, postal_code <chr>, telephone_number <chr>, fax_number <chr>,
#> #   taxon_code <chr>, taxonomy_group <chr>, taxon_desc <chr>,
#> #   taxon_state <chr>, taxon_license <chr>, taxon_primary <lgl>,
#> #   ident_code <chr>, ident_desc <chr>, ident_issuer <lgl>, identifier <chr>,
#> #   ident_state <chr>, and abbreviated variable names ¹​prov_type, …
```

| NPI        | Last Name | Provider Type | Code       | Primary | Description       | State | License |
|:-----------|:----------|:--------------|:-----------|:--------|:------------------|:------|:--------|
| 1760485387 | DEWEY     | NPI-1         | 207R00000X | TRUE    | Internal Medicine | MN    | 43634   |
| 1760485387 | DEWEY     | NPI-1         | 208000000X | FALSE   | Pediatrics        | MN    | 43634   |

<br>

What if you don’t have the provider’s NPI? You can search by first
and/or last name, city, state:

<br>

``` r
nppes_ex2 <- provider_nppes(first = "Paul", 
                            last = "Dewey",
                            state_abbr = "MN") |> 
                            provider_unpack()
```

<br>

| NPI        | Last Name | Provider Type | Code       | Primary | Description       | State | License |
|:-----------|:----------|:--------------|:-----------|:--------|:------------------|:------|:--------|
| 1760485387 | DEWEY     | NPI-1         | 207R00000X | TRUE    | Internal Medicine | MN    | 43634   |
| 1760485387 | DEWEY     | NPI-1         | 208000000X | FALSE   | Pediatrics        | MN    | 43634   |

<br>

What if you need the provider’s PECOS PAC ID or Enrollment ID? Using the
`provider_mppe()` function, you can search Medicare’s **Fee-For-Service
Public Provider Enrollment API**:

<br>

``` r
mppe_ex <- provider_mppe(1760485387)
```

<br>

| NPI        | Last Name | PECOS PAC ID | PECOS Enrollment ID | Specialty                        | State |
|:-----------|:----------|:-------------|:--------------------|:---------------------------------|:------|
| 1760485387 | DEWEY     | 8729990007   | I20100505000906     | PRACTITIONER - INTERNAL MEDICINE | MN    |

<br>

Is the provider currently eligible to make referrals to Medicare Part B
or a Home Health Agency (HHA)? Order Durable Medical Equipment (DME) or
Power Mobility Devices (PMDs)? Search Medicare’s **Order and Referring
API** with `provider_moar()`:

<br>

``` r
moar_ex <- provider_moar(1760485387)
```

<br>

| NPI        | Last Name | First Name | Part B | DME | HHA | PMD |
|:-----------|:----------|:-----------|:-------|:----|:----|:----|
| 1760485387 | DEWEY     | PAUL       | Y      | Y   | Y   | Y   |

<br>

You may need to find Medicare’s specialty codes for this provider’s
taxonomies. Using the output from the NPPES search in the first example,
you can search Medicare’s **Provider and Supplier Taxonomy Crosswalk
API** with `provider_mpstc()`:

<br>

``` r
mpstc_ex <- nppes_ex |> 
            dplyr::distinct(taxon_code) |> 
            dplyr::group_split(taxon_code) |> 
            purrr::map_dfr(provider_mpstc)
```

<br>

| Taxonomy Code | Medicare Specialty Code | Specialty                    | Classification                                        |
|:--------------|:------------------------|:-----------------------------|:------------------------------------------------------|
| 207R00000X    | 11                      | Physician/Internal Medicine  | Allopathic & Osteopathic Physicians/Internal Medicine |
| 208000000X    | 37                      | Physician/Pediatric Medicine | Allopathic & Osteopathic Physicians/Pediatrics        |

<br>

You can check to see if a provider is due to revalidate their Medicare
enrollment by accessing Medicare’s **Revalidation Due Date API** with
`provider_mrdd()`:

<br>

``` r
mrdd_ex <- provider_mrdd(1760485387)
```

<br>

| NPI        | Enrollment ID   | Enrollment Type | Last Name | State | Provider Type  | Specialty         | Revalidation Due Date |
|:-----------|:----------------|:----------------|:----------|:------|:---------------|:------------------|:----------------------|
| 1760485387 | I20100505000906 | 3               | Dewey     | MN    | Non-DME Part B | Internal Medicine | 2018-09-30            |

<br>

Providers may need to update their digital contact information in the
NPPES system. To check, you can access the **CMS Public Reporting of
Missing Digital Contact Information API** with `provider_promdci()`. If
they appear in the search results, it’s time to update their NPPES
contact information:

<br>

``` r
promdci_ex <- provider_promdci(1760485387)
```

<br>

| NPI        | Provider Name |
|:-----------|:--------------|
| 1760485387 | Dewey,Paul    |

<br>

You can find out if a provider has opted out of Medicare by searching
the **Medicare Opt Out Affidavits API** with `provider_mooa()`:

<br>

``` r
mooa_ex <- provider_mooa(1114974490)
```

<br>

| NPI        | Opt Out Effective | Opt Out End | Updated    | Last    | First | Specialty          | Address          | City     | State | Eligible to Order & Refer |
|:-----------|:------------------|:------------|:-----------|:--------|:------|:-------------------|:-----------------|:---------|:------|:--------------------------|
| 1114974490 | 2012-07-01        | 2024-07-01  | 2022-08-15 | Altchek | David | Orthopedic Surgery | 535 EAST 70TH ST | NEW YORK | NY    | Y                         |

<br>

Using `provider_mpop()`, you can access **Medicare’s Physician & Other
Practitioners - by Provider and Service API**:

<br>

``` r
mpop_ex_2020 <- provider_mpop(npi = 1760485387, 
                              year = "2020")
```

<br>

| NPI        | Last  | City       | State | PAR | HCPCS | Beneficiaries | Services | Avg Billed | Avg Allowed | Avg Payment |
|:-----------|:------|:-----------|:------|:----|:------|--------------:|---------:|-----------:|------------:|------------:|
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 36415 |           122 |      196 |      29.00 |        2.98 |        2.98 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 71046 |            16 |       17 |     141.00 |       20.48 |       10.59 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 80048 |            71 |      100 |      63.00 |        8.40 |        8.40 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 80053 |            36 |       39 |      85.00 |       10.51 |       10.51 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 80061 |            53 |       54 |     116.00 |       13.32 |       13.32 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 81001 |            19 |       24 |      48.00 |        3.15 |        3.15 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 83036 |            26 |       37 |      74.00 |        9.66 |        9.66 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 84153 |            13 |       14 |     111.00 |       18.28 |       18.28 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 84443 |            26 |       35 |      97.00 |       16.73 |       16.73 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 84450 |            14 |       14 |      43.00 |        5.14 |        5.14 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 85025 |            11 |       12 |      69.00 |        7.76 |        7.76 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 85027 |            48 |       52 |      69.00 |        6.43 |        6.43 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 85610 |            17 |       35 |      43.00 |        4.25 |        4.25 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 90662 |            25 |       25 |      68.00 |       60.74 |       60.74 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 90686 |            13 |       13 |      27.00 |       19.51 |       19.51 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 93000 |            25 |       25 |     113.00 |       16.97 |       10.85 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 99213 |            91 |      252 |     226.00 |       74.43 |       48.89 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 99214 |            81 |      136 |     334.00 |      107.93 |       66.88 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | G0008 |            38 |       38 |      78.00 |       16.80 |       16.80 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | G0103 |            17 |       17 |     111.00 |       19.17 |       19.17 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | G0438 |            18 |       18 |     508.11 |      170.25 |      170.25 |

<br>

Using packages like {gt} & {ggplot2}, you can create tables and graphs
for reporting purposes:

<br>

<br>

<img src="man/figures/gt_provider.png" style="width:100.0%" />

<img src="man/figures/gt_provider2.png" style="width:100.0%" />

<br> <br>

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
