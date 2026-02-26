# Tidy a Data Frame

Tidy a Data Frame

## Usage

``` r
tidyup(
  df,
  dtype = NULL,
  dt = "date",
  yn = NULL,
  int = NULL,
  dbl = NULL,
  chr = NULL,
  up = NULL,
  cred = NULL,
  zip = NULL,
  lgl = NULL,
  cma = NULL
)
```

## Arguments

- df:

  data frame

- dtype:

  `mdy` or `ymd`

- dt:

  convert to date, default is 'date'

- yn:

  convert to logical

- int:

  convert to integer

- dbl:

  convert to double

- chr:

  convert to character

- up:

  convert to upper case

- cred:

  remove periods

- zip:

  normalize zip code

- lgl:

  convert to logical

- cma:

  remove commas

## Value

tidy data frame
