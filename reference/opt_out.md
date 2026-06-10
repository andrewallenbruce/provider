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
#> opt_out summary
#> ◉ Rows  : 56,300
#> ◉ Pages : 12    

opt_out(state = "GA", specialty = contains("Psych"))
#> ✔ opt_out returned 226 results
#> ✔ order_refer returned 128 results
#> # A tibble: 226 × 12
#>         npi first last  specialty start_date end_date   updated    address city 
#>  *    <int> <chr> <chr> <chr>     <date>     <date>     <date>     <chr>   <chr>
#>  1   1.88e9 Ana   Adel… Clinical… 2012-07-01 2026-07-01 2024-08-15 675 SE… ATLA…
#>  2   1.98e9 Joan  Mill… Clinical… 2014-07-01 2026-07-01 2024-08-15 2520 W… MARI…
#>  3   1.68e9 Sher… Born… Clinical… 2012-04-01 2028-04-01 2026-04-16 990 HA… ATLA…
#>  4   1.70e9 Nich… Hume  Clinical… 2018-07-01 2026-07-01 2024-08-15 693 MO… ATLA…
#>  5   1.60e9 Carol Kran… Psychiat… 2012-01-01 2028-01-01 2026-01-15 3133 M… ATLA…
#>  6   1.12e9 Lawr… Gius… Psychiat… 2012-07-01 2026-07-01 2024-08-15 1945 C… ATLA…
#>  7   1.84e9 David Lips… Psychiat… 2012-07-01 2026-07-01 2024-08-15 12 PIE… ATLA…
#>  8   1.88e9 Barb… Da V… Psychiat… 2012-07-01 2026-07-01 2024-08-15 143 FO… ST S…
#>  9   1.29e9 Matt… Norm… Psychiat… 2012-10-01 2026-10-01 2024-11-15 3495 P… ATLA…
#> 10   1.30e9 Linda Ande… Clinical… 2013-01-01 2027-01-01 2025-01-15 4675 N… ATLA…
#> # ℹ 216 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, order_refer <chr>
```
