# Dialysis Facilities

Access information concerning individual providers' affiliations with
organizations/facilities.

## Usage

``` r
esrd(
  ccn = NULL,
  facility_name = NULL,
  chain_name = NULL,
  stars = NULL,
  network = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  status = NULL,
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

- chain_name:

  `<chr>` facility type

- stars:

  `<int>` 1 - 5

- network:

  `<int>` 1 - 18

- address, city, state, zip, county:

  `<chr>` Individual provider's name

- status:

  `<enum>` Non-profit or profit

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
esrd(count = TRUE)
#> ═ esrd Totals
#> • Rows  : 7,557
#> • Pages : 6    
#> 

esrd()
#> ═ esrd Totals
#> • Rows  : 7,557
#> • Pages : 6    
#> 
#> ! No Query ❯ Returning first 10 rows...
#> 
#> # A tibble: 10 × 141
#>    ccn   network facility_name five_star_date stars five_star_data_avail…¹ city 
#>  * <chr>   <int> <chr>         <chr>          <int> <chr>                  <chr>
#>  1 0123…       8 CHILDRENS HO… 01Jan2021-31D…    NA 260                    BIRM…
#>  2 0125…       8 FMC CAPITOL … 01Jan2021-31D…     2 001                    MONT…
#>  3 0125…       8 DaVita Gadsd… 01Jan2021-31D…     2 001                    GADS…
#>  4 0125…       8 DaVita Tusca… 01Jan2021-31D…     2 001                    TUSC…
#>  5 0125…       8 DaVita PDI-M… 01Jan2021-31D…     2 001                    MONT…
#>  6 0125…       8 DaVita Dotha… 01Jan2021-31D…     3 001                    DOTH…
#>  7 0125…       8 FMC MOBILE    01Jan2021-31D…     4 001                    MOBI…
#>  8 0125…       8 DaVita Birmi… 01Jan2021-31D…     2 001                    BIRM…
#>  9 0125…       8 FMC SELMA     01Jan2021-31D…     2 001                    SELMA
#> 10 0125…       8 BMA LANGDALE  01Jan2021-31D…     5 001                    VALL…
#> # ℹ abbreviated name: ¹​five_star_data_availability_code
#> # ℹ 134 more variables: state <chr>, zip <chr>, county <chr>, phone <chr>,
#> #   status <chr>, chain_owned <chr>, chain_name <chr>, late_shift <chr>,
#> #   of_dialysis_stations <chr>, offers_incenter_hemodialysis <chr>,
#> #   offers_peritoneal_dialysis <chr>, offers_home_hemodialysis_training <chr>,
#> #   cert_date <date>, claims_date <chr>, eqrs_date <chr>, smr_date <chr>,
#> #   patient_survival_category_text <chr>, …

esrd(stars = 1)
#> ✔ esrd returned 823 results.
#> # A tibble: 823 × 141
#>    ccn   network facility_name five_star_date stars five_star_data_avail…¹ city 
#>  * <chr>   <int> <chr>         <chr>          <int> <chr>                  <chr>
#>  1 0125…       8 DaVita Walke… 01Jan2021-31D…     1 001                    JASP…
#>  2 0125…       8 DaVita Demop… 01Jan2021-31D…     1 001                    Demo…
#>  3 0125…       8 DaVita Tusca… 01Jan2021-31D…     1 001                    TUSC…
#>  4 0125…       8 DaVita North… 01Jan2021-31D…     1 001                    NORT…
#>  5 0125…       8 DCI MONTGOME… 01Jan2021-31D…     1 001                    MONT…
#>  6 0125…       8 DCI PHENIX C… 01Jan2021-31D…     1 001                    PHEN…
#>  7 0126…       8 FMC CHASE     01Jan2021-31D…     1 001                    HUNT…
#>  8 0126…       8 FMC DISCOVERY 01Jan2021-31D…     1 001                    HUNT…
#>  9 0126…       8 RRC NORTHRID… 01Jan2021-31D…     1 001                    NORT…
#> 10 0126…       8 DCI EVERGREEN 01Jan2021-31D…     1 001                    EVER…
#> # ℹ 813 more rows
#> # ℹ abbreviated name: ¹​five_star_data_availability_code
#> # ℹ 134 more variables: state <chr>, zip <chr>, county <chr>, phone <chr>,
#> #   status <chr>, chain_owned <chr>, chain_name <chr>, late_shift <chr>,
#> #   of_dialysis_stations <chr>, offers_incenter_hemodialysis <chr>,
#> #   offers_peritoneal_dialysis <chr>, offers_home_hemodialysis_training <chr>,
#> #   cert_date <date>, claims_date <chr>, eqrs_date <chr>, smr_date <chr>, …

esrd(network = 15:18)
#> ✔ esrd returned 1,404 results.
#> # A tibble: 1,404 × 141
#>    ccn   network facility_name five_star_date stars five_star_data_avail…¹ city 
#>  * <chr>   <int> <chr>         <chr>          <int> <chr>                  <chr>
#>  1 0225…      16 USRC LAUREL … 01Jan2021-31D…     3 001                    ANCH…
#>  2 0225…      16 USRC FAIRBAN… 01Jan2021-31D…     3 001                    FAIR…
#>  3 0225…      16 USRC GROUP W… 01Jan2021-31D…     3 001                    WASI…
#>  4 0225…      16 JUNEAU DIALY… 01Jan2021-31D…     5 001                    JUNE…
#>  5 0225…      16 USRC DIMOND   01Jan2021-31D…     5 001                    ANCH…
#>  6 0225…      16 USRC SOLDOTNA 01Jan2021-31D…     5 001                    SOLD…
#>  7 0225…      16 USRC DENALI … 01Jan2021-31D…     5 001                    ANCH…
#>  8 0323…      15 Valleywise C… 01Jan2021-31D…     3 001                    PHOE…
#>  9 0323…      15 032314 PHOEN… 01Jan2021-31D…    NA 260                    PHOE…
#> 10 0323…      15 032315 GILA … 01Jan2021-31D…     3 001                    SACA…
#> # ℹ 1,394 more rows
#> # ℹ abbreviated name: ¹​five_star_data_availability_code
#> # ℹ 134 more variables: state <chr>, zip <chr>, county <chr>, phone <chr>,
#> #   status <chr>, chain_owned <chr>, chain_name <chr>, late_shift <chr>,
#> #   of_dialysis_stations <chr>, offers_incenter_hemodialysis <chr>,
#> #   offers_peritoneal_dialysis <chr>, offers_home_hemodialysis_training <chr>,
#> #   cert_date <date>, claims_date <chr>, eqrs_date <chr>, smr_date <chr>, …
```
