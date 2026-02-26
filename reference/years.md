# Years Currently Searchable for APIs

Years Currently Searchable for APIs

## Usage

``` r
open_years()

out_years()

rx_years()

util_years()

qpp_years()

bene_years(period = c("Year", "Month"))
```

## Arguments

- period:

  `<chr>` One of `"Year"` or `"Month"`

## Value

integer vector of years available to search

## Examples

``` r
if (FALSE) { # interactive()
# `beneficiaries()`
bene_years(period = "Year")

bene_years(period = "Month")

# `open_payments()`
open_years()

# `utilization()`
util_years()

# `quality_payment()`
qpp_years()

# `outpatient()`
out_years()

# `prescribers()`
rx_years()
}
```
