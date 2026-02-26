# CMS API Dataset Names Lookup

CMS API Dataset Names Lookup

## Usage

``` r
api_names(fn_name = "all")
```

## Arguments

- fn_name:

  `<chr>` function name, can be a regex pattern; default is `"all"`

## Value

`<chr>` API dataset name

## Examples

``` r
if (FALSE) { # rlang::is_interactive()
api_names("quality_payment")

api_names("utilization")

api_names("provider")

api_names("provider$")
}
```
