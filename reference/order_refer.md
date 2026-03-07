# Order and Referral Eligibility

`order_refer()` returns a provider's eligibility to order and refer
within Medicare to:

## Usage

``` r
order_refer(
  npi = NULL,
  first = NULL,
  last = NULL,
  partb = NULL,
  dme = NULL,
  hha = NULL,
  pmd = NULL,
  hos = NULL,
  tidy = TRUE,
  pivot = TRUE,
  ...
)
```

## Arguments

- npi:

  `<chr>` Unique 10-digit National Provider Identifier number issued by
  CMS to US healthcare providers through NPPES.

- first, last:

  `<chr>` Individual provider's first/last name

- partb, dme, hha, pmd, hos:

  `<lgl>` Whether a provider is eligible to order and refer to:

  - `partb`: Medicare Part B

  - `dme`: Durable Medical Equipment

  - `hha`: Home Health Agency

  - `pmd`: Power Mobility Devices

  - `hos`: Hospice

- tidy:

  `<lgl>` Tidy output; **default** is `TRUE`

- pivot:

  `<lgl>` Pivot output; **default** is `TRUE`

- ...:

  Empty dots

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|            |                                                  |
|------------|--------------------------------------------------|
| **Field**  | **Description**                                  |
| `npi`      | National Provider Identifier                     |
| `first`    | Order and Referring Provider's First Name        |
| `last`     | Order and Referring Provider's Last Name         |
| `eligible` | Services An Eligible Provider Can Order/Refer To |

## Details

- **Part B**: Clinical Laboratory Services, Imaging Services

- **DME**: Durable Medical Equipment, Prosthetics, Orthotics, & Supplies
  (DMEPOS)

- **Part A**: Home Health Services

To be eligible, a provider must:

- have an *Individual* NPI

- be enrolled in Medicare in either an *Approved* or *Opt-Out* status

- be of an *Eligible Specialty* type

**Ordering Providers** can order non-physician services for patients.

**Referring (or Certifying) Providers** can request items or services
that Medicare may reimburse on behalf of its beneficiaries.

**Opt-Out Providers**: Providers who have opted out of Medicare may
still order and refer. They can also enroll solely to order and refer.

## References

links:

- [Medicare Order and Referring
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)

- [CMS.gov: Ordering &
  Certifying](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/chain-ownership-system-pecos/ordering-certifying)

- [Order and Referring
  Methodology](https://data.cms.gov/resources/order-and-referring-methodology)

## Examples

``` r
if (FALSE) { # rlang::is_interactive()
order_refer(npi = 1003026055)

# Filter for certain privileges
order_refer(first = "Jennifer",
            last  = "Smith",
            partb = TRUE,
            hos   = FALSE,
            hha   = FALSE,
            pmd   = FALSE)
}
```
