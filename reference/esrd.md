# Dialysis Facilities

Access information concerning individual providers' affiliations with
organizations/facilities.

## Usage

``` r
esrd(
  ccn = NULL,
  facility_name = NULL,
  stars = NULL,
  network = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  status = NULL,
  chain_owned = NULL,
  chain_name = NULL,
  count = FALSE,
  set = FALSE
)
```

## Source

- [API: Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

## Arguments

- ccn:

  `<chr>` Individual National Provider Identifier

- facility_name:

  `<chr>` facility type

- stars:

  `<int>` 1 - 5

- network:

  `<int>` 1 - 18

- address, city, state, zip, county:

  `<chr>` Individual provider's name

- status:

  `<enum>` Non-profit/profit

- chain_owned:

  `<lgl>` CCN of the **primary** hospital containing

- chain_name:

  `<chr>` facility type

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
esrd(count = TRUE)
#> ℹ esrd has 7,557 rows.
esrd()
#> ! esrd ❯ No Query
#> ℹ Returning first 10 rows...
#> # A tibble: 10 × 14
#>    ccn    facility_name   stars network status chain_owned chain_name cert_date 
#>  * <chr>  <chr>           <int>   <int> <chr>  <chr>       <chr>      <date>    
#>  1 012306 CHILDRENS HOSP…    NA       8 Non-p… 0           Independe… 1982-11-17
#>  2 012500 FMC CAPITOL CI…     2       8 Profit 1           Fresenius… 1976-09-01
#>  3 012501 DaVita Gadsden…     2       8 Profit 1           DaVita     1976-09-01
#>  4 012502 DaVita Tuscalo…     2       8 Profit 1           DaVita     1977-10-21
#>  5 012505 DaVita PDI-Mon…     2       8 Profit 1           DaVita     1977-12-14
#>  6 012506 DaVita Dothan …     3       8 Profit 1           DaVita     1977-11-28
#>  7 012507 FMC MOBILE          4       8 Profit 1           Fresenius… 1979-01-04
#>  8 012508 DaVita Birming…     2       8 Profit 1           DaVita     1979-06-28
#>  9 012512 FMC SELMA           2       8 Profit 1           Fresenius… 1980-08-25
#> 10 012513 BMA LANGDALE        5       8 Profit 1           Fresenius… 1981-02-12
#> # ℹ 6 more variables: city <chr>, state <chr>, zip <chr>, county <chr>,
#> #   phone <chr>, address <chr>
esrd(stars = "1.0")
#> ✔ esrd returned 823 results.
#> # A tibble: 823 × 14
#>    ccn    facility_name   stars network status chain_owned chain_name cert_date 
#>  * <chr>  <chr>           <int>   <int> <chr>  <chr>       <chr>      <date>    
#>  1 012533 DaVita Walker …     1       8 Profit 1           DaVita     1987-12-29
#>  2 012543 DaVita Demopol…     1       8 Profit 1           DaVita     1992-05-20
#>  3 012545 DaVita Tuscalo…     1       8 Profit 1           DaVita     1992-08-11
#>  4 012570 DaVita Northpo…     1       8 Profit 1           DaVita     1996-12-03
#>  5 012576 DCI MONTGOMERY      1       8 Non-p… 1           Dialysis … 1998-06-05
#>  6 012598 DCI PHENIX CITY     1       8 Profit 1           Dialysis … 2000-02-09
#>  7 012606 FMC CHASE           1       8 Profit 1           Fresenius… 2002-09-19
#>  8 012613 FMC DISCOVERY       1       8 Profit 1           Fresenius… 2004-03-17
#>  9 012618 RRC NORTHRIDGE      1       8 Profit 1           Fresenius… 2006-10-25
#> 10 012641 DCI EVERGREEN       1       8 Non-p… 1           Dialysis … 2011-01-27
#> # ℹ 813 more rows
#> # ℹ 6 more variables: city <chr>, state <chr>, zip <chr>, county <chr>,
#> #   phone <chr>, address <chr>
esrd(network = 18)
#> ✔ esrd returned 460 results.
#> # A tibble: 460 × 14
#>    ccn    facility_name   stars network status chain_owned chain_name cert_date 
#>  * <chr>  <chr>           <int>   <int> <chr>  <chr>       <chr>      <date>    
#>  1 052311 St. Joseph Hos…     4      18 Non-p… 0           Independe… 1977-08-15
#>  2 052321 Childrens Hosp…    NA      18 Non-p… 0           Independe… 1977-07-28
#>  3 052323 Kaiser Foundat…     3      18 Non-p… 1           Kaiser Pe… 1977-07-25
#>  4 052334 Arrowhead Regi…     4      18 Non-p… 0           Independe… 2006-04-28
#>  5 052380 Kaiser Foundat…     1      18 Non-p… 1           Kaiser Pe… 1991-07-24
#>  6 052381 Kaiser Foundat…     4      18 Non-p… 1           Kaiser Pe… 1991-10-02
#>  7 052382 Kaiser Foundat…     4      18 Non-p… 1           Kaiser Pe… 1992-11-25
#>  8 052384 Kaiser Foundat…     3      18 Non-p… 1           Kaiser Pe… 1993-04-26
#>  9 052389 Kaiser Foundat…     5      18 Non-p… 1           Kaiser Pe… 1994-12-01
#> 10 052394 Kaiser Foundat…     4      18 Non-p… 1           Kaiser Pe… 1999-11-30
#> # ℹ 450 more rows
#> # ℹ 6 more variables: city <chr>, state <chr>, zip <chr>, county <chr>,
#> #   phone <chr>, address <chr>
```
