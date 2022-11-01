
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

<br>

Search for Providers:

-   `provider_nppes()` : by NPI, name, location, organization, taxonomy,
    etc.
-   `provider_mppe()` : who are actively approved to bill Medicare.
-   `provider_moar()` : who are legally eligible to order and refer in
    the Medicare program.
-   `provider_mooa()` : that have opted out of Medicare, along with
    their effective dates.
-   `provider_mpstc()` : eligible to enroll in Medicare programs with
    the proper provider taxonomy code.
-   `provider_mrdd()` : who are due to revalidate in the following six
    months.
-   `provider_mpop()` : and their utilization data across three related
    datasets and eight years.
-   `provider_promdci()` : who do not have adequate contact information
    in the NPPES system.
-   `provider_rcgpr()` : and the group practice they reassign their
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

## Motivating Example

You’re billing for a healthcare provider and receive a `CO-8` denial on
a claim and you need to confirm whether or not the correct taxonomy code
was entered on the claim. Armed with the provider’s NPI, you can search
the **NPPES NPI Registry API** with the `provider_nppes()` function:

<br>

``` r
# Load library
library(provider)

# Query the NPPES API by NPI
nppes_ex <- provider_nppes(npi = 1083879860)

# Or by Name, City, State, etc.
# nppes_ex <- provider_nppes(first = "Chris", 
#                            last  = "Aaron",
#                            city  = "Cresson",
#                            state = "PA")
```

<br>

    #> # A tibble: 1 × 3
    #>   datetime            outcome data_lists   
    #>   <dttm>              <chr>   <list>       
    #> 1 2022-11-01 05:18:15 results <df [1 × 11]>

<br>

Unpack the API response with the `provider_unpack()` function:

<br>

``` r
nppes_unpack <- provider_unpack(nppes_ex)
```

<br>

``` r
nppes_unpack
#> # A tibble: 2 × 38
#>   npi      prov_…¹ first…² last_…³ sole_…⁴ gender enume…⁵ last_…⁶ certi…⁷ status
#>   <chr>    <chr>   <chr>   <chr>   <lgl>   <chr>  <chr>   <chr>   <chr>   <chr> 
#> 1 1083879… Indivi… CHRIST… AARON   FALSE   M      2008-0… 2021-0… 2020-0… A     
#> 2 1083879… Indivi… CHRIST… AARON   FALSE   M      2008-0… 2021-0… 2020-0… A     
#> # … with 28 more variables: country_code <chr>, address_purpose <chr>,
#> #   address_1 <chr>, city <chr>, state <chr>, postal_code <chr>,
#> #   telephone_number <chr>, taxon_code <chr>, taxonomy_group <chr>,
#> #   taxon_desc <chr>, taxon_state <chr>, taxon_license <chr>,
#> #   taxon_primary <lgl>, endpts_endpoint_type <chr>,
#> #   endpts_endpoint_type_description <chr>, endpts_endpoint <chr>,
#> #   endpts_affiliation <chr>, endpts_affiliation_name <chr>, …
```

<br>

Filter and wrangle the data for presentation:

<br>

<details>
<summary>
Code
</summary>

``` r
nppes_table <- nppes_unpack |> 
   dplyr::select("NPI"           = npi, 
                 "Last Name"     = last_name,
                 "Provider Type" = prov_type, 
                 "Description"   = taxon_desc, 
                 "Code"          = taxon_code, 
                 "Primary"       = taxon_primary, 
                 "State"         = taxon_state, 
                 "License"       = taxon_license) |> 
   dplyr::distinct(Primary, 
                   .keep_all = TRUE) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "NPPES NPI Registry Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime),
                        cgroup = c("", "Taxonomy Information"), 
                        n.cgroup = c(3,5))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="10" style="text-align: left;">
NPPES NPI Registry Search Results
</td>
</tr>
<tr>
<th style="border-top: 2px solid grey;">
</th>
<th colspan="3" style="font-weight: 900; border-top: 2px solid grey; text-align: center;">
</th>
<th style="border-bottom: none; border-top: 2px solid grey;" colspan="1">
 
</th>
<th colspan="5" style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
Taxonomy Information
</th>
</tr>
<tr>
<th style="border-bottom: 1px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: left;">
NPI
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: left;">
Last Name
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: left;">
Provider Type
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: left;" colspan="1">
 
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: left;">
Description
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: left;">
Code
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: left;">
Primary
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: left;">
State
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: left;">
License
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
1
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
1083879860
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
AARON
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Individual
</td>
<td style="border-bottom: 4px double grey; text-align: left;" colspan="1">
 
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Family Medicine
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
207Q00000X
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
TRUE
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
PA
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
OS019703
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="10">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

<br>

What if you need the provider’s PECOS PAC ID or Enrollment ID? Using the
`provider_mppe()` function, you can search Medicare’s **Fee-For-Service
Public Provider Enrollment API**:

<br>

``` r
mppe_ex <- provider_mppe(nppes_unpack$npi[[1]])
```

<br>

<details>
<summary>
Code
</summary>

``` r
mppe_table <- mppe_ex |> 
   dplyr::select("NPI"             = npi, 
                 "Last Name"       = last_name, 
                 "PAC ID"    = pecos_asct_cntl_id, 
                 "Enrollment ID" = enrlmt_id, 
                 "Specialty"       = provider_type_desc, 
                 "State"           = state_cd) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Fee-For-Service Public Provider Enrollment Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="7" style="text-align: left;">
