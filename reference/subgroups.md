# Hospital Subgroups

Hospital Subgroups

## Usage

``` r
subgroups(
  acute = NULL,
  drug = NULL,
  child = NULL,
  general = NULL,
  long = NULL,
  short = NULL,
  psych = NULL,
  rehab = NULL,
  swing = NULL,
  psych_unit = NULL,
  rehab_unit = NULL,
  specialty = NULL,
  other = NULL
)
```

## Arguments

- acute:

  `<lgl>` Acute/Short Term Care Hospital

- drug:

  `<lgl>` Alcohol/Drug Treatment

- child:

  `<lgl>` Children's Hospital

- general:

  `<lgl>` General Hospital

- long:

  `<lgl>` Long-Term Care

- short:

  `<lgl>` Short-Term Care

- psych:

  `<lgl>` Psychiatric

- rehab:

  `<lgl>` Rehabilitation

- swing:

  `<lgl>` Swing-Bed Approved

- psych_unit:

  `<lgl>` Psychiatric Unit

- rehab_unit:

  `<lgl>` Rehabilitation Unit

- specialty:

  `<lgl>` Specialty Hospital

- other:

  `<lgl>` Unlisted on CMS form

## Value

A `<subgroups>` object

## Examples

``` r
subgroups(acute = TRUE, rehab = TRUE)
#> <subgroups>
#> • SUBGROUP %2D ACUTE CARE     : Y
#> • SUBGROUP %2D REHABILITATION : Y
```
