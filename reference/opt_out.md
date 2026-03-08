# Providers Opted Out of Medicare

Access information on providers who have decided not to participate in
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
  order_refer = NULL
)
```

## Arguments

- npi:

  `<int>` Individual National Provider Identifier

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

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|                     |                                               |
|---------------------|-----------------------------------------------|
| **Field**           | **Description**                               |
| `npi`               | 10-digit NPI                                  |
| `first`             | Opt-out provider's first name                 |
| `last`              | Opt-out provider's last name                  |
| `specialty`         | Opt-out provider's specialty                  |
| `order_refer`       | Indicates if the provider can order and refer |
| `optout_start_date` | Date that provider's Opt-Out period begins    |
| `optout_end_date`   | Date that provider's Opt-Out period ends      |
| `last_updated`      | Date information was last updated             |
| `address`           | Opt-out provider's street address             |
| `city`              | Opt-out provider's city                       |
| `state`             | Opt-out provider's state                      |
| `zip`               | Opt-out provider's zip code                   |

## Opting Out

Providers who do not wish to enroll in the Medicare program may
“opt-out”, meaning neither they nor the beneficiary can bill Medicare
for services rendered.

Instead, a private contract between provider and beneficiary is signed,
neither party is reimbursed by Medicare and the beneficiary pays the
provider out-of-pocket.

To opt out, a provider must:

- Be of an **eligible specialty** type

- Submit an **opt-out affidavit** to Medicare

- Enter into a **private contract** with their Medicare patients,
  reflecting the agreement that they will pay out-of-pocket and that no
  one will submit the bill to Medicare for reimbursement

## Opt-Out Periods

Opt-out periods last for two years and cannot be terminated early unless
the provider is opting out for the very first time and terminates the
opt-out no later than 90 days after the opt-out period's effective date.

Opt-out statuses are also effective for two years and automatically
renew. Providers that do not want to extend their opt-out status at the
end of an opt-out period may cancel by notifying all MACs an affidavit
was filed at least 30 days prior to the start of the next opt-out
period.

If a provider retires, surrenders their license, or no longer wants to
participate in the Medicare program, they must officially withdraw
within 90 days. DMEPOS suppliers must withdraw within 30 days.

Providers may **NOT** opt-out if they intend to be a Medicare Advantage
(Part C) provider or furnish services covered by traditional Medicare
fee-for-service (Part B).

## References

- [Medicare Opt Out Affidavits
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)

## Examples

``` r
opt_out()
#> ! No Query → Returning first 10 rows.
#> # A tibble: 10 × 13
#>    npi   first last  specialty date_start date_end last_update address1 address2
#>    <chr> <chr> <chr> <chr>     <chr>      <chr>    <chr>       <chr>    <chr>   
#>  1 1720… Jona… Rain… Psychiat… 1/30/1998  1/30/20… 2/16/2026   1629 MO… P O BOX…
#>  2 1811… Kevin Carl… Internal… 7/1/2010   7/1/2026 8/15/2024   10700 C… NA      
#>  3 1548… Bruce Shap… Psychiat… 12/28/2015 12/28/2… 1/15/2026   666 GLE… NA      
#>  4 1861… Alan  Mcfa… Clinical… 1/1/2018   1/1/2028 1/15/2026   7330 MC… STE B   
#>  5 1689… Heat… Razn… Clinical… 6/1/2010   6/1/2026 7/15/2024   3009 NO… NA      
#>  6 1235… Laura Bren… Psychiat… 5/1/2006   5/1/2026 5/15/2024   135 COU… SUITE 2C
#>  7 1003… Phyl… Tuth… Oral Sur… 2/16/2012  2/16/20… 10/15/2024  11111 J… STE 5   
#>  8 1366… Firas Kata… Oral Sur… 10/1/2015  10/1/20… 11/14/2025  2220 W … NA      
#>  9 1790… Gera… Card… Psychiat… 4/28/1998  4/28/20… 5/15/2024   1020 MA… NA      
#> 10 1275… John  Zaje… Psychiat… 4/1/2006   4/1/2026 5/15/2024   4711 GO… STE 1200
#> # ℹ 4 more variables: city <chr>, state <chr>, zip <chr>, order_refer <chr>

