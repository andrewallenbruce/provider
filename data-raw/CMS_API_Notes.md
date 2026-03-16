---
title: "API Notes"
editor_options: 
  chunk_output_type: console
output: 
  html_document: 
    toc: true
    toc_depth: 5
    highlight: zenburn
    theme: united
    keep_md: true
    df_print: tibble
---



## CMS

   - [data.CMS.gov API FAQ]("https://data.cms.gov/sites/default/files/2024-10/7ef65521-65a4-41ed-b600-3a0011f8ec4b/API%20Guide%20Formatted%201_6.pdf")

### Overview

   1. Dataset API endpoints have this structure:

      ```json
      https://data.cms.gov/data-api/v1/dataset/{{dataset_id}}/data
      ```

   2. The system uses the [JSONAPI](https://jsonapi.org/) query syntax:

      ```json
      ?filter[field_name]=value&filter[field_other]=value
      ```

<br>

### Examples

   - __EQUALS__:
   
      ```yaml
      dataset: "Medicare FFS Provider Enrollment"
        code: filter(PROVIDER_TYPE_DESC == "PRACTITIONER - GENERAL PRACTICE")
          query: >
             https://data.cms.gov/data-api/v1/dataset/
             2457ea29-fc82-48b0-86ec-3b0755de7515/data?
             filter[PROVIDER_TYPE_DESC]=PRACTITIONER%20-%20GENERAL%20PRACTICE
      ```
   - __CONTAINS__:
   
      ```yaml
      dataset: "Medicare FFS Provider Enrollment"
        code: grepl(PROVIDER_TYPE_DESC, "SUPPLIER")
          query: >
             https://data.cms.gov/data-api/v1/dataset/
             2457ea29-fc82-48b0-86ec-3b0755de7515/data?
             filter[example][condition][path]=PROVIDER_TYPE_DESC&
             filter[example][condition][operator]=CONTAINS&
             filter[example][condition][value]=SUPPLIER
      ```
   - __CONTAINS & EQUALS__:
   
      ```yaml
      dataset: "Medicare FFS Provider Enrollment"
        code: filter(STATE_CD == "MD" & grepl(PROVIDER_TYPE_DESC, "PRACTITIONER"))
          query: >
             https://data.cms.gov/data-api/v1/dataset/
             2457ea29-fc82-48b0-86ec-3b0755de7515/data?
             filter[filter-1][condition][path]=PROVIDER_TYPE_DESC&
             filter[filter-1][condition][operator]=CONTAINS&
             filter[filter-1][condition][value]=PRACTITIONER&
             filter[filter-2][condition][path]=STATE_CD&
             filter[filter-2][condition][operator]==&
             filter[filter-2][condition][value]=MD
      ```
<br>

### __Outputs__: `/data?` _vs._ `/data-viewer?`

`/data?` returns a `data.frame` with column names:


``` r
paste0(
  "https://data.cms.gov/data-api/v1/dataset/",
  "2457ea29-fc82-48b0-86ec-3b0755de7515/data?",
  "filter[PROVIDER_TYPE_DESC]=PRACTITIONER%20-%20GENERAL%20PRACTICE"
) |> 
httr2::request() |> 
  httr2::req_perform() |> 
  provider:::parse_string() |> 
  fastplyr::as_tbl() |> 
  head()
# A tibble: 6 × 11
  NPI        MULTIPLE_NPI_FLAG PECOS_ASCT_CNTL_ID ENRLMT_ID     PROVIDER_TYPE_CD
  <chr>      <chr>             <chr>              <chr>         <chr>           
1 1497881189 N                 1254243959         I20031103000… 14-01           
2 1396775714 N                 2961314661         I20031103000… 14-01           
3 1558464982 N                 9133031834         I20031103000… 14-01           
4 1477524981 N                 4486566114         I20031103000… 14-01           
5 1316041775 N                 9537071113         I20031103000… 14-01           
6 1891846697 N                 7012829625         I20031103000… 14-01           
# ℹ 6 more variables: PROVIDER_TYPE_DESC <chr>, STATE_CD <chr>,
#   FIRST_NAME <chr>, MDL_NAME <chr>, LAST_NAME <chr>, ORG_NAME <chr>
```

While `/data-viewer?` returns a `matrix`, no column names:


``` r
x <- paste0(
  "https://data.cms.gov/data-api/v1/dataset/",
  "2457ea29-fc82-48b0-86ec-3b0755de7515/data-viewer?",
  "filter[PROVIDER_TYPE_DESC]=PRACTITIONER%20-%20GENERAL%20PRACTICE"
) |> 
httr2::request() |> 
  httr2::req_perform() |> 
  provider:::parse_string()

fastplyr::new_tbl(
 npi = x$data[, 1],
 multi = x$data[, 2],
 pac = x$data[, 3],
 enid = x$data[, 4],
 pr_code = x$data[, 5],
 pr_type = x$data[, 6],
 state = x$data[, 7],
 first = x$data[, 8],
 middle = x$data[, 9],
 last = x$data[, 10],
 org = x$data[, 11]
)
# A tibble: 100 × 11
   npi        multi pac     enid  pr_code pr_type state first middle last  org  
   <chr>      <chr> <chr>   <chr> <chr>   <chr>   <chr> <chr> <chr>  <chr> <chr>
 1 1497881189 N     125424… I200… 14-01   PRACTI… PR    ELVIA "AREL… AYALA ""   
 2 1396775714 N     296131… I200… 14-01   PRACTI… PR    RAMON ""     PEREZ ""   
 3 1558464982 N     913303… I200… 14-01   PRACTI… PR    LUIS  ""     ARTA… ""   
 4 1477524981 N     448656… I200… 14-01   PRACTI… PR    JUANA ""     FIGU… ""   
 5 1316041775 N     953707… I200… 14-01   PRACTI… PR    EMIL… ""     ENCA… ""   
 6 1891846697 N     701282… I200… 14-01   PRACTI… PR    HILDA "M"    VELE… ""   
 7 1982645057 N     478959… I200… 14-01   PRACTI… PR    LEMU… "O"    SOTO… ""   
 8 1619927621 N     791181… I200… 14-01   PRACTI… PR    ZULMA ""     FERN… ""   
 9 1609894237 N     600272… I200… 14-01   PRACTI… PR    MARIA "A"    GARC… ""   
10 1457368847 N     711383… I200… 14-01   PRACTI… PR    JORGE "L"    GONZ… ""   
# ℹ 90 more rows
```

<br>

> Also, requests with `%20` encoded spaces seem to be faster than those with `+` encoded spaces.

<br>

## Provider

Which query modifiers work?


``` r
clinicians(first = starts_with("J")) |> _$first |> collapse::funique()
✔ `clinicians()` returned 187 results.
[1] "J"
clinicians(first = contains("J"), count = TRUE)
✔ `clinicians()` returned 187 results.
```



``` r
contains_url <- paste0(
  "https://data.cms.gov/provider-data/api/1/datastore/query/mj5m-pzi6/0?",
  "schema=false&",
  "keys=true&",
  "results=true&",
  "count=true&",
  "format=json&",
  "rowIds=false&",
  "limit=10&",
  "offset=0&",
  "conditions[0][property]=provider_first_name&",
  "conditions[0][operator]=contains&",
  "conditions[0][value]=JO"
)
contains_url |> 
  urlparse::url_encoder(safe = ":/=&?") |> 
  httr2::request() |> 
  httr2::req_perform() |> 
  provider:::parse_string() |> 
  _$results |> 
  _$provider_first_name |> 
  collapse::funique()
[1] "JON"      "JONATHAN" "JOSEPH"   "JONATHON"

contains_url |> 
  httr2::url_modify_query(`conditions[0][operator]` = "starts with") |> 
  httr2::request() |> 
  httr2::req_perform() |> 
  provider:::parse_string() |> 
  _$results |> 
  _$provider_first_name |> 
  collapse::funique()
[1] "JON"      "JONATHAN" "JOSEPH"   "JONATHON"

contains_url |> 
  httr2::url_modify_query(`conditions[0][operator]` = "ENDS_WITH") |> 
  httr2::request() |> 
  httr2::req_perform() |> 
  provider:::parse_string() |> 
  _$results |> 
  _$provider_first_name |> 
  collapse::funique()
Error in `httr2::req_perform()` at provider/R/url-httr2.R:8:5:
! HTTP 400 Bad Request.

contains_url |> 
  httr2::url_modify_query(`conditions[0][operator]` = "=") |> 
  httr2::request() |> 
  httr2::req_perform() |> 
  provider:::parse_string() |> 
  _$results |> 
  _$provider_first_name |> 
  collapse::funique()
[1] "JO"

contains_url |> 
  httr2::url_modify_query(`conditions[0][operator]` = "like") |> 
  httr2::request() |> 
  httr2::req_perform() |> 
  provider:::parse_string() |> 
  _$results |> 
  _$provider_first_name |> 
  collapse::funique()
[1] "JO"
```

