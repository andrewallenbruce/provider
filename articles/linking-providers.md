# Linking Providers

``` r
library(provider)
library(vctrs)
library(dplyr)
library(purrr)
library(gt)
```

  

## Individual Provider

``` r
vctrs::vec_rbind(
  display_long(providers(pac = 7810891009)) |> tibble::add_column(source = "`providers()`"),
  display_long(reassignments(pac = 7810891009)) |> tibble::add_column(source = "`reassignments()`"),
  display_long(clinicians(pac = 7810891009)) |> tibble::add_column(source = "`clinicians()`"),
  display_long(nppes(npi = 1043245657)) |> tibble::add_column(source = "`nppes()`"),
  display_long(order_refer(npi = 1043245657)) |> tibble::add_column(source = "`order_refer()`")) |> 
  distinct(name, value, .keep_all = TRUE) |> 
  gt(groupname_col = "source", 
     row_group_as_column = TRUE, process_md = TRUE) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono")) |> 
  tab_options(column_labels.hidden = TRUE, 
              table.width = px(600),
              heading.background.color = "black",
              heading.align = "left", 
              stub_row_group.font.weight = "bold") |> 
  tab_header(title = md("**PROVIDER**: Mark K. Fung, M.D.")) |> 
  opt_horizontal_padding(scale = 2) |> 
  opt_all_caps()
```

    #> Error in `httr2::req_perform()`:
    #> ! HTTP 400 Bad Request.
    #> ℹ Invalid query string.

  

``` r
affiliations(pac = 7810891009) |> 
  pull(facility_ccn) |>
  map_dfr(~hospitals(facility_ccn = .x)) |> 
  select(-reh_conversion) |> 
  display_long(cols = !organization) |> 
  filter(!is.na(value)) |> 
  gt(groupname_col = "organization", 
     row_group_as_column = TRUE) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono")) |> 
  tab_options(column_labels.hidden = TRUE, 
              table.width = px(800),
              heading.background.color = "black",
              heading.align = "left", 
              stub_row_group.font.weight = "bold") |> 
  tab_header(title = md("**FACILITY** AFFILIATIONS")) |> 
  opt_horizontal_padding(scale = 2) |> 
  opt_all_caps()
```

    #> Error in `affiliations()`:
    #> ! unused argument (pac = 7810891009)

  

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r
providers(organization = "Elizabethtown Community Hospital") |> 
  gt_preview(top_n = 10) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono"))
```

|     | npi        | pac        | enid            | specialty_code | specialty_description                        | state | organization                     |
|-----|------------|------------|-----------------|----------------|----------------------------------------------|-------|----------------------------------|
| 1   | 1053656744 | 3577554138 | O20040521000534 | 12-70          | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | NY    | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 2   | 1891785184 | 3577554138 | O20101110000259 | 00-85          | PART A PROVIDER - CRITICAL ACCESS HOSPITAL   | NY    | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 3   | 1487923637 | 3577554138 | O20190719002511 | 12-59          | PART B SUPPLIER - AMBULANCE SERVICE SUPPLIER | NY    | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 4   | 1407061591 | 3577554138 | O20220827000145 | 00-85          | PART A PROVIDER - CRITICAL ACCESS HOSPITAL   | NY    | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 5   | 1053656744 | 3577554138 | O20240508002551 | 12-70          | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | CT    | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 6   | 1053656744 | 3577554138 | O20240509001572 | 12-70          | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | FL    | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 7   | 1053656744 | 3577554138 | O20240515002137 | 12-70          | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | VT    | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 8   | 1053656744 | 3577554138 | O20250909000919 | 12-70          | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | NH    | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 9   | 1053656744 | 3577554138 | O20250912004448 | 12-70          | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | CO    | ELIZABETHTOWN COMMUNITY HOSPITAL |

``` r
hospitals(organization = "Elizabethtown Community Hospital") |> 
  gt_preview(top_n = 10) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono"))
```

|     | npi_org    | pac_org    | enid_org        | enid_state | facility_ccn | organization                     | specialty_code | specialty                                  | incorp_date | incorp_state | structure   | address    | city          | state | zip       | location_type                    | registration | multi_npi | reh_conversion | subgroup |
|-----|------------|------------|-----------------|------------|--------------|----------------------------------|----------------|--------------------------------------------|-------------|--------------|-------------|------------|---------------|-------|-----------|----------------------------------|--------------|-----------|----------------|----------|
| 1   | 1891785184 | 3577554138 | O20101110000259 | NY         | 331302       | ELIZABETHTOWN COMMUNITY HOSPITAL | 00-85          | PART A PROVIDER - CRITICAL ACCESS HOSPITAL | 1926-05-08  | NY           | CORPORATION | 75 PARK ST | ELIZABETHTOWN | NY    | 129322300 | OTHER HOSPITAL PRACTICE LOCATION | Non-Profit   | TRUE      | FALSE          | None     |
| 2   | 1407061591 | 3577554138 | O20220827000145 | NY         | 33Z302       | ELIZABETHTOWN COMMUNITY HOSPITAL | 00-85          | PART A PROVIDER - CRITICAL ACCESS HOSPITAL | 1926-05-08  | NY           | CORPORATION | 75 PARK ST | ELIZABETHTOWN | NY    | 129322300 | OTHER HOSPITAL PRACTICE LOCATION | Non-Profit   | FALSE     | FALSE          | None     |

  

The **Hospital Enrollment** API includes only Medicare Part A (hospital)
providers, so we only get two rows back, but those include a new data
point: two facility CCNs. Plugging those into the **Facility
Affiliations** API, we can retrieve information on the individual
providers practicing at this hospital. First, the all-numeric CCN
(`331302`):

  

``` r
affiliations(facility_ccn = 331302) |> 
  gt_preview(top_n = 20) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono"))
```

    #> Error in `affiliations()`:
    #> ! unused argument (facility_ccn = 331302)

  

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r
affiliations(facility_ccn = "33Z302") |> 
  gt_preview(top_n = 10) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono"))
```

    #> Error in `affiliations()`:
    #> ! unused argument (facility_ccn = "33Z302")

  

That returns more affiliated individual providers that practice in the
Hospital’s nursing home..

  

> An *alphanumeric* CCN represents a sub-unit of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
