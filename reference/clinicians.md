# Clinicians Enrolled in Medicare

Access information about providers enrolled in Medicare, including the
medical school that they attended and the year they graduated

## Usage

``` r
clinicians(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  suffix = NULL,
  gender = NULL,
  credential = NULL,
  specialty = NULL,
  school = NULL,
  year = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  facility_name = NULL,
  facility_pac = NULL
)
```

## Arguments

- npi:

  `<int>` Individual National Provider Identifier

- pac:

  `<int>` Individual PECOS Associate Control ID

- enid:

  `<chr>` Individual Medicare Enrollment ID

- first, middle, last, suffix:

  `<chr>` Individual provider's name

- gender:

  `<chr>` Individual provider's gender; `"F"` (Female), `"M"` (Male), or
  `"U"` (Unknown)

- credential:

  `<chr>` Individual provider's credential, i.e. `"MD"`

- specialty:

  `<chr>` Individual provider’s primary medical specialty

- school:

  `<chr>` Individual provider’s alma mater

- year:

  `<int>` Individual provider’s graduation year

- city, state, zip:

  `<chr>` Facility's city, state, zip

- facility_name:

  `<chr>` Facility associated with Provider

- facility_pac:

  `<int>` Facility's PECOS Associate Control ID

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|                 |                                                       |
|-----------------|-------------------------------------------------------|
| **Field**       | **Description**                                       |
| `npi`           | 10-digit individual NPI                               |
| `pac`           | 10-digit individual PAC ID                            |
| `enid`          | 15-digit individual enrollment ID                     |
| `first`         | Provider's first name                                 |
| `middle`        | Provider's middle name                                |
| `last`          | Provider's last name                                  |
| `suffix`        | Provider's name suffix                                |
| `gender`        | Provider's gender                                     |
| `credential`    | Provider's credential                                 |
| `school`        | Provider's medical school                             |
| `grad_year`     | Provider's graduation year                            |
| `specialty`     | Provider's primary specialty                          |
| `specialty_sec` | Provider's secondary specialty                        |
| `facility_name` | Facility associated with provider                     |
| `pac_org`       | Facility's 10-digit PAC ID                            |
| `members`       | Number of providers associated with facility's PAC ID |
| `address`       | Provider's street address                             |
| `city`          | Provider's city                                       |
| `state`         | Provider's state                                      |
| `zip`           | Provider's zip code                                   |
| `phone`         | Provider's phone number                               |
| `telehealth`    | Indicates if provider offers telehealth services      |
| `assign_ind`    | Indicates if provider accepts Medicare assignment     |
| `assign_org`    | Indicates if facility accepts Medicare assignment     |

## Links

- [National Downloadable
  File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)

- [Provider Data Catalog (PDC) Data
  Dictionary](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)

## Examples

``` r
clinicians()
#> ! No Query → Returning first 10 rows.
#> # A tibble: 10 × 25
#>    npi       pac   enid  last  first middle suffix gender credential grad_school
#>    <chr>     <chr> <chr> <chr> <chr> <chr>  <chr>  <chr>  <chr>      <chr>      
#>  1 10030001… 7517… I201… ENKE… ARDA… NA     NA     M      MD         OTHER      
#>  2 10030001… 9931… I201… KHAL… RASH… NA     NA     M      MD         OTHER      
#>  3 10030001… 9931… I201… KHAL… RASH… NA     NA     M      MD         OTHER      
#>  4 10030001… 9931… I201… KHAL… RASH… NA     NA     M      MD         OTHER      
#>  5 10030001… 9931… I201… KHAL… RASH… NA     NA     M      MD         OTHER      
#>  6 10030004… 9133… I201… VELO… JENN… A      NA     F      MD         TOLEDO MED…
#>  7 10030004… 0446… I200… ROTH… KEVIN B      NA     M      MD         OHIO STATE…
#>  8 10030004… 0446… I200… ROTH… KEVIN B      NA     M      MD         OHIO STATE…
#>  9 10030004… 0446… I200… ROTH… KEVIN B      NA     M      MD         OHIO STATE…
#> 10 10030005… 2163… I200… SEMO… AMAN… M      NA     F      DO         LAKE ERIE …
#> # ℹ 15 more variables: grad_year <chr>, specialty <chr>, spec_other <chr>,
#> #   telehealth <chr>, facility_name <chr>, org_pac <chr>, org_mem <chr>,
#> #   add_1 <chr>, add_2 <chr>, city <chr>, state <chr>, zip <chr>, phone <chr>,
#> #   ind_par <chr>, grp_par <chr>

clinicians(enid = "I20081002000549")
#> ✔ Query returned 1  result.
#> # A tibble: 1 × 25
#>   npi        pac   enid  last  first middle suffix gender credential grad_school
#>   <chr>      <chr> <chr> <chr> <chr> <chr>  <chr>  <chr>  <chr>      <chr>      
#> 1 1407031495 8022… I200… MCCU… DORO… E      NA     F      AU         OTHER      
#> # ℹ 15 more variables: grad_year <chr>, specialty <chr>, spec_other <chr>,
#> #   telehealth <chr>, facility_name <chr>, org_pac <chr>, org_mem <chr>,
#> #   add_1 <chr>, add_2 <chr>, city <chr>, state <chr>, zip <chr>, phone <chr>,
#> #   ind_par <chr>, grp_par <chr>

clinicians(first = "ETAN")
#> ✔ Query returned 11  results.
#> # A tibble: 11 × 25
#>    npi       pac   enid  last  first middle suffix gender credential grad_school
#>    <chr>     <chr> <chr> <chr> <chr> <chr>  <chr>  <chr>  <chr>      <chr>      
#>  1 10030118… 4587… I201… SPIRA ETAN  NA     NA     M      MD         NEW YORK U…
#>  2 10030118… 4587… I201… SPIRA ETAN  NA     NA     M      MD         NEW YORK U…
#>  3 12354266… 0244… I202… SUGA… ETAN  NA     NA     M      NA         ALBERT EIN…
#>  4 12354266… 0244… I202… SUGA… ETAN  NA     NA     M      NA         ALBERT EIN…
#>  5 12354266… 0244… I202… SUGA… ETAN  NA     NA     M      NA         ALBERT EIN…
#>  6 14071762… 9638… I202… EITC… ETAN  NA     NA     M      MD         COLUMBIA U…
#>  7 14071762… 9638… I202… EITC… ETAN  NA     NA     M      MD         COLUMBIA U…
#>  8 14071762… 9638… I202… EITC… ETAN  NA     NA     M      MD         COLUMBIA U…
#>  9 15283017… 7113… I201… MARKS ETAN  ARIEL  NA     M      DO         NOVA SOUTH…
#> 10 15283017… 7113… I202… MARKS ETAN  ARIEL  NA     M      DO         NOVA SOUTH…
#> 11 16990407… 7618… I202… DAYAN ETAN  NA     NA     M      MD         STATE UNIV…
#> # ℹ 15 more variables: grad_year <chr>, specialty <chr>, spec_other <chr>,
#> #   telehealth <chr>, facility_name <chr>, org_pac <chr>, org_mem <chr>,
#> #   add_1 <chr>, add_2 <chr>, city <chr>, state <chr>, zip <chr>, phone <chr>,
#> #   ind_par <chr>, grp_par <chr>
```