Medicare Fee-For-Service Public Provider Enrollment Search Results
</td>
</tr>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
NPI
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Last Name
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
PAC ID
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Enrollment ID
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Specialty
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
State
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
1
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
1083879860
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
AARON
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
8426328519
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
I20200617001010
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
PRACTITIONER - FAMILY PRACTICE
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
PA
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="7">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

<br>

Is a Provider currently eligible to: \* Make referrals to Medicare Part
B or a Home Health Agency (HHA)? \* Order Durable Medical Equipment
(DME) or Power Mobility Devices (PMDs)?

<br>

Search Medicare’s **Order and Referring API** with `provider_moar()`:

<br>

``` r
moar_ex <- provider_moar(nppes_unpack$npi[[1]])
```

<br>

<details>
<summary>
Code
</summary>

``` r
moar_table <- moar_ex |> 
   dplyr::select("NPI"        = npi, 
                 "Last Name"  = last_name,
                 "First Name" = first_name, 
                 "Part B"     = partb, 
                 "DME"        = dme,
                 "HHA"        = hha, 
                 "PMD"        = pmd) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Order and Referring Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="8" style="text-align: left;">
Medicare Order and Referring Search Results
</td>
</tr>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
NPI
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Last Name
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
First Name
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Part B
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
DME
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
HHA
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
PMD
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
1
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
1083879860
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
AARON
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
CHRISTOPHER
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
TRUE
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
TRUE
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
TRUE
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
TRUE
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="8">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

You may need to find Medicare’s specialty codes for this provider’s
taxonomies. You can search Medicare’s **Provider and Supplier Taxonomy
Crosswalk API** with `provider_mpstc()`:

<br>

``` r
mpstc_ex <- provider_mpstc(nppes_unpack$taxon_code[[1]])
```

<br>

<details>
<summary>
Code
</summary>

``` r
mpstc_table <- mpstc_ex |> 
   dplyr::select("Taxonomy Code"                  = provider_taxonomy_code, 
                 "Medicare Specialty Code"        = medicare_specialty_code,
                 "Medicare Specialty Description" = medicare_provider_supplier_type_description,
                 "Specialty"                      = medicare_provider_supplier_type_description, 
                 "Classification"                 = provider_taxonomy_description_type_classification_specialization) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Provider and Supplier Taxonomy Crosswalk Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="6" style="text-align: left;">
Medicare Provider and Supplier Taxonomy Crosswalk Search Results
</td>
</tr>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Taxonomy Code
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Medicare Specialty Code
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Medicare Specialty Description
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Specialty
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Classification
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
1
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
207Q00000X
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
8
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Physician/Family Practice
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Physician/Family Practice
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Allopathic & Osteopathic Physicians/Family Medicine
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="6">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

You can check to see if a provider is due to revalidate their Medicare
enrollment by accessing Medicare’s **Revalidation Due Date API** with
`provider_mrdd()`:

<br>

``` r
mrdd_ex <- provider_mrdd(nppes_unpack$npi[[1]])
```

<br>

<details>
<summary>
Code
</summary>

