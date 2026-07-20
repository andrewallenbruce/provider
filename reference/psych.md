# Inpatient Psychiatric Facilities

This dataset includes provider-level data for quality measures included
under the IPFQR program, including HBIPS, SUB, TOB, Transition Record
(TR), Screening for Metabolic Disorders (SMD), FAPH, IMM, Readmissions
(READM), and Medication Continuation (MedCont, formerly known as
MedCoPsy). Psychiatric facilities that are eligible for the Inpatient
Psychiatric Facility Quality Reporting (IPFQR) program are required to
meet all program requirements, otherwise their Medicare payments may be
reduced.

## Usage

``` r
psych(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  rating = NULL,
  count = FALSE
)
```

## Source

- [API: Inpatient Psychiatric Facility Quality Measure Data - by
  Facility](https://data.cms.gov/provider-data/dataset/q9vs-r7wp)

## Arguments

- ccn:

  `<chr>` desc

- name:

  `<chr>` desc

- city, state, zip, county:

  `<chr>` desc

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
psych(count = TRUE)
#> ◼ psych | 1,424 rows | 1 pages
psych(state = "GA")
#> ✔ psych returned 41 results
#> ✔ Retrieving 1 page
#> # A tibble: 41 × 7
#>    ccn    name                                  address city  state zip   county
#>    <chr>  <chr>                                 <chr>   <chr> <chr> <chr> <chr> 
#>  1 110002 UPSON REGIONAL MEDICAL CENTER         801 W … THOM… GA    30286 UPSON 
#>  2 110003 Memorial Satilla Health               1900 T… WAYC… GA    31501 WARE  
#>  3 110007 PHOEBE PUTNEY MEMORIAL HOSPITAL       417 TH… ALBA… GA    31703 DOUGH…
#>  4 110015 TANNER MEDICAL CENTER VILLA RICA      601 DA… VILL… GA    30180 CARRO…
#>  5 110029 NORTHEAST GEORGIA MEDICAL CENTER, INC 743 SP… GAIN… GA    30501 HALL  
#>  6 110038 ARCHBOLD MEMORIAL HOSPITAL            915 GO… THOM… GA    31792 THOMAS
#>  7 110054 ATRIUM HEALTH FLOYD MEDICAL CENTER    304 TU… ROME  GA    30162 FLOYD 
#>  8 110071 APPLING HEALTHCARE                    163 E … BAXL… GA    31513 APPLI…
#>  9 110073 DORMINY MEDICAL CENTER                200 PE… FITZ… GA    31750 BEN H…
#> 10 110079 GRADY MEMORIAL HOSPITAL               80 JES… ATLA… GA    30303 FULTON
#> # ℹ 31 more rows
```
