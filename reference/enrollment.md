# Facility Enrollment

Providers with pending Medicare enrollment applications.

## Usage

``` r
fqhc_enroll(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  count = FALSE,
  set = FALSE
)

hospice_enroll(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  count = FALSE,
  set = FALSE
)

rhc_enroll(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  count = FALSE,
  set = FALSE
)

snf_enroll(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  count = FALSE,
  set = FALSE
)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- ccn:

  `<int>` CMS Certification Number

- pac:

  `<chr>` PECOS Associate Control ID

- enid:

  `<chr>` Medicare Enrollment ID

- org_name:

  `<chr>` Legal business name

- org_dba:

  `<chr>` Doing-business-as name

- city, state, zip:

  `<chr>` Location city, state, zip

- multi:

  `<lgl>` Does hospital have more than one NPI?

- status:

  `<enum>` Organization status

  - `P` = Proprietary

  - `N` = Non-Profit

  - `D` = Unknown

- org_type:

  `<enum>` Organization structure type

  - `corp` = Corporation

  - `other` = Other

  - `llc` = LLC

  - `part` = Partnership

  - `sole` = Sole Proprietor

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
fqhc_enroll(count = TRUE)
#> fqhc_enroll Totals
#> • Rows  : 11,063
#> • Pages : 3     
#> 
hospice_enroll(count = TRUE)
#> hospice_enroll Totals
#> • Rows  : 6,066
#> • Pages : 2    
#> 
rhc_enroll(count = TRUE)
#> rhc_enroll Totals
#> • Rows  : 5,530
#> • Pages : 2    
#> 
snf_enroll(count = TRUE)
#> snf_enroll Totals
#> • Rows  : 14,426
#> • Pages : 3     
#> 

fqhc_enroll(state = c("GA", "FL")) |> str()
#> ✔ fqhc_enroll returned 768 results.
#> fqhc_nrl [768 × 14] (S3: fqhc_enroll/tbl_df/tbl/data.frame)
#>  $ enid    : chr [1:768] "O20020819000009" "O20020927000008" "O20021207000004" "O20030207000029" ...
#>  $ npi     : int [1:768] 1801826268 1164642419 1811947245 1285644799 1033229059 1609037944 1497773055 1689692246 1609814219 1538163043 ...
#>  $ multi   : int [1:768] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ ccn     : chr [1:768] "101936" "101937" "101938" "101916" ...
#>  $ pac     : chr [1:768] "2365359387" "2365359387" "9931017126" "3870402548" ...
#>  $ org_name: chr [1:768] "TRENTON MEDICAL CENTER INC" "TRENTON MEDICAL CENTER INC" "FLORIDA COMMUNITY HEALTH CENTERS INC" "SUNCOAST COMMUNITY HEALTH CENTERS, INC" ...
#>  $ org_dba : chr [1:768] "PALMS MEDICAL GROUP" "PALMS MEDICAL GROUP" "ST. LUCIE WOMEN AND CHILDREN" "RUSKIN HEALTH CENTER" ...
#>  $ inc_date: Date[1:768], format: "1988-01-14" "1988-01-14" ...
#>  $ org_type: chr [1:768] "CORPORATION" "CORPORATION" "CORPORATION" "CORPORATION" ...
#>  $ status  : chr [1:768] "N" "N" "N" "N" ...
#>  $ address : chr [1:768] "911 S MAIN ST" "1830 N MAIN ST" "1871 SE TIFFANY AVE, STE 200" "2814 14TH AVE SE" ...
#>  $ city    : chr [1:768] "TRENTON" "BELL" "PORT ST LUCIE" "RUSKIN" ...
#>  $ state   : chr [1:768] "FL" "FL" "FL" "FL" ...
#>  $ zip     : chr [1:768] "326933239" "326194713" "349527585" "335705471" ...

hospice_enroll(state = c("GA", "FL")) |> str()
#> ✔ hospice_enroll returned 312 results.
#> hspc_nrl [312 × 14] (S3: hospice_enroll/tbl_df/tbl/data.frame)
#>  $ enid    : chr [1:312] "O20040216000832" "O20040715000105" "O20040715000161" "O20040817000027" ...
#>  $ npi     : int [1:312] 1003872276 1801834593 1891733580 1205960473 1932242260 1043257934 1134126774 1144328881 1063450666 1154369171 ...
#>  $ multi   : int [1:312] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ ccn     : chr [1:312] "101528" "111560" "111559" "111621" ...
#>  $ pac     : chr [1:312] "5597650994" "5597663104" "5597663104" "7517930720" ...
#>  $ org_name: chr [1:312] "AVOW HOSPICE INC" "VISTACARE USA, LLC" "VISTACARE USA, LLC" "HARBOR GRACE HOSPICE, INC." ...
#>  $ org_dba : chr [1:312] "HOSPICE OF NAPLES INC" "GENTIVA" "GENTIVA" "HARBOR GRACE HOSPICE" ...
#>  $ inc_date: Date[1:312], format: "1982-04-05" NA ...
#>  $ org_type: chr [1:312] "CORPORATION" "LLC" "LLC" "CORPORATION" ...
#>  $ status  : chr [1:312] "N" "P" "P" "P" ...
#>  $ address : chr [1:312] "1095 WHIPPOORWILL LN" "700 BROOKSTONE CENTRE PKWY, STE 100" "105 JIM MASON CT, STE 100" "500 LANIER AVE W, SUITE 401" ...
#>  $ city    : chr [1:312] "NAPLES" "COLUMBUS" "WARNER ROBINS" "FAYETTEVILLE" ...
#>  $ state   : chr [1:312] "FL" "GA" "GA" "GA" ...
#>  $ zip     : chr [1:312] "341053847" "319049255" "310889241" "302147638" ...

rhc_enroll(state = c("GA", "FL")) |> str()
#> ✔ rhc_enroll returned 220 results.
#> rhc_nrll [220 × 14] (S3: rhc_enroll/tbl_df/tbl/data.frame)
#>  $ enid    : chr [1:220] "O20021021000000" "O20021113000013" "O20021118000017" "O20030227000008" ...
#>  $ npi     : int [1:220] 1952357519 1255477360 1154533677 1437271509 1033114285 1992710610 1497760243 1508929050 1285706879 1437225067 ...
#>  $ multi   : int [1:220] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ ccn     : chr [1:220] "103951" "103920" "108947" "108941" ...
#>  $ pac     : chr [1:220] "6709794332" "8426966854" "2668380924" "7810806288" ...
#>  $ org_name: chr [1:220] "EXPRESS CARE OF BELLEVIEW, LLC" "HEALTHFLO MEDICAL CLINICS INC" "SOUTHERN FAMILY HEALTHCARE, P.A." "DOCTORS MEDICAL CENTER OF WALTON COUNTY PA" ...
#>  $ org_dba : chr [1:220] NA "BUSHNELL MEDICAL CLINIC" "N/A" "N/A" ...
#>  $ inc_date: Date[1:220], format: "2012-09-04" "1996-05-17" ...
#>  $ org_type: chr [1:220] "LLC" "CORPORATION" "CORPORATION" "CORPORATION" ...
#>  $ status  : chr [1:220] "P" "P" "P" "P" ...
#>  $ address : chr [1:220] "10762 S US HIGHWAY 441" "117 W BELT AVE, STE A" "877 3RD STREET, SUITE 4" "21W MAIN AVE" ...
#>  $ city    : chr [1:220] "BELLEVIEW" "BUSHNELL" "CHIPLEY" "DEFUNIAK SPRINGS" ...
#>  $ state   : chr [1:220] "FL" "FL" "FL" "FL" ...
#>  $ zip     : chr [1:220] "344203805" "335135101" "324281855" "324352529" ...

snf_enroll(state = c("GA", "FL")) |> str()
#> ✔ snf_enroll returned 1,044 results.
#> snf_nrll [1,044 × 16] (S3: snf_enroll/tbl_df/tbl/data.frame)
#>  $ enid    : chr [1:1044] "O20020829000002" "O20020910000037" "O20020912000012" "O20020916000022" ...
#>  $ npi     : int [1:1044] 1265427934 1558308692 1235171174 1043252083 1952485989 1871519736 1235249368 1881628105 1962459487 1073677167 ...
#>  $ multi   : int [1:1044] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ ccn     : chr [1:1044] "105319C" "115387" "115507" "115382" ...
#>  $ pac     : chr [1:1044] "5092622951" "6709793615" "3870400690" "0749197580" ...
#>  $ org_name: chr [1:1044] "SUN CITY CENTER ASSOCIATES LTD LP" "TOOMBS NURSING HOME LLC" "TAYLOR COUNTY HEALTH CARE LLC" "SPARTA HEALTH CARE LLC" ...
#>  $ org_dba : chr [1:1044] "SUN TERRACE HEALTH CARE CENTER" "OXLEY PARK HEALTH AND REHABILITATION" "TAYLOR COUNTY HEALTH AND REHABILITATION" "SPARTA HEALTH AND REHABILITATION" ...
#>  $ inc_date: Date[1:1044], format: "1963-01-12" "2002-07-01" ...
#>  $ org_type: chr [1:1044] "OTHER: LIMITED PARTNERSHIP" "LLC" "LLC" "LLC" ...
#>  $ status  : chr [1:1044] "P" "N" "N" "N" ...
#>  $ address : chr [1:1044] "105 TRINITY LAKES DR" "181 OXLEY DR" "165 S BROAD ST" "11744 GA HIGHWAY 22" ...
#>  $ city    : chr [1:1044] "SUN CITY CENTER" "LYONS" "BUTLER" "SPARTA" ...
#>  $ state   : chr [1:1044] "FL" "GA" "GA" "GA" ...
#>  $ zip     : chr [1:1044] "335735728" "304365644" "310065526" "310871475" ...
#>  $ nhp_name: chr [1:1044] "SUN TERRACE HEALTH CARE CENTER" "OXLEY PARK HEALTH AND REHABILITATION" "TAYLOR COUNTY HEALTH AND REHABILITATION" "SPARTA HEALTH AND REHABILITATION" ...
#>  $ aff_name: chr [1:1044] "CLEAR CHOICE HEALTHCARE" "ETHICA HEALTH" "ETHICA HEALTH" "ETHICA HEALTH" ...
```
