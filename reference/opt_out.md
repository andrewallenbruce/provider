# Opt-Out Providers

Information on providers who have decided not to participate in
Medicare.

## Usage

``` r
opt_out(
  npi = NULL,
  first = NULL,
  last = NULL,
  specialty = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  order_refer = NULL,
  count = FALSE,
  set = FALSE
)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- specialty:

  `<chr>` Provider's specialty

- address:

  `<chr>` Provider's address

- city:

  `<chr>` Provider's city

- state:

  `<chr>` Provider's state abbreviation

- zip:

  `<chr>` Provider's zip code

- order_refer:

  `<lgl>` Indicates order and refer eligibility

- count:

  `<lgl>` Return the dataset's total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Opting Out

Providers who do not wish to enroll in the Medicare program may
"opt-out", meaning neither they nor the beneficiary can bill Medicare
for services rendered.

Instead, a private contract between provider and beneficiary is signed,
neither party is reimbursed by Medicare and the beneficiary pays the
provider out-of-pocket.

To opt out, a provider must:

- Be of an **eligible specialty** type

- Submit an **opt-out affidavit** to Medicare

- Enter into a **private contract** with their Medicare patients

## Opt-Out Periods

Opt-out periods last for two years and cannot be terminated early unless
the provider is opting out for the very first time and terminates the
opt-out no later than 90 days after the opt-out period's effective date.
Opt-out statuses are effective for two years and automatically renew.

Providers may **NOT** opt-out if they intend to be a Medicare Advantage
(Part C) provider or furnish services covered by traditional Medicare
fee-for-service (Part B).

## References

- [Medicare Opt Out Affidavits
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)

## Examples

``` r
opt_out(count = TRUE)
#> opt_out Totals
#> • Rows  : 55,898
#> • Pages : 12    
#> 

opt_out(npi = 1043522824)
#> ✔ opt_out returned 1 result.
#> # A tibble: 1 × 12
#>         npi first last  specialty start_date end_date   updated    address city 
#>       <int> <chr> <chr> <chr>     <date>     <date>     <date>     <chr>   <chr>
#> 1    1.04e9 James Smith Nurse Pr… 2019-07-01 2027-07-01 2025-08-15 STE 111 SCOT…
#> # ℹ 3 more variables: state <chr>, zip <chr>, order_refer <int>

opt_out(state = "AK")
#> ✔ opt_out returned 260 results.
#> # A tibble: 260 × 12
#>         npi first last  specialty start_date end_date   updated    address city 
#>       <int> <chr> <chr> <chr>     <date>     <date>     <date>     <chr>   <chr>
#>  1   1.27e9 Henry Chap… Physicia… 2012-04-01 2028-04-01 2026-04-16 STE 101 ANCH…
#>  2   1.49e9 Ann   Stoc… Clinical… 2012-04-01 2028-04-01 2026-04-16 STE 214 ANCH…
#>  3   1.04e9 Amber Shea  Nurse Pr… 2013-04-01 2027-04-01 2025-05-15 5805 E… WASI…
#>  4   1.60e9 Robe… Skala Family P… 2013-06-04 2027-06-04 2025-07-15 STE 102 EAGL…
#>  5   1.51e9 Robe… Cass… Dentist   2013-07-23 2027-07-23 2025-09-15 STE 1   WASI…
#>  6   1.95e9 Eliz… Desc… Family P… 2014-04-01 2028-04-01 2026-04-16 STE 201 ANCH…
#>  7   1.12e9 Evel… Wisz… Clinical… 2018-07-01 2026-07-01 2024-08-15 104 CE… KODI…
#>  8   1.15e9 Suza… Stra… Nurse Pr… 2014-04-01 2028-04-01 2026-04-16 STE 100 EAGL…
#>  9   1.30e9 Will… Berg… Oral Sur… 2018-11-05 2026-11-05 2024-12-15 STE 203 ANCH…
#> 10   1.23e9 Ray   Holl… Oral Sur… 2014-06-16 2026-06-16 2024-07-15 STE 203 ANCH…
#> # ℹ 250 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, order_refer <int>

opt_out(specialty = "Psychiatry", order_refer = FALSE)
#> ✔ opt_out returned 813 results.
#> # A tibble: 813 × 12
#>         npi first last  specialty start_date end_date   updated    address city 
#>       <int> <chr> <chr> <chr>     <date>     <date>     <date>     <chr>   <chr>
#>  1   1.72e9 Jona… Rain… Psychiat… 1998-01-30 2028-01-30 2026-02-16 P O BO… GLAD…
#>  2   1.60e9 Mart… Leat… Psychiat… 2012-04-01 2028-04-01 2026-04-16 #5101   SAN …
#>  3   1.97e9 Nancy Shos… Psychiat… 2012-03-02 2028-03-02 2026-04-16 12880 … DALL…
#>  4   1.12e9 Namir Daml… Psychiat… 2020-07-26 2026-07-26 2024-08-15 STE 207 ENCI…
#>  5   1.43e9 Lawr… Corm… Psychiat… 2012-05-10 2026-05-10 2024-10-15 3773 C… DENV…
#>  6   1.11e9 Char… Scha… Psychiat… 2012-06-14 2026-06-14 2024-10-15 1455 3… SACR…
#>  7   1.09e9 Andr… Popp… Psychiat… 2012-06-01 2026-06-01 2026-01-15 STE 40… NEWT…
#>  8   1.87e9 Ingr… Schm… Psychiat… 2010-09-02 2026-09-02 2024-10-15 STE 109 AUST…
#>  9   1.48e9 Lore… Henry Psychiat… 2012-05-26 2026-05-26 2024-10-15 SUITE … COLL…
#> 10   1.93e9 Patr… Mcgr… Psychiat… 2012-06-01 2026-06-01 2024-07-15 SUITE … NEW …
#> # ℹ 803 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, order_refer <int>
```
