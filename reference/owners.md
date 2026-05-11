# Facility Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
fqhc_owner(
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  pac = NULL,
  owner = NULL,
  dba = NULL,
  percent = NULL,
  role = NULL,
  entity = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
)

hospital_owner(
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  pac = NULL,
  owner = NULL,
  dba = NULL,
  percent = NULL,
  role = NULL,
  entity = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
)

hospice_owner(
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  pac = NULL,
  owner = NULL,
  dba = NULL,
  percent = NULL,
  role = NULL,
  entity = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
)

rhc_owner(
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  pac = NULL,
  owner = NULL,
  dba = NULL,
  percent = NULL,
  role = NULL,
  entity = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
)

snf_owner(
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  pac = NULL,
  owner = NULL,
  dba = NULL,
  percent = NULL,
  role = NULL,
  entity = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
)
```

## Arguments

- org_enid:

  `<chr>` National Provider Identifier

- org_pac:

  `<chr>` Provider's name

- org_name:

  `<chr>` Provider's name

- pac:

  `<chr>` Provider's name

- owner:

  `<chr>` Provider's name

- dba:

  `<chr>` Provider's name

- percent:

  `<chr>` Provider's name

- role:

  `<chr>` Provider's name

- entity:

  `<chr>` Provider's name

- first, middle, last:

  `<chr>` Provider's name

- title:

  `<chr>` Provider's name

- address, city, state, zip:

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
#> fqhc_owner Totals
#> • Rows  : 148,919
#> • Pages : 30     
#> 
hospital_owner(count = TRUE)
#> hospital_owner Totals
#> • Rows  : 23,028
#> • Pages : 5     
#> 
hospice_owner(count = TRUE)
#> hospice_owner Totals
#> • Rows  : 71,133
#> • Pages : 15    
#> 
rhc_owner(count = TRUE)
#> rhc_owner Totals
#> • Rows  : 65,551
#> • Pages : 14    
#> 
snf_owner(count = TRUE)
#> snf_owner Totals
#> • Rows  : 116,973
#> • Pages : 24     
#> 

fqhc_owner(state = c("GA", "FL")) |> str()
#> ✔ fqhc_owner returned 254 results.
#> tibble [254 × 19] (S3: tbl_df/tbl/data.frame)
#>  $ org_enid: chr [1:254] "O20101007000545" "O20160930000000" "O20160930000007" "O20160930000102" ...
#>  $ org_pac : chr [1:254] "0143127951" "0143127951" "0143127951" "0143127951" ...
#>  $ org_name: chr [1:254] "CENTRAL FLORIDA HEALTH CARE INC" "CENTRAL FLORIDA HEALTH CARE INC" "CENTRAL FLORIDA HEALTH CARE INC" "CENTRAL FLORIDA HEALTH CARE INC" ...
#>  $ pac     : chr [1:254] "0143127951" "0143127951" "0143127951" "0143127951" ...
#>  $ entity  : chr [1:254] "O" "O" "O" "O" ...
#>  $ role    : chr [1:254] "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" ...
#>  $ asc_date: Date[1:254], format: "1994-10-01" "2016-09-30" ...
#>  $ first   : chr [1:254] NA NA NA NA ...
#>  $ middle  : chr [1:254] NA NA NA NA ...
#>  $ last    : chr [1:254] NA NA NA NA ...
#>  $ title   : chr [1:254] NA NA NA NA ...
#>  $ own_name: chr [1:254] "CENTRAL FLORIDA HEALTH CARE INC" "CENTRAL FLORIDA HEALTH CARE INC" "CENTRAL FLORIDA HEALTH CARE INC" "CENTRAL FLORIDA HEALTH CARE INC" ...
#>  $ own_dba : chr [1:254] "CENTRAL FLORIDA HEALTH CARE WAUCHULA PRIMARY CARE" "CENTRAL FLORIDA HEALTH CARE WAUCHULA PRIMARY CARE" "CENTRAL FLORIDA HEALTH CARE WAUCHULA PRIMARY CARE" "CENTRAL FLORIDA HEALTH CARE WAUCHULA PRIMARY CARE" ...
#>  $ address : chr [1:254] "47 5TH ST NW" "47 5TH ST NW" "47 5TH ST NW" "47 5TH ST NW" ...
#>  $ city    : chr [1:254] "WINTER HAVEN" "WINTER HAVEN" "WINTER HAVEN" "WINTER HAVEN" ...
#>  $ state   : chr [1:254] "FL" "FL" "FL" "FL" ...
#>  $ zip     : chr [1:254] "338814672" "338814672" "338814672" "338814672" ...
#>  $ percent : num [1:254] 100 NA NA NA NA 100 100 100 0 100 ...
#>  $ own_type: chr [1:254] "Other: FQHC" "Other: FQHC" "Other: FQHC" "Other: FQHC" ...

hospital_owner(state = c("GA", "FL")) |> str()
#> ✔ hospital_owner returned 137 results.
#> tibble [137 × 19] (S3: tbl_df/tbl/data.frame)
#>  $ org_enid: chr [1:137] "O20110112000012" "O20160715000727" "O20171114002880" "O20220126000430" ...
#>  $ org_pac : chr [1:137] "7618164518" "6305138009" "5395001937" "1355745209" ...
#>  $ org_name: chr [1:137] "MHA LLC" "SELECT SPECIALTY HOSPITAL MIDTOWN ATLANTA LLC" "NAVICENT HEALTH OCONEE, LLC" "NAVICENT HEALTH BALDWIN, INC" ...
#>  $ pac     : chr [1:137] "0143417048" "0143445031" "0345247649" "0345247649" ...
#>  $ entity  : chr [1:137] "O" "O" "O" "O" ...
#>  $ role    : chr [1:137] "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER INDIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" ...
#>  $ asc_date: Date[1:137], format: "2010-12-07" "2023-01-01" ...
#>  $ first   : chr [1:137] NA NA NA NA ...
#>  $ middle  : chr [1:137] NA NA NA NA ...
#>  $ last    : chr [1:137] NA NA NA NA ...
#>  $ title   : chr [1:137] NA NA NA NA ...
#>  $ own_name: chr [1:137] "ATRP LLC" "EMORY REHABILITATION LLC" "NAVICENT HEALTH INC" "NAVICENT HEALTH INC" ...
#>  $ own_dba : chr [1:137] NA NA NA NA ...
#>  $ address : chr [1:137] "UNIT 2103" "201 DOWMAN DR NE" "STE 700" "STE A" ...
#>  $ city    : chr [1:137] "MIAMI BEACH" "ATLANTA" "MACON" "MACON" ...
#>  $ state   : chr [1:137] "FL" "GA" "GA" "GA" ...
#>  $ zip     : chr [1:137] "331417409" "303221007" "312012666" "312012187" ...
#>  $ percent : num [1:137] NA 4 100 100 100 NA 100 100 100 NA ...
#>  $ own_type: chr [1:137] NA "LLC" "Corporation" "Corporation" ...

hospice_owner(state = c("GA", "FL")) |> str()
#> ✔ hospice_owner returned 1,961 results.
#> tibble [1,961 × 19] (S3: tbl_df/tbl/data.frame)
#>  $ org_enid: chr [1:1961] "O20151222001715" "O20180315000362" "O20060308000611" "O20071128000100" ...
#>  $ org_pac : chr [1:1961] "3476853888" "5395007132" "3476560905" "3678477445" ...
#>  $ org_name: chr [1:1961] "AUGUSTA HOME CARE SERVICES LLC" "GODLY HOSPICE AND PALLIATIVE CARE LLC" "CATHOLIC HOSPICE, INC" "THE MEDICAL CENTER OF CENTRAL GEORGIA INC." ...
#>  $ pac     : chr [1:1961] "0143249995" "0244668879" "0345243564" "0345247649" ...
#>  $ entity  : chr [1:1961] "O" "O" "O" "O" ...
#>  $ role    : chr [1:1961] "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER INDIRECT OWNERSHIP INTEREST" "OPERATIONAL/MANAGERIAL CONTROL" "5% OR GREATER DIRECT OWNERSHIP INTEREST" ...
#>  $ asc_date: Date[1:1961], format: "2025-12-31" "2022-02-14" ...
#>  $ first   : chr [1:1961] NA NA NA NA ...
#>  $ middle  : chr [1:1961] NA NA NA NA ...
#>  $ last    : chr [1:1961] NA NA NA NA ...
#>  $ title   : chr [1:1961] NA NA NA NA ...
#>  $ own_name: chr [1:1961] "UNIVERSITY HEALTH SERVICES,INC" "PETRA GROWTH FUND IV, L.P." "CATHOLIC HEALTH SERVICES INC" "NAVICENT HEALTH INC" ...
#>  $ own_dba : chr [1:1961] "PIEDMONT AUGUSTA HOSPITAL" NA "CATHOLIC HEALTH SERVICES MEDICAL GROUP" NA ...
#>  $ address : chr [1:1961] "1350 WALTON WAY" "STE 1800" "4790 NORTH STATE ROAD 7" "STE A" ...
#>  $ city    : chr [1:1961] "AUGUSTA" "ATLANTA" "LAUDERDALE LAKES" "MACON" ...
#>  $ state   : chr [1:1961] "GA" "GA" "FL" "GA" ...
#>  $ zip     : chr [1:1961] "309012612" "303395946" "333195860" "312012187" ...
#>  $ percent : num [1:1961] 75 16.8 NA 100 100 ...
#>  $ own_type: chr [1:1961] "Another Org/Ind" "Other: LIMITED PARTNERSHIP" NA "Corporation" ...

rhc_owner(state = c("GA", "FL")) |> str()
#> ✔ rhc_owner returned 136 results.
#> tibble [136 × 19] (S3: tbl_df/tbl/data.frame)
#>  $ org_enid: chr [1:136] "O20130617000633" "O20130604000415" "O20170208002332" "O20170208002332" ...
#>  $ org_pac : chr [1:136] "0244224947" "3375795693" "8921380759" "8921380759" ...
#>  $ org_name: chr [1:136] "THE HOSPITAL AUTHORITY OF MILLER COUNTY" "THE MEDICAL CENTER OF PEACH COUNTY, INC." "LIFEBRITE HOSPITAL GROUP OF STOKES LLC" "LIFEBRITE HOSPITAL GROUP OF STOKES LLC" ...
#>  $ pac     : chr [1:136] "0244224947" "0345247649" "0345522199" "0345522199" ...
#>  $ entity  : chr [1:136] "O" "O" "O" "O" ...
#>  $ role    : chr [1:136] "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" "OPERATIONAL/MANAGERIAL CONTROL" ...
#>  $ asc_date: Date[1:136], format: "2013-02-04" "2011-11-01" ...
#>  $ first   : chr [1:136] NA NA NA NA ...
#>  $ middle  : chr [1:136] NA NA NA NA ...
#>  $ last    : chr [1:136] NA NA NA NA ...
#>  $ title   : chr [1:136] NA NA NA NA ...
#>  $ own_name: chr [1:136] "THE HOSPITAL AUTHORITY OF MILLER COUNTY" "NAVICENT HEALTH INC" "LIFEBRITE HOSPITAL GROUP LLC" "LIFEBRITE HOSPITAL GROUP LLC" ...
#>  $ own_dba : chr [1:136] "MILLER COUNTY HOSPITAL PHARMACY" NA NA NA ...
#>  $ address : chr [1:136] "209 N CUTHBERT ST" "STE A" "STE 100" "STE 100" ...
#>  $ city    : chr [1:136] "COLQUITT" "MACON" "BROOKHAVEN" "BROOKHAVEN" ...
#>  $ state   : chr [1:136] "GA" "GA" "GA" "GA" ...
#>  $ zip     : chr [1:136] "398373518" "312012187" "303291905" "303291905" ...
#>  $ percent : num [1:136] NA 100 100 NA 100 0 NA NA 100 5 ...
#>  $ own_type: chr [1:136] "Other: GOV'T ENTITY" "Corporation" "For-Profit" "For-Profit" ...

snf_owner(state = c("GA", "FL")) |> str()
#> ✔ snf_owner returned 4,175 results.
#> tibble [4,175 × 19] (S3: tbl_df/tbl/data.frame)
#>  $ org_enid: chr [1:4175] "O20050728000461" "O20050728000461" "O20140109001208" "O20140225000653" ...
#>  $ org_pac : chr [1:4175] "9335177625" "9335177625" "0941438329" "0042440737" ...
#>  $ org_name: chr [1:4175] "HILL HAVEN, INC." "HILL HAVEN, INC." "PLEASANT SPRINGS OPERATING COMPANY LLC" "HENDERSON OPERATING COMPANY LLC" ...
#>  $ pac     : chr [1:4175] "0042248338" "0042248338" "0042447054" "0042447054" ...
#>  $ entity  : chr [1:4175] "O" "O" "O" "O" ...
#>  $ role    : chr [1:4175] "5% OR GREATER DIRECT OWNERSHIP INTEREST" "OPERATIONAL/MANAGERIAL CONTROL" "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" ...
#>  $ asc_date: Date[1:4175], format: "2005-06-23" "2005-06-23" ...
#>  $ first   : chr [1:4175] NA NA NA NA ...
#>  $ middle  : chr [1:4175] NA NA NA NA ...
#>  $ last    : chr [1:4175] NA NA NA NA ...
#>  $ title   : chr [1:4175] NA NA NA NA ...
#>  $ own_name: chr [1:4175] "BRAYCO INC" "BRAYCO INC" "SWC EQUITY HOLDINGS PARENT HOLDCO LLC" "SWC EQUITY HOLDINGS PARENT HOLDCO LLC" ...
#>  $ own_dba : chr [1:4175] NA NA NA NA ...
#>  $ address : chr [1:4175] "1571 BOWMAN HWY" "1571 BOWMAN HWY" "SUITE 1500" "STE 775" ...
#>  $ city    : chr [1:4175] "ELBERTON" "ELBERTON" "ATLANTA" "SANDY SPRINGS" ...
#>  $ state   : chr [1:4175] "GA" "GA" "GA" "GA" ...
#>  $ zip     : chr [1:4175] "30635" "30635" "303462115" "303502519" ...
#>  $ percent : num [1:4175] NA NA 100 NA 100 ...
#>  $ own_type: chr [1:4175] NA NA "Created for Aquisition" "Created for Aquisition" ...
```