``` r
mrdd_table <- mrdd_ex |> 
   dplyr::select("NPI"                   = national_provider_identifier, 
                 "Last Name"             = last_name,
                 "Enrollment ID"         = enrollment_id,
                 "Enrollment Type"       = provider_type_text,
                 "Enrollment Specialty"  = enrollment_specialty,
                 "State"                 = enrollment_state_code,
                 "Provider Type"         = provider_type_text, 
                 "Revalidation Due Date" = revalidation_due_date) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Revalidation Due Date Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="9" style="text-align: left;">
Medicare Revalidation Due Date Search Results
</td>
</tr>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
NPI
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Last Name
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Enrollment ID
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Enrollment Type
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Enrollment Specialty
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
State
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Provider Type
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Revalidation Due Date
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
1
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
1083879860
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Aaron
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
I20200617001010
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Non-DME Part B
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Family Practice
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
PA
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Non-DME Part B
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="9">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

<br>

Providers may need to update their digital contact information in the
NPPES system. To check, you can access the **CMS Public Reporting of
Missing Digital Contact Information API** with `provider_promdci()`. If
they appear in the search results, it’s time to update their NPPES
contact information:

<br>

``` r
provider_promdci(nppes_unpack$npi[[1]])
```

<br>

You can find out if a provider has opted out of Medicare by searching
the **Medicare Opt Out Affidavits API** with `provider_mooa()`:

<br>

``` r
mooa_ex <- provider_mooa(nppes_unpack$npi[[1]])
```

<br>

<details>
<summary>
Code
</summary>

``` r
mooa_ex |> 
   dplyr::select(NPI                        = npi,
                 Last                       = last_name,
                 First                      = first_name,
                 "Optout Effective Date"    = optout_effective_date,
                 "Optout End Date"          = optout_end_date,
                 "Order & Refer Eligible"   = eligible_to_order_and_refer,
                 Updated                    = last_updated,
                 Specialty                  = specialty,
                 Address                    = first_line_street_address,
                 City                       = city_name,
                 State                      = state_code) |>
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Revalidation Due Date Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in `dplyr::select()`:
#> ! `select()` doesn't handle lists.
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'mooa_table' not found

<br>

`provider_rcgpr()` accesses **Medicare’s Revalidation Clinic Group
Practice Reassignment API**:

<br>

``` r
rcgpr_ex <- provider_rcgpr(nppes_unpack$npi[[1]])
```

<br>

<details>
<summary>
Code
</summary>

``` r
rcgpr_table <- rcgpr_ex |> 
   dplyr::select("NPI"                           = individual_npi,
                 "Last"                          = individual_last_name,
                 "Type"                          = record_type,
                 "PAC ID Group "                 = group_pac_id,
                 "Enroll ID Group"               = group_enrollment_id,
                 "Business Name"                 = group_legal_business_name,
                 "Due Date Group"                = group_due_date,
                 "PAC ID Ind"                    = individual_pac_id,
                 "Enroll ID Ind"                 = individual_enrollment_id,
                 "Due Date Ind"                  = individual_due_date,
                 "Reassignments & Phys Assts"    = group_reassignments_and_physician_assistants,
                 "Employer Associations"         = individual_total_employer_associations) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Revalidation Clinic Group Practice Reassignment Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="13" style="text-align: left;">
Medicare Revalidation Clinic Group Practice Reassignment Search Results
</td>
</tr>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
NPI
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Last
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Type
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
PAC ID Group
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Enroll ID Group
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Business Name
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Due Date Group
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
PAC ID Ind
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Enroll ID Ind
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Due Date Ind
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Reassignments & Phys Assts
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Employer Associations
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
1
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
1083879860
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Aaron
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Reassignment
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
5395659312
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
O20040312000257
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Upmc Altoona Regional Health Services, Inc.
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
TBD
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
8426328519
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
I20200617001010
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
TBD
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
434
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
1
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="13">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

<br>

Using `provider_mpop()`, you can access **Medicare’s Physician & Other
Practitioners API**, enabling you to choose between three related
datasets:

> 1.  by Provider and Service API:

<br>

``` r
mpop_serv_ex <- provider_mpop(npi = nppes_unpack$npi[[1]], 
                              set = "serv",
                              year = "2020")
