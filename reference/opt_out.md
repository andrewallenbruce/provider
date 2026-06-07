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
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  

opt_out(start_year = 2026, count = TRUE)
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ✔ opt_out returned 2,331 results.
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  

opt_out(start_year = 2000)
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ✔ opt_out returned 12 results.
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ✔ order_refer returned 12 results.
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> # A tibble: 12 × 12
#>         npi first last  specialty start_date end_date   updated    address city 
#>  *    <int> <chr> <chr> <chr>     <date>     <date>     <date>     <chr>   <chr>
#>  1   1.13e9 Yehu… Sand… General … 2000-06-01 2026-06-01 2024-07-15 417 S … ANN …
#>  2   1.08e9 Albe… Gold… Psychiat… 2000-06-30 2026-06-30 2024-08-15 239 WA… JERS…
#>  3   1.67e9 Jim   Morn… Clinical… 2000-07-01 2026-07-01 2024-08-15 4200 W… MILW…
#>  4   1.54e9 Mich… Reyes Family P… 2000-10-01 2026-10-01 2024-11-15 6789 N… GLEN…
#>  5   1.41e9 Will… Franz Clinical… 2000-01-01 2028-01-01 2026-01-15 2920 C… ALBU…
#>  6   1.01e9 David Brow… Family P… 2000-01-01 2028-01-01 2026-01-15 5821 W… WEST…
#>  7   1.92e9 Jeff… Nusb… Family P… 2000-01-01 2028-01-01 2026-01-15 5821 W… WEST…
#>  8   1.79e9 Rich… Ng    Family P… 2000-01-01 2028-01-01 2026-01-15 5821 W… WEST…
#>  9   1.66e9 Mich… Bier… Psychiat… 2000-02-28 2028-02-29 2026-04-16 20 TRI… MONT…
#> 10   1.45e9 Step… Cave  Family P… 2000-04-01 2028-04-01 2026-04-16 10562 … BATO…
#> 11   1.01e9 Edwin Cort… Plastic … 2000-04-01 2028-04-01 2026-04-16 14241 … OVER…
#> 12   1.32e9 Dale  Rosin Psychiat… 2000-07-13 2026-07-13 2024-08-15 129 GR… SOME…
#> # ℹ 3 more variables: state <chr>, zip <chr>, order_refer <chr>

opt_out(npi = 1043522824) |> str()
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ✔ opt_out returned 1 result.
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ✔ order_refer returned 1 result.
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> opt_out [1 × 12] (S3: opt_out/tbl_df/tbl/data.frame)
#>  $ npi        : int 1043522824
#>  $ first      : chr "James"
#>  $ last       : chr "Smith"
#>  $ specialty  : chr "Nurse Practitioner"
#>  $ start_date : Date[1:1], format: "2019-07-01"
#>  $ end_date   : Date[1:1], format: "2027-07-01"
#>  $ updated    : Date[1:1], format: "2025-08-15"
#>  $ address    : chr "8585 E HARTFORD DR, STE 111"
#>  $ city       : chr "SCOTTSDALE"
#>  $ state      : chr "AZ"
#>  $ zip        : chr "852555472"
#>  $ order_refer: chr "Part B, DME, HHA, PMD"

opt_out(state = "GA",
        specialty = contains("Psych"),
        order_refer = FALSE) |>
        str()
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
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
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ✔ opt_out returned 226 results.
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> ✔ order_refer returned 128 results.
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■                 
#> Waiting 2s for throttling delay ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> opt_out [226 × 12] (S3: opt_out/tbl_df/tbl/data.frame)
#>  $ npi        : int [1:226] 1881778967 1982776308 1679613319 1699766568 1598942070 1124202387 1841409182 1881876175 1285843516 1295956217 ...
#>  $ first      : chr [1:226] "Ana" "Joan" "Sherri" "Nicholas" ...
#>  $ last       : chr [1:226] "Adelstein" "Miller" "Bornstein" "Hume" ...
#>  $ specialty  : chr [1:226] "Clinical Psychologist" "Clinical Psychologist" "Clinical Psychologist" "Clinical Psychologist" ...
#>  $ start_date : Date[1:226], format: "2012-07-01" "2014-07-01" ...
#>  $ end_date   : Date[1:226], format: "2026-07-01" "2026-07-01" ...
#>  $ updated    : Date[1:226], format: "2024-08-15" "2024-08-15" ...
#>  $ address    : chr [1:226] "675 SEMINOLE AVENUE NE, SUITE 307" "2520 WINDY HILL ROAD, SUITE 106" "990 HAMMOND DRIVE, SUITE 575" "693 MOUNTAIN DRIVE N. E." ...
#>  $ city       : chr [1:226] "ATLANTA" "MARIETTA" "ATLANTA" "ATLANTA" ...
#>  $ state      : chr [1:226] "GA" "GA" "GA" "GA" ...
#>  $ zip        : chr [1:226] "30307" "300678633" "30328" "30342" ...
#>  $ order_refer: chr [1:226] NA NA "Part B, DME" NA ...
```
