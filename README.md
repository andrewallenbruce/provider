
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

-   [NPPES National Provider Identifier (NPI) Registry
    API](https://npiregistry.cms.hhs.gov/search)
-   [Medicare Fee-For-Service Public Provider Enrollment
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
-   [Medicare Order and Referring
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
-   [Medicare Provider and Supplier Taxonomy Crosswalk
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)
-   [Medicare Physician & Other Practitioners
    API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
-   [Medicare Revalidation Due Date
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
-   [Medicare Revalidation Clinic Group Practice Reassignment
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)
-   [Medicare Opt Out Affidavits
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
-   [Medicare Market Saturation & Utilization State-County
    API](https://data.cms.gov/summary-statistics-on-use-and-payments/program-integrity-market-saturation-by-type-of-service/market-saturation-utilization-state-county)
-   [Medicare Provider of Services File - Clinical Laboratories
    API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)
-   [CMS Public Reporting of Missing Digital Contact Information
    API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)
-   [NIH NLM Clinical Table Service ICD-10-CM
    API](https://clinicaltables.nlm.nih.gov/apidoc/icd10cm/v3/doc.html)

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
    #> 1 2022-10-11 10:43:59 results <df [1 × 11]>

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
                            last  = "Dewey",
                            state = "MN") |> 
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

| NPI        | Last Name | PECOS PAC ID | PECOS Enroll ID | Specialty                        | State |
|:-----------|:----------|:-------------|:----------------|:---------------------------------|:------|
| 1760485387 | DEWEY     | 8729990007   | I20100505000906 | PRACTITIONER - INTERNAL MEDICINE | MN    |

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

| NPI        | Last    | First | Opt-Out Begins | Opt-Out Ends | Order & Refer Eligible | Updated    | Specialty          | Address          | City     | State | days |
|:-----------|:--------|:------|:---------------|:-------------|:-----------------------|:-----------|:-------------------|:-----------------|:---------|:------|-----:|
| 1114974490 | Altchek | David | 07/01/2012     | 07/01/2024   | Y                      | 08/15/2022 | Orthopedic Surgery | 535 EAST 70TH ST | NEW YORK | NY    |  629 |

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
Practitioners API**, enabling you to choose between three related
datasets:

> 1.  by Provider and Service API:

<br>

``` r
mpop_serv_ex <- provider_mpop(npi = 1760485387, 
                              set = "serv",
                              year = "2020")
```

<br>

| NPI        | Last  | City       | State | PAR | HCPCS | Beneficiaries | Services | Avg Billed | Avg Allowed | Avg Payment |
|:-----------|:------|:-----------|:------|:----|:------|--------------:|---------:|-----------:|------------:|------------:|
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 36415 |           122 |      196 |    29.0000 |    2.983469 |    2.983469 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 71046 |            16 |       17 |   141.0000 |   20.480588 |   10.592353 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 80048 |            71 |      100 |    63.0000 |    8.402200 |    8.402200 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 80053 |            36 |       39 |    85.0000 |   10.511539 |   10.511539 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 80061 |            53 |       54 |   116.0000 |   13.315000 |   13.315000 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 81001 |            19 |       24 |    48.0000 |    3.147500 |    3.147500 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 83036 |            26 |       37 |    74.0000 |    9.658649 |    9.658649 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 84153 |            13 |       14 |   111.0000 |   18.284286 |   18.284286 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 84443 |            26 |       35 |    97.0000 |   16.732000 |   16.732000 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 84450 |            14 |       14 |    43.0000 |    5.137143 |    5.137143 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 85025 |            11 |       12 |    69.0000 |    7.756667 |    7.756667 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 85027 |            48 |       52 |    69.0000 |    6.430000 |    6.430000 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 85610 |            17 |       35 |    43.0000 |    4.246286 |    4.246286 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 90662 |            25 |       25 |    68.0000 |   60.736400 |   60.736400 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 90686 |            13 |       13 |    27.0000 |   19.508461 |   19.508461 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 93000 |            25 |       25 |   113.0000 |   16.969200 |   10.853200 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 99213 |            91 |      252 |   226.0000 |   74.433254 |   48.886825 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | 99214 |            81 |      136 |   334.0000 |  107.934265 |   66.875956 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | G0008 |            38 |       38 |    78.0000 |   16.802105 |   16.802105 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | G0103 |            17 |       17 |   111.0000 |   19.172353 |   19.172353 |
| 1760485387 | Dewey | Moose Lake | MN    | Y   | G0438 |            18 |       18 |   508.1111 |  170.250000 |  170.250000 |

<br>

> 2.  by Geography and Service API:

<br>

``` r
mpop_geo_ex <- provider_mpop(hcpcs = "99214", 
                             set   = "geo",
                             year  = "2020")
```

<br>

| Year | HCPCS | Level    | Region                             | FIPS | POS | Providers | Beneficiaries |   Services | Distinct Beneficiaries Per Day Services | Avg Charge | Avg Allowed | Avg Payment | Avg Standard Pymt |
|:-----|:------|:---------|:-----------------------------------|:-----|:----|----------:|--------------:|-----------:|----------------------------------------:|-----------:|------------:|------------:|------------------:|
| 2020 | 99214 | National | National                           |      | F   |    159324 |       3183652 |  7008865.0 |                                 7007708 |   210.0959 |    77.34813 |    55.27629 |          54.77598 |
| 2020 | 99214 | National | National                           |      | O   |    551728 |      21794074 | 81741450.8 |                                81710520 |   222.2427 |   104.99487 |    72.22790 |          72.37773 |
| 2020 | 99214 | State    |                                    |      | O   |         1 |            23 |       23.0 |                                      23 |   115.0000 |    90.88435 |    66.36913 |          67.44130 |
| 2020 | 99214 | State    | Alabama                            | 01   | F   |      1520 |         36142 |    79848.0 |                                   79844 |   205.1436 |    72.51056 |    51.43583 |          53.51484 |
| 2020 | 99214 | State    | Alabama                            | 01   | O   |      7833 |        392296 |  1415952.0 |                                 1415921 |   160.9483 |    99.08389 |    67.10658 |          73.01572 |
| 2020 | 99214 | State    | Alaska                             | 02   | F   |       391 |          5906 |    11405.0 |                                   11405 |   298.9026 |   101.30883 |    73.25739 |          54.51994 |
| 2020 | 99214 | State    | Alaska                             | 02   | O   |      1362 |         47371 |   130619.0 |                                  130607 |   335.4511 |   130.17462 |    89.18937 |          69.56978 |
| 2020 | 99214 | State    | Arizona                            | 04   | F   |      2974 |         37818 |    65739.0 |                                   65728 |   188.6739 |    75.71533 |    54.91175 |          55.15280 |
| 2020 | 99214 | State    | Arizona                            | 04   | O   |     12020 |        571554 |  2345308.8 |                                 2343781 |   210.6922 |   102.45681 |    71.44179 |          73.44077 |
| 2020 | 99214 | State    | Arkansas                           | 05   | F   |      1176 |         45101 |    92284.0 |                                   92278 |   183.7939 |    71.25937 |    50.81537 |          55.39097 |
| 2020 | 99214 | State    | Arkansas                           | 05   | O   |      4606 |        300050 |  1015440.0 |                                 1015384 |   174.4740 |    92.71308 |    61.45950 |          71.29238 |
| 2020 | 99214 | State    | California                         | 06   | F   |     10349 |        215658 |   504645.0 |                                  504578 |   310.4187 |    83.02859 |    60.06233 |          55.84349 |
| 2020 | 99214 | State    | California                         | 06   | O   |     47031 |       1862063 |  7414408.8 |                                 7397050 |   246.1348 |   115.17086 |    81.41191 |          75.11972 |
| 2020 | 99214 | State    | Colorado                           | 08   | F   |      2761 |         46427 |    94926.0 |                                   94897 |   240.3239 |    77.03815 |    55.78138 |          54.92626 |
| 2020 | 99214 | State    | Colorado                           | 08   | O   |      9708 |        317370 |   987970.0 |                                  987707 |   228.0393 |   103.50586 |    70.44214 |          71.71460 |
| 2020 | 99214 | State    | Connecticut                        | 09   | F   |      1992 |         27912 |    56522.0 |                                   56472 |   259.2373 |    81.31415 |    59.15523 |          55.32360 |
| 2020 | 99214 | State    | Connecticut                        | 09   | O   |      7792 |        259175 |   865599.0 |                                  865443 |   233.2623 |   112.11484 |    78.36942 |          72.61910 |
| 2020 | 99214 | State    | Delaware                           | 10   | F   |       693 |         16034 |    26394.0 |                                   26394 |   187.7894 |    78.51771 |    56.46992 |          54.78539 |
| 2020 | 99214 | State    | Delaware                           | 10   | O   |      1760 |        134246 |   445720.0 |                                  445688 |   193.6163 |   107.68342 |    74.70553 |          73.13284 |
| 2020 | 99214 | State    | District of Columbia               | 11   | F   |       614 |         11981 |    22286.0 |                                   22262 |   244.4377 |    85.85950 |    61.54721 |          55.59967 |
| 2020 | 99214 | State    | District of Columbia               | 11   | O   |      1800 |         70729 |   154824.0 |                                  154809 |   238.4022 |   119.01530 |    83.08494 |          74.58465 |
| 2020 | 99214 | State    | Florida                            | 12   | F   |      7200 |        125625 |   267789.0 |                                  267715 |   211.8997 |    80.11027 |    59.62371 |          57.12564 |
| 2020 | 99214 | State    | Florida                            | 12   | O   |     36723 |       1835558 |  8075137.0 |                                 8074852 |   225.8502 |   107.50262 |    76.27034 |          75.36983 |
| 2020 | 99214 | State    | Georgia                            | 13   | F   |      3296 |         52559 |   113411.0 |                                  113404 |   246.4470 |    75.27215 |    54.57796 |          55.22478 |
| 2020 | 99214 | State    | Georgia                            | 13   | O   |     15582 |        731013 |  2680310.0 |                                 2680232 |   230.6255 |   102.58046 |    70.13565 |          72.73536 |
| 2020 | 99214 | State    | Hawaii                             | 15   | F   |       340 |          7579 |    15257.0 |                                   15257 |   172.9798 |    74.17537 |    49.85345 |          54.86690 |
| 2020 | 99214 | State    | Hawaii                             | 15   | O   |      1896 |         71853 |   226053.0 |                                  226013 |   191.1299 |   105.50104 |    70.33480 |          72.43494 |
| 2020 | 99214 | State    | Idaho                              | 16   | F   |      1007 |         37567 |    78838.0 |                                   78835 |   147.2040 |    72.12901 |    50.59927 |          53.05905 |
| 2020 | 99214 | State    | Idaho                              | 16   | O   |      2922 |        110058 |   281489.0 |                                  281479 |   191.4662 |    90.94623 |    60.84861 |          66.14490 |
| 2020 | 99214 | State    | Illinois                           | 17   | F   |      7363 |        161326 |   342798.0 |                                  342754 |   211.3887 |    81.20367 |    57.97919 |          55.04998 |
| 2020 | 99214 | State    | Illinois                           | 17   | O   |     21399 |        963991 |  3039737.4 |                                 3039271 |   220.0282 |   107.37172 |    73.37302 |          71.46775 |
| 2020 | 99214 | State    | Indiana                            | 18   | F   |      3319 |         59386 |   116154.0 |                                  116152 |   185.6050 |    73.89938 |    53.65755 |          55.99613 |
| 2020 | 99214 | State    | Indiana                            | 18   | O   |     12239 |        570825 |  1745990.0 |                                 1745943 |   181.8870 |    99.01228 |    65.99577 |          71.03936 |
| 2020 | 99214 | State    | Iowa                               | 19   | F   |      2268 |         65456 |   136324.0 |                                  136321 |   218.7926 |    73.53551 |    52.01280 |          54.49746 |
| 2020 | 99214 | State    | Iowa                               | 19   | O   |      5114 |        261257 |   680174.0 |                                  680161 |   211.3674 |    96.83009 |    64.70677 |          69.59037 |
| 2020 | 99214 | State    | Kansas                             | 20   | F   |      1640 |         45385 |    94969.0 |                                   94963 |   176.4225 |    73.41136 |    52.92166 |          55.01545 |
| 2020 | 99214 | State    | Kansas                             | 20   | O   |      4820 |        265076 |   727890.0 |                                  727869 |   185.4135 |    98.21212 |    66.19781 |          70.98501 |
| 2020 | 99214 | State    | Kentucky                           | 21   | F   |      2429 |         52516 |   110038.0 |                                  110024 |   175.1642 |    74.16329 |    53.76958 |          55.61086 |
| 2020 | 99214 | State    | Kentucky                           | 21   | O   |      8442 |        374239 |  1124984.0 |                                 1124918 |   192.0052 |    96.44178 |    64.21043 |          70.07480 |
| 2020 | 99214 | State    | Louisiana                          | 22   | F   |      3090 |         74527 |   189085.0 |                                  189060 |   211.1460 |    76.62409 |    54.34391 |          54.45522 |
| 2020 | 99214 | State    | Louisiana                          | 22   | O   |      7453 |        327020 |  1169997.0 |                                 1168588 |   201.0263 |   100.77465 |    69.30095 |          73.54054 |
| 2020 | 99214 | State    | Maine                              | 23   | F   |      1334 |         31973 |    61381.0 |                                   61366 |   171.1737 |    74.17088 |    52.24957 |          52.80283 |
| 2020 | 99214 | State    | Maine                              | 23   | O   |      2842 |         93148 |   239293.0 |                                  239271 |   186.7153 |    88.59707 |    60.28278 |          61.63552 |
| 2020 | 99214 | State    | Maryland                           | 24   | F   |      3454 |         55604 |   103115.0 |                                  103109 |   224.2588 |    81.80583 |    59.23509 |          55.73785 |
| 2020 | 99214 | State    | Maryland                           | 24   | O   |     11949 |        637179 |  2270876.5 |                                 2270313 |   224.9833 |   113.08058 |    78.31403 |          73.74758 |
| 2020 | 99214 | State    | Massachusetts                      | 25   | F   |      7354 |        186158 |   410356.0 |                                  410315 |   270.5321 |    82.52486 |    57.99152 |          53.80658 |
| 2020 | 99214 | State    | Massachusetts                      | 25   | O   |     15760 |        633167 |  1974920.4 |                                 1974192 |   297.9379 |   110.02902 |    75.54129 |          71.29905 |
| 2020 | 99214 | State    | Michigan                           | 26   | F   |      7737 |        138918 |   261407.0 |                                  261397 |   159.5970 |    77.42197 |    55.90304 |          55.43783 |
| 2020 | 99214 | State    | Michigan                           | 26   | O   |     18757 |        638966 |  1961164.5 |                                 1961076 |   172.7698 |   100.05394 |    68.07635 |          70.50241 |
| 2020 | 99214 | State    | Minnesota                          | 27   | F   |      4499 |         80782 |   177355.0 |                                  177351 |   205.7880 |    74.63419 |    52.39622 |          53.17549 |
| 2020 | 99214 | State    | Minnesota                          | 27   | O   |     12253 |        309339 |   837752.0 |                                  837712 |   270.1779 |   100.33936 |    67.97159 |          69.38939 |
| 2020 | 99214 | State    | Mississippi                        | 28   | F   |      1291 |         52608 |   114595.0 |                                  114573 |   159.9295 |    72.47030 |    51.85780 |          54.90154 |
| 2020 | 99214 | State    | Mississippi                        | 28   | O   |      4560 |        302662 |  1004848.0 |                                 1004703 |   164.6648 |    94.63375 |    63.62042 |          70.56396 |
| 2020 | 99214 | State    | Missouri                           | 29   | F   |      3571 |         93655 |   200290.0 |                                  200284 |   167.5906 |    75.67573 |    54.58291 |          55.55489 |
| 2020 | 99214 | State    | Missouri                           | 29   | O   |     10170 |        469160 |  1343728.0 |                                 1343662 |   187.6604 |    99.47453 |    67.45937 |          70.92771 |
| 2020 | 99214 | State    | Montana                            | 30   | F   |       975 |         43071 |   100697.0 |                                  100695 |   145.1078 |    76.12798 |    52.41998 |          52.74329 |
| 2020 | 99214 | State    | Montana                            | 30   | O   |      1831 |         77126 |   174590.0 |                                  174588 |   215.3212 |    96.40342 |    63.70812 |          67.63293 |
| 2020 | 99214 | State    | Nebraska                           | 31   | F   |      1570 |         39048 |    76906.0 |                                   76906 |   226.9757 |    73.72143 |    53.87500 |          56.42443 |
| 2020 | 99214 | State    | Nebraska                           | 31   | O   |      3722 |        175114 |   514615.0 |                                  514598 |   222.8738 |    96.80255 |    65.44070 |          71.93242 |
| 2020 | 99214 | State    | Nevada                             | 32   | F   |       457 |          6182 |    11283.0 |                                   11283 |   207.5909 |    77.82218 |    54.49326 |          53.75432 |
| 2020 | 99214 | State    | Nevada                             | 32   | O   |      4313 |        197952 |   748825.0 |                                  748027 |   235.1992 |   104.41997 |    72.89399 |          73.35649 |
| 2020 | 99214 | State    | New Hampshire                      | 33   | F   |      1384 |         40397 |    78443.0 |                                   78384 |   170.8733 |    77.56392 |    54.79512 |          53.41759 |
| 2020 | 99214 | State    | New Hampshire                      | 33   | O   |      3258 |        141129 |   387727.0 |                                  387609 |   237.0311 |   100.52269 |    68.47191 |          66.91809 |
| 2020 | 99214 | State    | New Jersey                         | 34   | F   |      3576 |         40464 |    74321.0 |                                   74279 |   260.4168 |    83.35137 |    61.30783 |          56.55191 |
| 2020 | 99214 | State    | New Jersey                         | 34   | O   |     15886 |        732766 |  2783371.0 |                                 2781837 |   242.3919 |   116.62832 |    82.27500 |          75.83385 |
| 2020 | 99214 | State    | New Mexico                         | 35   | F   |      1120 |         26551 |    47082.0 |                                   47080 |   154.0023 |    75.18671 |    50.97159 |          51.22546 |
| 2020 | 99214 | State    | New Mexico                         | 35   | O   |      2999 |        129649 |   366134.5 |                                  365603 |   209.0765 |    98.25470 |    65.68069 |          68.80132 |
| 2020 | 99214 | State    | New York                           | 36   | F   |      8748 |        142073 |   283533.0 |                                  283505 |   233.6151 |    80.98320 |    57.73948 |          54.86769 |
| 2020 | 99214 | State    | New York                           | 36   | O   |     37056 |       1296065 |  4602104.0 |                                 4601076 |   283.3954 |   116.39077 |    82.86941 |          74.36437 |
| 2020 | 99214 | State    | North Carolina                     | 37   | F   |      4895 |        104742 |   214197.0 |                                  214195 |   205.4366 |    74.58948 |    53.74601 |          54.85314 |
| 2020 | 99214 | State    | North Carolina                     | 37   | O   |     19868 |        928038 |  3370272.5 |                                 3370192 |   210.5631 |    99.47996 |    67.09370 |          69.97883 |
| 2020 | 99214 | State    | North Dakota                       | 38   | F   |       999 |         37870 |    85096.0 |                                   85095 |   148.6166 |    72.52361 |    51.02898 |          52.70455 |
| 2020 | 99214 | State    | North Dakota                       | 38   | O   |      1505 |         60365 |   137963.0 |                                  137961 |   220.7049 |    85.98350 |    56.63764 |          61.53532 |
| 2020 | 99214 | State    | Ohio                               | 39   | F   |      8509 |        151443 |   312876.0 |                                  312860 |   195.1697 |    74.76124 |    53.07184 |          54.40250 |
| 2020 | 99214 | State    | Ohio                               | 39   | O   |     22540 |        836719 |  2559955.5 |                                 2559705 |   190.0500 |    96.33961 |    63.16100 |          68.93707 |
| 2020 | 99214 | State    | Oklahoma                           | 40   | F   |      1400 |         64471 |   139174.0 |                                  139168 |   161.9307 |    73.42221 |    52.44503 |          55.63185 |
| 2020 | 99214 | State    | Oklahoma                           | 40   | O   |      6299 |        340808 |  1173165.0 |                                 1172883 |   190.0742 |    96.22307 |    64.33766 |          71.59497 |
| 2020 | 99214 | State    | Oregon                             | 41   | F   |      1813 |         31206 |    59992.0 |                                   59990 |   212.9584 |    74.17442 |    51.34729 |          53.43067 |
| 2020 | 99214 | State    | Oregon                             | 41   | O   |      7541 |        249109 |   718708.0 |                                  718681 |   275.2796 |    97.83680 |    64.59100 |          69.32889 |
| 2020 | 99214 | State    | Pennsylvania                       | 42   | F   |      9393 |        153567 |   297661.0 |                                  297628 |   193.6124 |    78.67369 |    57.01163 |          55.59461 |
| 2020 | 99214 | State    | Pennsylvania                       | 42   | O   |     27048 |       1065959 |  3274192.5 |                                 3273850 |   197.2330 |   105.33099 |    71.01289 |          71.50211 |
| 2020 | 99214 | State    | Rhode Island                       | 44   | F   |       514 |         10190 |    17774.0 |                                   17771 |   240.4786 |    80.70772 |    59.79363 |          57.46604 |
| 2020 | 99214 | State    | Rhode Island                       | 44   | O   |      2349 |         85494 |   239300.0 |                                  239278 |   223.4746 |   103.17028 |    69.67001 |          71.52000 |
| 2020 | 99214 | State    | South Carolina                     | 45   | F   |      2017 |         40063 |    84690.0 |                                   84685 |   175.8428 |    74.24687 |    54.05279 |          55.99511 |
| 2020 | 99214 | State    | South Carolina                     | 45   | O   |      8469 |        540638 |  1957098.0 |                                 1957059 |   197.4752 |   100.45661 |    68.24855 |          72.70845 |
| 2020 | 99214 | State    | South Dakota                       | 46   | F   |       965 |         41357 |    84471.0 |                                   84469 |   123.8411 |    75.11340 |    51.80048 |          52.56523 |
| 2020 | 99214 | State    | South Dakota                       | 46   | O   |      1544 |         66440 |   137921.9 |                                  137889 |   178.8416 |    94.33116 |    63.52970 |          65.52253 |
| 2020 | 99214 | State    | Tennessee                          | 47   | F   |      2781 |         58713 |   122135.0 |                                  122132 |   250.0928 |    72.82259 |    52.26744 |          55.21403 |
| 2020 | 99214 | State    | Tennessee                          | 47   | O   |     12813 |        622864 |  2206367.0 |                                 2206183 |   211.5550 |    96.87703 |    65.48428 |          71.47619 |
| 2020 | 99214 | State    | Texas                              | 48   | F   |      8613 |        168573 |   370165.0 |                                  370104 |   220.6652 |    76.51453 |    55.06089 |          55.29102 |
| 2020 | 99214 | State    | Texas                              | 48   | O   |     35559 |       1533940 |  5831944.4 |                                 5830416 |   228.6706 |   103.35461 |    71.32325 |          73.23781 |
| 2020 | 99214 | State    | Utah                               | 49   | F   |       985 |         13270 |    21206.0 |                                   21206 |   200.6993 |    75.52827 |    53.08124 |          53.76684 |
| 2020 | 99214 | State    | Utah                               | 49   | O   |      4758 |        167300 |   536303.0 |                                  536236 |   189.6556 |    99.28565 |    67.19280 |          71.03076 |
| 2020 | 99214 | State    | Vermont                            | 50   | F   |       581 |         23896 |    42279.0 |                                   42274 |   118.0817 |    75.78451 |    51.96948 |          52.30822 |
| 2020 | 99214 | State    | Vermont                            | 50   | O   |      1175 |         48355 |   113250.0 |                                  113237 |   158.2895 |    92.66087 |    60.80079 |          62.33731 |
| 2020 | 99214 | State    | Virginia                           | 51   | F   |      3657 |         95907 |   189510.0 |                                  189506 |   190.6162 |    77.59966 |    54.59526 |          53.73531 |
| 2020 | 99214 | State    | Virginia                           | 51   | O   |     14044 |        805356 |  2681633.0 |                                 2681487 |   204.9995 |   105.93820 |    71.86672 |          70.45223 |
| 2020 | 99214 | State    | Washington                         | 53   | F   |      3721 |        102236 |   220527.0 |                                  220258 |   169.2841 |    79.62411 |    55.84049 |          53.67684 |
| 2020 | 99214 | State    | Washington                         | 53   | O   |     13567 |        485442 |  1508067.0 |                                 1507829 |   243.7960 |   104.57677 |    70.80640 |          69.25029 |
| 2020 | 99214 | State    | West Virginia                      | 54   | F   |      1577 |         41961 |    83893.0 |                                   83893 |   169.6142 |    75.04547 |    52.50353 |          53.57119 |
| 2020 | 99214 | State    | West Virginia                      | 54   | O   |      3063 |        151552 |   397713.1 |                                  397704 |   190.6232 |    96.45296 |    63.70499 |          68.90104 |
| 2020 | 99214 | State    | Wisconsin                          | 55   | F   |      5130 |        110076 |   234329.0 |                                  234191 |   227.0551 |    73.28295 |    51.16187 |          53.21140 |
| 2020 | 99214 | State    | Wisconsin                          | 55   | O   |     11090 |        366178 |   953363.0 |                                  953286 |   291.6898 |    97.53964 |    63.84331 |          67.26738 |
| 2020 | 99214 | State    | Wyoming                            | 56   | F   |       153 |          2936 |     5880.0 |                                    5879 |   250.0307 |    75.71077 |    54.88886 |          54.61224 |
| 2020 | 99214 | State    | Wyoming                            | 56   | O   |       972 |         49550 |   121035.0 |                                  121022 |   234.6224 |   103.07803 |    70.27535 |          70.53864 |
| 2020 | 99214 | State    | Guam                               | 66   | F   |        13 |           234 |      479.0 |                                     479 |   334.2821 |    81.44184 |    61.21681 |          58.24079 |
| 2020 | 99214 | State    | Guam                               | 66   | O   |       106 |          5652 |    16557.0 |                                   16556 |   137.6484 |   112.30174 |    73.44534 |          71.29761 |
| 2020 | 99214 | State    | Northern Mariana Islands           | 69   | F   |         6 |            62 |      293.0 |                                     293 |   261.6770 |    77.82611 |    58.46696 |          56.24041 |
| 2020 | 99214 | State    | Northern Mariana Islands           | 69   | O   |         8 |           437 |     1230.0 |                                    1230 |   128.8585 |   109.95365 |    59.35826 |          58.75810 |
| 2020 | 99214 | State    | Puerto Rico                        | 72   | F   |        84 |           931 |     2232.0 |                                    2232 |   118.9027 |    79.08020 |    58.09674 |          58.10088 |
| 2020 | 99214 | State    | Puerto Rico                        | 72   | O   |      1392 |         17829 |    42291.0 |                                   42284 |   127.9665 |   104.78114 |    70.73766 |          74.06313 |
| 2020 | 99214 | State    | Virgin Islands                     | 78   | O   |        90 |          7552 |    18225.0 |                                   18225 |   180.5812 |   107.06861 |    67.46070 |          68.10906 |
| 2020 | 99214 | State    | Armed Forces Central/South America | 9A   | O   |         2 |            39 |       49.0 |                                      49 |   132.8571 |    95.22327 |    61.57449 |          71.95367 |
| 2020 | 99214 | State    | Armed Forces Europe                | 9B   | F   |         6 |           233 |      291.0 |                                     291 |   142.7801 |    75.62928 |    51.86900 |          52.13471 |
| 2020 | 99214 | State    | Armed Forces Europe                | 9B   | O   |        23 |          1373 |     1973.0 |                                    1973 |   236.4895 |   101.53947 |    67.86482 |          67.65047 |
| 2020 | 99214 | State    | Armed Forces Pacific               | 9C   | F   |         3 |            45 |       48.0 |                                      48 |    92.5625 |    67.99458 |    50.02583 |          50.09604 |
| 2020 | 99214 | State    | Armed Forces Pacific               | 9C   | O   |         9 |           645 |      779.0 |                                     779 |   231.6088 |   105.79838 |    74.94798 |          74.96872 |
| 2020 | 99214 | State    | Unknown                            | 9D   | F   |         6 |            85 |      113.0 |                                     113 |   177.1255 |    67.22991 |    40.35487 |          40.76062 |
| 2020 | 99214 | State    | Unknown                            | 9D   | O   |         8 |           923 |     2093.0 |                                    2093 |   172.1438 |   107.06892 |    76.06544 |          76.60396 |
| 2020 | 99214 | State    | Foreign Country                    | 9E   | F   |         9 |            60 |       71.0 |                                      71 |   184.3335 |    77.20549 |    58.67183 |          59.53000 |
| 2020 | 99214 | State    | Foreign Country                    | 9E   | O   |        27 |          1605 |     2427.0 |                                    2427 |   192.0909 |   104.69262 |    71.19485 |          73.87223 |

<br>

> 3.  by Provider API:

<br>

``` r
mpop_prov_ex <- provider_mpop(npi  = 1003000134, 
                              set  = "prov",
                              year = "2020")
```

<br>

    #> S3<data.frame>
    #> ├─year: "2020"
    #> ├─rndrng_npi: "1003000134"
    #> ├─rndrng_prvdr_last_org_name: "Cibull"
    #> ├─rndrng_prvdr_first_name: "Thomas"
    #> ├─rndrng_prvdr_mi: "L"
    #> ├─rndrng_prvdr_crdntls: "M.D."
    #> ├─rndrng_prvdr_gndr: "M"
    #> ├─rndrng_prvdr_ent_cd: "I"
    #> ├─rndrng_prvdr_st1: "2650 Ridge Ave"
    #> ├─rndrng_prvdr_st2: "Evanston Hospital"
    #> ├─rndrng_prvdr_city: "Evanston"
    #> ├─rndrng_prvdr_state_abrvtn: "IL"
    #> ├─rndrng_prvdr_state_fips: "17"
    #> ├─rndrng_prvdr_zip5: "60201"
    #> ├─rndrng_prvdr_ruca: "1"
    #> ├─rndrng_prvdr_ruca_desc: "Metropolitan area core: primary..."
    #> ├─rndrng_prvdr_cntry: "US"
    #> ├─rndrng_prvdr_type: "Pathology"
    #> ├─rndrng_prvdr_mdcr_prtcptg_ind: "Y"
    #> ├─tot_hcpcs_cds: 18
    #> ├─tot_benes: 2633
    #> ├─tot_srvcs: 5930
    #> ├─tot_sbmtd_chrg: 915291
    #> ├─tot_mdcr_alowd_amt: 227372.53
    #> ├─tot_mdcr_pymt_amt: 176497.74
    #> ├─tot_mdcr_stdzd_amt: 167363.18
    #> ├─drug_sprsn_ind: ""
    #> ├─drug_tot_hcpcs_cds: 0
    #> ├─drug_tot_benes: 0
    #> ├─drug_tot_srvcs: 0
    #> ├─drug_sbmtd_chrg: 0
    #> ├─drug_mdcr_alowd_amt: 0
    #> ├─drug_mdcr_pymt_amt: 0
    #> ├─drug_mdcr_stdzd_amt: 0
    #> ├─med_sprsn_ind: ""
    #> ├─med_tot_hcpcs_cds: 18
    #> ├─med_tot_benes: 2633
    #> ├─med_tot_srvcs: 5930
    #> ├─med_sbmtd_chrg: 915291
    #> ├─med_mdcr_alowd_amt: 227372.53
    #> ├─med_mdcr_pymt_amt: 176497.74
    #> ├─med_mdcr_stdzd_amt: 167363.18
    #> ├─bene_avg_age: 76
    #> ├─bene_age_lt_65_cnt: 69
    #> ├─bene_age_65_74_cnt: 1189
    #> ├─bene_age_75_84_cnt: 963
    #> ├─bene_age_gt_84_cnt: 412
    #> ├─bene_feml_cnt: 1310
    #> ├─bene_male_cnt: 1323
    #> ├─bene_race_wht_cnt: 2385
    #> ├─bene_race_black_cnt: NA
    #> ├─bene_race_api_cnt: 45
    #> ├─bene_race_hspnc_cnt: 49
    #> ├─bene_race_nat_ind_cnt: NA
    #> ├─bene_race_othr_cnt: 128
    #> ├─bene_dual_cnt: 125
    #> ├─bene_ndual_cnt: 2508
    #> ├─bene_cc_af_pct: 0.1
    #> ├─bene_cc_alzhmr_pct: 0.06
    #> ├─bene_cc_asthma_pct: 0.04
    #> ├─bene_cc_cncr_pct: 0.14
    #> ├─bene_cc_chf_pct: 0.12
    #> ├─bene_cc_ckd_pct: 0.22
    #> ├─bene_cc_copd_pct: 0.06
    #> ├─bene_cc_dprssn_pct: 0.15
    #> ├─bene_cc_dbts_pct: 0.2
    #> ├─bene_cc_hyplpdma_pct: 0.48
    #> ├─bene_cc_hyprtnsn_pct: 0.48
    #> ├─bene_cc_ihd_pct: 0.24
    #> ├─bene_cc_opo_pct: 0.1
    #> ├─bene_cc_raoa_pct: 0.38
    #> ├─bene_cc_sz_pct: 0.01
    #> ├─bene_cc_strok_pct: 0.03
    #> └─bene_avg_risk_scre: 1.1124

<br>

`provider_clia()` accesses **Medicare’s Provider of Services File for
Clinical Laboratories API**:

<br>

``` r
clia_ex <- provider_clia(name = "carbon hill", 
                         year = "2022")
```

<br>

    #> S3<data.frame>
    #> ├─prvdr_ctgry_sbtyp_cd<chr [7]>: "01", "01", "01", "01", "01", "01", "01"
    #> ├─prvdr_ctgry_cd<chr [7]>: "22", "22", "22", "22", "22", "22", "22"
    #> ├─chow_cnt<chr [7]>: "00", "00", "00", "00", "00", "00", "00"
    #> ├─chow_dt<chr [7]>: "", "", "", "", "", "", ""
    #> ├─city_name<chr [7]>: "CARBON HILL", "CARBON HILL", "CARBON HILL", "CARBON HILL", "CARBON HILL", "CARBON HILL", "CARBON HILL"
    #> ├─acptbl_poc_sw<chr [7]>: "N", "N", "N", "N", "N", "N", "N"
    #> ├─cmplnc_stus_cd<chr [7]>: "A", "", "B", "", "", "", ""
    #> ├─ssa_cnty_cd<chr [7]>: "630", "630", "630", "630", "630", "400", "380"
    #> ├─cross_ref_provider_number<chr [7]>: "", "", "", "", "", "", ""
    #> ├─crtfctn_dt<chr [7]>: "20041213", "19950619", "20101213", "20091216", "20210225", "20210923", "19940922"
    #> ├─elgblty_sw<chr [7]>: "Y", "N", "Y", "N", "N", "N", "N"
    #> ├─fac_name<chr [7]>: "CARBON HILL...", "WALKER REHAB...", "QUEST DIAGNO...", "CARBON HILL...", "CARBON HILL...", "COAL CITY SC...", "HOCKING VALL..."
    #> ├─intrmdry_carr_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─mdcd_vndr_num<chr [7]>: "", "", "", "", "", "", ""
    #> ├─orgnl_prtcptn_dt<chr [7]>: "19920901", "19950619", "20061220", "20091216", "20210225", "20210923", "19940922"
    #> ├─chow_prior_dt<chr [7]>: "", "", "", "", "", "", ""
    #> ├─intrmdry_carr_prior_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─prvdr_num<chr [7]>: "01D0302047", "01D0902331", "01D1062626", "01D2001338", "01D2214879", "14D2237280", "36D0892007"
    #> ├─rgn_cd<chr [7]>: "04", "04", "04", "04", "04", "05", "05"
    #> ├─skltn_rec_sw<chr [7]>: "N", "Y", "N", "Y", "Y", "Y", "Y"
    #> ├─state_cd<chr [7]>: "AL", "AL", "AL", "AL", "AL", "IL", "OH"
    #> ├─ssa_state_cd<chr [7]>: "01", "01", "01", "01", "01", "14", "36"
    #> ├─state_rgn_cd<chr [7]>: "001", "LAB", "001", "001", "001", "001", "LAB"
    #> ├─st_adr<chr [7]>: "317 NW SECON...", "516 EAST 4TH...", "31040 NORTH...", "31040 NORTHE...", "31040 1ST AV...", "550 S CARBON...", "15047 FIRST..."
    #> ├─phne_num<chr [7]>: "2059244441", "2059244404", "2053131240", "2059242224", "2059249616", "8156345031", "7407539357"
    #> ├─pgm_trmntn_cd<chr [7]>: "01", "00", "00", "01", "00", "00", "08"
    #> ├─trmntn_exprtn_dt<chr [7]>: "20061201", "20230618", "20230831", "20130802", "20230224", "20230922", "20100921"
    #> ├─crtfctn_actn_type_cd<chr [7]>: "2", "", "2", "", "", "", ""
    #> ├─gnrl_cntl_type_cd<chr [7]>: "04", "04", "04", "04", "04", "09", "04"
    #> ├─zip_cd<chr [7]>: "35549", "35549", "35549", "35549", "35549", "60416", "43111"
    #> ├─fips_state_cd<chr [7]>: "01", "01", "01", "01", "01", "17", "39"
    #> ├─fips_cnty_cd<chr [7]>: "127", "127", "127", "127", "127", "063", "073"
    #> ├─cbsa_urbn_rrl_ind<chr [7]>: "R", "R", "R", "R", "R", "U", "U"
    #> ├─cbsa_cd<chr [7]>: "13820", "13820", "13820", "13820", "13820", "16974", "18140"
    #> ├─addtnl_st_adr<chr [7]>: "", "", "", "", "", "", ""
    #> ├─affiliated_provider_number_1<chr [7]>: "", "", "01D1062628", "", "", "", ""
    #> ├─affiliated_provider_number_2<chr [7]>: "", "", "", "", "", "", ""
    #> ├─affiliated_provider_number_3<chr [7]>: "", "", "", "", "", "", ""
    #> ├─affiliated_provider_number_4<chr [7]>: "", "", "", "", "", "", ""
    #> ├─affiliated_provider_number_5<chr [7]>: "", "", "", "", "", "", ""
    #> ├─affiliated_provider_number_6<chr [7]>: "", "", "", "", "", "", ""
    #> ├─affiliated_provider_number_7<chr [7]>: "", "", "", "", "", "", ""
    #> ├─affiliated_provider_number_8<chr [7]>: "", "", "", "", "", "", ""
    #> ├─a2la_acrdtd_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─a2la_acrdtd_y_match_dt<chr [7]>: "", "", "", "", "", "", ""
    #> ├─a2la_acrdtd_y_match_sw<chr [7]>: "N", "N", "N", "N", "N", "N", "N"
    #> ├─aabb_acrdtd_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─aabb_acrdtd_y_match_dt<chr [7]>: "", "", "", "", "", "", ""
    #> ├─aabb_acrdtd_y_match_sw<chr [7]>: "N", "N", "N", "N", "N", "N", "N"
    #> ├─aoa_acrdtd_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─aoa_acrdtd_y_match_dt<chr [7]>: "", "", "", "", "", "", ""
    #> ├─aoa_acrdtd_y_match_sw<chr [7]>: "N", "N", "N", "N", "N", "N", "N"
    #> ├─ashi_acrdtd_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─ashi_acrdtd_y_match_dt<chr [7]>: "", "", "", "", "", "", ""
    #> ├─ashi_acrdtd_y_match_sw<chr [7]>: "N", "N", "N", "N", "N", "N", "N"
    #> ├─cap_acrdtd_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─cap_acrdtd_y_match_dt<chr [7]>: "", "", "", "", "", "", ""
    #> ├─cap_acrdtd_y_match_sw<chr [7]>: "N", "N", "N", "N", "N", "N", "N"
    #> ├─cola_acrdtd_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─cola_acrdtd_y_match_dt<chr [7]>: "", "", "", "", "", "", ""
    #> ├─cola_acrdtd_y_match_sw<chr [7]>: "N", "N", "N", "N", "N", "N", "N"
    #> ├─jcaho_acrdtd_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─jcaho_acrdtd_y_match_dt<chr [7]>: "", "", "", "", "", "", ""
    #> ├─jcaho_acrdtd_y_match_sw<chr [7]>: "N", "N", "N", "N", "N", "N", "N"
    #> ├─aplctn_rcvd_dt<chr [7]>: "19930115", "19950619", "20061220", "20091216", "20210225", "20210923", "19940922"
    #> ├─aplctn_type_cd<chr [7]>: "1", "2", "2", "4", "2", "2", "2"
    #> ├─gnrl_fac_type_cd<chr [7]>: "21", "27", "15", "21", "20", "26", "19"
    #> ├─crtfct_efctv_dt<chr [7]>: "20050623", "20210619", "20210901", "20111216", "20210225", "20210923", "20080922"
    #> ├─crtfct_mail_dt<chr [7]>: "20050524", "20210921", "20210803", "20111119", "20210316", "20211005", "20080823"
    #> ├─crtfct_type_cd<chr [7]>: "1", "2", "2", "4", "2", "2", "2"
    #> ├─current_clia_lab_clsfctn_cd<chr [7]>: "00", "00", "00", "00", "00", "00", "00"
    #> ├─clia_lab_classification_cd_1<chr [7]>: "00", "00", "00", "00", "00", "00", "00"
    #> ├─clia_lab_classification_cd_10<chr [7]>: "", "00", "00", "", "", "", ""
    #> ├─clia_lab_classification_cd_2<chr [7]>: "00", "00", "00", "00", "", "", "00"
    #> ├─clia_lab_classification_cd_3<chr [7]>: "00", "00", "00", "", "", "", "00"
    #> ├─clia_lab_classification_cd_4<chr [7]>: "00", "00", "00", "", "", "", "00"
    #> ├─clia_lab_classification_cd_5<chr [7]>: "00", "00", "00", "", "", "", "00"
    #> ├─clia_lab_classification_cd_6<chr [7]>: "00", "00", "00", "", "", "", "00"
    #> ├─clia_lab_classification_cd_7<chr [7]>: "00", "00", "00", "", "", "", "00"
    #> ├─clia_lab_classification_cd_8<chr [7]>: "00", "00", "00", "", "", "", "00"
    #> ├─clia_lab_classification_cd_9<chr [7]>: "", "00", "00", "", "", "", ""
    #> ├─clia_mdcr_num<chr [7]>: "", "", "", "", "", "", ""
    #> ├─clia_trmntn_cd<chr [7]>: "01", "00", "00", "01", "00", "00", "08"
    #> ├─acrdtn_schdl_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─form_116_acrdtd_test_vol_cnt<chr [7]>: "0", "0", "0", "0", "0", "0", "0"
    #> ├─form_116_test_vol_cnt<chr [7]>: "0", "0", "0", "0", "0", "0", "0"
    #> ├─drctly_afltd_lab_cnt<chr [7]>: "0", "0", "1", "0", "0", "0", "0"
    #> ├─fax_phne_num<chr [7]>: "2059244463", "", "", "2059244077", "2059249767", "8156348775", "7404748172"
    #> ├─fy_end_mo_day_cd<chr [7]>: "1231", "", "1231", "", "", "", ""
    #> ├─mlt_site_excptn_sw<chr [7]>: "N", "N", "N", "N", "N", "Y", "N"
    #> ├─hosp_lab_excptn_sw<chr [7]>: "N", "N", "N", "N", "N", "N", "N"
    #> ├─non_prft_excptn_sw<chr [7]>: "N", "N", "N", "N", "N", "Y", "N"
    #> ├─lab_temp_tstg_site_sw<chr [7]>: "N", "N", "N", "N", "N", "N", "N"
    #> ├─lab_site_cnt<chr [7]>: "0", "0", "0", "0", "0", "6", "0"
    #> ├─ppmp_test_vol_cnt<chr [7]>: "0", "0", "0", "600", "0", "0", "0"
    #> ├─addtnl_fac_name<chr [7]>: "", "", "", "", "", "", ""
    #> ├─related_provider_number<chr [7]>: "", "", "", "", "", "", ""
    #> ├─shr_lab_sw<chr [7]>: "N", "N", "N", "N", "N", "N", "N"
    #> ├─shared_lab_xref_number<chr [7]>: "", "", "", "", "", "", ""
    #> ├─form_1557_crtfct_schdl_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─form_1557_cmplnc_schdl_cd<chr [7]>: "", "", "", "", "", "", ""
    #> ├─form_1557_test_vol_cnt<chr [7]>: "0", "0", "0", "0", "0", "0", "0"
    #> └─wvd_test_vol_cnt<chr [7]>: "0", "1300", "200", "1200", "50", "400", "10"

Using packages like {gt} & {ggplot2}, you can create tables and graphs
for reporting purposes:

<br>

<br>

<img src="man/figures/gt_provider.png" style="width:100.0%" />

<img src="man/figures/gt_provider2.png" style="width:100.0%" />

<img src="man/figures/gt_provider3.png" style="width:100.0%" />

<br> <br>

------------------------------------------------------------------------

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
