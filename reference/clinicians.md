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
#>    npi        pac      enid  last  first middle suffix gender cred  school year 
#>    <chr>      <chr>    <chr> <chr> <chr> <chr>  <chr>  <chr>  <chr> <chr>  <chr>
#>  1 1003000126 7517003… I201… ENKE… ARDA… NA     NA     M      MD    OTHER  1994 
#>  2 1003000142 9931380… I201… KHAL… RASH… NA     NA     M      MD    OTHER  1999 
#>  3 1003000142 9931380… I201… KHAL… RASH… NA     NA     M      MD    OTHER  1999 
#>  4 1003000142 9931380… I201… KHAL… RASH… NA     NA     M      MD    OTHER  1999 
#>  5 1003000142 9931380… I201… KHAL… RASH… NA     NA     M      MD    OTHER  1999 
#>  6 1003000423 9133397… I201… VELO… JENN… A      NA     F      MD    TOLED… 2007 
#>  7 1003000480 0446348… I200… ROTH… KEVIN B      NA     M      MD    OHIO … 1997 
#>  8 1003000480 0446348… I200… ROTH… KEVIN B      NA     M      MD    OHIO … 1997 
#>  9 1003000480 0446348… I200… ROTH… KEVIN B      NA     M      MD    OHIO … 1997 
#> 10 1003000530 2163575… I200… SEMO… AMAN… M      NA     F      DO    LAKE … 2006 
#> # ℹ 14 more variables: specialty <chr>, spec_other <chr>, telehealth <chr>,
#> #   facility_name <chr>, org_pac <chr>, org_mems <chr>, add_1 <chr>,
#> #   add_2 <chr>, city <chr>, state <chr>, zip <chr>, phone <chr>, ind <chr>,
#> #   grp <chr>

clinicians(enid = "I20081002000549")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 25
#>   npi        pac       enid  last  first middle suffix gender cred  school year 
#>   <chr>      <chr>     <chr> <chr> <chr> <chr>  <chr>  <chr>  <chr> <chr>  <chr>
#> 1 1407031495 80221861… I200… MCCU… DORO… E      NA     F      AU    OTHER  2008 
#> # ℹ 14 more variables: specialty <chr>, spec_other <chr>, telehealth <chr>,
#> #   facility_name <chr>, org_pac <chr>, org_mems <chr>, add_1 <chr>,
#> #   add_2 <chr>, city <chr>, state <chr>, zip <chr>, phone <chr>, ind <chr>,
#> #   grp <chr>

clinicians(first = "ETAN")
#> ✔ Query returned 11 results.
#> # A tibble: 11 × 25
#>    npi        pac      enid  last  first middle suffix gender cred  school year 
#>    <chr>      <chr>    <chr> <chr> <chr> <chr>  <chr>  <chr>  <chr> <chr>  <chr>
#>  1 1003011891 4587858… I201… SPIRA ETAN  NA     NA     M      MD    NEW Y… 2007 
#>  2 1003011891 4587858… I201… SPIRA ETAN  NA     NA     M      MD    NEW Y… 2007 
#>  3 1235426610 0244526… I202… SUGA… ETAN  NA     NA     M      NA    ALBER… 2011 
#>  4 1235426610 0244526… I202… SUGA… ETAN  NA     NA     M      NA    ALBER… 2011 
#>  5 1235426610 0244526… I202… SUGA… ETAN  NA     NA     M      NA    ALBER… 2011 
#>  6 1407176233 9638313… I202… EITC… ETAN  NA     NA     M      MD    COLUM… 2010 
#>  7 1407176233 9638313… I202… EITC… ETAN  NA     NA     M      MD    COLUM… 2010 
#>  8 1407176233 9638313… I202… EITC… ETAN  NA     NA     M      MD    COLUM… 2010 
#>  9 1528301728 7113252… I201… MARKS ETAN  ARIEL  NA     M      DO    NOVA … 2013 
#> 10 1528301728 7113252… I202… MARKS ETAN  ARIEL  NA     M      DO    NOVA … 2013 
#> 11 1699040790 7618254… I202… DAYAN ETAN  NA     NA     M      MD    STATE… 2012 
#> # ℹ 14 more variables: specialty <chr>, spec_other <chr>, telehealth <chr>,
#> #   facility_name <chr>, org_pac <chr>, org_mems <chr>, add_1 <chr>,
#> #   add_2 <chr>, city <chr>, state <chr>, zip <chr>, phone <chr>, ind <chr>,
#> #   grp <chr>

clinicians(city = starts_with("At"), state = "GA", year = 2020)
#> ✔ Query returned 651 results.
#> # A tibble: 651 × 25
#>    npi        pac      enid  last  first middle suffix gender cred  school year 
#>    <chr>      <chr>    <chr> <chr> <chr> <chr>  <chr>  <chr>  <chr> <chr>  <chr>
#>  1 1003403940 9032526… I202… BROWN ABBY  A      NA     F      NP    OTHER  2020 
#>  2 1003443938 2769874… I202… TUCK… JAMES QUINT… NA     M      NA    KANSA… 2020 
#>  3 1003445529 2769929… I202… DUNS… SARAH ELIZA… NA     F      MD    UNIVE… 2020 
#>  4 1013410398 0941682… I202… WISE  ANNA  NA     NA     F      NA    OTHER  2020 
#>  5 1013500073 3870993… I202… HAMB… SANT… GIBBS  NA     F      NA    OTHER  2020 
#>  6 1013525310 1759786… I202… ST L… SAND… NA     NA     F      NA    OTHER  2020 
#>  7 1013527811 2567889… I202… CERVI JACK… J      NA     M      NA    OTHER  2020 
#>  8 1013545854 3072973… I202… KHIM… SHAM… NA     NA     F      NA    OTHER  2020 
#>  9 1013545912 5799221… I202… FOST… TYREL NA     NA     M      MD    UNIVE… 2020 
#> 10 1013546126 4183047… I202… BHAT  KART… NA     NA     M      MD    EASTE… 2020 
#> # ℹ 641 more rows
#> # ℹ 14 more variables: specialty <chr>, spec_other <chr>, telehealth <chr>,
#> #   facility_name <chr>, org_pac <chr>, org_mems <chr>, add_1 <chr>,
#> #   add_2 <chr>, city <chr>, state <chr>, zip <chr>, phone <chr>, ind <chr>,
#> #   grp <chr>
```
