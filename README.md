
<!-- README.md is generated from README.Rmd. Please edit that file -->

# provider <img src="man/figures/logo.svg" align="right" height="200" />

<!-- badges: start -->

[![devel
version](https://img.shields.io/badge/devel%20version-0.0.0.9012-blue.svg)](https://github.com/andrewallenbruce/provider)
[![R-CMD-check](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://choosealicense.com/licenses/mit/)
[![code
size](https://img.shields.io/github/languages/code-size/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider)
[![last
commit](https://img.shields.io/github/last-commit/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider/commits/main)
[![pkgdown](https://github.com/andrewallenbruce/provider/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/andrewallenbruce/provider/actions/workflows/pkgdown.yaml)
[![Codecov test
coverage](https://codecov.io/gh/andrewallenbruce/provider/branch/main/graph/badge.svg)](https://app.codecov.io/gh/andrewallenbruce/provider?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/andrewallenbruce/provider/badge)](https://www.codefactor.io/repository/github/andrewallenbruce/provider)
![GitHub
milestone](https://img.shields.io/github/milestones/progress/andrewallenbruce/provider/1?color=white&logo=milestones)
<!-- badges: end -->

> Providing easy access to [healthcare
> provider](https://en.wikipedia.org/wiki/Health_care_provider) data
> through publicly available APIs.

## Installation

You can install `provider` from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("andrewallenbruce/provider")
```

## Usage

``` r
library(provider)
```

- `nppes()`: Registry of all healthcare providers.
- `providers()`: Providers actively enrolled in Medicare.
- `opt_out()`: Providers currently opted out of Medicare.
- `order_refer()`: Is a provider eligible to order and refer?
- `reassignments`()\`: Link Type-1 and Type-2 providers.
- `clinicians()`: Provider school, graduation year, linking.
- `affiliations()`: Linking providers to Facilities.
- `hospitals()`: Hospitals actively enrolled in Medicare.
- `utilization()`: Yearly high-level utilization data.
- `quality_payment()`: Yearly QPP/MIPS performance data.
- `open_payments()`: Yearly Open Payments reporting data.
- `beneficiaries()`
- `conditions()`

``` r
providers(first = "ANDREW", state = "GA", specialty_code = "14-93")
```

    #> # A tibble: 29 × 10
    #>    npi       pac   enid  specialty_code specialty_description state first middle
    #>    <chr>     <chr> <chr> <chr>          <chr>                 <chr> <chr> <chr> 
    #>  1 18211979… 6507… I200… 14-93          PRACTITIONER - EMERG… GA    ANDR… S     
    #>  2 16290504… 1557… I200… 14-93          PRACTITIONER - EMERG… GA    ANDR… K     
    #>  3 14575504… 2769… I201… 14-93          PRACTITIONER - EMERG… GA    ANDR… PATRI…
    #>  4 10230036… 6608… I201… 14-93          PRACTITIONER - EMERG… GA    ANDR… G     
    #>  5 10636636… 4880… I201… 14-93          PRACTITIONER - EMERG… GA    ANDR… <NA>  
    #>  6 16997185… 1759… I201… 14-93          PRACTITIONER - EMERG… GA    ANDR… A     
    #>  7 13061595… 5991… I201… 14-93          PRACTITIONER - EMERG… GA    ANDR… M     
    #>  8 16394605… 3274… I201… 14-93          PRACTITIONER - EMERG… GA    ANDR… JAMES 
    #>  9 17203772… 7719… I201… 14-93          PRACTITIONER - EMERG… GA    ANDR… R     
    #> 10 13465008… 6305… I201… 14-93          PRACTITIONER - EMERG… GA    ANDR… <NA>  
    #> # ℹ 19 more rows
    #> # ℹ 2 more variables: last <chr>, gender <chr>

------------------------------------------------------------------------

## Code of Conduct

Please note that the `provider` project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
