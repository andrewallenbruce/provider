
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
    #> 1 2022-10-06 19:21:17 results <df [1 × 11]>

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

| NPI        | Last    | First | Opt-Out Begins | Opt-Out Ends | Order & Refer Eligible | Updated    | Specialty          | Address          | City     | State |  age |
|:-----------|:--------|:------|:---------------|:-------------|:-----------------------|:-----------|:-------------------|:-----------------|:---------|:------|-----:|
| 1114974490 | Altchek | David | 2012-07-01     | 2024-07-01   | Y                      | 08/15/2022 | Orthopedic Surgery | 535 EAST 70TH ST | NEW YORK | NY    | -633 |

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

1.  by Provider and Service API:

<br>

``` r
mpop_serv_ex <- provider_mpop(npi = 1760485387, 
                              set = "serv",
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

2.  by Geography and Service API:

<br>

``` r
mpop_geo_ex1 <- provider_mpop(hcpcs = "99214", 
                              set = "geo",
                              year = "2020")

mpop_geo_ex2 <- provider_mpop(hcpcs = "99214", 
                              set = "geo",
                              year = "2019")

mpop_geo_99214 <- dplyr::bind_rows(mpop_geo_ex1, mpop_geo_ex2)
```

<br>

| Year | HCPCS | Level    | Region                             | FIPS | POS | Providers | Beneficiaries | Services   | Distinct Beneficiaries Per Day Services | Avg Charge   | Avg Allowed  | Avg Payment  | Avg Standard Pymt |
|:-----|:------|:---------|:-----------------------------------|:-----|:----|:----------|:--------------|:-----------|:----------------------------------------|:-------------|:-------------|:-------------|:------------------|
| 2020 | 99214 | National | National                           |      | F   | 159324    | 3183652       | 7008865    | 7007708                                 | 210.09590176 | 77.348125868 | 55.276294601 | 54.775983048      |
| 2020 | 99214 | National | National                           |      | O   | 551728    | 21794074      | 81741450.8 | 81710520                                | 222.24271159 | 104.99486506 | 72.227897324 | 72.377731393      |
| 2020 | 99214 | State    |                                    |      | O   | 1         | 23            | 23         | 23                                      | 115          | 90.884347826 | 66.369130435 | 67.441304348      |
| 2020 | 99214 | State    | Alabama                            | 01   | F   | 1520      | 36142         | 79848      | 79844                                   | 205.1435654  | 72.510556683 | 51.435830703 | 53.514837065      |
| 2020 | 99214 | State    | Alabama                            | 01   | O   | 7833      | 392296        | 1415952    | 1415921                                 | 160.94829157 | 99.083887787 | 67.106584813 | 73.015723203      |
| 2020 | 99214 | State    | Alaska                             | 02   | F   | 391       | 5906          | 11405      | 11405                                   | 298.90256642 | 101.30883209 | 73.257391495 | 54.519937747      |
| 2020 | 99214 | State    | Alaska                             | 02   | O   | 1362      | 47371         | 130619     | 130607                                  | 335.45108062 | 130.17461556 | 89.189372756 | 69.569780124      |
| 2020 | 99214 | State    | Arizona                            | 04   | F   | 2974      | 37818         | 65739      | 65728                                   | 188.67394636 | 75.715326366 | 54.911745691 | 55.152802142      |
| 2020 | 99214 | State    | Arizona                            | 04   | O   | 12020     | 571554        | 2345308.8  | 2343781                                 | 210.69222189 | 102.4568124  | 71.44178651  | 73.440767719      |
| 2020 | 99214 | State    | Arkansas                           | 05   | F   | 1176      | 45101         | 92284      | 92278                                   | 183.79388453 | 71.259373456 | 50.815368103 | 55.390971674      |
| 2020 | 99214 | State    | Arkansas                           | 05   | O   | 4606      | 300050        | 1015440    | 1015384                                 | 174.47400728 | 92.713082506 | 61.459495224 | 71.29237631       |
| 2020 | 99214 | State    | California                         | 06   | F   | 10349     | 215658        | 504645     | 504578                                  | 310.41868371 | 83.028589147 | 60.062330232 | 55.843487699      |
| 2020 | 99214 | State    | California                         | 06   | O   | 47031     | 1862063       | 7414408.8  | 7397050                                 | 246.13483514 | 115.17086162 | 81.41191161  | 75.11971651       |
| 2020 | 99214 | State    | Colorado                           | 08   | F   | 2761      | 46427         | 94926      | 94897                                   | 240.32386048 | 77.038145503 | 55.781380022 | 54.926256874      |
| 2020 | 99214 | State    | Colorado                           | 08   | O   | 9708      | 317370        | 987970     | 987707                                  | 228.03931578 | 103.50585794 | 70.442143193 | 71.714595008      |
| 2020 | 99214 | State    | Connecticut                        | 09   | F   | 1992      | 27912         | 56522      | 56472                                   | 259.23726797 | 81.31414635  | 59.15523106  | 55.323602137      |
| 2020 | 99214 | State    | Connecticut                        | 09   | O   | 7792      | 259175        | 865599     | 865443                                  | 233.2622691  | 112.11484367 | 78.369415757 | 72.61909696       |
| 2020 | 99214 | State    | Delaware                           | 10   | F   | 693       | 16034         | 26394      | 26394                                   | 187.78940403 | 78.517715011 | 56.469921952 | 54.785387588      |
| 2020 | 99214 | State    | Delaware                           | 10   | O   | 1760      | 134246        | 445720     | 445688                                  | 193.61631111 | 107.68341912 | 74.705530984 | 73.132837858      |
| 2020 | 99214 | State    | District of Columbia               | 11   | F   | 614       | 11981         | 22286      | 22262                                   | 244.43772009 | 85.859495199 | 61.547210356 | 55.599667056      |
| 2020 | 99214 | State    | District of Columbia               | 11   | O   | 1800      | 70729         | 154824     | 154809                                  | 238.40224313 | 119.01529627 | 83.084944065 | 74.584647923      |
| 2020 | 99214 | State    | Florida                            | 12   | F   | 7200      | 125625        | 267789     | 267715                                  | 211.89968744 | 80.110269802 | 59.623711691 | 57.125636639      |
| 2020 | 99214 | State    | Florida                            | 12   | O   | 36723     | 1835558       | 8075137    | 8074852                                 | 225.85020218 | 107.5026197  | 76.270341913 | 75.369828804      |
| 2020 | 99214 | State    | Georgia                            | 13   | F   | 3296      | 52559         | 113411     | 113404                                  | 246.44701484 | 75.272152437 | 54.577959281 | 55.22478331       |
| 2020 | 99214 | State    | Georgia                            | 13   | O   | 15582     | 731013        | 2680310    | 2680232                                 | 230.62550305 | 102.58046417 | 70.135654055 | 72.735362869      |
| 2020 | 99214 | State    | Hawaii                             | 15   | F   | 340       | 7579          | 15257      | 15257                                   | 172.97984859 | 74.175368683 | 49.853446287 | 54.866903061      |
| 2020 | 99214 | State    | Hawaii                             | 15   | O   | 1896      | 71853         | 226053     | 226013                                  | 191.12989489 | 105.50103918 | 70.334802591 | 72.434938665      |
| 2020 | 99214 | State    | Idaho                              | 16   | F   | 1007      | 37567         | 78838      | 78835                                   | 147.20396649 | 72.129012405 | 50.599269515 | 53.059054897      |
| 2020 | 99214 | State    | Idaho                              | 16   | O   | 2922      | 110058        | 281489     | 281479                                  | 191.46620152 | 90.946234276 | 60.848612024 | 66.144896852      |
| 2020 | 99214 | State    | Illinois                           | 17   | F   | 7363      | 161326        | 342798     | 342754                                  | 211.38865002 | 81.203670646 | 57.979187131 | 55.049977654      |
| 2020 | 99214 | State    | Illinois                           | 17   | O   | 21399     | 963991        | 3039737.4  | 3039271                                 | 220.02822146 | 107.3717184  | 73.373017597 | 71.467745748      |
| 2020 | 99214 | State    | Indiana                            | 18   | F   | 3319      | 59386         | 116154     | 116152                                  | 185.60503831 | 73.899383577 | 53.657553851 | 55.996130051      |
| 2020 | 99214 | State    | Indiana                            | 18   | O   | 12239     | 570825        | 1745990    | 1745943                                 | 181.88700161 | 99.012284423 | 65.995770818 | 71.039360855      |
| 2020 | 99214 | State    | Iowa                               | 19   | F   | 2268      | 65456         | 136324     | 136321                                  | 218.79264157 | 73.535505927 | 52.01279892  | 54.497457161      |
| 2020 | 99214 | State    | Iowa                               | 19   | O   | 5114      | 261257        | 680174     | 680161                                  | 211.36738685 | 96.830092521 | 64.706770047 | 69.590372625      |
| 2020 | 99214 | State    | Kansas                             | 20   | F   | 1640      | 45385         | 94969      | 94963                                   | 176.42252567 | 73.411358654 | 52.921658331 | 55.015447251      |
| 2020 | 99214 | State    | Kansas                             | 20   | O   | 4820      | 265076        | 727890     | 727869                                  | 185.41351519 | 98.212117435 | 66.197808886 | 70.985012969      |
| 2020 | 99214 | State    | Kentucky                           | 21   | F   | 2429      | 52516         | 110038     | 110024                                  | 175.16416801 | 74.163287228 | 53.769579691 | 55.610856159      |
| 2020 | 99214 | State    | Kentucky                           | 21   | O   | 8442      | 374239        | 1124984    | 1124918                                 | 192.00521966 | 96.441784994 | 64.210425873 | 70.074797668      |
| 2020 | 99214 | State    | Louisiana                          | 22   | F   | 3090      | 74527         | 189085     | 189060                                  | 211.14602644 | 76.624087685 | 54.343913954 | 54.455219557      |
| 2020 | 99214 | State    | Louisiana                          | 22   | O   | 7453      | 327020        | 1169997    | 1168588                                 | 201.02632825 | 100.77465224 | 69.300953028 | 73.540544156      |
| 2020 | 99214 | State    | Maine                              | 23   | F   | 1334      | 31973         | 61381      | 61366                                   | 171.17372982 | 74.170882358 | 52.249566478 | 52.802834265      |
| 2020 | 99214 | State    | Maine                              | 23   | O   | 2842      | 93148         | 239293     | 239271                                  | 186.71529359 | 88.597069158 | 60.282775342 | 61.635517211      |
| 2020 | 99214 | State    | Maryland                           | 24   | F   | 3454      | 55604         | 103115     | 103109                                  | 224.25884963 | 81.80582728  | 59.235088106 | 55.737853077      |
| 2020 | 99214 | State    | Maryland                           | 24   | O   | 11949     | 637179        | 2270876.5  | 2270313                                 | 224.98333197 | 113.08057524 | 78.314033432 | 73.747577766      |
| 2020 | 99214 | State    | Massachusetts                      | 25   | F   | 7354      | 186158        | 410356     | 410315                                  | 270.53208824 | 82.524863679 | 57.991519827 | 53.806579701      |
| 2020 | 99214 | State    | Massachusetts                      | 25   | O   | 15760     | 633167        | 1974920.4  | 1974192                                 | 297.93788582 | 110.02902078 | 75.541291411 | 71.299052235      |
| 2020 | 99214 | State    | Michigan                           | 26   | F   | 7737      | 138918        | 261407     | 261397                                  | 159.59701431 | 77.421972786 | 55.903044333 | 55.437830815      |
| 2020 | 99214 | State    | Michigan                           | 26   | O   | 18757     | 638966        | 1961164.5  | 1961076                                 | 172.76981897 | 100.05393603 | 68.076350567 | 70.502408181      |
| 2020 | 99214 | State    | Minnesota                          | 27   | F   | 4499      | 80782         | 177355     | 177351                                  | 205.787981   | 74.634189676 | 52.396218263 | 53.175491077      |
| 2020 | 99214 | State    | Minnesota                          | 27   | O   | 12253     | 309339        | 837752     | 837712                                  | 270.17793253 | 100.33935511 | 67.971589779 | 69.38939395       |
| 2020 | 99214 | State    | Mississippi                        | 28   | F   | 1291      | 52608         | 114595     | 114573                                  | 159.9295231  | 72.47030202  | 51.857801824 | 54.901542825      |
| 2020 | 99214 | State    | Mississippi                        | 28   | O   | 4560      | 302662        | 1004848    | 1004703                                 | 164.66484569 | 94.633746776 | 63.620419964 | 70.563961952      |
| 2020 | 99214 | State    | Missouri                           | 29   | F   | 3571      | 93655         | 200290     | 200284                                  | 167.59055    | 75.675727046 | 54.582908333 | 55.554886714      |
| 2020 | 99214 | State    | Missouri                           | 29   | O   | 10170     | 469160        | 1343728    | 1343662                                 | 187.66035684 | 99.474534422 | 67.459365392 | 70.927714835      |
| 2020 | 99214 | State    | Montana                            | 30   | F   | 975       | 43071         | 100697     | 100695                                  | 145.10776061 | 76.127983555 | 52.419978847 | 52.743285897      |
| 2020 | 99214 | State    | Montana                            | 30   | O   | 1831      | 77126         | 174590     | 174588                                  | 215.32122802 | 96.403420757 | 63.708121026 | 67.632932069      |
| 2020 | 99214 | State    | Nebraska                           | 31   | F   | 1570      | 39048         | 76906      | 76906                                   | 226.97568343 | 73.721426937 | 53.875004941 | 56.424432424      |
| 2020 | 99214 | State    | Nebraska                           | 31   | O   | 3722      | 175114        | 514615     | 514598                                  | 222.87379194 | 96.802549887 | 65.440705032 | 71.93241804       |
| 2020 | 99214 | State    | Nevada                             | 32   | F   | 457       | 6182          | 11283      | 11283                                   | 207.59090313 | 77.822178499 | 54.493256226 | 53.754315342      |
| 2020 | 99214 | State    | Nevada                             | 32   | O   | 4313      | 197952        | 748825     | 748027                                  | 235.19920439 | 104.41996647 | 72.893990331 | 73.356487898      |
| 2020 | 99214 | State    | New Hampshire                      | 33   | F   | 1384      | 40397         | 78443      | 78384                                   | 170.87329908 | 77.563916729 | 54.795118749 | 53.417591882      |
| 2020 | 99214 | State    | New Hampshire                      | 33   | O   | 3258      | 141129        | 387727     | 387609                                  | 237.03113817 | 100.52269465 | 68.471913898 | 66.918092008      |
| 2020 | 99214 | State    | New Jersey                         | 34   | F   | 3576      | 40464         | 74321      | 74279                                   | 260.41683104 | 83.351365832 | 61.307834663 | 56.551905518      |
| 2020 | 99214 | State    | New Jersey                         | 34   | O   | 15886     | 732766        | 2783371    | 2781837                                 | 242.39193432 | 116.62831681 | 82.275001224 | 75.833846172      |
| 2020 | 99214 | State    | New Mexico                         | 35   | F   | 1120      | 26551         | 47082      | 47080                                   | 154.00234676 | 75.186712119 | 50.971591691 | 51.22546281       |
| 2020 | 99214 | State    | New Mexico                         | 35   | O   | 2999      | 129649        | 366134.5   | 365603                                  | 209.07645649 | 98.254699052 | 65.680693051 | 68.801317876      |
| 2020 | 99214 | State    | New York                           | 36   | F   | 8748      | 142073        | 283533     | 283505                                  | 233.61506735 | 80.983195184 | 57.739476428 | 54.86768743       |
| 2020 | 99214 | State    | New York                           | 36   | O   | 37056     | 1296065       | 4602104    | 4601076                                 | 283.39536849 | 116.39076677 | 82.869412469 | 74.364372289      |
| 2020 | 99214 | State    | North Carolina                     | 37   | F   | 4895      | 104742        | 214197     | 214195                                  | 205.43656013 | 74.589476136 | 53.746011289 | 54.853143835      |
| 2020 | 99214 | State    | North Carolina                     | 37   | O   | 19868     | 928038        | 3370272.5  | 3370192                                 | 210.56305146 | 99.479955318 | 67.093697889 | 69.978832051      |
| 2020 | 99214 | State    | North Dakota                       | 38   | F   | 999       | 37870         | 85096      | 85095                                   | 148.61659267 | 72.523610981 | 51.028977155 | 52.704553328      |
| 2020 | 99214 | State    | North Dakota                       | 38   | O   | 1505      | 60365         | 137963     | 137961                                  | 220.70487007 | 85.983504998 | 56.637638207 | 61.535324544      |
| 2020 | 99214 | State    | Ohio                               | 39   | F   | 8509      | 151443        | 312876     | 312860                                  | 195.16972769 | 74.761235825 | 53.071835647 | 54.402501119      |
| 2020 | 99214 | State    | Ohio                               | 39   | O   | 22540     | 836719        | 2559955.5  | 2559705                                 | 190.04995421 | 96.339609936 | 63.160998783 | 68.937073597      |
| 2020 | 99214 | State    | Oklahoma                           | 40   | F   | 1400      | 64471         | 139174     | 139168                                  | 161.9307237  | 73.42220501  | 52.445030825 | 55.631847759      |
| 2020 | 99214 | State    | Oklahoma                           | 40   | O   | 6299      | 340808        | 1173165    | 1172883                                 | 190.07422913 | 96.223074444 | 64.337655436 | 71.59497127       |
| 2020 | 99214 | State    | Oregon                             | 41   | F   | 1813      | 31206         | 59992      | 59990                                   | 212.95843629 | 74.174419256 | 51.347289639 | 53.430671256      |
| 2020 | 99214 | State    | Oregon                             | 41   | O   | 7541      | 249109        | 718708     | 718681                                  | 275.27961161 | 97.836804627 | 64.591001102 | 69.328892679      |
| 2020 | 99214 | State    | Pennsylvania                       | 42   | F   | 9393      | 153567        | 297661     | 297628                                  | 193.61243808 | 78.673685837 | 57.011625809 | 55.594610379      |
| 2020 | 99214 | State    | Pennsylvania                       | 42   | O   | 27048     | 1065959       | 3274192.5  | 3273850                                 | 197.23298606 | 105.33099233 | 71.012891365 | 71.502111661      |
| 2020 | 99214 | State    | Rhode Island                       | 44   | F   | 514       | 10190         | 17774      | 17771                                   | 240.47861764 | 80.707722516 | 59.793630584 | 57.466036345      |
| 2020 | 99214 | State    | Rhode Island                       | 44   | O   | 2349      | 85494         | 239300     | 239278                                  | 223.4746471  | 103.17027522 | 69.670009068 | 71.520000418      |
| 2020 | 99214 | State    | South Carolina                     | 45   | F   | 2017      | 40063         | 84690      | 84685                                   | 175.8427779  | 74.246869642 | 54.052788759 | 55.995111347      |
| 2020 | 99214 | State    | South Carolina                     | 45   | O   | 8469      | 540638        | 1957098    | 1957059                                 | 197.47521927 | 100.45660662 | 68.248547574 | 72.70845203       |
| 2020 | 99214 | State    | South Dakota                       | 46   | F   | 965       | 41357         | 84471      | 84469                                   | 123.8410664  | 75.113403298 | 51.800475548 | 52.565231736      |
| 2020 | 99214 | State    | South Dakota                       | 46   | O   | 1544      | 66440         | 137921.9   | 137889                                  | 178.84161167 | 94.331157778 | 63.529701302 | 65.522530577      |
| 2020 | 99214 | State    | Tennessee                          | 47   | F   | 2781      | 58713         | 122135     | 122132                                  | 250.09284022 | 72.822589675 | 52.2674398   | 55.214030949      |
| 2020 | 99214 | State    | Tennessee                          | 47   | O   | 12813     | 622864        | 2206367    | 2206183                                 | 211.55497102 | 96.877030485 | 65.484275272 | 71.476194278      |
| 2020 | 99214 | State    | Texas                              | 48   | F   | 8613      | 168573        | 370165     | 370104                                  | 220.6652019  | 76.514533762 | 55.060893656 | 55.29101525       |
| 2020 | 99214 | State    | Texas                              | 48   | O   | 35559     | 1533940       | 5831944.4  | 5830416                                 | 228.67059604 | 103.35461487 | 71.323253323 | 73.237808243      |
| 2020 | 99214 | State    | Utah                               | 49   | F   | 985       | 13270         | 21206      | 21206                                   | 200.69927945 | 75.528274545 | 53.081242573 | 53.766837216      |
| 2020 | 99214 | State    | Utah                               | 49   | O   | 4758      | 167300        | 536303     | 536236                                  | 189.65558065 | 99.285654714 | 67.192795584 | 71.030764232      |
| 2020 | 99214 | State    | Vermont                            | 50   | F   | 581       | 23896         | 42279      | 42274                                   | 118.08173869 | 75.784508858 | 51.969480357 | 52.308216845      |
| 2020 | 99214 | State    | Vermont                            | 50   | O   | 1175      | 48355         | 113250     | 113237                                  | 158.28948618 | 92.660874525 | 60.800794084 | 62.337313731      |
| 2020 | 99214 | State    | Virginia                           | 51   | F   | 3657      | 95907         | 189510     | 189506                                  | 190.61620928 | 77.599657643 | 54.595257137 | 53.735305314      |
| 2020 | 99214 | State    | Virginia                           | 51   | O   | 14044     | 805356        | 2681633    | 2681487                                 | 204.99953833 | 105.93819925 | 71.866718954 | 70.452226853      |
| 2020 | 99214 | State    | Washington                         | 53   | F   | 3721      | 102236        | 220527     | 220258                                  | 169.28406993 | 79.624110971 | 55.840488648 | 53.676841294      |
| 2020 | 99214 | State    | Washington                         | 53   | O   | 13567     | 485442        | 1508067    | 1507829                                 | 243.79604516 | 104.57676532 | 70.80639955  | 69.250291207      |
| 2020 | 99214 | State    | West Virginia                      | 54   | F   | 1577      | 41961         | 83893      | 83893                                   | 169.61415625 | 75.045466725 | 52.503531045 | 53.571188657      |
| 2020 | 99214 | State    | West Virginia                      | 54   | O   | 3063      | 151552        | 397713.1   | 397704                                  | 190.62322667 | 96.45296255  | 63.704986006 | 68.901040499      |
| 2020 | 99214 | State    | Wisconsin                          | 55   | F   | 5130      | 110076        | 234329     | 234191                                  | 227.05510155 | 73.282948461 | 51.161874928 | 53.211402729      |
| 2020 | 99214 | State    | Wisconsin                          | 55   | O   | 11090     | 366178        | 953363     | 953286                                  | 291.68981092 | 97.539644028 | 63.843308645 | 67.267376802      |
| 2020 | 99214 | State    | Wyoming                            | 56   | F   | 153       | 2936          | 5880       | 5879                                    | 250.03065816 | 75.710772109 | 54.888858844 | 54.612243197      |
| 2020 | 99214 | State    | Wyoming                            | 56   | O   | 972       | 49550         | 121035     | 121022                                  | 234.62237568 | 103.07802619 | 70.275353658 | 70.538635849      |
| 2020 | 99214 | State    | Guam                               | 66   | F   | 13        | 234           | 479        | 479                                     | 334.28206681 | 81.441837161 | 61.216805846 | 58.240793319      |
| 2020 | 99214 | State    | Guam                               | 66   | O   | 106       | 5652          | 16557      | 16556                                   | 137.64835236 | 112.30173884 | 73.445336716 | 71.29760645       |
| 2020 | 99214 | State    | Northern Mariana Islands           | 69   | F   | 6         | 62            | 293        | 293                                     | 261.67696246 | 77.826109215 | 58.466962457 | 56.240409556      |
| 2020 | 99214 | State    | Northern Mariana Islands           | 69   | O   | 8         | 437           | 1230       | 1230                                    | 128.8585122  | 109.95365041 | 59.358260163 | 58.758097561      |
| 2020 | 99214 | State    | Puerto Rico                        | 72   | F   | 84        | 931           | 2232       | 2232                                    | 118.90268369 | 79.080197133 | 58.096742832 | 58.100882616      |
| 2020 | 99214 | State    | Puerto Rico                        | 72   | O   | 1392      | 17829         | 42291      | 42284                                   | 127.96648199 | 104.78114492 | 70.737664515 | 74.063132345      |
| 2020 | 99214 | State    | Virgin Islands                     | 78   | O   | 90        | 7552          | 18225      | 18225                                   | 180.58116818 | 107.06860686 | 67.460698491 | 68.109063374      |
| 2020 | 99214 | State    | Armed Forces Central/South America | 9A   | O   | 2         | 39            | 49         | 49                                      | 132.85714286 | 95.223265306 | 61.574489796 | 71.953673469      |
| 2020 | 99214 | State    | Armed Forces Europe                | 9B   | F   | 6         | 233           | 291        | 291                                     | 142.78006873 | 75.629278351 | 51.869003436 | 52.134707904      |
| 2020 | 99214 | State    | Armed Forces Europe                | 9B   | O   | 23        | 1373          | 1973       | 1973                                    | 236.48953371 | 101.53946782 | 67.864820071 | 67.650466295      |
| 2020 | 99214 | State    | Armed Forces Pacific               | 9C   | F   | 3         | 45            | 48         | 48                                      | 92.5625      | 67.994583333 | 50.025833333 | 50.096041667      |
| 2020 | 99214 | State    | Armed Forces Pacific               | 9C   | O   | 9         | 645           | 779        | 779                                     | 231.60875481 | 105.79838254 | 74.947984596 | 74.968716303      |
| 2020 | 99214 | State    | Unknown                            | 9D   | F   | 6         | 85            | 113        | 113                                     | 177.12548673 | 67.229911504 | 40.354867257 | 40.760619469      |
| 2020 | 99214 | State    | Unknown                            | 9D   | O   | 8         | 923           | 2093       | 2093                                    | 172.14381271 | 107.06891543 | 76.065441949 | 76.603956044      |
| 2020 | 99214 | State    | Foreign Country                    | 9E   | F   | 9         | 60            | 71         | 71                                      | 184.33352113 | 77.205492958 | 58.671830986 | 59.53             |
| 2020 | 99214 | State    | Foreign Country                    | 9E   | O   | 27        | 1605          | 2427       | 2427                                    | 192.09091059 | 104.6926164  | 71.194845488 | 73.87223321       |
| 2019 | 99214 | National | National                           |      | F   | 159538    | 3613079       | 8691066    | 8690167                                 | 203.21581329 | 76.361859284 | 55.602596277 | 55.654806894      |
| 2019 | 99214 | National | National                           |      | O   | 540168    | 23594693      | 98005405.5 | 97997891                                | 215.61252223 | 104.2276743  | 73.187599059 | 73.99365968       |
| 2019 | 99214 | State    | Alabama                            | 01   | F   | 1601      | 43485         | 103176     | 103168                                  | 188.9911932  | 70.878119427 | 51.654438435 | 54.852405792      |
| 2019 | 99214 | State    | Alabama                            | 01   | O   | 7568      | 431466        | 1714452    | 1714418                                 | 156.3167449  | 97.861253304 | 67.642627749 | 74.834937595      |
| 2019 | 99214 | State    | Alaska                             | 02   | F   | 395       | 6274          | 13963      | 13963                                   | 291.89440736 | 100.07784502 | 73.853561556 | 55.33122753       |
| 2019 | 99214 | State    | Alaska                             | 02   | O   | 1375      | 50110         | 151206     | 151201                                  | 325.06214383 | 128.88493889 | 90.199974141 | 71.313604685      |
| 2019 | 99214 | State    | Arizona                            | 04   | F   | 2932      | 44299         | 85348      | 85332                                   | 181.83657051 | 75.049917163 | 55.408740568 | 56.265501125      |
| 2019 | 99214 | State    | Arizona                            | 04   | O   | 11619     | 599406        | 2662799    | 2661636                                 | 206.87446822 | 102.64353063 | 72.863777334 | 74.947475941      |
| 2019 | 99214 | State    | Arkansas                           | 05   | F   | 1179      | 47732         | 102236     | 102180                                  | 184.56292813 | 70.385331586 | 51.587664717 | 56.456422982      |
| 2019 | 99214 | State    | Arkansas                           | 05   | O   | 4574      | 326567        | 1197418    | 1197244                                 | 172.54185726 | 93.159260191 | 63.386881047 | 73.129370094      |
| 2019 | 99214 | State    | California                         | 06   | F   | 10229     | 238413        | 595705     | 595652                                  | 283.42307659 | 81.686113345 | 60.101381103 | 56.775126094      |
| 2019 | 99214 | State    | California                         | 06   | O   | 46943     | 2021474       | 8683284    | 8681018                                 | 238.5080719  | 114.89737901 | 82.423200354 | 76.598235873      |
| 2019 | 99214 | State    | Colorado                           | 08   | F   | 2721      | 49441         | 109140     | 109130                                  | 239.55839692 | 75.856273135 | 55.714042514 | 55.564987081      |
| 2019 | 99214 | State    | Colorado                           | 08   | O   | 9466      | 342145        | 1143302    | 1143207                                 | 220.36022016 | 102.54757295 | 70.920646513 | 73.180813311      |
| 2019 | 99214 | State    | Connecticut                        | 09   | F   | 2150      | 36055         | 82437      | 82388                                   | 263.59374431 | 80.115368706 | 59.78679064  | 56.584655191      |
| 2019 | 99214 | State    | Connecticut                        | 09   | O   | 7631      | 290340        | 1102620    | 1102551                                 | 225.47486741 | 111.59760745 | 79.830050897 | 74.599636575      |
| 2019 | 99214 | State    | Delaware                           | 10   | F   | 718       | 20159         | 38621      | 38621                                   | 184.8456055  | 77.802361668 | 57.434714016 | 56.419144507      |
| 2019 | 99214 | State    | Delaware                           | 10   | O   | 1780      | 146142        | 545495     | 545477                                  | 191.20291609 | 106.77620843 | 75.818722225 | 74.716734232      |
| 2019 | 99214 | State    | District of Columbia               | 11   | F   | 612       | 15965         | 32840      | 32839                                   | 231.42452436 | 84.33629324  | 61.276047503 | 56.401621498      |
| 2019 | 99214 | State    | District of Columbia               | 11   | O   | 1744      | 82053         | 198555.8   | 198525                                  | 230.87512367 | 118.44245749 | 84.765580154 | 76.78569027       |
| 2019 | 99214 | State    | Florida                            | 12   | F   | 7091      | 134100        | 290184     | 290157                                  | 206.70942661 | 79.180787914 | 59.175471839 | 57.480202286      |
| 2019 | 99214 | State    | Florida                            | 12   | O   | 35688     | 1941827       | 9081199    | 9080861                                 | 220.46248837 | 106.95273735 | 76.855090106 | 76.526494869      |
| 2019 | 99214 | State    | Georgia                            | 13   | F   | 3498      | 63852         | 144443     | 144433                                  | 232.79550203 | 74.663089869 | 54.688625409 | 55.628321968      |
| 2019 | 99214 | State    | Georgia                            | 13   | O   | 15149     | 782797        | 3123186.2  | 3123063                                 | 221.87506388 | 102.57803854 | 71.655104873 | 74.538912509      |
| 2019 | 99214 | State    | Hawaii                             | 15   | F   | 319       | 8450          | 19340      | 19340                                   | 165.63131282 | 70.990562565 | 48.690892968 | 56.235220269      |
| 2019 | 99214 | State    | Hawaii                             | 15   | O   | 1748      | 78995         | 270403     | 270388                                  | 187.87935285 | 103.86573211 | 70.854720436 | 74.318619912      |
| 2019 | 99214 | State    | Idaho                              | 16   | F   | 964       | 40652         | 93360      | 93353                                   | 149.4635     | 71.781916774 | 51.398575086 | 53.896197301      |
| 2019 | 99214 | State    | Idaho                              | 16   | O   | 2883      | 117908        | 323454     | 323448                                  | 184.88777693 | 90.236702993 | 61.918590897 | 67.186330576      |
| 2019 | 99214 | State    | Illinois                           | 17   | F   | 7638      | 189615        | 440074     | 439934                                  | 207.33772552 | 79.85217552  | 58.414116717 | 56.26804392       |
| 2019 | 99214 | State    | Illinois                           | 17   | O   | 20860     | 1059415       | 3725928    | 3725685                                 | 210.82484623 | 106.34892847 | 74.467291724 | 73.262088081      |
| 2019 | 99214 | State    | Indiana                            | 18   | F   | 3363      | 67441         | 139969     | 139960                                  | 181.16684559 | 72.960564768 | 53.466517729 | 56.293245933      |
| 2019 | 99214 | State    | Indiana                            | 18   | O   | 12000     | 632369        | 2185319    | 2185237                                 | 179.81082166 | 98.540094371 | 67.58547677  | 73.013173472      |
| 2019 | 99214 | State    | Iowa                               | 19   | F   | 2139      | 69280         | 157760     | 157746                                  | 214.73429913 | 73.006857568 | 52.733580312 | 55.496337348      |
| 2019 | 99214 | State    | Iowa                               | 19   | O   | 5154      | 289634        | 828465     | 828421                                  | 206.70963978 | 96.478901438 | 66.1943232   | 71.559192205      |
| 2019 | 99214 | State    | Kansas                             | 20   | F   | 1581      | 45834         | 99130      | 99129                                   | 174.62197327 | 71.816859881 | 52.639180773 | 55.373657218      |
| 2019 | 99214 | State    | Kansas                             | 20   | O   | 4944      | 280795        | 831827     | 831808                                  | 182.40863745 | 97.980837301 | 67.469923939 | 72.789450487      |
| 2019 | 99214 | State    | Kentucky                           | 21   | F   | 2396      | 62488         | 134739     | 134735                                  | 170.3202202  | 72.730619049 | 53.475684546 | 55.885077817      |
| 2019 | 99214 | State    | Kentucky                           | 21   | O   | 8363      | 425675        | 1429166    | 1429127                                 | 187.71183469 | 95.988941215 | 65.707670439 | 72.041064145      |
| 2019 | 99214 | State    | Louisiana                          | 22   | F   | 3097      | 82568         | 225503     | 225489                                  | 187.44907482 | 75.592775573 | 54.782885106 | 55.462710518      |
| 2019 | 99214 | State    | Louisiana                          | 22   | O   | 6986      | 356783        | 1405685.8  | 1405624                                 | 196.26859829 | 100.49178407 | 70.381574275 | 74.982360048      |
| 2019 | 99214 | State    | Maine                              | 23   | F   | 1378      | 38294         | 82821      | 82797                                   | 141.98092984 | 73.288136825 | 53.62124437  | 54.784910349      |
| 2019 | 99214 | State    | Maine                              | 23   | O   | 2820      | 112741        | 332790     | 332750                                  | 174.58275759 | 86.973259022 | 61.397914571 | 62.97685853       |
| 2019 | 99214 | State    | Maryland                           | 24   | F   | 3491      | 69545         | 142796     | 142775                                  | 219.48883708 | 80.934495504 | 59.962164556 | 56.867474719      |
| 2019 | 99214 | State    | Maryland                           | 24   | O   | 11248     | 675616        | 2679389    | 2679095                                 | 220.4370141  | 113.0135329  | 80.162723293 | 75.67938845       |
| 2019 | 99214 | State    | Massachusetts                      | 25   | F   | 7471      | 233474        | 628898     | 628880                                  | 253.06749581 | 81.180545239 | 59.264418936 | 55.826013487      |
| 2019 | 99214 | State    | Massachusetts                      | 25   | O   | 14917     | 709610        | 2629332    | 2629232                                 | 294.71694466 | 110.4597986  | 78.444796229 | 73.896170776      |
| 2019 | 99214 | State    | Michigan                           | 26   | F   | 7280      | 157818        | 320658     | 320654                                  | 147.14527082 | 75.50389443  | 55.193995846 | 56.003408523      |
| 2019 | 99214 | State    | Michigan                           | 26   | O   | 18691     | 764450        | 2666153    | 2666063                                 | 165.16185262 | 98.766904356 | 68.750732617 | 72.157994245      |
| 2019 | 99214 | State    | Minnesota                          | 27   | F   | 4593      | 93582         | 223141     | 223133                                  | 198.77159258 | 73.745162207 | 53.345249282 | 54.562125248      |
| 2019 | 99214 | State    | Minnesota                          | 27   | O   | 12307     | 356434        | 1147568    | 1147541                                 | 264.45568765 | 100.37145901 | 70.274042924 | 71.929103652      |
| 2019 | 99214 | State    | Mississippi                        | 28   | F   | 1327      | 55498         | 130436     | 130410                                  | 158.76271259 | 71.051070793 | 51.771379604 | 55.594362446      |
| 2019 | 99214 | State    | Mississippi                        | 28   | O   | 4509      | 328206        | 1223094    | 1223038                                 | 162.71462517 | 94.070475875 | 65.012257284 | 72.543280173      |
| 2019 | 99214 | State    | Missouri                           | 29   | F   | 3588      | 98595         | 222575     | 222571                                  | 161.50838998 | 74.984932629 | 54.818946872 | 56.199358149      |
| 2019 | 99214 | State    | Missouri                           | 29   | O   | 10080     | 514025        | 1594002    | 1593964                                 | 186.21918951 | 98.784738595 | 68.398570686 | 72.461894796      |
| 2019 | 99214 | State    | Montana                            | 30   | F   | 968       | 47595         | 126278     | 126277                                  | 132.74946705 | 75.007009218 | 52.561921396 | 53.873515498      |
| 2019 | 99214 | State    | Montana                            | 30   | O   | 1693      | 77191         | 191162     | 191153                                  | 218.13464297 | 98.567837593 | 66.733113642 | 69.390454222      |
| 2019 | 99214 | State    | Nebraska                           | 31   | F   | 1583      | 44781         | 94883      | 94882                                   | 224.53123889 | 73.248525869 | 53.563275086 | 56.589621955      |
| 2019 | 99214 | State    | Nebraska                           | 31   | O   | 3627      | 186082        | 582368     | 582359                                  | 214.21588806 | 96.523629698 | 66.912544113 | 73.475910507      |
| 2019 | 99214 | State    | Nevada                             | 32   | F   | 437       | 9418          | 18153      | 18153                                   | 207.27393103 | 75.696085496 | 55.012367653 | 55.481859197      |
| 2019 | 99214 | State    | Nevada                             | 32   | O   | 4149      | 210573        | 854399     | 854326                                  | 230.87491445 | 104.50418708 | 73.968857946 | 74.838622763      |
| 2019 | 99214 | State    | New Hampshire                      | 33   | F   | 1385      | 51326         | 114122     | 114114                                  | 166.96708558 | 76.898094232 | 56.40128941  | 55.325191637      |
| 2019 | 99214 | State    | New Hampshire                      | 33   | O   | 3220      | 156680        | 491634     | 491615                                  | 225.84078742 | 99.008735604 | 69.484413059 | 68.420550186      |
| 2019 | 99214 | State    | New Jersey                         | 34   | F   | 3830      | 53050         | 106505     | 106396                                  | 242.33328201 | 81.041770715 | 60.038297639 | 56.968058307      |
| 2019 | 99214 | State    | New Jersey                         | 34   | O   | 15612     | 802529        | 3425722.5  | 3425474                                 | 231.72977164 | 114.97391728 | 82.447285193 | 77.339674889      |
| 2019 | 99214 | State    | New Mexico                         | 35   | F   | 1104      | 34033         | 74840      | 74838                                   | 153.46819148 | 74.94013108  | 52.957601951 | 53.602432523      |
| 2019 | 99214 | State    | New Mexico                         | 35   | O   | 3038      | 149760        | 470007     | 469983                                  | 203.39246239 | 97.987107958 | 67.703080678 | 70.580282421      |
| 2019 | 99214 | State    | New York                           | 36   | F   | 8836      | 167225        | 373935     | 373909                                  | 241.97947336 | 79.857244842 | 58.257590062 | 56.131947638      |
| 2019 | 99214 | State    | New York                           | 36   | O   | 36150     | 1423531       | 5569604    | 5569152                                 | 263.86400003 | 113.36391903 | 81.842093024 | 75.548476675      |
| 2019 | 99214 | State    | North Carolina                     | 37   | F   | 4734      | 119410        | 253355     | 253353                                  | 190.72626027 | 73.309899666 | 53.620951392 | 55.401967832      |
| 2019 | 99214 | State    | North Carolina                     | 37   | O   | 19216     | 1001080       | 4046909    | 4046836                                 | 201.56573052 | 98.465680067 | 68.105824349 | 71.847062585      |
| 2019 | 99214 | State    | North Dakota                       | 38   | F   | 1002      | 41037         | 94029      | 94028                                   | 148.07184571 | 71.67214285  | 50.782669283 | 53.033204224      |
| 2019 | 99214 | State    | North Dakota                       | 38   | O   | 1425      | 65212         | 156189     | 156186                                  | 206.28048461 | 85.518483376 | 58.142600759 | 62.786323749      |
| 2019 | 99214 | State    | Ohio                               | 39   | F   | 8354      | 167080        | 366875     | 366873                                  | 200.15479847 | 73.90169491  | 53.706213642 | 55.418886542      |
| 2019 | 99214 | State    | Ohio                               | 39   | O   | 22012     | 934610        | 3215391.1  | 3215317                                 | 186.56269649 | 95.063522463 | 64.128037348 | 71.041069993      |
| 2019 | 99214 | State    | Oklahoma                           | 40   | F   | 1401      | 63199         | 149161     | 149143                                  | 157.10937021 | 71.921121339 | 51.43020146  | 55.298704554      |
| 2019 | 99214 | State    | Oklahoma                           | 40   | O   | 6188      | 370642        | 1371782.2  | 1371696                                 | 189.47706925 | 95.612110778 | 65.127482439 | 72.801907074      |
| 2019 | 99214 | State    | Oregon                             | 41   | F   | 1904      | 37739         | 78716      | 78716                                   | 202.37311233 | 73.114897225 | 51.169515346 | 54.111635246      |
| 2019 | 99214 | State    | Oregon                             | 41   | O   | 7418      | 274931        | 866284     | 866265                                  | 271.54955204 | 97.934806114 | 66.455038278 | 71.364770664      |
| 2019 | 99214 | State    | Pennsylvania                       | 42   | F   | 9305      | 168125        | 358149     | 358132                                  | 186.61006    | 77.488142337 | 56.707349846 | 56.011045431      |
| 2019 | 99214 | State    | Pennsylvania                       | 42   | O   | 26585     | 1161773       | 4099460.6  | 4099279                                 | 191.5822807  | 104.42116856 | 72.384457301 | 73.611681088      |
| 2019 | 99214 | State    | Rhode Island                       | 44   | F   | 483       | 10551         | 19453      | 19451                                   | 214.09073305 | 79.388788362 | 58.646129132 | 57.282071146      |
| 2019 | 99214 | State    | Rhode Island                       | 44   | O   | 2281      | 99711         | 319582     | 319576                                  | 211.91773661 | 103.01601648 | 71.936882584 | 74.241468919      |
| 2019 | 99214 | State    | South Carolina                     | 45   | F   | 2007      | 40525         | 86765      | 86765                                   | 179.47043036 | 72.930319829 | 53.529792313 | 56.320637239      |
| 2019 | 99214 | State    | South Carolina                     | 45   | O   | 8176      | 574981        | 2246673    | 2246625                                 | 192.43077134 | 99.696769579 | 69.333602741 | 74.542813622      |
| 2019 | 99214 | State    | South Dakota                       | 46   | F   | 1004      | 46079         | 105122     | 105119                                  | 116.03160071 | 74.013137117 | 52.289581629 | 53.509519796      |
| 2019 | 99214 | State    | South Dakota                       | 46   | O   | 1548      | 71881         | 161773     | 161772                                  | 173.89176333 | 93.473689862 | 64.567836042 | 66.962774752      |
| 2019 | 99214 | State    | Tennessee                          | 47   | F   | 2819      | 63028         | 130933     | 130928                                  | 235.90581076 | 71.716449864 | 51.613435268 | 55.089256337      |
| 2019 | 99214 | State    | Tennessee                          | 47   | O   | 12603     | 667351        | 2538796    | 2538717                                 | 206.97713413 | 96.452149783 | 66.592319474 | 73.00099078       |
| 2019 | 99214 | State    | Texas                              | 48   | F   | 8594      | 190606        | 436312     | 436254                                  | 217.69015833 | 75.507065403 | 54.829383835 | 55.599236739      |
| 2019 | 99214 | State    | Texas                              | 48   | O   | 34882     | 1649664       | 6749141.3  | 6748777                                 | 222.36860338 | 102.60877666 | 72.033994103 | 74.554535566      |
| 2019 | 99214 | State    | Utah                               | 49   | F   | 1088      | 17921         | 31640      | 31632                                   | 198.93628413 | 75.146078382 | 54.269623262 | 54.857270228      |
| 2019 | 99214 | State    | Utah                               | 49   | O   | 4326      | 177336        | 612945     | 612897                                  | 186.04819906 | 100.15602968 | 69.378502786 | 72.306845884      |
| 2019 | 99214 | State    | Vermont                            | 50   | F   | 565       | 27519         | 54845      | 54843                                   | 108.47811195 | 75.130216063 | 53.50639329  | 54.075486735      |
| 2019 | 99214 | State    | Vermont                            | 50   | O   | 1114      | 55528         | 147587     | 147573                                  | 150.82919857 | 91.813973521 | 62.956460528 | 63.756123575      |
| 2019 | 99214 | State    | Virginia                           | 51   | F   | 3754      | 114077        | 251198     | 251195                                  | 198.58419573 | 76.290395186 | 54.911977364 | 54.979509909      |
| 2019 | 99214 | State    | Virginia                           | 51   | O   | 13646     | 868112        | 3199081    | 3199006                                 | 201.2528933  | 104.58033037 | 72.699455912 | 72.485152398      |
| 2019 | 99214 | State    | Washington                         | 53   | F   | 3638      | 118341        | 280197     | 280164                                  | 158.23846861 | 78.245383712 | 56.187223882 | 54.743674379      |
| 2019 | 99214 | State    | Washington                         | 53   | O   | 13358     | 536108        | 1843214    | 1843154                                 | 237.3762152  | 104.03893898 | 72.078068624 | 71.138449507      |
| 2019 | 99214 | State    | West Virginia                      | 54   | F   | 1575      | 49836         | 111087     | 111084                                  | 162.65312701 | 73.810377542 | 52.718879617 | 54.539884775      |
| 2019 | 99214 | State    | West Virginia                      | 54   | O   | 2937      | 171389        | 499346     | 499333                                  | 188.98746565 | 96.536198868 | 65.613590917 | 71.625744634      |
| 2019 | 99214 | State    | Wisconsin                          | 55   | F   | 5144      | 129860        | 304861     | 304794                                  | 221.41929135 | 72.697071649 | 52.31136413  | 54.497144994      |
| 2019 | 99214 | State    | Wisconsin                          | 55   | O   | 11094     | 415273        | 1229350    | 1229297                                 | 281.58478463 | 97.29539538  | 65.970805564 | 69.484688144      |
| 2019 | 99214 | State    | Wyoming                            | 56   | F   | 136       | 2714          | 5874       | 5874                                    | 264.62789751 | 75.172538304 | 55.358699353 | 55.488028601      |
| 2019 | 99214 | State    | Wyoming                            | 56   | O   | 950       | 50207         | 132117     | 132106                                  | 233.2643217  | 102.5794492  | 70.872287518 | 71.84889121       |
| 2019 | 99214 | State    | Guam                               | 66   | F   | 16        | 153           | 207        | 207                                     | 299.65574879 | 77.896570048 | 57.873671498 | 57.794879227      |
| 2019 | 99214 | State    | Guam                               | 66   | O   | 99        | 5560          | 16707      | 16707                                   | 137.39565571 | 111.1369839  | 73.634271862 | 72.279883881      |
| 2019 | 99214 | State    | Northern Mariana Islands           | 69   | F   | 3         | 24            | 44         | 44                                      | 278.62613636 | 79.368409091 | 57.975681818 | 56.671818182      |
| 2019 | 99214 | State    | Northern Mariana Islands           | 69   | O   | 10        | 612           | 1588       | 1588                                    | 134.87134131 | 105.85116499 | 61.506026448 | 63.570573048      |
| 2019 | 99214 | State    | Puerto Rico                        | 72   | F   | 94        | 1370          | 3702       | 3698                                    | 115.04119395 | 78.149051864 | 58.573422474 | 59.213287412      |
| 2019 | 99214 | State    | Puerto Rico                        | 72   | O   | 1612      | 24820         | 65038      | 65038                                   | 120.87880009 | 103.64276116 | 72.403399397 | 76.632439343      |
| 2019 | 99214 | State    | Virgin Islands                     | 78   | F   | 4         | 26            | 26         | 26                                      | 112.47       | 68.442307692 | 52.615384615 | 52.354230769      |
| 2019 | 99214 | State    | Virgin Islands                     | 78   | O   | 83        | 7367          | 17646      | 17646                                   | 154.14354811 | 105.68766349 | 66.539990366 | 68.419408931      |
| 2019 | 99214 | State    | Armed Forces Central/South America | 9A   | O   | 2         | 42            | 57         | 57                                      | 129.8245614  | 93.675964912 | 65.776315789 | 78.258245614      |
| 2019 | 99214 | State    | Armed Forces Europe                | 9B   | F   | 4         | 244           | 324        | 324                                     | 184.90123457 | 74.117037037 | 57.940339506 | 58.757283951      |
| 2019 | 99214 | State    | Armed Forces Europe                | 9B   | O   | 23        | 1953          | 2955       | 2955                                    | 230.81275465 | 102.12570897 | 72.911001692 | 72.837299492      |
| 2019 | 99214 | State    | Armed Forces Pacific               | 9C   | F   | 3         | 72            | 72         | 72                                      | 93.888888889 | 67.003055556 | 43.274027778 | 43.937777778      |
| 2019 | 99214 | State    | Armed Forces Pacific               | 9C   | O   | 11        | 346           | 432        | 432                                     | 231.05113426 | 110.3525463  | 76.881342593 | 75.337824074      |
| 2019 | 99214 | State    | Unknown                            | 9D   | F   | 2         | 26            | 26         | 26                                      | 248.38461538 | 74.11        | 50.555384615 | 50.180769231      |
| 2019 | 99214 | State    | Unknown                            | 9D   | O   | 4         | 500           | 1115       | 1115                                    | 163.7103139  | 101.72235874 | 72.996071749 | 78.016914798      |
| 2019 | 99214 | State    | Foreign Country                    | 9E   | F   | 9         | 67            | 82         | 82                                      | 188.19719512 | 77.266463415 | 50.277317073 | 51.354756098      |
| 2019 | 99214 | State    | Foreign Country                    | 9E   | O   | 29        | 2244          | 3257       | 3257                                    | 186.95892539 | 105.8982315  | 72.934221676 | 73.720187289      |

<br>

3.  by Provider API:

<br>

``` r
mpop_prov_ex <- provider_mpop(npi = 1003000134, 
                              set = "prov",
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
    #> ├─tot_hcpcs_cds: "18"
    #> ├─tot_benes: "2633"
    #> ├─tot_srvcs: "5930"
    #> ├─tot_sbmtd_chrg: "915291"
    #> ├─tot_mdcr_alowd_amt: "227372.53"
    #> ├─tot_mdcr_pymt_amt: "176497.74"
    #> ├─tot_mdcr_stdzd_amt: "167363.18"
    #> ├─drug_sprsn_ind: ""
    #> ├─drug_tot_hcpcs_cds: "0"
    #> ├─drug_tot_benes: "0"
    #> ├─drug_tot_srvcs: "0"
    #> ├─drug_sbmtd_chrg: "0"
    #> ├─drug_mdcr_alowd_amt: "0"
    #> ├─drug_mdcr_pymt_amt: "0"
    #> ├─drug_mdcr_stdzd_amt: "0"
    #> ├─med_sprsn_ind: ""
    #> ├─med_tot_hcpcs_cds: "18"
    #> ├─med_tot_benes: "2633"
    #> ├─med_tot_srvcs: "5930"
    #> ├─med_sbmtd_chrg: "915291"
    #> ├─med_mdcr_alowd_amt: "227372.53"
    #> ├─med_mdcr_pymt_amt: "176497.74"
    #> ├─med_mdcr_stdzd_amt: "167363.18"
    #> ├─bene_avg_age: "76"
    #> ├─bene_age_lt_65_cnt: "69"
    #> ├─bene_age_65_74_cnt: "1189"
    #> ├─bene_age_75_84_cnt: "963"
    #> ├─bene_age_gt_84_cnt: "412"
    #> ├─bene_feml_cnt: "1310"
    #> ├─bene_male_cnt: "1323"
    #> ├─bene_race_wht_cnt: "2385"
    #> ├─bene_race_black_cnt: ""
    #> ├─bene_race_api_cnt: "45"
    #> ├─bene_race_hspnc_cnt: "49"
    #> ├─bene_race_nat_ind_cnt: ""
    #> ├─bene_race_othr_cnt: "128"
    #> ├─bene_dual_cnt: "125"
    #> ├─bene_ndual_cnt: "2508"
    #> ├─bene_cc_af_pct: "0.1"
    #> ├─bene_cc_alzhmr_pct: "0.06"
    #> ├─bene_cc_asthma_pct: "0.04"
    #> ├─bene_cc_cncr_pct: "0.14"
    #> ├─bene_cc_chf_pct: "0.12"
    #> ├─bene_cc_ckd_pct: "0.22"
    #> ├─bene_cc_copd_pct: "0.06"
    #> ├─bene_cc_dprssn_pct: "0.15"
    #> ├─bene_cc_dbts_pct: "0.2"
    #> ├─bene_cc_hyplpdma_pct: "0.48"
    #> ├─bene_cc_hyprtnsn_pct: "0.48"
    #> ├─bene_cc_ihd_pct: "0.24"
    #> ├─bene_cc_opo_pct: "0.1"
    #> ├─bene_cc_raoa_pct: "0.38"
    #> ├─bene_cc_sz_pct: "0.01"
    #> ├─bene_cc_strok_pct: "0.03"
    #> └─bene_avg_risk_scre: "1.1124"

<br>

`provider_clia()` accesses **Medicare’s Provider of Services File for
Clinical Laboratories API**:

<br>

``` r
clia_ex <- provider_clia(name = "carbon hill", year = "2022")
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

<br> <br>

------------------------------------------------------------------------

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
