
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `provider` <img src="man/figures/logo.svg" align="right" height="300" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Project Status: WIP - Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://choosealicense.com/licenses/mit/)
[![code
size](https://img.shields.io/github/languages/code-size/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider)
[![last
commit](https://img.shields.io/github/last-commit/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider/commits/main)
<!-- badges: end -->

The goal of `provider` is to provide performant and reliable open-source
tools to facilitate easy access to [healthcare
provider](https://en.wikipedia.org/wiki/Health_care_provider) data
through publicly available APIs & sources. The current list of supported
APIs are:

<br>

-   [NPPES National Provider Identifier (NPI) Registry
    API](https://npiregistry.cms.hhs.gov/search)
-   [Medicare Fee-For-Service Public Provider Enrollment
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
-   [Medicare Order and Referring
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
-   [Medicare Provider and Supplier Taxonomy
    Crosswalk](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)
-   [Medicare Physician & Other Practitioners - by Provider and Service
    API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
-   [Medicare Revalidation Due Date
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
-   [Medicare Revalidation Clinic Group Practice Reassignment
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)
-   [Medicare Opt Out Affidavits
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
-   [CMS Public Reporting of Missing Digital Contact Information
    API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)

<br>

## Installation

You can install the development version of `provider` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andrewallenbruce/provider")

# install.packages("remotes")
remotes::install_github("andrewallenbruce/provider")
```

<br>

<br>

## Motivating Example

Let’s say that you’re billing claims for a healthcare provider and you
get a denial for incorrect primary taxonomy code. Armed with the
provider’s NPI, you can search the **NPPES NPI Registry API** with the
`prov_npi_nppes()` function & unpack the results with the
`prov_nppes_unpack()` function:

<br>

``` r
# Load library
library(provider)

# Query the NPPES API
provider_nppes <- prov_npi_nppes(1003026055) |> 
                  prov_nppes_unpack()
```

<br>

As it turns out, `207R00000X` is her secondary taxonomy and `207RE0101X`
should be entered on the claim:

<br>

| NPI        | Last Name | Provider Type | Code       | Primary | Description                                             | State | License    |
|:-----------|:----------|:--------------|:-----------|:--------|:--------------------------------------------------------|:------|:-----------|
| 1003026055 | PHADKE    | NPI-1         | 207R00000X | FALSE   | Internal Medicine                                       | NC    | 201100885  |
| 1003026055 | PHADKE    | NPI-1         | 207RE0101X | TRUE    | Internal Medicine, Endocrinology, Diabetes & Metabolism | NC    | 2011-00885 |

<br>

What if you need the provider’s PECOS PAC ID or their Enrollment ID?
Using the `prov_mcr_ffs()` function, you can search Medicare’s
**Fee-For-Service Public Provider Enrollment API**:

<br>

``` r
provider_ffs <- prov_mcr_ffs(1003026055)
```

<br>

| NPI        | Last Name | PECOS PAC ID | PECOS Enrollment ID | Provider Type                | State |
|:-----------|:----------|:-------------|:--------------------|:-----------------------------|:------|
| 1003026055 | PHADKE    | 4486827367   | I20170403002190     | PRACTITIONER - ENDOCRINOLOGY | FL    |

<br>

Is the provider currently eligible to make referrals to Medicare Part B
or a Home Health Agency (HHA)? Order Durable Medical Equipment (DME) or
Power Mobility Devices (PMDs)? Search Medicare’s **Order and Referring
API** with `prov_mcr_ordref()`:

<br>

``` r
provider_oar <- prov_mcr_ordref(1003026055)
```

<br>

| NPI        | Last Name | First Name | Part B | DME | HHA | PMD |
|:-----------|:----------|:-----------|:-------|:----|:----|:----|
| 1003026055 | PHADKE    | RADHIKA    | Y      | Y   | Y   | Y   |

<br>

You may need to find Medicare’s specialty codes for this provider’s
taxonomies. Using the output from the NPPES search in the first example,
you can search Medicare’s **Provider and Supplier Taxonomy Crosswalk
API** with `prov_mcr_taxcross()`:

<br>

``` r
provider_cross <- provider_nppes |> dplyr::distinct(taxon_code) |> 
                  dplyr::group_split(taxon_code) |> 
                  purrr::map_dfr(prov_mcr_taxcross)
```

<br>

| Taxonomy Code | Medicare Specialty Code | Provider Type               | Taxonomy Class                                                                            |
|:--------------|:------------------------|:----------------------------|:------------------------------------------------------------------------------------------|
| 207R00000X    | 11                      | Physician/Internal Medicine | Allopathic & Osteopathic Physicians/Internal Medicine                                     |
| 207RE0101X    | 11                      | Physician/Internal Medicine | Allopathic & Osteopathic Physicians/Internal Medicine Endocrinology Diabetes & Metabolism |
| 207RE0101X    | 46                      | Physician/Endocrinology     | Allopathic & Osteopathic Physicians/Internal Medicine Endocrinology Diabetes & Metabolism |

<br>

You can check to see if a provider is due to revalidate their Medicare
enrollment by accessing Medicare’s **Revalidation Due Date API** with
`prov_mcr_reval_date()`:

<br>

``` r
provider_due <- prov_mcr_reval_date(1760485387)
```

<br>

| NPI        | Enrollment ID   | Enrollment Type | Last Name | State | Provider Type  | Specialty         | Revalidation Due Date |
|:-----------|:----------------|:----------------|:----------|:------|:---------------|:------------------|:----------------------|
| 1760485387 | I20100505000906 | 3               | Dewey     | MN    | Non-DME Part B | Internal Medicine | 2018-09-30            |

<br>

Providers may need to update their digital contact information in the
NPPES system. To check, you can access the **CMS Public Reporting of
Missing Digital Contact Information API** with `prov_nppes_missing()`:

<br>

``` r
provider_miss <- prov_nppes_missing(1760485387)
```

<br>

| NPI        | Provider Name |
|:-----------|:--------------|
| 1760485387 | Dewey,Paul    |

<br>

You can find out if a provider has opted out of Medicare by searching
the **Medicare Opt Out Affidavits API** with `prov_opt_out()`:

<br>

``` r
provider_opt_out <- prov_opt_out(1114974490)
```

<br>

| NPI        | Optout Effective | Optout End | Updated    | Last    | First | Specialty          | Address          | City     | State | Eligible to Order & Refer |
|:-----------|:-----------------|:-----------|:-----------|:--------|:------|:-------------------|:-----------------|:---------|:------|:--------------------------|
| 1114974490 | 2012-07-01       | 2024-07-01 | 2022-08-15 | Altchek | David | Orthopedic Surgery | 535 EAST 70TH ST | NEW YORK | NY    | Y                         |

<br>

Using `prov_mcr_phys_pract()`, you can access **Medicare’s Physician &
Other Practitioners - by Provider and Service API**:

<br>

``` r
provider_2020 <- prov_mcr_phys_pract(npi = 1003026055, 
                                     year = "2020")
```

<br>

| Year | NPI        | Last Name | City          | State | PAR | HCPCS | Benefits | Services | Avg Billed | Avg Allowed | Avg Payment |
|:-----|:-----------|:----------|:--------------|:------|:----|:------|---------:|---------:|-----------:|------------:|------------:|
| 2020 | 1003026055 | Phadke    | Coconut Creek | FL    | Y   | 36415 |       69 |      108 |      24.00 |        2.92 |        2.92 |
| 2020 | 1003026055 | Phadke    | Coconut Creek | FL    | Y   | 83036 |       24 |       25 |      15.00 |        9.71 |        9.71 |
| 2020 | 1003026055 | Phadke    | Coconut Creek | FL    | Y   | 83037 |       18 |       22 |      15.00 |        9.30 |        9.30 |
| 2020 | 1003026055 | Phadke    | Coconut Creek | FL    | Y   | 95251 |       13 |       27 |     100.00 |       38.34 |       30.67 |
| 2020 | 1003026055 | Phadke    | Coconut Creek | FL    | Y   | 99203 |       32 |       32 |     220.00 |      111.19 |       84.78 |
| 2020 | 1003026055 | Phadke    | Coconut Creek | FL    | Y   | 99204 |       57 |       57 |     284.00 |      173.41 |      130.99 |
| 2020 | 1003026055 | Phadke    | Coconut Creek | FL    | Y   | 99213 |       44 |       63 |     134.00 |       75.34 |       60.18 |
| 2020 | 1003026055 | Phadke    | Coconut Creek | FL    | Y   | 99214 |       61 |      120 |     169.97 |      113.18 |       86.63 |

<br>

This API contains data going back to 2013, so you can perform a
long-term analysis of a provider’s Medicare data:

<br>

``` r
# Retrieve the data from each year
pr2020 <- prov_mcr_phys_pract(1003026055, "2020")
pr2019 <- prov_mcr_phys_pract(1003026055, "2019")
pr2018 <- prov_mcr_phys_pract(1003026055, "2018")
pr2017 <- prov_mcr_phys_pract(1003026055, "2017")
pr2016 <- prov_mcr_phys_pract(1003026055, "2016")
pr2015 <- prov_mcr_phys_pract(1003026055, "2015")
pr2014 <- prov_mcr_phys_pract(1003026055, "2014")
pr2013 <- prov_mcr_phys_pract(1003026055, "2013")

# Bind the data frames together by row
prov_2013_2020 <- dplyr::bind_rows(pr2020, 
                                   pr2019, 
                                   pr2018, 
                                   pr2017, 
                                   pr2016, 
                                   pr2015, 
                                   pr2014, 
                                   pr2013)
```

<br>

| HCPCS | HCPCS Description                                                                                   | Benefits | Services | Avg Charge | Avg Allowed | Avg Payment |
|:------|:----------------------------------------------------------------------------------------------------|---------:|---------:|-----------:|------------:|------------:|
| 36415 | Insertion of needle into vein for collection of blood sample                                        |      316 |      500 |      15.55 |        2.94 |        2.94 |
| 80048 | Blood test, basic group of blood chemicals                                                          |       40 |       58 |      45.00 |       10.33 |       10.33 |
| 80053 | Blood test, comprehensive group of blood chemicals                                                  |      103 |      116 |      50.04 |        9.50 |        9.50 |
| 80061 | Blood test, lipids (cholesterol and triglycerides)                                                  |       53 |       61 |      83.08 |       13.04 |       13.04 |
| 82043 | Urine microalbumin (protein) level                                                                  |       44 |       44 |      37.46 |        7.72 |        7.72 |
| 82044 | Urine microalbumin (protein) analysis, (microalbumin)                                               |       13 |       13 |      30.00 |        3.91 |        3.91 |
| 82570 | Creatinine level to test for kidney function or muscle injury                                       |       55 |       55 |      21.00 |        6.95 |        6.95 |
| 82947 | Blood glucose (sugar) level                                                                         |       30 |       34 |      32.00 |        4.76 |        4.76 |
| 82962 | Blood glucose (sugar) test performed by hand-held instrument                                        |      103 |      117 |      24.00 |        3.02 |        3.02 |
| 83036 | Hemoglobin a1c level                                                                                |       24 |       25 |      15.00 |        9.71 |        9.71 |
| 83036 | Hemoglobin A1C level                                                                                |      240 |      392 |      47.37 |       11.97 |       11.97 |
| 83037 | Hemoglobin a1c level                                                                                |       18 |       22 |      15.00 |        9.30 |        9.30 |
| 83970 | Parathormone (parathyroid hormone) level                                                            |       12 |       19 |     150.00 |       55.18 |       55.18 |
| 84100 | Phosphate level                                                                                     |       15 |       22 |      33.00 |        4.68 |        4.68 |
| 84439 | Thyroxine (thyroid chemical) measurement                                                            |      135 |      186 |      61.82 |       12.08 |       12.08 |
| 84443 | Blood test, thyroid stimulating hormone (TSH)                                                       |      127 |      178 |     105.66 |       21.87 |       21.87 |
| 84481 | Thyroid hormone, T3 measurement                                                                     |       50 |       73 |      49.47 |       22.73 |       22.73 |
| 95251 | Ambulatory continuous glucose (sugar) including interpretation and report for a minimum of 72 hours |       13 |       27 |     100.00 |       38.34 |       30.67 |
| 99203 | New patient office or other outpatient visit, typically 30 minutes                                  |       32 |       32 |     220.00 |      111.19 |       84.78 |
| 99204 | New patient office or other outpatient visit, typically 45 minutes                                  |      285 |      285 |     309.19 |      161.54 |      114.75 |
| 99213 | Established patient office or other outpatient visit, typically 15 minutes                          |      235 |      319 |     138.43 |       71.49 |       52.55 |
| 99214 | Established patient office or other outpatient, visit typically 25 minutes                          |      436 |      813 |     203.13 |      104.44 |       73.61 |
| 99222 | Initial hospital inpatient care, typically 50 minutes per day                                       |       12 |       12 |     292.00 |      143.46 |      114.34 |
| 99223 | Initial hospital inpatient care, typically 70 minutes per day                                       |      146 |      154 |     427.69 |      209.31 |      165.28 |
| 99232 | Subsequent hospital inpatient care, typically 25 minutes per day                                    |      159 |      335 |     152.67 |       74.79 |       59.38 |

<br>

<details>
<summary>
Click for Table Code
</summary>

``` r
gt_table <- prov_2013_2020 |>
  janitor::clean_names() |> 
  dplyr::select(year,
                hcpcs = hcpcs_cd,
                benefits = tot_benes,
                services = tot_srvcs,
                avg_bill = avg_sbmtd_chrg,
                avg_allow = avg_mdcr_alowd_amt,
                avg_pay = avg_mdcr_pymt_amt) |> 
  dplyr::filter(hcpcs != "82044",
                hcpcs != "82947",
                hcpcs != "83037",
                hcpcs != "83970",
                hcpcs != "84100",
                hcpcs != "95251",
                hcpcs != "99203",
                hcpcs != "99222") |> 
  dplyr::group_by(hcpcs) |> 
  dplyr::summarize(
    ben_sum = sum(benefits),
    ben_mean = mean(benefits),
    ben_med = median(benefits),
    ben_spark = list(benefits),
    serv_sum = sum(services),
    serv_mean = mean(services),
    serv_med = median(services),
    serv_spark = list(services),
    char_mean = mean(avg_bill),
    char_med = median(avg_bill),
    char_spark = list(avg_bill),
    all_mean = mean(avg_allow),
    all_med = median(avg_allow),
    all_spark = list(avg_allow),
    pay_mean = mean(avg_pay),
    pay_med = median(avg_pay),
    pay_spark = list(avg_pay),
    .groups = "drop")

gt_table <- gt_table |> 
  gt::gt(groupname_col = "hcpcs") |> 
  gt::tab_header(title = gt::md("**Provider's Medicare Data Summary**: 2013 - 2020"), 
                 subtitle = gt::md("Codes with a Beneficiary count *less than 40* have been excluded.")) |> 
  gtExtras::gt_theme_nytimes() |> 
  gt::tab_options(row_group.as_column = TRUE, footnotes.multiline = TRUE) |> 
  gtExtras::gt_plt_sparkline(ben_spark, type = "ref_iqr", fig_dim = c(5, 30), same_limit = FALSE, palette = c("black", "black", "blue", "green", "red")) |> 
  gtExtras::gt_plt_sparkline(serv_spark, type = "ref_iqr", fig_dim = c(5, 30), same_limit = FALSE, palette = c("black", "black", "blue", "green", "red")) |> 
  gtExtras::gt_plt_sparkline(char_spark, type = "ref_iqr", fig_dim = c(5, 30), same_limit = FALSE, palette = c("black", "black", "blue", "green", "red")) |> 
  gtExtras::gt_plt_sparkline(all_spark, type = "ref_iqr", fig_dim = c(5, 30), same_limit = FALSE, palette = c("black", "black", "blue", "green", "red")) |> 
  gtExtras::gt_plt_sparkline(pay_spark, type = "ref_iqr", fig_dim = c(5, 30), same_limit = FALSE, palette = c("black", "black", "blue", "green", "red")) |> 
  gtExtras::gt_add_divider(columns = c("hcpcs", "ben_spark", "serv_spark", 
                                       "char_spark", "all_spark", "pay_spark"), 
                           style = "dotted", color = "gray") |> 
  gt::fmt_number(columns = c(ben_mean:ben_med, serv_mean:serv_med), decimals = 0) |> 
  gt::fmt_currency(columns = c(char_mean:char_med, all_mean:all_med, pay_mean:pay_med), currency = "USD") |> 
  gt::tab_spanner(label = "Beneficiaries", id = "ben", columns = c(ben_sum, ben_mean, ben_med, ben_spark)) |> 
  gt::tab_spanner(label = "Services", id = "serv", columns = c(serv_sum, serv_mean, serv_med, serv_spark)) |> 
  gt::tab_spanner(label = "Submitted Charge", columns = c(char_mean, char_med, char_spark)) |> 
  gt::tab_spanner(label = "Allowed Amount", columns = c(all_mean, all_med, all_spark)) |> 
  gt::tab_spanner(label = "Payment", columns = c(pay_mean, pay_med, pay_spark)) |> 
  gt::cols_label(ben_sum = "Count", ben_mean = "Mean", ben_med = "Median", ben_spark = "Trend") |> 
  gt::cols_label(serv_sum = "Count", serv_mean = "Mean", serv_med = "Median", serv_spark = "Trend") |> 
  gt::cols_label(char_mean = "Mean", char_med = "Median", char_spark = "Trend") |> 
  gt::cols_label(all_mean = "Mean", all_med = "Median", all_spark = "Trend") |> 
  gt::cols_label(pay_mean = "Mean", pay_med = "Median", pay_spark = "Trend") |> 
  gt::tab_source_note(source_note = gt::md("Data Source: *Physician & Other Practitioners: by Provider and Service* (2013 - 2020). **Medicare.**")) |> 
  gt::tab_footnote(footnote = gt::md("Number of *distinct* Medicare beneficiaries receiving the service for each HCPCS code."), 
                   locations = gt::cells_column_spanners(spanners = "ben")) |> 
  gt::tab_footnote(footnote = gt::md("Number of services provided. *Note: The metrics used to count the number provided can vary from service to service.*"), 
                   locations = gt::cells_column_spanners(spanners = "serv")) |> 
  gt::opt_table_outline() |> 
  gt::opt_stylize(style = 1, color = "red", add_row_striping = TRUE) |> 
  gtExtras::gt_color_rows(ben_sum) |> 
  gtExtras::gt_color_rows(serv_sum) |> 
  gtExtras::gt_color_rows(char_mean) |> 
  gtExtras::gt_color_rows(all_mean) |> 
  gtExtras::gt_color_rows(pay_mean)

gt_table |> gt::gtsave("gt_provider.png", expand = 20, zoom = 2, vwidth = 1500)
```

</details>

<br>

<img src="man/figures/gt_provider.png" style="width:100.0%" />

<br> <br>

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
