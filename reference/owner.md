# Owners

Owners of facilities enrolled in Medicare.

## Usage

``` r
owner(
  fac_type = NULL,
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  pac = NULL,
  owner = NULL,
  dba = NULL,
  percent = NULL,
  role = NULL,
  entity = NULL,
  first = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE
)
```

## Source

Medicare

## Arguments

- fac_type:

  `<enum>` Facility type; if NULL (default), will search all:

  - `HHA` = Home Health Agency

  - `RHC` = Rural Health Clinic

  - `FQHC` = Federally Qualified Health Clinic

  - `SNF` = Skilled Nursing Facility

  - `Hospice` = Hospice

  - `Hospital` = Hospital

- org_enid:

  `<chr>` National Provider Identifier

- org_pac:

  `<chr>` Provider's name

- org_name:

  `<chr>` Provider's name

- pac:

  `<chr>` Provider's name

- owner:

  `<chr>` Provider's name

- dba:

  `<chr>` Provider's name

- percent:

  `<dbl>` Provider's name

- role:

  `<chr>` Provider's name

- entity:

  `<enum>` Provider's name

- first, last:

  `<chr>` Provider's name

- title:

  `<chr>` Provider's name

- address, city, state, zip:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

## Examples

``` r
owner(city = "Valdosta", state = "GA")
#> ✔ owner returned 13 results
#> ✔ Retrieving 4 pages
#> Error in collapse::recode_char(x[["own_type"]], acq_ind = "Acquisition",     corp_ind = "Corp", llc_ind = "LLC", mps_ind = "Prov/Supp",     msr_ind = "Mgmt", mst_ind = "Staff", hld_ind = "Holding",     inv_ind = "Investment", fin_ind = "Bank", con_ind = "Consult",     fp_ind = "For-Profit", np_ind = "Non-Profit", pe_ind = "PE",     reit_ind = "Real Estate", cho_ind = "Chain", oth_ind = "Other",     ano_ind = "Another Org/Ind", default = NA_character_, set = TRUE): X needs to be character or a list
```
