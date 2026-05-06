# Skilled Nursing Facility Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
snf_owner(
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
snf_owner(count = TRUE)
#> snf_owner Totals
#> • Rows  : 116,973
#> • Pages : 24     
#> 

snf_owner(own_state = c("GA", "FL")) |> str()
#> ✔ snf_owner returned 4,175 results.
#> tibble [4,175 × 21] (S3: tbl_df/tbl/data.frame)
#>  $ enid      : chr [1:4175] "O20030210000048" "O20030402000016" "O20030402000016" "O20040115000225" ...
#>  $ pac       : chr [1:4175] "4284543869" "5496664583" "5496664583" "6901707850" ...
#>  $ org_name  : chr [1:4175] "13000 VICTORY BOULEVARD LLC" "SENIOR CARE GROUP OF MCDOWELL, LLC" "SENIOR CARE GROUP OF MCDOWELL, LLC" "HEBREW HOME SINAI INC" ...
#>  $ own_pac   : chr [1:4175] "8527345461" "3577472661" "3577472661" "4981853009" ...
#>  $ own_type  : chr [1:4175] "O" "O" "O" "O" ...
#>  $ own_code  : int [1:4175] 34 34 36 34 34 34 36 43 35 35 ...
#>  $ own_role  : chr [1:4175] "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER MORTGAGE INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" ...
#>  $ own_date  : Date[1:4175], format: "1998-06-01" "2002-04-02" ...
#>  $ own_first : chr [1:4175] NA NA NA NA ...
#>  $ own_middle: chr [1:4175] NA NA NA NA ...
#>  $ own_last  : chr [1:4175] NA NA NA NA ...
#>  $ own_title : chr [1:4175] NA NA NA NA ...
#>  $ own_org   : chr [1:4175] "JANIS C ROSZLER TRUST U/AD" "SENIOR CARE GROUP, INC" "SENIOR CARE GROUP, INC" "HEBREW HOMES MANAGEMENT SERVICES INC" ...
#>  $ own_dba   : chr [1:4175] NA "LAKESHORE VILLAS HEALTH CARE CENTER" "LAKESHORE VILLAS HEALTH CARE CENTER" NA ...
#>  $ own_city  : chr [1:4175] "MIAMI" "TAMPA" "TAMPA" "NORTH MIAMI BEACH" ...
#>  $ own_state : chr [1:4175] "FL" "FL" "FL" "FL" ...
#>  $ own_zip   : chr [1:4175] "331402944" "336194491" "336194491" "331621744" ...
#>  $ own_pct   : num [1:4175] 5.69 NA NA 100 100 100 100 NA 100 100 ...
#>  $ oth_txt   : chr [1:4175] "TRUST" NA NA NA ...
#>  $ own_add   : chr [1:4175] "4575 N MERIDIAN" "410 S WARE BLVD, STE 1001" "410 S WARE BLVD, STE 1001" "16855 NE 2ND AVE, STE 400N" ...
#>  $ own_ind   : chr [1:4175] "For-Profit, Other" "Corporation, Non-Profit" "Corporation, Non-Profit" "Created for Aquisition, Corporation, Management Services Company, For-Profit, Non-Profit" ...
```
