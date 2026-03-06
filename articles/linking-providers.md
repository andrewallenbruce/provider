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

    #> Error in `dplyr::mutate()`:
    #> ℹ In argument: `dplyr::across(dplyr::where(is.character), na_blank)`.
    #> Caused by error:
    #> ! object 'na_blank' not found

  

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

    #> Error in `select()`:
    #> ! Can't select columns that don't exist.
    #> ✖ Column `reh_conversion` doesn't exist.

  

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r
providers(organization = "Elizabethtown Community Hospital") |> 
  gt_preview(top_n = 10) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono"))
```

    #> Error in `dplyr::mutate()`:
    #> ℹ In argument: `dplyr::across(dplyr::where(is.character), na_blank)`.
    #> Caused by error:
    #> ! object 'na_blank' not found

``` r
hospitals(organization = "Elizabethtown Community Hospital") |> 
  gt_preview(top_n = 10) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono"))
```

    #> Error in `dplyr::mutate()`:
    #> ℹ In argument: `dplyr::across(dplyr::where(is.character), na_blank)`.
    #> Caused by error:
    #> ! object 'na_blank' not found

  

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

|         | npi        | pac        | first            | middle  | last   | suffix | facility_type | parent_ccn | facility_ccn |
|---------|------------|------------|------------------|---------|--------|--------|---------------|------------|--------------|
| 1       | 1003845272 | 1759384035 | GREENE           | LAURA   | A      |        | Hospital      | 331302     |              |
| 2       | 1013141860 | 8022069558 | KAMPSCHROR       | DEBORAH | M      |        | Hospital      | 331302     |              |
| 3       | 1013539584 | 9133544109 | VASSILIAN        | NAROD   |        |        | Hospital      | 331302     |              |
| 4       | 1013595560 | 3375947401 | TRIPLETT         | EMILY   |        |        | Hospital      | 331302     |              |
| 5       | 1013910256 | 5890719371 | ACOSTAMADIEDO    | JOSE    | M      |        | Hospital      | 331302     |              |
| 6       | 1023377843 | 6901115278 | WILHELM          | LINDSEY | B      |        | Hospital      | 331302     |              |
| 7       | 1043672140 | 7214229350 | FIORINI FURTADO  | VANESSA |        |        | Hospital      | 331302     |              |
| 8       | 1063420891 | 9436051687 | YOUNG            | JOHN    |        |        | Hospital      | 331302     |              |
| 9       | 1073073177 | 0547593097 | OSBORN           | DELANEY |        |        | Hospital      | 331302     |              |
| 10      | 1073133435 | 6800318452 | GILL             | ANGAD   |        |        | Hospital      | 331302     |              |
| 11      | 1073258398 | 3870095805 | KLOTZ            | JEFFREY |        |        | Hospital      | 331302     |              |
| 12      | 1073572236 | 7012816168 | RHEEMAN          | CHARLES | H      |        | Hospital      | 331302     |              |
| 13      | 1073634531 | 9234285487 | GILBERT          | MATTHEW | P      |        | Hospital      | 331302     |              |
| 14      | 1073660684 | 1759418007 | BIGELOW          | GAYLEN  | M      |        | Hospital      | 331302     |              |
| 15      | 1083148837 | 0042564882 | KRULEWITZ        | NEIL    | A      |        | Hospital      | 331302     |              |
| 16      | 1083861934 | 2860555141 | ELLIOTT          | STEVEN  | J      |        | Hospital      | 331302     |              |
| 17      | 1083887137 | 8921256520 | WALSH            | RYAN    |        |        | Hospital      | 331302     |              |
| 18      | 1093386070 | 3476085051 | GADELHA PIEROTTI | ELISSA  | JENSEN |        | Hospital      | 331302     |              |
| 19      | 1093796898 | 5597848077 | MAHONEY          | ANDREW  | C      |        | Hospital      | 331302     |              |
| 20      | 1104118330 | 0547408825 | BROWN            | JODI    | AU     |        | Hospital      | 331302     |              |
| 21..205 |            |            |                  |         |        |        |               |            |              |
| 206     | 1992993794 | 7113172685 | DAVIS            | ELLEN   |        |        | Hospital      | 331302     |              |

  

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r
affiliations(facility_ccn = "33Z302") |> 
  gt_preview(top_n = 10) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono"))
```

|     | npi        | pac        | first    | middle  | last | suffix | facility_type | parent_ccn | facility_ccn |
|-----|------------|------------|----------|---------|------|--------|---------------|------------|--------------|
| 1   | 1073258398 | 3870095805 | KLOTZ    | JEFFREY |      |        | Nursing home  | 33Z302     | 331302       |
| 2   | 1396989059 | 8921259557 | HALLORAN | MARY    | K    |        | Nursing home  | 33Z302     | 331302       |
| 3   | 1538173869 | 0547299091 | CHON     | IL      | JUN  |        | Nursing home  | 33Z302     | 331302       |
| 4   | 1558659367 | 6709004682 | BANU     | DRAGOS  |      |        | Nursing home  | 33Z302     | 331302       |

  

That returns more affiliated individual providers that practice in the
Hospital’s nursing home..

  

> An *alphanumeric* CCN represents a sub-unit of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