opt_out(npi = 1043522824)
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 13
#>   npi    first last  specialty date_start date_end last_update address1 address2
#>   <chr>  <chr> <chr> <chr>     <chr>      <chr>    <chr>       <chr>    <chr>   
#> 1 10435… James Smith Nurse Pr… 7/1/2019   7/1/2027 8/15/2025   8585 E … STE 111 
#> # ℹ 4 more variables: city <chr>, state <chr>, zip <chr>, order_refer <chr>

opt_out(state = "AK")
#> ✔ Query returned 256 results.
#> # A tibble: 256 × 13
#>    npi   first last  specialty date_start date_end last_update address1 address2
#>    <chr> <chr> <chr> <chr>     <chr>      <chr>    <chr>       <chr>    <chr>   
#>  1 1265… Henry Chap… Physicia… 4/1/2012   4/1/2026 5/15/2024   3300 AR… STE 101 
#>  2 1487… Ann   Stoc… Clinical… 4/1/2012   4/1/2026 5/15/2024   505 W N… STE 214 
#>  3 1043… Amber Shea  Nurse Pr… 4/1/2013   4/1/2027 5/15/2025   5805 E … NA      
#>  4 1598… Robe… Skala Family P… 6/4/2013   6/4/2027 7/15/2025   12641 O… STE 102 
#>  5 1508… Robe… Cass… Dentist   7/23/2013  7/23/20… 9/15/2025   351 W S… STE 1   
#>  6 1952… Eliz… Desc… Family P… 4/1/2014   4/1/2026 5/15/2024   4001 DA… STE 201 
#>  7 1124… Evel… Wisz… Clinical… 7/1/2018   7/1/2026 8/15/2024   104 CEN… NA      
#>  8 1154… Suza… Stra… Nurse Pr… 4/1/2014   4/1/2026 5/15/2024   11470 B… STE 100 
#>  9 1295… Will… Berg… Oral Sur… 11/5/2018  11/5/20… 12/15/2024  111 W 1… STE 203 
#> 10 1225… Ray   Holl… Oral Sur… 6/16/2014  6/16/20… 7/15/2024   111 W 1… STE 203 
#> # ℹ 246 more rows
#> # ℹ 4 more variables: city <chr>, state <chr>, zip <chr>, order_refer <chr>

opt_out(specialty = "Psychiatry", order_refer = FALSE)
#> ✔ Query returned 790 results.
#> # A tibble: 790 × 13
#>    npi   first last  specialty date_start date_end last_update address1 address2
#>    <chr> <chr> <chr> <chr>     <chr>      <chr>    <chr>       <chr>    <chr>   
#>  1 1720… Jona… Rain… Psychiat… 1/30/1998  1/30/20… 2/16/2026   1629 MO… P O BOX…
#>  2 1598… Mart… Leat… Psychiat… 4/1/2012   4/1/2026 10/15/2024  1314 E … #5101   
#>  3 1972… Nancy Shos… Psychiat… 3/2/2012   3/2/2026 10/15/2024  12880 H… NA      
#>  4 1124… Namir Daml… Psychiat… 7/26/2020  7/26/20… 8/15/2024   4407 MA… STE 207 
#>  5 1427… Lawr… Corm… Psychiat… 5/10/2012  5/10/20… 10/15/2024  3773 CH… NA      
#>  6 1114… Char… Scha… Psychiat… 6/14/2012  6/14/20… 10/15/2024  1455 34… NA      
#>  7 1093… Andr… Popp… Psychiat… 6/1/2012   6/1/2026 1/15/2026   93 UNIO… STE 401C
#>  8 1871… Ingr… Schm… Psychiat… 9/2/2010   9/2/2026 10/15/2024  5750 BA… STE 109 
#>  9 1477… Lore… Henry Psychiat… 5/26/2012  5/26/20… 10/15/2024  1721 BI… SUITE 2…
#> 10 1932… Patr… Mcgr… Psychiat… 6/1/2012   6/1/2026 7/15/2024   100 PAR… SUITE 1…
#> # ℹ 780 more rows
#> # ℹ 4 more variables: city <chr>, state <chr>, zip <chr>, order_refer <chr>
```