```

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_serv_table <- mpop_serv_ex |> 
   dplyr::select(Year            = year,
                 NPI             = rndrng_npi,
                 Last            = rndrng_prvdr_last_org_name,
                 City            = rndrng_prvdr_city,
                 State           = rndrng_prvdr_state_abrvtn,
                 PAR             = rndrng_prvdr_mdcr_prtcptg_ind,
                 HCPCS           = hcpcs_cd,
                 Beneficiaries   = tot_benes,
                 "Services"      = tot_srvcs,
                 "Avg Billed"    = avg_sbmtd_chrg,
                 "Avg Allowed"   = avg_mdcr_alowd_amt,
                 "Avg Payment"   = avg_mdcr_pymt_amt) |>
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Provider & Service Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="13" style="text-align: left;">
Medicare Physician & Other Practitioners by Provider & Service Search
Results
</td>
</tr>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Year
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
NPI
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Last
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
City
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
State
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
PAR
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
HCPCS
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Beneficiaries
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Services
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Avg Billed
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Avg Allowed
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Avg Payment
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;">
1
</td>
<td style="text-align: left;">
2020
</td>
<td style="text-align: left;">
1083879860
</td>
<td style="text-align: left;">
Aaron
</td>
<td style="text-align: left;">
Cresson
</td>
<td style="text-align: left;">
PA
</td>
<td style="text-align: left;">
Y
</td>
<td style="text-align: left;">
36415
</td>
<td style="text-align: left;">
38
</td>
<td style="text-align: left;">
53
</td>
<td style="text-align: left;">
15
</td>
<td style="text-align: left;">
3
</td>
<td style="text-align: left;">
3
</td>
</tr>
<tr>
<td style="text-align: left;">
2
</td>
<td style="text-align: left;">
2020
</td>
<td style="text-align: left;">
1083879860
</td>
<td style="text-align: left;">
Aaron
</td>
<td style="text-align: left;">
Cresson
</td>
<td style="text-align: left;">
PA
</td>
<td style="text-align: left;">
Y
</td>
<td style="text-align: left;">
85610
</td>
<td style="text-align: left;">
12
</td>
<td style="text-align: left;">
32
</td>
<td style="text-align: left;">
17
</td>
<td style="text-align: left;">
4.29
</td>
<td style="text-align: left;">
4.29
</td>
</tr>
<tr>
<td style="text-align: left;">
3
</td>
<td style="text-align: left;">
2020
</td>
<td style="text-align: left;">
1083879860
</td>
<td style="text-align: left;">
Aaron
</td>
<td style="text-align: left;">
Cresson
</td>
<td style="text-align: left;">
PA
</td>
<td style="text-align: left;">
Y
</td>
<td style="text-align: left;">
90682
</td>
<td style="text-align: left;">
15
</td>
<td style="text-align: left;">
15
</td>
<td style="text-align: left;">
34
</td>
<td style="text-align: left;">
34
</td>
<td style="text-align: left;">
34
</td>
</tr>
<tr>
<td style="text-align: left;">
4
</td>
<td style="text-align: left;">
2020
</td>
<td style="text-align: left;">
1083879860
</td>
<td style="text-align: left;">
Aaron
</td>
<td style="text-align: left;">
Cresson
</td>
<td style="text-align: left;">
PA
</td>
<td style="text-align: left;">
Y
</td>
<td style="text-align: left;">
93793
</td>
<td style="text-align: left;">
13
</td>
<td style="text-align: left;">
33
</td>
<td style="text-align: left;">
49
</td>
<td style="text-align: left;">
11.58
</td>
<td style="text-align: left;">
8.6987878788
</td>
</tr>
<tr>
<td style="text-align: left;">
5
</td>
<td style="text-align: left;">
2020
</td>
<td style="text-align: left;">
1083879860
</td>
<td style="text-align: left;">
Aaron
</td>
<td style="text-align: left;">
Cresson
</td>
<td style="text-align: left;">
PA
</td>
<td style="text-align: left;">
Y
</td>
<td style="text-align: left;">
99214
</td>
<td style="text-align: left;">
62
</td>
<td style="text-align: left;">
101
</td>
<td style="text-align: left;">
220
</td>
<td style="text-align: left;">
105.40613861
</td>
<td style="text-align: left;">
76.368019802
</td>
</tr>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
6
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
2020
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
1083879860
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Aaron
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Cresson
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
PA
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
Y
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
G0008
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
15
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
15
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
32
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
16.28
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
16.28
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="13">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

<br>

> 2.  by Geography and Service API:

<br>

``` r
mpop_geo_ex <- provider_mpop(hcpcs   = "99214", 
                             set     = "geo",
                             geo_lvl = "National",
                             year    = "2020")
```

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_geo_table <- mpop_geo_ex |> 
   dplyr::select(Year                       = year, 
                 HCPCS                      = hcpcs_cd,
                 Region                     = rndrng_prvdr_geo_desc,
                 POS                        = place_of_srvc,
                 Providers                  = tot_rndrng_prvdrs,
                 Beneficiaries              = tot_benes, 
                 Services                   = tot_srvcs, 
                 "Avg Charge"               = avg_sbmtd_chrg, 
                 "Avg Allowed"              = avg_mdcr_alowd_amt, 
                 "Avg Payment"              = avg_mdcr_pymt_amt) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Geography & Service Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="11" style="text-align: left;">
Medicare Physician & Other Practitioners by Geography & Service Search
Results
</td>
</tr>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Year
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
HCPCS
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Region
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
POS
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Providers
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Beneficiaries
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Services
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Avg Charge
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Avg Allowed
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Avg Payment
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;">
1
</td>
<td style="text-align: left;">
2020
</td>
<td style="text-align: left;">
99214
</td>
<td style="text-align: left;">
National
</td>
<td style="text-align: left;">
F
</td>
<td style="text-align: left;">
159324
</td>
<td style="text-align: left;">
3183652
</td>
<td style="text-align: left;">
7008865
</td>
<td style="text-align: left;">
210.09590176
</td>
<td style="text-align: left;">
77.348125868
</td>
<td style="text-align: left;">
55.276294601
</td>
</tr>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
2
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
2020
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
99214
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
National
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
O
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
551728
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
21794074
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
81741450.8
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
222.24271159
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
104.99486506
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
72.227897324
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="11">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

<br>

> 3.  by Provider API:

<br>

``` r
mpop_prov_ex <- provider_mpop(npi  = nppes_unpack$npi[[1]], 
                              set  = "prov",
                              year = "2020")
