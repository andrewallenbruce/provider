
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

<br>

## Installation

You can install the development version of `provider` from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("andrewallenbruce/provider")
```

## Motivation

<br>

The *overarching* goal of `provider` is to make the experience of
accessing publicly-available Provider data easier and more consistent
across a variety of CMS sources. It aims to accomplish this through the
following *general* goals, where possible:

- Harmonization of variable names so as to allow for removal of
  duplicate information across API output, if desired
- Validation checks of provider identifiers (e.g., NPI, PAC ID, Medicare
  Enrollment ID, CCN)
- Structuring output in the *tidy* framework as much as is reasonably
  possible (with an option to turn off by setting `tidy = FALSE`)

<br>

## APIs

API Search functions can be grouped according to the type of data they
return about a provider: *administrative*, *statistical*, and
*auxillary.*

### Administrative

- `nppes_npi()`: Registry of all healthcare providers.
- `provider_enrollment()`: Providers actively enrolled in Medicare.
- `opt_out()`: Providers currently opted out of Medicare.
- `revalidation_*()`: Link Type-1 and Type-2 providers.
- `doctors_and_clinicians()`: Provider school, graduation year, linking.
- `facility_affiliations()`: Linking providers to Facilities.
- `hospital_enrollment()`: Facilities linked to providers.

### Statistical

The following return provider-specific stats:

- `physician_by_provider()`: Yearly high-level utilization data.
- `physician_by_service()`: Yearly detailed utilization data.
- `quality_payments()`: Yearly QPP/MIPS performance data.
- `quality_eligibility()`: Yearly QPP/MIPS eligibility data.
- `open_payments()`: Yearly Open Payments reporting data.

The following return yearly stats useful for comparison against data
returned from `physician_by_service()`:

- `physician_by_geography()`
- `beneficiary_enrollment()`
- `cc_multiple()`
- `cc_specific()`

### Auxillary

- `order_refer()`: Is a provider eligible to order and refer?
- `missing_information()`: Is a provider missing Endpoints in the NPPES
  NPI Registry?
- `pending_applications()`: Has a provider’s Medicare application been
  processed?
- `taxonomy_crosswalk()`: Is a provider’s specialty eligible to enroll
  in Medicare?

<br>

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
