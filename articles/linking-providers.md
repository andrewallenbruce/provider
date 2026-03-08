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

    #> Error in `map()`:
    #> ℹ In index: 1.
    #> Caused by error in `hospitals()`:
    #> ! object 'sg' not found

  

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r
providers(organization = "Elizabethtown Community Hospital") |> 
  gt_preview(top_n = 10) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono"))
```

    #> Error in `providers()`:
    #> ! unused argument (organization = "Elizabethtown Community Hospital")

``` r
hospitals(organization = "Elizabethtown Community Hospital") |> 
  gt_preview(top_n = 10) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono"))
```

    #> Error in `hospitals()`:
    #> ! object 'sg' not found

  

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

|         | npi        | pac        | last             | first   | middle | suffix | facility_type | facility_ccn | parent_ccn |
|---------|------------|------------|------------------|---------|--------|--------|---------------|--------------|------------|
| 1       | 1003845272 | 1759384035 | GREENE           | LAURA   | A      | NA     | Hospital      | 331302       | NA         |
| 2       | 1013141860 | 8022069558 | KAMPSCHROR       | DEBORAH | M      | NA     | Hospital      | 331302       | NA         |
| 3       | 1013539584 | 9133544109 | VASSILIAN        | NAROD   | NA     | NA     | Hospital      | 331302       | NA         |
| 4       | 1013595560 | 3375947401 | TRIPLETT         | EMILY   | NA     | NA     | Hospital      | 331302       | NA         |
| 5       | 1013910256 | 5890719371 | ACOSTAMADIEDO    | JOSE    | M      | NA     | Hospital      | 331302       | NA         |
| 6       | 1023377843 | 6901115278 | WILHELM          | LINDSEY | B      | NA     | Hospital      | 331302       | NA         |
| 7       | 1043672140 | 7214229350 | FIORINI FURTADO  | VANESSA | NA     | NA     | Hospital      | 331302       | NA         |
| 8       | 1063420891 | 9436051687 | YOUNG            | JOHN    | NA     | NA     | Hospital      | 331302       | NA         |
| 9       | 1073073177 | 0547593097 | OSBORN           | DELANEY | NA     | NA     | Hospital      | 331302       | NA         |
| 10      | 1073133435 | 6800318452 | GILL             | ANGAD   | NA     | NA     | Hospital      | 331302       | NA         |
| 11      | 1073258398 | 3870095805 | KLOTZ            | JEFFREY | NA     | NA     | Hospital      | 331302       | NA         |
| 12      | 1073572236 | 7012816168 | RHEEMAN          | CHARLES | H      | NA     | Hospital      | 331302       | NA         |
| 13      | 1073634531 | 9234285487 | GILBERT          | MATTHEW | P      | NA     | Hospital      | 331302       | NA         |
| 14      | 1073660684 | 1759418007 | BIGELOW          | GAYLEN  | M      | NA     | Hospital      | 331302       | NA         |
| 15      | 1083148837 | 0042564882 | KRULEWITZ        | NEIL    | A      | NA     | Hospital      | 331302       | NA         |
| 16      | 1083861934 | 2860555141 | ELLIOTT          | STEVEN  | J      | NA     | Hospital      | 331302       | NA         |
| 17      | 1083887137 | 8921256520 | WALSH            | RYAN    | NA     | NA     | Hospital      | 331302       | NA         |
| 18      | 1093386070 | 3476085051 | GADELHA PIEROTTI | ELISSA  | JENSEN | NA     | Hospital      | 331302       | NA         |
| 19      | 1093796898 | 5597848077 | MAHONEY          | ANDREW  | C      | NA     | Hospital      | 331302       | NA         |
| 20      | 1104118330 | 0547408825 | BROWN            | JODI    | AU     | NA     | Hospital      | 331302       | NA         |
| 21..205 |            |            |                  |         |        |        |               |              |            |
| 206     | 1992993794 | 7113172685 | DAVIS            | ELLEN   | NA     | NA     | Hospital      | 331302       | NA         |

  

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r
affiliations(facility_ccn = "33Z302") |> 
  gt_preview(top_n = 10) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono"))
```

|     | npi        | pac        | last     | first   | middle | suffix | facility_type | facility_ccn | parent_ccn |
|-----|------------|------------|----------|---------|--------|--------|---------------|--------------|------------|
| 1   | 1073258398 | 3870095805 | KLOTZ    | JEFFREY | NA     | NA     | Nursing home  | 33Z302       | 331302     |
| 2   | 1396989059 | 8921259557 | HALLORAN | MARY    | K      | NA     | Nursing home  | 33Z302       | 331302     |
| 3   | 1538173869 | 0547299091 | CHON     | IL      | JUN    | NA     | Nursing home  | 33Z302       | 331302     |
| 4   | 1558659367 | 6709004682 | BANU     | DRAGOS  | NA     | NA     | Nursing home  | 33Z302       | 331302     |

  

That returns more affiliated individual providers that practice in the
Hospital’s nursing home..

  

> An *alphanumeric* CCN represents a sub-unit of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