```

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_prov_totals_table <- mpop_prov_ex |> 
   dplyr::select("Year"              = year,
                 "Unique HCPCS"      = tot_hcpcs_cds,
                 "Beneficiaries"     = tot_benes, 
                 "Services"          = tot_srvcs, 
                 "Charges Submitted" = tot_sbmtd_chrg,
                 "Amount Allowed"    = tot_mdcr_alowd_amt,
                 "Payments"          = tot_mdcr_pymt_amt) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Provider: Yearly Totals", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="8" style="text-align: left;">
Medicare Physician & Other Practitioners by Provider: Yearly Totals
</td>
</tr>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Year
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Unique HCPCS
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Beneficiaries
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Services
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Charges Submitted
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Amount Allowed
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Payments
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
1
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
2020
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
37
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
93
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
333
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
35226
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
17076.15
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
13170.13
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="8">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_prov_age_table <- mpop_prov_ex |> 
   dplyr::select("Year"     = year,
                 "Average Age" = bene_avg_age,
                 "Under 65" = bene_age_lt_65_cnt,
                 "65 - 74" = bene_age_65_74_cnt,
                 "75 - 84" = bene_age_75_84_cnt,
                 "Over 84" = bene_age_gt_84_cnt) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Provider: Beneficiary Age", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="7" style="text-align: left;">
Medicare Physician & Other Practitioners by Provider: Beneficiary Age
</td>
</tr>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Year
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Average Age
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Under 65
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
65 - 74
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
75 - 84
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Over 84
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
1
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
2020
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
72
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
14
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
45
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
23
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
11
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="7">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_prov_demo_table <- mpop_prov_ex |> 
   dplyr::select("Year" = year,
                 "Female" = bene_feml_cnt,
                 "Male" = bene_male_cnt,
                 "White" = bene_race_wht_cnt,
                 "Black" = bene_race_black_cnt,
                 "Dual" = bene_dual_cnt,
                 "Non-Dual" = bene_ndual_cnt) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Provider: Beneficiary Demographics", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="8" style="text-align: left;">
Medicare Physician & Other Practitioners by Provider: Beneficiary
Demographics
</td>
</tr>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Year
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Female
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Male
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
White
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Black
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Dual
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Non-Dual
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
1
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
2020
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
48
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
45
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
93
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
0
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
12
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
81
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="8">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

<br>

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_prov_ccw_table <- mpop_prov_ex |> 
   dplyr::select("Year" = year,
                 "Cancer" = bene_cc_cncr_pct,
                 "CKD" = bene_cc_ckd_pct,
                 "Diabetes" = bene_cc_dbts_pct,
                 "Hyperlipidemia" = bene_cc_hyplpdma_pct,
                 "Hypertension" = bene_cc_hyprtnsn_pct,
                 "Rheumatoid Arthritis / Osteoarthritis" = bene_cc_raoa_pct,
                 "Avg. HCC Risk Score" = bene_avg_risk_scre) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Provider: Beneficiary Chronic Disease Percentages", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
```

</details>

<br>

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="9" style="text-align: left;">
Medicare Physician & Other Practitioners by Provider: Beneficiary
Chronic Disease Percentages
</td>
</tr>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Year
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Cancer
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
CKD
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Diabetes
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Hyperlipidemia
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Hypertension
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Rheumatoid Arthritis / Osteoarthritis
</th>
<th style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: left;">
Avg. HCC Risk Score
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="border-bottom: 4px double grey; text-align: left;">
1
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
2020
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
0.12
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
0.3
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
0.34
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
0.6
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
0.7
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
0.42
</td>
<td style="border-bottom: 4px double grey; text-align: left;">
1.1213
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="9">
Retrieved on Tuesday, November 01, 2022 at 05:18 AM
</td>
</tr>
</tfoot>
</table>

------------------------------------------------------------------------

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
