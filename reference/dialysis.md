# Dialysis Facilities

A list of all dialysis facilities registered with Medicare that includes
addresses and phone numbers, as well as services and quality of care
provided.

## Usage

``` r
dialysis(
  fac_ccn = NULL,
  fac_name = NULL,
  org_name = NULL,
  rating = NULL,
  network = NULL,
  status = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  count = FALSE,
  set = FALSE
)
```

## Source

- [API: Dialysis Facility - Listing by
  Facility](https://data.cms.gov/provider-data/dataset/23ew-n7w9)

## Arguments

- fac_ccn:

  `<chr>` Facility CMS Certification Number

- fac_name:

  `<chr>` Facility name

- org_name:

  `<chr>` Name of the chain organization the facility is owned/managed
  by

- rating:

  `<int>` Facility's Quality of Care star rating; (1-5)

- network:

  `<int>` Numeric code for the network the facility participates in;
  (1-18)

- status:

  `<enum>` `Non-profit` or `Profit`

- address, city, state, zip, county:

  `<chr>` Facility's city, state, zip, county

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Examples

``` r
dialysis(count = TRUE)
#> dialysis Totals
#> • Rows  : 7,557
#> • Pages : 6    
#> 
dialysis(count = TRUE, rating = 1:5)
#> ✔ dialysis returned 7,072 results.
dialysis(count = TRUE, org_name = "DaVita")
#> ✔ dialysis returned 2,800 results.
dialysis(rating = 1)
#> ✔ dialysis returned 823 results.
#> ! Using default <polish> method
#> # A tibble: 823 × 142
#>    cms_certification_number_ccn network facility_name   five_star_date five_star
#>    <chr>                        <chr>   <chr>           <chr>          <chr>    
#>  1 012533                       8       DaVita Walker … 01Jan2021-31D… 1.0      
#>  2 012543                       8       DaVita Demopol… 01Jan2021-31D… 1.0      
#>  3 012545                       8       DaVita Tuscalo… 01Jan2021-31D… 1.0      
#>  4 012570                       8       DaVita Northpo… 01Jan2021-31D… 1.0      
#>  5 012576                       8       DCI MONTGOMERY  01Jan2021-31D… 1.0      
#>  6 012598                       8       DCI PHENIX CITY 01Jan2021-31D… 1.0      
#>  7 012606                       8       FMC CHASE       01Jan2021-31D… 1.0      
#>  8 012613                       8       FMC DISCOVERY   01Jan2021-31D… 1.0      
#>  9 012618                       8       RRC NORTHRIDGE  01Jan2021-31D… 1.0      
#> 10 012641                       8       DCI EVERGREEN   01Jan2021-31D… 1.0      
#> # ℹ 813 more rows
#> # ℹ 137 more variables: five_star_data_availability_code <chr>,
#> #   address_line_1 <chr>, address_line_2 <chr>, citytown <chr>, state <chr>,
#> #   zip_code <chr>, countyparish <chr>, telephone_number <chr>,
#> #   profit_or_nonprofit <chr>, chain_owned <chr>, chain_organization <chr>,
#> #   late_shift <chr>, of_dialysis_stations <chr>,
#> #   offers_incenter_hemodialysis <chr>, offers_peritoneal_dialysis <chr>, …
```
