# Quality Payment Program

``` r
library(provider)
library(future)
library(furrr)
library(dplyr)
library(tidyr)
```

## Quality Payment Reporting

``` r
plan(multisession, workers = 4)
q <- quality_payment_(npi = 1144544834)
```

    #> Error:
    #> ℹ In index: 1.
    #> Caused by error in `purrr::pmap()`:
    #> ℹ In index: 1.
    #> Caused by error in `.f()`:
    #> ! object 'out' not found

``` r
plan(sequential)
q
```

    #> function (save = "default", status = 0, runLast = TRUE) 
    #> .Internal(quit(save, status, runLast))
    #> <bytecode: 0x55c5caa70990>
    #> <environment: namespace:base>

## Grouping

``` r
q |> 
  select(year, 
         participation_type,
         org_name,
         org_size,
         beneficiaries,
         services,
         charges,
         final_score,
         pay_adjust,
         ind_lvt_status_desc)
```

    #> Error in `UseMethod()`:
    #> ! no applicable method for 'select' applied to an object of class "function"

### Special Statuses

``` r
select(q, year, participation_type, org_name, org_size, qpp_status) |> 
  unnest(qpp_status)
```

    #> Error in `UseMethod()`:
    #> ! no applicable method for 'select' applied to an object of class "function"

  

``` r
select(q, year, participation_type, org_name, org_size, qpp_status) |> 
  unnest(qpp_status) |> 
  count(org_name, qualified, sort = TRUE)
```

    #> Error in `UseMethod()`:
    #> ! no applicable method for 'select' applied to an object of class "function"

  

### Individual Category Measures

``` r
select(q, year, participation_type, org_name, org_size, qpp_measures) |>
  unnest(qpp_measures)
```

    #> Error in `UseMethod()`:
    #> ! no applicable method for 'select' applied to an object of class "function"

  

``` r
select(q, year, participation_type, org_name, org_size, qpp_measures) |>
  unnest(qpp_measures) |> 
  count(year, org_name, category, sort = TRUE)
```

    #> Error in `UseMethod()`:
    #> ! no applicable method for 'select' applied to an object of class "function"

  

``` r
plan(multisession, workers = 4)
qq <- quality_payment_(npi = 1043477615)
```

    #> Error:
    #> ℹ In index: 1.
    #> Caused by error in `purrr::pmap()`:
    #> ℹ In index: 1.
    #> Caused by error in `.f()`:
    #> ! object 'out' not found

``` r
plan(sequential)
qq
```

    #> Error:
    #> ! object 'qq' not found
