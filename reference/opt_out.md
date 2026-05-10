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
#>   first last       npi specialty start_date end_date   address city  state zip  
#>   <chr> <chr>    <int> <chr>     <date>     <date>     <chr>   <chr> <chr> <chr>
#> 1 James Smith   1.04e9 Nurse Pr… 2019-07-01 2027-07-01 STE 111 SCOT… AZ    8525…
#> # ℹ 2 more variables: order_refer <int>, updated <date>

opt_out(state = "AK")
#> ✔ opt_out returned 260 results.
#> # A tibble: 260 × 12
#>    first  last     npi specialty start_date end_date   address city  state zip  
#>    <chr>  <chr>  <int> <chr>     <date>     <date>     <chr>   <chr> <chr> <chr>
#>  1 Henry  Chap… 1.27e9 Physicia… 2012-04-01 2028-04-01 STE 101 ANCH… AK    9950…
#>  2 Ann    Stoc… 1.49e9 Clinical… 2012-04-01 2028-04-01 STE 214 ANCH… AK    9950…
#>  3 Amber  Shea  1.04e9 Nurse Pr… 2013-04-01 2027-04-01 5805 E… WASI… AK    9965…
#>  4 Robert Skala 1.60e9 Family P… 2013-06-04 2027-06-04 STE 102 EAGL… AK    9957…
#>  5 Robert Cass… 1.51e9 Dentist   2013-07-23 2027-07-23 STE 1   WASI… AK    9965…
#>  6 Eliza… Desc… 1.95e9 Family P… 2014-04-01 2028-04-01 STE 201 ANCH… AK    9950…
#>  7 Evelyn Wisz… 1.12e9 Clinical… 2018-07-01 2026-07-01 104 CE… KODI… AK    99615
#>  8 Suzan… Stra… 1.15e9 Nurse Pr… 2014-04-01 2028-04-01 STE 100 EAGL… AK    9957…
#>  9 Willi… Berg… 1.30e9 Oral Sur… 2018-11-05 2026-11-05 STE 203 ANCH… AK    9950…
#> 10 Ray    Holl… 1.23e9 Oral Sur… 2014-06-16 2026-06-16 STE 203 ANCH… AK    9950…
#> # ℹ 250 more rows
#> # ℹ 2 more variables: order_refer <int>, updated <date>

opt_out(specialty = "Psychiatry", order_refer = FALSE)
#> ✔ opt_out returned 813 results.
#> # A tibble: 813 × 12
#>    first  last     npi specialty start_date end_date   address city  state zip  
#>    <chr>  <chr>  <int> <chr>     <date>     <date>     <chr>   <chr> <chr> <chr>
#>  1 Jonat… Rain… 1.72e9 Psychiat… 1998-01-30 2028-01-30 P O BO… GLAD… PA    1903…
#>  2 Martha Leat… 1.60e9 Psychiat… 2012-04-01 2028-04-01 #5101   SAN … TX    7825…
#>  3 Nancy  Shos… 1.97e9 Psychiat… 2012-03-02 2028-03-02 12880 … DALL… TX    7523…
#>  4 Namir  Daml… 1.12e9 Psychiat… 2020-07-26 2026-07-26 STE 207 ENCI… CA    9202…
#>  5 Lawre… Corm… 1.43e9 Psychiat… 2012-05-10 2026-05-10 3773 C… DENV… CO    8020…
#>  6 Charl… Scha… 1.11e9 Psychiat… 2012-06-14 2026-06-14 1455 3… SACR… CA    9581…
#>  7 Andrew Popp… 1.09e9 Psychiat… 2012-06-01 2026-06-01 STE 40… NEWT… MA    0245…
#>  8 Ingrid Schm… 1.87e9 Psychiat… 2010-09-02 2026-09-02 STE 109 AUST… TX    7873…
#>  9 Lorene Henry 1.48e9 Psychiat… 2012-05-26 2026-05-26 SUITE … COLL… TX    7784…
#> 10 Patri… Mcgr… 1.93e9 Psychiat… 2012-06-01 2026-06-01 SUITE … NEW … NY    10017
#> # ℹ 803 more rows
#> # ℹ 2 more variables: order_refer <int>, updated <date>
```
