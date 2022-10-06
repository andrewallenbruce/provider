
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
    #> 1 2022-10-05 22:50:30 results <df [1 × 11]>

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

<br>

Filter and wrangle the data for presentation:

<br>

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
#> Error in provider_nppes(first = "Paul", last = "Dewey", state_abbr = "MN"): unused argument (state_abbr = "MN")
```

<br>

    #> Error in dplyr::select(nppes_ex2, NPI = npi, `Last Name` = last_name, : object 'nppes_ex2' not found

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

    #> Error in `dplyr::mutate()`:
    #> ! Problem while computing `days_to_end = age_days(start_date =
    #>   optout_end_date, end_date = lubridate::today())`.
    #> Caused by error in `inherits()`:
    #> ! argument "df" is missing, with no default
    #> Error in dplyr::select(NPI = npi, Last = last_name, First = first_name, : object 'optout_effective_date' not found

<br>

`provider_rcgpr()` accesses **Medicare’s Revalidation Clinic Group
Practice Reassignment API**:

<br>

``` r
rcgpr_ex <- provider_rcgpr(npi = 1760485387)
```

<br>

| NPI        | Last  | Type         | PAC ID Group | Enroll ID Group | Business Name                      | Due Date Group | PAC ID Ind | Enroll ID Ind   | Due Date Ind | Reassignments & Phys Assts | Employer Associations |
|:-----------|:------|:-------------|:-------------|:----------------|:-----------------------------------|:---------------|:-----------|:----------------|:-------------|:---------------------------|:----------------------|
| 1760485387 | Dewey | Reassignment | 6305758657   | O20031104000556 | Gateway Family Health Clinic, Ltd. | 07/31/2022     | 8729990007 | I20100505000906 | 09/30/2018   | 33                         | 2                     |
| 1760485387 | Dewey | Reassignment | 3870406945   | O20031106000272 | Pine Medical Center                | 01/31/2018     | 8729990007 | I20100505000906 | 09/30/2018   | 136                        | 2                     |

<br>

Using `provider_mpop()`, you can access **Medicare’s Physician & Other
Practitioners - by Provider and Service API**:

<br>

``` r
mpop_ex_2020 <- provider_mpop(npi = 1760485387, 
                              year = "2020")
```

<br>

| NPI        | Last  | City       | State | PAR | HCPCS | Beneficiaries | Services | Avg Billed   | Avg Allowed  | Avg Payment  |
|:-----------|:------|:-----------|:------|:----|:------|:--------------|:---------|:-------------|:-------------|:-------------|
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 36415 | 122           | 196      | 29           | 2.9834693878 | 2.9834693878 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 71046 | 16            | 17       | 141          | 20.480588235 | 10.592352941 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 80048 | 71            | 100      | 63           | 8.4022       | 8.4022       |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 80053 | 36            | 39       | 85           | 10.511538462 | 10.511538462 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 80061 | 53            | 54       | 116          | 13.315       | 13.315       |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 81001 | 19            | 24       | 48           | 3.1475       | 3.1475       |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 83036 | 26            | 37       | 74           | 9.6586486486 | 9.6586486486 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 84153 | 13            | 14       | 111          | 18.284285714 | 18.284285714 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 84443 | 26            | 35       | 97           | 16.732       | 16.732       |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 84450 | 14            | 14       | 43           | 5.1371428571 | 5.1371428571 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 85025 | 11            | 12       | 69           | 7.7566666667 | 7.7566666667 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 85027 | 48            | 52       | 69           | 6.43         | 6.43         |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 85610 | 17            | 35       | 43           | 4.2462857143 | 4.2462857143 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 90662 | 25            | 25       | 68           | 60.7364      | 60.7364      |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 90686 | 13            | 13       | 27           | 19.508461538 | 19.508461538 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 93000 | 25            | 25       | 113          | 16.9692      | 10.8532      |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 99213 | 91            | 252      | 226          | 74.433253968 | 48.886825397 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 99214 | 81            | 136      | 334          | 107.93426471 | 66.875955882 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | G0008 | 38            | 38       | 78           | 16.802105263 | 16.802105263 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | G0103 | 17            | 17       | 111          | 19.172352941 | 19.172352941 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | G0438 | 18            | 18       | 508.11111111 | 170.25       | 170.25       |

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
