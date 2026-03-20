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
#> ✔ `opt_out` returned 54,943 results.
opt_out(npi = 1043522824)
#> ✔ `opt_out` returned 1 result.
#> # A data frame: 1 × 13
#>   npi        first last  specialty start_date end_date updated add_1 add_2 city 
#> * <chr>      <chr> <chr> <chr>     <chr>      <chr>    <chr>   <chr> <chr> <chr>
#> 1 1043522824 James Smith Nurse Pr… 7/1/2019   7/1/2027 8/15/2… 8585… STE … SCOT…
#> # ℹ 3 more variables: state <chr>, zip <chr>, order_refer <chr>
opt_out(state = "AK")
#> ✔ `opt_out` returned 256 results.
#> # A data frame: 256 × 13
#>    npi       first last  specialty start_date end_date updated add_1 add_2 city 
#>  * <chr>     <chr> <chr> <chr>     <chr>      <chr>    <chr>   <chr> <chr> <chr>
#>  1 12655534… Henry Chap… Physicia… 4/1/2012   4/1/2026 5/15/2… 3300… STE … ANCH…
#>  2 14878796… Ann   Stoc… Clinical… 4/1/2012   4/1/2026 5/15/2… 505 … STE … ANCH…
#>  3 10435593… Amber Shea  Nurse Pr… 4/1/2013   4/1/2027 5/15/2… 5805… NA    WASI…
#>  4 15988256… Robe… Skala Family P… 6/4/2013   6/4/2027 7/15/2… 1264… STE … EAGL…
#>  5 15081982… Robe… Cass… Dentist   7/23/2013  7/23/20… 9/15/2… 351 … STE 1 WASI…
#>  6 19523403… Eliz… Desc… Family P… 4/1/2014   4/1/2026 5/15/2… 4001… STE … ANCH…
#>  7 11241762… Evel… Wisz… Clinical… 7/1/2018   7/1/2026 8/15/2… 104 … NA    KODI…
#>  8 11544675… Suza… Stra… Nurse Pr… 4/1/2014   4/1/2026 5/15/2… 1147… STE … EAGL…
#>  9 12957552… Will… Berg… Oral Sur… 11/5/2018  11/5/20… 12/15/… 111 … STE … ANCH…
#> 10 12250589… Ray   Holl… Oral Sur… 6/16/2014  6/16/20… 7/15/2… 111 … STE … ANCH…
#> # ℹ 246 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, order_refer <chr>
opt_out(specialty = "Psychiatry", order_refer = FALSE)
#> ✔ `opt_out` returned 790 results.
#> # A data frame: 790 × 13
#>    npi       first last  specialty start_date end_date updated add_1 add_2 city 
#>  * <chr>     <chr> <chr> <chr>     <chr>      <chr>    <chr>   <chr> <chr> <chr>
#>  1 17204445… Jona… Rain… Psychiat… 1/30/1998  1/30/20… 2/16/2… 1629… P O … GLAD…
#>  2 15988021… Mart… Leat… Psychiat… 4/1/2012   4/1/2026 10/15/… 1314… #5101 SAN …
#>  3 19726233… Nancy Shos… Psychiat… 3/2/2012   3/2/2026 10/15/… 1288… NA    DALL…
#>  4 11241167… Namir Daml… Psychiat… 7/26/2020  7/26/20… 8/15/2… 4407… STE … ENCI…
#>  5 14271463… Lawr… Corm… Psychiat… 5/10/2012  5/10/20… 10/15/… 3773… NA    DENV…
#>  6 11141323… Char… Scha… Psychiat… 6/14/2012  6/14/20… 10/15/… 1455… NA    SACR…
#>  7 10938944… Andr… Popp… Psychiat… 6/1/2012   6/1/2026 1/15/2… 93 U… STE … NEWT…
#>  8 18715013… Ingr… Schm… Psychiat… 9/2/2010   9/2/2026 10/15/… 5750… STE … AUST…
#>  9 14776142… Lore… Henry Psychiat… 5/26/2012  5/26/20… 10/15/… 1721… SUIT… COLL…
#> 10 19322840… Patr… Mcgr… Psychiat… 6/1/2012   6/1/2026 7/15/2… 100 … SUIT… NEW …
#> # ℹ 780 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, order_refer <chr>
```
