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
rx
```

    #> # A tibble: 27 × 8
    #>     year brand_name        generic_name tot_claims tot_fills tot_supply tot_cost
    #>    <int> <chr>             <chr>             <int>     <dbl>      <int>    <dbl>
    #>  1  2021 Acetazolamide Er  Acetazolami…         20      20.5        533     971.
    #>  2  2021 Alphagan P        Brimonidine…         34      51         1424   12450.
    #>  3  2021 Azithromycin      Azithromycin        661    1588.       45870    7181.
    #>  4  2021 Brimonidine Tart… Brimonidine…        306     550.       15746    8700.
    #>  5  2021 Bromsite          Bromfenac S…         78      80.5       2387   21943.
    #>  6  2021 Carteolol Hcl     Carteolol H…         79     184.        5482    1578.
    #>  7  2021 Cephalexin        Cephalexin           57      57          279     444.
    #>  8  2021 Combigan          Brimonidine…         63      87.8       2444   17835.
    #>  9  2021 Dorzolamide Hcl   Dorzolamide…         71     151.        4533    2189 
    #> 10  2021 Dorzolamide-Timo… Dorzolamide…         99     216.        6463    3921.
    #> # ℹ 17 more rows
    #> # ℹ 1 more variable: tot_benes <int>
