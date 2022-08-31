
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `provider` <img src="man/figures/logo.svg" align="right" height="500" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Project Status: WIP - Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://choosealicense.com/licenses/mit/)
<!-- badges: end -->

The goal of {provider} is to provide performant and reliable open-source
tools to facilitate easy access to [healthcare
provider](https://en.wikipedia.org/wiki/Health_care_provider) data
through publicly available APIs & sources.

<br>

## Installation

You can install the development version of `provider` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andrewallenbruce/provider")
```

<br>

## Search the NPPES by A Provider’s NPI

Input the 10-digit NPI you wish to search for into `prov_npi_nppes()`:

``` r
# Load library
library(provider)

# Query the NPPES API
nppes_npi_response <- prov_npi_nppes(1528060837)
```

<br>

This returns a response in the form of a data frame with the NPI
searched for, the date & time that the search was performed, the outcome
(*results* means the search was successful, *errors*, that something
went wrong) and a column called `data_lists`:

<br>

    #> # A tibble: 1 × 4
    #>   search     datetime            outcome data_lists   
    #>   <chr>      <dttm>              <chr>   <list>       
    #> 1 1528060837 2022-08-31 15:18:57 results <df [1 × 11]>

<br>

`data_lists` is a nested list-column. You can access the inner lists
using the `$` operator, but we can get a better sense of the
hierarchical structure of these list columns using lobstr’s `tree()`
function:

<br>

``` r
lobstr::tree(nppes_npi_response$data_lists, 
             max_depth = 2)
#> <list>
#> └─S3<data.frame>
#>   ├─created_epoch: "1117631856000"
#>   ├─enumeration_type: "NPI-1"
#>   ├─last_updated_epoch: "1183957886000"
#>   ├─number: "1528060837"
#>   ├─addresses: <list>
#>   │ └─S3<data.frame>...
#>   ├─practiceLocations: <list>
#>   │ └─<list>
#>   ├─basic: S3<data.frame>...
#>   ├─taxonomies: <list>
#>   │ └─S3<data.frame>...
#>   ├─identifiers: <list>
#>   │ └─S3<data.frame>...
#>   ├─endpoints: <list>
#>   │ └─<list>
#>   └─other_names: <list>
#>     └─<list>
```

<br>

This exposes seven more nested list-columns, but using the
`prov_nppes_unpack()` function, we can untangle this mess:

<br>

``` r
# Unpack NPPES response
nppes_npi_unpacked <- prov_nppes_unpack(nppes_npi_response)
```

<br>

And the final tidied results:

<br>

| prov_type | npi        | first_name | last_name | credential | gender | address_purpose | address_1             | city      | state_abb | postal_code | telephone_number | address_2 | fax_number   | taxon_code | taxon_desc         | taxon_license | ident_desc                   | ident_issuer           | identifier |
|:----------|:-----------|:-----------|:----------|:-----------|:-------|:----------------|:----------------------|:----------|:----------|:------------|:-----------------|:----------|:-------------|:-----------|:-------------------|:--------------|:-----------------------------|:-----------------------|:-----------|
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | MAILING         | 1939 OLD ANNAPOLIS RD | WOODBINE  | MD        | 217978201   | 301-854-6748     | NA        | NA           | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | Aetna HMO              | 0129008    |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | MAILING         | 1939 OLD ANNAPOLIS RD | WOODBINE  | MD        | 217978201   | 301-854-6748     | NA        | NA           | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | DOL/OWCP               | 146574500  |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | MAILING         | 1939 OLD ANNAPOLIS RD | WOODBINE  | MD        | 217978201   | 301-854-6748     | NA        | NA           | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | United Healthcare      | 230033     |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | MAILING         | 1939 OLD ANNAPOLIS RD | WOODBINE  | MD        | 217978201   | 301-854-6748     | NA        | NA           | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | MDIPA/Alliance/MLH/OC  | 38311      |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | MAILING         | 1939 OLD ANNAPOLIS RD | WOODBINE  | MD        | 217978201   | 301-854-6748     | NA        | NA           | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | Cigna                  | 4074069    |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | MAILING         | 1939 OLD ANNAPOLIS RD | WOODBINE  | MD        | 217978201   | 301-854-6748     | NA        | NA           | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | Aetna PPO              | 4296824    |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | MAILING         | 1939 OLD ANNAPOLIS RD | WOODBINE  | MD        | 217978201   | 301-854-6748     | NA        | NA           | 225100000X | Physical Therapist | 14262         | MEDICARE ID-Type Unspecified | MCR Provider#          | 575182E20  |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | MAILING         | 1939 OLD ANNAPOLIS RD | WOODBINE  | MD        | 217978201   | 301-854-6748     | NA        | NA           | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | MCR Railroad retiremnt | 650003825  |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | MAILING         | 1939 OLD ANNAPOLIS RD | WOODBINE  | MD        | 217978201   | 301-854-6748     | NA        | NA           | 225100000X | Physical Therapist | 14262         | MEDICARE UPIN                | NA                     | R23823     |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | MAILING         | 1939 OLD ANNAPOLIS RD | WOODBINE  | MD        | 217978201   | 301-854-6748     | NA        | NA           | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | BC/BS Non Provider#    | k366       |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | LOCATION        | 6000 EXECUTIVE BLVD   | ROCKVILLE | MD        | 208523803   | 301-816-0020     | STE 201   | 301-816-0334 | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | Aetna HMO              | 0129008    |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | LOCATION        | 6000 EXECUTIVE BLVD   | ROCKVILLE | MD        | 208523803   | 301-816-0020     | STE 201   | 301-816-0334 | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | DOL/OWCP               | 146574500  |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | LOCATION        | 6000 EXECUTIVE BLVD   | ROCKVILLE | MD        | 208523803   | 301-816-0020     | STE 201   | 301-816-0334 | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | United Healthcare      | 230033     |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | LOCATION        | 6000 EXECUTIVE BLVD   | ROCKVILLE | MD        | 208523803   | 301-816-0020     | STE 201   | 301-816-0334 | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | MDIPA/Alliance/MLH/OC  | 38311      |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | LOCATION        | 6000 EXECUTIVE BLVD   | ROCKVILLE | MD        | 208523803   | 301-816-0020     | STE 201   | 301-816-0334 | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | Cigna                  | 4074069    |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | LOCATION        | 6000 EXECUTIVE BLVD   | ROCKVILLE | MD        | 208523803   | 301-816-0020     | STE 201   | 301-816-0334 | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | Aetna PPO              | 4296824    |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | LOCATION        | 6000 EXECUTIVE BLVD   | ROCKVILLE | MD        | 208523803   | 301-816-0020     | STE 201   | 301-816-0334 | 225100000X | Physical Therapist | 14262         | MEDICARE ID-Type Unspecified | MCR Provider#          | 575182E20  |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | LOCATION        | 6000 EXECUTIVE BLVD   | ROCKVILLE | MD        | 208523803   | 301-816-0020     | STE 201   | 301-816-0334 | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | MCR Railroad retiremnt | 650003825  |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | LOCATION        | 6000 EXECUTIVE BLVD   | ROCKVILLE | MD        | 208523803   | 301-816-0020     | STE 201   | 301-816-0334 | 225100000X | Physical Therapist | 14262         | MEDICARE UPIN                | NA                     | R23823     |
| NPI-1     | 1528060837 | JOHN       | SARGEANT  | PT         | M      | LOCATION        | 6000 EXECUTIVE BLVD   | ROCKVILLE | MD        | 208523803   | 301-816-0020     | STE 201   | 301-816-0334 | 225100000X | Physical Therapist | 14262         | Other (non-Medicare)         | BC/BS Non Provider#    | k366       |

<br>

## Usage

Read the Overview vignette for a more thorough introduction to the
package’s functionality.

<br>

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
