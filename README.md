
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
[![pkgdown](https://github.com/andrewallenbruce/provider/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/andrewallenbruce/provider/actions/workflows/pkgdown.yaml)
[![Codecov test
coverage](https://codecov.io/gh/andrewallenbruce/provider/branch/main/graph/badge.svg)](https://app.codecov.io/gh/andrewallenbruce/provider?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/andrewallenbruce/provider/badge)](https://www.codefactor.io/repository/github/andrewallenbruce/provider)
![GitHub
milestone](https://img.shields.io/github/milestones/progress/andrewallenbruce/provider/1?color=white&logo=milestones)
<!-- badges: end -->

> Providing easy access to [healthcare
> provider](https://en.wikipedia.org/wiki/Health_care_provider) data
> through publicly available APIs & sources.

## Installation

You can install `provider` from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("andrewallenbruce/provider")
```

## Motivation

The overarching goal of `provider` is to make the experience of
accessing publicly-available Provider data easier and more consistent
across a variety of sources. It aims to accomplish this through the
following general goals, where possible:

- *Structuring output in the **tidy** framework* as much as is
  reasonably possible, with an option to turn it off by setting
  `tidy = FALSE`.

- *Harmonization of variable names*, for the express purpose of making
  it easier to understand (and make connections between) each API’s
  output. This will also allow for removal of duplicate information
  across API output, if desired.

- *Validation checks of inputs*, as is reasonable (e.g, identifiers such
  as NPI, PAC ID, Medicare Enrollment ID, CCN, Taxonomy codes). Not only
  is this simply good practice, it will also prevent unnecessary
  querying of the APIs.

- *Well-written documentation*, containing as many examples as is
  necessary. Each API’s output can be difficult to understand, even for
  someone with expertise in R, healthcare, or both.

## Exported Functions

API Search functions can be grouped according to the type of data they
return about a provider: *administrative*, *statistical*, and
*auxiliary.*

### Administrative

- `nppes()`: Registry of all healthcare providers.
- `enrollment()`: Providers actively enrolled in Medicare.
- `opt_out()`: Providers currently opted out of Medicare.
- `revalidation_*()`: Link Type-1 and Type-2 providers.
- `doctors_and_clinicians()`: Provider school, graduation year, linking.
- `affiliation()`: Linking providers to Facilities.
- `hospital_enrollment()`: Facilities linked to providers.

### Statistical

The following return provider-specific stats:

- `by_provider()`: Yearly high-level utilization data.
- `by_service()`: Yearly detailed utilization data.
- `quality_payment()`: Yearly QPP/MIPS performance data.
- `quality_eligibility()`: Yearly QPP/MIPS eligibility data.
- `open_payments()`: Yearly Open Payments reporting data.

The following return yearly stats useful for comparison against data
returned from `by_service()`:

- `geography()`
- `beneficiary()`
- `chronic_multiple()`
- `chronic_specific()`

### Auxiliary

- `order_refer()`: Is a provider eligible to order and refer?
- `missing_endpoints()`: Is a provider missing Endpoints in the NPPES
  NPI Registry?
- `pending_applications()`: Has a provider’s Medicare application been
  processed?
- `taxonomy_crosswalk()`: Is a provider’s specialty eligible to enroll
  in Medicare?

## Usage

``` r
library(provider)
```

------------------------------------------------------------------------

## Code of Conduct

Please note that the `provider` project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
