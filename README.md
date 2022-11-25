
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `provider` <img src="man/figures/logo.svg" align="right" height="200" />

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
[![CodeFactor](https://www.codefactor.io/repository/github/andrewallenbruce/provider/badge)](https://www.codefactor.io/repository/github/andrewallenbruce/provider)
<!-- badges: end -->

The goal of `provider` is to provide performant and reliable open-source
tools to facilitate easy access to [healthcare
provider](https://en.wikipedia.org/wiki/Health_care_provider) data
through publicly available APIs & sources. The current list of supported
APIs are:

<br> \* [Medicare Provider and Supplier Taxonomy Crosswalk
API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)
\* [Medicare Revalidation Due Date
API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
\* [Medicare Revalidation Clinic Group Practice Reassignment
API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)
\* [CMS Public Reporting of Missing Digital Contact Information
API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)
\* [Medicare Physician & Other Practitioners
API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
\* [Medicare Market Saturation & Utilization State-County
API](https://data.cms.gov/summary-statistics-on-use-and-payments/program-integrity-market-saturation-by-type-of-service/market-saturation-utilization-state-county)
\* [Medicare Provider of Services File - Clinical Laboratories
API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)

<br>

| Function                 | API                                                                                                                                                                                                                                 |
|:-------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `nppes_npi()`            | [NPPES National Provider Identifier (NPI) Registry](https://npiregistry.cms.hhs.gov/search)                                                                                                                                         |
| `provider_enrollment()`  | [Medicare Fee-For-Service Public Provider Enrollment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)                                      |
| `order_refer()`          | [Medicare Order and Referring](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)                                                                                             |
| `opt_out()`              | [Medicare Opt Out Affidavits](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)                                                                                               |
| `physician_by_service()` | [Medicare Physician & Other Practitioners: by Provider and Service](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service) |

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

# Define search parameter
npi <- 1083879860

# Query the NPPES API and unpack the response
nppes_ex <- provider_nppes(npi) |> 
            provider_unpack()
```

<br>

# Basic Information

| npi        | prov_type  | first_name  | last_name | sole_proprietor |
|:-----------|:-----------|:------------|:----------|:----------------|
| 1083879860 | Individual | CHRISTOPHER | AARON     | FALSE           |

| gender | enumeration_date | last_updated | certification_date | status |
|:-------|:-----------------|:-------------|:-------------------|:-------|
| M      | 2008-07-22       | 2021-03-25   | 2020-05-01         | A      |

------------------------------------------------------------------------

# Addresses

| address_1           | city    | state | postal_code | telephone_number |
|:--------------------|:--------|:------|:------------|:-----------------|
| 792 GALLITZIN RD    | CRESSON | PA    | 166302213   | 814-886-8161     |
| 10 CASTLE GARDEN CT | OLNEY   | MD    | 208321443   | NA               |

# Taxonomy

| taxon_code | taxonomy_group | taxon_desc      | taxon_state | taxon_license | taxon_primary |
|:-----------|:---------------|:----------------|:------------|:--------------|:--------------|
| 207Q00000X |                | Family Medicine | PA          | OS019703      | TRUE          |

# Endpoints

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

<table class="kable_wrapper">
<caption>
Title of the table
</caption>
<tbody>
<tr>
<td>

| npi        | pecos_asct_cntl_id | enrlmt_id       | provider_type_cd |
|:-----------|:-------------------|:----------------|:-----------------|
| 1083879860 | 8426328519         | I20200617001010 | 14-08            |

</td>
<td>

| provider_type_desc             | state_cd | first_name  | mdl_name | last_name |
|:-------------------------------|:---------|:------------|:---------|:----------|
| PRACTITIONER - FAMILY PRACTICE | PA       | CHRISTOPHER | L        | AARON     |

</td>
</tr>
</tbody>
</table>

<br>

### Order and Referring

Is a Provider currently eligible to:

- Make referrals to Medicare Part B or a Home Health Agency (HHA)?
- Order Durable Medical Equipment (DME) or Power Mobility Devices
  (PMDs)?

Search Medicare’s **Order and Referring API** with `order_refer()`:

|        npi | last_name | first_name  | partb | dme  | hha  | pmd  |
|-----------:|:----------|:------------|:------|:-----|:-----|:-----|
| 1083879860 | AARON     | CHRISTOPHER | TRUE  | TRUE | TRUE | TRUE |

<br>

### Taxonomy Crosswalk

You may need to find Medicare’s specialty codes for this provider’s
taxonomies. You can search Medicare’s **Provider and Supplier Taxonomy
Crosswalk API** with `provider_mpstc()`:

<br>

| medicare_specialty_code | medicare_provider_supplier_type_description | provider_taxonomy_code | provider_taxonomy_description_type_classification_specialization |
|:------------------------|:--------------------------------------------|:-----------------------|:-----------------------------------------------------------------|
| 8                       | Physician/Family Practice                   | 207Q00000X             | Allopathic & Osteopathic Physicians/Family Medicine              |

<br>

### Revalidation Due Date

You can check to see if a provider is due to revalidate their Medicare
enrollment by accessing Medicare’s **Revalidation Due Date API** with
`provider_mrdd()`:

<br>

| enrollment_id   | national_provider_identifier | first_name  | last_name | organization_name | enrollment_state_code | enrollment_type | provider_type_text | enrollment_specialty | revalidation_due_date | adjusted_due_date | individual_total_reassign_to | receiving_benefits_reassignment |
|:----------------|:-----------------------------|:------------|:----------|:------------------|:----------------------|:----------------|:-------------------|:---------------------|:----------------------|:------------------|:-----------------------------|:--------------------------------|
| I20200617001010 | 1083879860                   | Christopher | Aaron     |                   | PA                    | 3               | Non-DME Part B     | Family Practice      |                       |                   |                              | 1                               |

<br>

### Missing Digital Contact Information

Providers may need to update their digital contact information in the
NPPES system. To check, you can access the **CMS Public Reporting of
Missing Digital Contact Information API** with `provider_promdci()`. If
they appear in the search results, it’s time to update their NPPES
contact information:

<br>

| npi        | provider_name |
|:-----------|:--------------|
| 1144224569 | Clouse,John   |

<br>

### Opt-Out Affidavits

You can find out if a provider has opted out of Medicare by searching
the **Medicare Opt Out Affidavits API** with `opt_out()`:

<br>

| date       | last_updated | first_name | last_name | npi        | specialty              | optout_effective_date | optout_end_date | first_line_street_address | second_line_street_address | city_name  | state_code | zip_code  | eligible_to_order_and_refer |
|:-----------|:-------------|:-----------|:----------|:-----------|:-----------------------|:----------------------|:----------------|:--------------------------|:---------------------------|:-----------|:-----------|:----------|:----------------------------|
| 2022-11-25 | 09/15/2022   | Sheryl     | Aaron     | 1427358282 | Clinical Social Worker | 02/17/2022            | 02/17/2024      | 1633 Q ST NW              | STE 230                    | WASHINGTON | DC         | 200096351 | N                           |

<br>

### Revalidation Clinic Group Practice Reassignment

`provider_rcgpr()` accesses **Medicare’s Revalidation Clinic Group
Practice Reassignment API**:

<br>

    #>   group_pac_id group_enrollment_id                   group_legal_business_name
    #> 1   5395659312     O20040312000257 Upmc Altoona Regional Health Services, Inc.
    #>   group_state_code group_due_date group_reassignments_and_physician_assistants
    #> 1               PA     01/31/2022                                          446
    #>    record_type individual_enrollment_id individual_npi individual_first_name
    #> 1 Reassignment          I20200617001010     1083879860           Christopher
    #>   individual_last_name individual_state_code individual_specialty_description
    #> 1                Aaron                    PA                  Family Practice
    #>   individual_due_date individual_total_employer_associations
    #> 1                 TBD                                      1

## Provider Statistics

These APIs are generally concerned with providing access to a provider’s
longitudinal utilization data.

### Physician & Other Practitioners

> by Provider and Service API

| year | hcpcs_cd | tot_benes | tot_srvcs | avg_sbmtd_chrg | avg_mdcr_alowd_amt | avg_mdcr_pymt_amt |
|:-----|:---------|----------:|----------:|---------------:|-------------------:|------------------:|
| 2013 | 99222    |       138 |       142 |       368.6268 |          132.17007 |         104.29972 |
| 2013 | 99223    |        95 |        96 |       524.6042 |          196.93240 |         155.90115 |
| 2013 | 99231    |        47 |        61 |        97.0000 |           37.68820 |          30.06525 |
| 2013 | 99232    |       381 |       777 |       187.5946 |           69.43354 |          55.09135 |
| 2013 | 99233    |       106 |       170 |       271.9765 |          101.07035 |          80.64124 |
| 2013 | 99238    |       208 |       219 |       201.0046 |           69.80708 |          55.65046 |
| 2013 | 99239    |       137 |       142 |       245.8310 |          103.48056 |          82.63211 |
| 2014 | 99222    |       341 |       357 |       416.5462 |          137.74919 |         107.51787 |
| 2014 | 99223    |        98 |        98 |       611.0000 |          201.09684 |         152.55122 |
| 2014 | 99231    |        65 |       104 |       119.0000 |           39.08673 |          30.83538 |
| 2014 | 99232    |       596 |      1418 |       217.0000 |           71.69861 |          56.29776 |
| 2014 | 99233    |       104 |       175 |       312.0000 |          103.83000 |          82.39817 |
| 2014 | 99238    |       316 |       330 |       217.0000 |           72.37955 |          55.68124 |
| 2014 | 99239    |       215 |       223 |       322.0000 |          106.37072 |          83.70637 |
| 2014 | 99291    |        13 |        23 |       674.0000 |          224.66000 |         179.00000 |
| 2015 | 99217    |        23 |        23 |       328.0000 |           71.57043 |          54.50261 |
| 2015 | 99219    |        18 |        18 |       614.0000 |          133.79333 |         100.95889 |
| 2015 | 99221    |        58 |        59 |       333.2881 |           99.74085 |          79.46966 |
| 2015 | 99222    |       130 |       132 |       356.4924 |          136.80970 |         107.93341 |
| 2015 | 99223    |       215 |       220 |       631.1864 |          199.45268 |         157.90895 |
| 2015 | 99231    |        18 |        38 |       100.8421 |           38.92474 |          31.01579 |
| 2015 | 99232    |       481 |      1117 |       200.9320 |           71.87013 |          56.31386 |
| 2015 | 99233    |       286 |       580 |       301.9810 |          101.51336 |          80.92938 |
| 2015 | 99238    |       172 |       175 |       210.8800 |           72.46834 |          57.07949 |
| 2015 | 99239    |       353 |       368 |       308.3016 |          106.55685 |          83.94720 |
| 2015 | 99291    |        13 |        21 |       633.8095 |          223.42190 |         178.01190 |
| 2016 | 99217    |        55 |        57 |       325.1579 |           70.79825 |          54.47439 |
| 2016 | 99219    |        38 |        38 |       614.0000 |          132.85000 |         105.85000 |
| 2016 | 99220    |        23 |        23 |       769.3478 |          186.25913 |         146.11652 |
| 2016 | 99221    |        20 |        20 |       460.0000 |           99.14000 |          78.99000 |
| 2016 | 99222    |        87 |        96 |       625.0000 |          134.09740 |         105.47760 |
| 2016 | 99223    |       141 |       148 |       920.6149 |          200.54466 |         159.08345 |
| 2016 | 99225    |        11 |        11 |       328.0000 |           71.32000 |          56.82000 |
| 2016 | 99232    |       270 |       596 |       326.4866 |           70.71562 |          56.21099 |
| 2016 | 99233    |        85 |       117 |       470.0000 |          101.88538 |          80.90932 |
| 2016 | 99238    |        20 |        20 |       328.0000 |           71.04550 |          52.83150 |
| 2016 | 99239    |       231 |       271 |       485.0000 |          105.05000 |          83.70000 |
| 2016 | 99291    |        26 |        53 |      1400.0000 |          219.04000 |         174.52000 |
| 2017 | 99217    |        96 |       100 |       325.7800 |           71.96390 |          56.82720 |
| 2017 | 99218    |        25 |        26 |       449.0000 |           98.48000 |          78.46000 |
| 2017 | 99219    |        51 |        52 |       614.0000 |          134.28385 |         102.80769 |
| 2017 | 99220    |        59 |        59 |       755.9322 |          184.32203 |         141.29356 |
| 2017 | 99221    |        16 |        16 |       462.8125 |          100.05000 |          79.71000 |
| 2017 | 99222    |        57 |        59 |       625.0000 |          135.14729 |         105.82542 |
| 2017 | 99223    |       110 |       114 |       923.9912 |          202.79219 |         160.37719 |
| 2017 | 99232    |       233 |       627 |       326.2456 |           71.24051 |          56.36673 |
| 2017 | 99233    |       127 |       207 |       461.0725 |          103.94768 |          82.82068 |
| 2017 | 99239    |       291 |       341 |       481.6862 |          106.32874 |          84.05616 |
| 2017 | 99291    |        23 |        36 |      1400.0000 |          220.58000 |         175.75000 |
| 2018 | 99217    |        67 |        68 |       381.3088 |           72.64103 |          57.88029 |
| 2018 | 99218    |        19 |        19 |       476.9474 |           99.31158 |          76.79526 |
| 2018 | 99220    |        26 |        26 |      1086.9231 |          185.10154 |         147.47923 |
| 2018 | 99221    |        24 |        24 |       474.5833 |          100.60125 |          80.15500 |
| 2018 | 99222    |        17 |        17 |       625.0000 |          135.83647 |         108.22529 |
| 2018 | 99223    |        82 |        86 |      1093.5000 |          199.75721 |         159.25907 |
| 2018 | 99232    |       206 |       360 |       360.5722 |           72.38542 |          57.67031 |
| 2018 | 99233    |       148 |       284 |       576.9894 |          103.66095 |          82.51299 |
| 2018 | 99238    |        16 |        16 |       415.3125 |           72.66688 |          57.90125 |
| 2018 | 99239    |       217 |       250 |       555.6400 |          106.73396 |          85.03664 |
| 2018 | 99291    |        30 |        42 |      1400.0000 |          215.74119 |         171.89333 |
| 2019 | 99217    |        40 |        40 |       232.2750 |           72.59000 |          57.87000 |
| 2019 | 99220    |        25 |        25 |       712.8000 |          186.72520 |         148.85160 |
| 2019 | 99221    |        24 |        24 |       320.1667 |          101.12125 |          80.61583 |
| 2019 | 99223    |       157 |       158 |       651.4177 |          200.93000 |         160.19000 |
| 2019 | 99232    |       117 |       205 |       245.6146 |           72.75639 |          58.00556 |
| 2019 | 99233    |       306 |       605 |       345.2364 |          103.58820 |          82.58817 |
| 2019 | 99238    |        39 |        40 |       229.4750 |           72.59000 |          57.87000 |
| 2019 | 99239    |       240 |       243 |       349.2593 |          106.54309 |          84.96992 |
| 2019 | 99291    |        21 |        27 |       701.4444 |          221.27000 |         176.40000 |
| 2020 | 99217    |        23 |        23 |       406.1739 |           76.80391 |          61.40174 |
| 2020 | 99218    |        16 |        16 |       811.8125 |          108.24938 |          85.08125 |
| 2020 | 99220    |        16 |        16 |      1150.9375 |          191.96062 |         152.37688 |
| 2020 | 99221    |        12 |        12 |       681.6667 |          110.04750 |          82.23750 |
| 2020 | 99223    |        52 |        52 |      1108.3846 |          209.42385 |         170.83462 |
| 2020 | 99232    |        57 |       134 |       251.3284 |           73.45470 |          57.95582 |
| 2020 | 99233    |       154 |       326 |       513.2117 |          108.84687 |          88.94589 |
| 2020 | 99238    |        13 |        13 |       268.4615 |           74.15769 |          60.53308 |
| 2020 | 99239    |       145 |       146 |       491.8699 |          111.25979 |          90.92384 |

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
```

| year | year_2 | month | bene_geo_lvl | bene_state_abrvtn | bene_state_desc | bene_county_desc |
|-----:|-------:|:------|:-------------|:------------------|:----------------|:-----------------|
| 2018 |   2018 | Year  | County       | AL                | Alabama         | Autauga          |

| bene_fips_cd | tot_benes | orgnl_mdcr_benes | ma_and_oth_benes | aged_tot_benes | aged_esrd_benes |
|:-------------|----------:|-----------------:|-----------------:|---------------:|----------------:|
| 01001        |     10645 |             5700 |             4945 |           8241 |              53 |

| aged_no_esrd_benes | dsbld_tot_benes | dsbld_esrd_and_esrd_only_benes | dsbld_no_esrd_benes | a_b\_tot_benes |
|-------------------:|----------------:|-------------------------------:|--------------------:|---------------:|
|               8189 |            2403 |                             50 |                2353 |           9892 |

| a_b\_orgnl_mdcr_benes | a_b\_ma_and_oth_benes | prscrptn_drug_tot_benes | prscrptn_drug_pdp_benes |
|----------------------:|----------------------:|------------------------:|------------------------:|
|                  4948 |                  4944 |                    7088 |                    2260 |

------------------------------------------------------------------------

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
