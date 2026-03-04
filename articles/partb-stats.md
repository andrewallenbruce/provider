# Comparing Providers

## Demographics, Patient Mix, and Performance

``` r
library(provider)
library(tidyr)
library(dplyr)
library(purrr)
library(future)
library(furrr)
library(ggplot2)
library(gt)
library(gtExtras)
```

## `utilization()`

``` r
future::plan(multisession, workers = 4)

# Retrieve provider's overall utilization data
ind     <- utilization_(npi = 1043477615, type = "Provider")
```

    #> Error:
    #> ℹ In index: 1.
    #> Caused by error in `dplyr::mutate()`:
    #> ℹ In argument: `dplyr::across(dplyr::where(is.character), na_blank)`.
    #> Caused by error:
    #> ! object 'na_blank' not found

``` r
# Retrieve provider's utilization data by HCPCS
srvc    <- utilization_(npi = 1023076643, type = "Service")
```

    #> Error:
    #> ! Future (<unnamed-5>) of class MultisessionFuture interrupted (pid 8772) [future <unnamed-5> (e3854e08810679d5e8b6603c59c59945-5); on e3854e08810679d5e8b6603c59c59945@runnervm0kj6c<8701> at 2026-03-04 21:00:34.418343]

``` r
# Retrieve state & national HCPCS data to compare with
hcpcs   <- compare_hcpcs(srvc)
```

    #> Error:
    #> ! object 'srvc' not found

``` r
future::plan(sequential)
```

### Overall Performance

``` r
performance <- ind |> 
  unnest(performance) |> 
  select(year, tot_hcpcs:.pymt_per_srvc)
```

    #> Error:
    #> ! object 'ind' not found

``` r
performance
```

    #> Error:
    #> ! object 'performance' not found

``` r
ggplot(performance, aes(x = .pymt_per_srvc, 
                        y = .srvcs_per_bene, 
                        fill = year, group = year)) +
  geom_point(shape = 21, size = 4, alpha = 0.75) +
  theme_minimal()
```

    #> Error:
    #> ! object 'performance' not found

``` r
ind |> 
  unnest(performance) |> 
  select(year, tot_hcpcs:tot_srvcs) |> 
  provider:::change(!year, csm = "_chg") |> 
  gt(rowname_col = "year") |> 
  opt_table_font(font = google_font(name = "Fira Code")) |> 
  fmt_currency(columns = starts_with("avg_"), decimals = 0)
```

    #> Error:
    #> ! object 'ind' not found

``` r
ind |> 
  unnest(performance) |> 
  select(year, tot_charges:tot_payment) |> 
  provider:::change(!year) |> 
  gt(rowname_col = "year") |> 
  opt_table_font(font = google_font(name = "Fira Code")) |> 
  fmt_currency(columns = c(tot_charges, tot_allowed, tot_payment), decimals = 0) |> 
  fmt_currency(columns = ends_with("_chg"), decimals = 0, force_sign = TRUE) |> 
  fmt_percent(columns = ends_with("_pct"), decimals = 0, force_sign = TRUE) |> 
  fmt_percent(columns = ends_with("_ror"), decimals = 0)
```

    #> Error:
    #> ! object 'ind' not found

``` r
ind |> 
  unnest(performance) |> 
  select(year, .copay_deduct:.pymt_per_srvc) |> 
  provider:::change(!year) |> 
  gt(rowname_col = "year") |> 
  opt_table_font(font = google_font(name = "Fira Code")) |> 
  fmt_currency(columns = starts_with(".pymt"), decimals = 2)
```

    #> Error:
    #> ! object 'ind' not found

### HCPCS Utilization Data

``` r
srvc |> 
  group_by(year, family) |> 
  mutate(
    hcpcs_level = min_rank(
      pick(avg_allowed, avg_payment))) |> 
  select(year, 
         hcpcs, 
         hcpcs_desc, 
         rank = hcpcs_level, 
         subcategory, 
         family, 
         tot_benes:tot_srvcs, 
         avg_charge:avg_payment) |> 
  arrange(year, family, rank) |> 
  gt(groupname_col = "subcategory") |> 
  gt_merge_stack(hcpcs, hcpcs_desc) |> 
  fmt_roman(rank) |> 
  cols_label(
    tot_benes = "Beneficiaries",
    tot_srvcs = "Services",
    avg_charge = "Charge",
    avg_allowed= "Allowed",
    avg_payment = "Payment") |> 
  opt_table_font(font = google_font(name = "Fira Code")) |> 
  fmt_currency(columns = starts_with("avg_"), decimals = 0) |> 
  opt_all_caps()
```

    #> Error:
    #> ! object 'srvc' not found

