# Opt-Out Providers

Information on providers who have decided not to participate in
Medicare.

## Usage

``` r
opted_out(
  npi = NULL,
  first = NULL,
  last = NULL,
  specialty = NULL,
  start_year = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  order_refer = NULL,
  count = FALSE
)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- specialty:

  `<chr>` Provider's specialty

- start_year:

  `<int>` Opt-out effective date year

- address, city, state, zip:

  `<chr>` Provider's address, city, state, zip

- order_refer:

  `<lgl>` Indicates order and refer eligibility

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

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
opted_out(count = TRUE)
#> ◼ opted_out | 59,071 rows | 12 pages

opted_out(state = "GA", specialty = contains("Psych"))
#> ✔ opted_out returned 227 results
#> ✔ order_refer returned 128 results
#> # A tibble: 227 × 12
#>         npi first last  specialty start_date end_date updated address      city 
#>  *    <int> <chr> <chr> <chr>     <date>     <date>   <date>  <chr>        <chr>
#>  1   1.41e9 Mich… Bris… Clinical… NA         NA       NA      620 HILLCRE… LILB…
#>  2   1.90e9 Nisha Patel Psychiat… NA         NA       NA      5150 STILES… KENN…
#>  3   1.05e9 Sarah Mcna… Psychiat… NA         NA       NA      246 ROBERT … AUGU…
#>  4   1.76e9 Kris… Ivany Psychiat… NA         NA       NA      650 PONCE D… ATLA…
#>  5   1.29e9 Matt… Norm… Psychiat… NA         NA       NA      3495 Piedmo… ATLA…
#>  6   1.25e9 Susan Peri… Psychiat… NA         NA       NA      980 JOHNSON… ATLA…
#>  7   1.03e9 Smit… Bhan… Psychiat… NA         NA       NA      550 PHARR R… ATLA…
#>  8   1.63e9 Dona… Davi… Clinical… NA         NA       NA      620 HILLCRE… LILB…
#>  9   1.64e9 Meli… Barn… Clinical… NA         NA       NA      1059 W NANC… BROO…
#> 10   1.72e9 Ellen Brac… Clinical… NA         NA       NA      1251 APPLE … ATLA…
#> # ℹ 217 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, order_refer <chr>
```
