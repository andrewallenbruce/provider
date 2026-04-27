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
#> ℹ opt_out has 55,898 rows.
opt_out(npi = 1043522824)
#> ✔ opt_out returned 1 result.
#> # A tibble: 1 × 12
#>          npi first last  specialty  start_date end_date   updated    city  state
#> *      <int> <chr> <chr> <chr>      <date>     <date>     <date>     <chr> <chr>
#> 1 1043522824 James Smith Nurse Pra… 2019-07-01 2027-07-01 2025-08-15 SCOT… AZ   
#> # ℹ 3 more variables: zip <chr>, order_refer <int>, address <chr>
opt_out(state = "AK")
#> ✔ opt_out returned 258 results.
#> # A tibble: 258 × 12
#>           npi first last  specialty start_date end_date   updated    city  state
#>  *      <int> <chr> <chr> <chr>     <date>     <date>     <date>     <chr> <chr>
#>  1 1265553432 Henry Chap… Physicia… 2012-04-01 2026-04-01 2024-05-15 ANCH… AK   
#>  2 1487879664 Ann   Stoc… Clinical… 2012-04-01 2026-04-01 2024-05-15 ANCH… AK   
#>  3 1043559362 Amber Shea  Nurse Pr… 2013-04-01 2027-04-01 2025-05-15 WASI… AK   
#>  4 1598825663 Robe… Skala Family P… 2013-06-04 2027-06-04 2025-07-15 EAGL… AK   
#>  5 1508198276 Robe… Cass… Dentist   2013-07-23 2027-07-23 2025-09-15 WASI… AK   
#>  6 1952340358 Eliz… Desc… Family P… 2014-04-01 2026-04-01 2024-05-15 ANCH… AK   
#>  7 1124176227 Evel… Wisz… Clinical… 2018-07-01 2026-07-01 2024-08-15 KODI… AK   
#>  8 1154467520 Suza… Stra… Nurse Pr… 2014-04-01 2026-04-01 2024-05-15 EAGL… AK   
#>  9 1295755296 Will… Berg… Oral Sur… 2018-11-05 2026-11-05 2024-12-15 ANCH… AK   
#> 10 1225058977 Ray   Holl… Oral Sur… 2014-06-16 2026-06-16 2024-07-15 ANCH… AK   
#> # ℹ 248 more rows
#> # ℹ 3 more variables: zip <chr>, order_refer <int>, address <chr>
opt_out(specialty = "Psychiatry", order_refer = FALSE)
#> ✔ opt_out returned 813 results.
#> # A tibble: 798 × 12
#>           npi first last  specialty start_date end_date   updated    city  state
#>  *      <int> <chr> <chr> <chr>     <date>     <date>     <date>     <chr> <chr>
#>  1 1720444581 Jona… Rain… Psychiat… 1998-01-30 2028-01-30 2026-02-16 GLAD… PA   
#>  2 1598802100 Mart… Leat… Psychiat… 2012-04-01 2026-04-01 2024-10-15 SAN … TX   
#>  3 1972623346 Nancy Shos… Psychiat… 2012-03-02 2026-03-02 2024-10-15 DALL… TX   
#>  4 1124116793 Namir Daml… Psychiat… 2020-07-26 2026-07-26 2024-08-15 ENCI… CA   
#>  5 1427146331 Lawr… Corm… Psychiat… 2012-05-10 2026-05-10 2024-10-15 DENV… CO   
#>  6 1114132313 Char… Scha… Psychiat… 2012-06-14 2026-06-14 2024-10-15 SACR… CA   
#>  7 1093894420 Andr… Popp… Psychiat… 2012-06-01 2026-06-01 2026-01-15 NEWT… MA   
#>  8 1871501395 Ingr… Schm… Psychiat… 2010-09-02 2026-09-02 2024-10-15 AUST… TX   
#>  9 1477614204 Lore… Henry Psychiat… 2012-05-26 2026-05-26 2024-10-15 COLL… TX   
#> 10 1932284098 Patr… Mcgr… Psychiat… 2012-06-01 2026-06-01 2024-07-15 NEW … NY   
#> # ℹ 788 more rows
#> # ℹ 3 more variables: zip <chr>, order_refer <int>, address <chr>
```