``` r
srvc |> 
  select(year, 
         hcpcs, 
         family, 
         tot_benes, 
         tot_srvcs, 
         avg_charge, 
         avg_allowed, 
         avg_payment) |> 
  group_by(year, family) |> 
  summarise(tot_benes = sum(tot_benes),
            tot_srvcs = sum(tot_srvcs),
            avg_charge = mean(avg_charge), 
            avg_allowed = mean(avg_allowed), 
            avg_payment = mean(avg_payment), .groups = "drop") |>
  arrange(family) |> 
  gt(rowname_col = "year") |> 
  fmt_currency(columns = starts_with("avg_"), decimals = 0) |>
  cols_label(
    tot_benes = "Beneficiaries",
    tot_srvcs = "Services",
    avg_charge = "Charge",
    avg_allowed= "Allowed",
    avg_payment = "Payment") |> 
  opt_table_font(font = google_font(name = "JetBrains Mono")) |> 
  opt_all_caps()
```

    #> Error:
    #> ! object 'srvc' not found

``` r
hcpcs |> 
  group_by(year, level, subcategory) |>
  summarise(Beneficiaries = sum(beneficiaries),
            Services = sum(services),
            "Average Payment" = mean(avg_payment), .groups = "drop") |>
  arrange(year, subcategory) |>
  gt(rowname_col = "year") |> 
  cols_align("left", level) |> 
  cols_move_to_start(columns = subcategory) |> 
  fmt_integer(columns = c(Beneficiaries, Services)) |> 
  fmt_currency(columns = c('Average Payment'), decimals = 2) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono")) |>
  tab_header(title = md("**Medicare Part B** Utilization")) |> 
  opt_horizontal_padding(scale = 2) |> 
  tab_options(table.width = pct(50),
              column_labels.font.weight = "bold",
              row_group.font.weight = "bold",
              heading.background.color = "black",
              heading.align = "left") |> 
  opt_all_caps()
```

    #> Error:
    #> ! object 'hcpcs' not found

``` r
hcpcs |> 
  select(year, 
         level,
         hcpcs,
         category,
         subcategory,
         family, 
         beneficiaries, 
         services, 
         avg_charge, 
         avg_allowed, 
         avg_payment) |> 
  arrange(hcpcs, year) |>
  gt(rowname_col = "year") |> 
  cols_label(
    hcpcs = "HCPCS",
    avg_charge = "Charge",
    avg_allowed= "Allowed",
    avg_payment = "Payment") |> 
  cols_align(columns = "level", align = "left") |>
  fmt_integer(columns = c(beneficiaries, services)) |>
  fmt_currency(columns = starts_with("avg_"), decimals = 0) |>
  opt_table_font(font = google_font(name = "JetBrains Mono")) |> 
  opt_all_caps()
```

    #> Error:
    #> ! object 'hcpcs' not found

### Demographics

``` r
ind |> 
  unnest(performance, demographics) |> 
  select(year, tot_benes, starts_with("bene_")) |> 
  select(-bene_race_detailed) |> 
  gt(rowname_col = "year") |> 
  cols_label(tot_benes = "Total") |>  
  fmt_percent(columns = starts_with("cc_"), decimals = 0) |>
  opt_table_font(font = google_font(name = "JetBrains Mono")) |> 
  sub_missing(missing_text = "") |>
  sub_zero(zero_text = "") |>
  opt_all_caps()
```

    #> Error:
    #> ! object 'ind' not found

#### Chronic Conditions

``` r
ind |> 
  unnest(performance) |> 
  select(year, tot_benes, conditions) |> 
  unnest(conditions) |>
  gt(rowname_col = "year") |> 
  cols_label(tot_benes = "Total") |>  
  fmt_percent(columns = starts_with("cc_"), decimals = 0) |>
  opt_table_font(font = google_font(name = "JetBrains Mono")) |> 
  sub_missing(missing_text = "") |>
  sub_zero(zero_text = "") |>
  opt_all_caps()
```

    #> Error:
    #> ! object 'ind' not found
