# Open Payments

``` r
library(provider)
library(future)
library(furrr)
library(dplyr)
library(stringr)
library(tidyr)
library(gt)
```

## Open Payments

``` r
ex <- open_payments(
  year = 2021, 
  npi = 1043218118, 
  na.rm = TRUE)
```

    #> Error in `paste0()`:
    #> ! cannot coerce type 'closure' to vector of type 'character'

``` r
ex
```

    #> Error:
    #> ! object 'ex' not found

``` r
payment <- ex |> 
  select(
    payer_name,
    pay_form,
    pay_nature,
    row_id,
    group_id,
    pay_total,
    pay_date, 
    name:category,
    ndc.atc_second)
```

    #> Error:
    #> ! object 'ex' not found

``` r
payment
```

    #> Error:
    #> ! object 'payment' not found

``` r
payment |> 
  filter(!is.na(pay_total)) |> 
  summarise(payments = n(),
            total = sum(pay_total, na.rm = TRUE),
            avg_per_pmt = total / payments) |> 
  gt_preview() |> 
  fmt_currency(columns = c(total, avg_per_pmt)) |> 
  opt_all_caps()
```

    #> Error:
    #> ! object 'payment' not found

``` r
payment |> 
  filter(!is.na(pay_total)) |> 
  group_by(payer_name) |> 
  summarise(payments = n(),
            total = sum(pay_total, na.rm = TRUE),
            avg_per_pmt = total / payments) |> 
  arrange(desc(total)) |> 
  gt_preview(30) |> 
  fmt_currency(columns = c(total, avg_per_pmt)) |> 
  opt_all_caps()
```

    #> Error:
    #> ! object 'payment' not found

``` r
payment |> 
  select(group_id, 
         pay_total, 
         name, 
         type, 
         category) |> 
  group_by(type, category, name) |> 
  summarise(payments = n(),
            total = sum(pay_total, na.rm = TRUE),
            avg_per_pmt = total / payments) |> 
  arrange(desc(total)) |> 
  gt_preview(40) |> 
  fmt_currency(columns = c(total, avg_per_pmt)) |> 
  opt_all_caps()
```

    #> Error:
    #> ! object 'payment' not found

``` r
op <- ex |> 
  filter(type == "Drug") |> 
  select(year = program_year, 
         pay_total, 
         group_id,
         brand_name = ndc.brand_name,
         generic_name = ndc.drug_name) |> 
  mutate(brand_name = str_to_title(brand_name),
         generic_name = str_to_title(generic_name))
```

    #> Error:
    #> ! object 'ex' not found

``` r
op
```

    #> Error:
    #> ! object 'op' not found

``` r
rx <- prescribers(
  year = 2021, 
  type = 'Drug', 
  npi = 1043218118) |> 
  select(
    year,
    brand_name, 
    generic_name, 
    tot_claims, 
    tot_fills, 
    tot_supply, 
    tot_cost, 
    tot_benes)
```

    #> Error in `dplyr::mutate()`:
    #> ℹ In argument: `dplyr::across(dplyr::where(is.character), na_blank)`.
    #> Caused by error:
    #> ! object 'na_blank' not found

``` r
rx
```

    #> Error:
    #> ! object 'rx' not found
