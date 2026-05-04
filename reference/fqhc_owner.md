# FQHC Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
fqhc_owner(
  enid = NULL,
  pac = NULL,
  org_name = NULL,
  own_pac = NULL,
  own_type = NULL,
  own_role = NULL,
  own_first = NULL,
  own_middle = NULL,
  own_last = NULL,
  own_title = NULL,
  own_org = NULL,
  own_dba = NULL,
  own_address = NULL,
  own_city = NULL,
  own_state = NULL,
  own_zip = NULL,
  own_pct = NULL,
  count = FALSE,
  set = FALSE
)
```

## Arguments

- enid:

  `<chr>` National Provider Identifier

- pac:

  `<chr>` Provider's name

- org_name:

  `<chr>` Provider's name

- own_pac:

  `<chr>` Provider's name

- own_type:

  `<chr>` Provider's name

- own_role:

  `<chr>` Provider's name

- own_first:

  `<chr>` Provider's name

- own_middle:

  `<chr>` Provider's name

- own_last:

  `<chr>` Provider's name

- own_title:

  `<chr>` Provider's name

- own_org:

  `<chr>` Provider's name

- own_dba:

  `<chr>` Provider's name

- own_address:

  `<chr>` Provider's name

- own_city:

  `<chr>` Provider's name

- own_state:

  `<chr>` Provider's name

- own_zip:

  `<chr>` Provider's name

- own_pct:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
fqhc_owner(count = TRUE)
#> ═ fqhc_owner Totals
#> • Rows  : 148,919
#> • Pages : 30     
#> 

fqhc_owner(own_state = c("GA", "FL")) |> str()
#> ✔ fqhc_owner returned 254 results.
#> tibble [254 × 21] (S3: tbl_df/tbl/data.frame)
#>  $ enid      : chr [1:254] "O20030417000004" "O20030417000004" "O20030417000009" "O20030417000009" ...
#>  $ pac       : chr [1:254] "3577472422" "3577472422" "3577472422" "3577472422" ...
#>  $ org_name  : chr [1:254] "NORTH BROWARD HOSPITAL DISTRICT" "NORTH BROWARD HOSPITAL DISTRICT" "NORTH BROWARD HOSPITAL DISTRICT" "NORTH BROWARD HOSPITAL DISTRICT" ...
#>  $ own_pac   : chr [1:254] "3577472422" "3577472422" "3577472422" "3577472422" ...
#>  $ own_type  : chr [1:254] "O" "O" "O" "O" ...
#>  $ own_code  : int [1:254] 34 43 34 43 43 43 34 43 34 34 ...
#>  $ own_role  : chr [1:254] "5% OR GREATER DIRECT OWNERSHIP INTEREST" "OPERATIONAL/MANAGERIAL CONTROL" "5% OR GREATER DIRECT OWNERSHIP INTEREST" "OPERATIONAL/MANAGERIAL CONTROL" ...
#>  $ own_date  : Date[1:254], format: "1993-07-01" "1993-10-01" ...
#>  $ own_first : chr [1:254] NA NA NA NA ...
#>  $ own_middle: chr [1:254] NA NA NA NA ...
#>  $ own_last  : chr [1:254] NA NA NA NA ...
#>  $ own_title : chr [1:254] NA NA NA NA ...
#>  $ own_org   : chr [1:254] "NORTH BROWARD HOSPITAL DISTRICT" "NORTH BROWARD HOSPITAL DISTRICT" "NORTH BROWARD HOSPITAL DISTRICT" "NORTH BROWARD HOSPITAL DISTRICT" ...
#>  $ own_dba   : chr [1:254] "BROWARD HEALTH MEDICAL CENTER OUTPATIENT PHARMACY" "BROWARD HEALTH MEDICAL CENTER OUTPATIENT PHARMACY" "BROWARD HEALTH MEDICAL CENTER OUTPATIENT PHARMACY" "BROWARD HEALTH MEDICAL CENTER OUTPATIENT PHARMACY" ...
#>  $ own_city  : chr [1:254] "FORT LAUDERDALE" "FORT LAUDERDALE" "FT LAUDERDALE" "FT LAUDERDALE" ...
#>  $ own_state : chr [1:254] "FL" "FL" "FL" "FL" ...
#>  $ own_zip   : chr [1:254] "333093092" "333093092" "333121638" "333121638" ...
#>  $ own_pct   : num [1:254] 100 100 100 100 0 100 NA 0 NA NA ...
#>  $ oth_txt   : chr [1:254] "GOVERNMENT" "GOVERNMENT" NA NA ...
#>  $ own_add   : chr [1:254] "1800 NW 49TH ST, STE 110" "1800 NW 49TH ST, STE 110" "1111 W BROWARD BLVD" "1111 W BROWARD BLVD" ...
#>  $ var       : chr [1:254] "Created for Aquisition" "Created for Aquisition" "Created for Aquisition" "Created for Aquisition" ...
```
