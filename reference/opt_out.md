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
#> opt_out Totals
#> • Rows  : 56,300
#> • Pages : 12    
#> 

opt_out(start_year = 2026, count = TRUE)
#> ✔ opt_out returned 2,331 results.

opt_out(start_year = 2000)
#> ✔ opt_out returned 12 results.
#> ✔ order_refer returned 12 results.
#> Error in pivot_order_refer(x): "\"order_refer\"" is not a column in `x`

opt_out(npi = 1043522824) |> str()
#> ✔ opt_out returned 1 result.
#> ✔ order_refer returned 1 result.
#> Error in pivot_order_refer(x): "\"order_refer\"" is not a column in `x`

opt_out(state = "GA",
        specialty = contains("Psych"),
        order_refer = FALSE) |>
        str()
#> ✔ opt_out returned 98 results.
#> opt_out [98 × 12] (S3: opt_out/tbl_df/tbl/data.frame)
#>  $ npi        : int [1:98] 1881778967 1982776308 1699766568 1881876175 1821238791 1528283736 1689781692 1730235912 1427291087 1609044916 ...
#>  $ first      : chr [1:98] "Ana" "Joan" "Nicholas" "Barbara" ...
#>  $ last       : chr [1:98] "Adelstein" "Miller" "Hume" "Da Vanzo" ...
#>  $ specialty  : chr [1:98] "Clinical Psychologist" "Clinical Psychologist" "Clinical Psychologist" "Psychiatry" ...
#>  $ start_date : Date[1:98], format: "2012-07-01" "2014-07-01" ...
#>  $ end_date   : Date[1:98], format: "2026-07-01" "2026-07-01" ...
#>  $ updated    : Date[1:98], format: "2024-08-15" "2024-08-15" ...
#>  $ address    : chr [1:98] "675 SEMINOLE AVENUE NE, SUITE 307" "2520 WINDY HILL ROAD, SUITE 106" "693 MOUNTAIN DRIVE N. E." "143 FOLLINS LANE" ...
#>  $ city       : chr [1:98] "ATLANTA" "MARIETTA" "ATLANTA" "ST SIMONS ISLAND" ...
#>  $ state      : chr [1:98] "GA" "GA" "GA" "GA" ...
#>  $ zip        : chr [1:98] "30307" "300678633" "30342" "31522" ...
#>  $ order_refer: chr [1:98] NA NA NA NA ...

opt_out(state = "GA",
        specialty = contains("Psych")) |>
        str()
#> ✔ opt_out returned 226 results.
#> ✔ order_refer returned 128 results.
#> Error in pivot_order_refer(x): "\"order_refer\"" is not a column in `x`
```
