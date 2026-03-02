# Mapping Providers

## Load Packages

``` r
library(provider)
library(dplyr)
library(purrr)
library(tidygeocoder)
library(tigris)
library(rmapshaper)
library(ggplot2)
library(sf)
```

## Retrieve Addresses of all RHCs in Georgia

``` r
rhcs <- providers(
  state = "GA", 
  specialty_code = "00-17") |> 
  pull(npi) |> 
  map_dfr(\(x) nppes(npi = x)) |> 
  select(
    organization, 
    address:zip) |> 
  mutate(
    address = paste0(
      address, " ", 
      city, ", ", 
      state),
    city = NULL,
    state = NULL) |> 
  distinct()

rhcs
```

    #> # A tibble: 81 × 3
    #>    organization                                  address                   zip  
    #>    <chr>                                         <chr>                     <chr>
    #>  1 TMC HARALSON FAMILY HEALTHCARE CENTER         204 ALLEN MEMORIAL DR SU… 3011…
    #>  2 TMC TALLAPOOSA FAMILY HEALTHCARE CENTER       25 W LYON ST TALLAPOOSA,… 3017…
    #>  3 HIAWASSEE FAMILY PRACTICE P C                 386 BELAIRE DR HIAWASSEE… 3054…
    #>  4 TMC WEST CARROLL FAMILY HEALTHCARE CENTER INC 1125 E HIGHWAY 166 BOWDO… 3010…
    #>  5 BACON COUNTY HEALTH SERVICES, INC             204 E 15TH ST ALMA, GA    3151…
    #>  6 BOWDON- MT. ZION PRIMARY HEALTH CENTER ,INC.  41 WELLINGTON MILL RD WH… 3018…
    #>  7 HOSPITAL AUTHORITY OF MITCHELL COUNTY         25 PERRY ST CAMILLA, GA   3173…
    #>  8 THE MEDICAL CENTER OF ELBERTON, LLP           109 COLLEGE AVE ELBERTON… 3063…
    #>  9 UNION COUNTY HOSPITAL AUTHORITY               162 HOSPITAL RD STE A BL… 3051…
    #> 10 HOSPITAL AUTHORITY OF MITCHELL COUNTY         259 US HIGHWAY 19 NORTH … 3173…
    #> # ℹ 71 more rows

## Geocode with `{tidygeocoder}`

``` r
mapbox <- geocode(
  rhcs,
  address = address,
  method = 'mapbox', 
  full_results = TRUE) |> 
  select(organization:long)
```

## Retrieve Georgia counties shapefile from `{tigris}`

``` r
sf_cnt <- counties(
  state = "GA",
  year = 2022,
  progress_bar = FALSE) |>
  ms_simplify()

sf_cnt$mid <- st_centroid(sf_cnt$geometry)
```

## Map with `{ggplot}`

``` r
ggplot(sf_cnt) +
  geom_sf(
    fill = "skyblue",
    colour = "white",
    alpha = 0.5) +
  geom_sf_text(
    aes(geometry = mid, 
        label = NAME),
    size = 3.5,
    check_overlap = TRUE) +
  geom_jitter(
    data = mapbox,
    mapping = aes(long, lat),
    fill = "yellow",
    color = "darkred",
    alpha = 0.75,
    size = 4,
    shape = 21,
    stroke = 1) +
  theme_void()
```

![](geospatial_files/figure-html/unnamed-chunk-5-1.png)
