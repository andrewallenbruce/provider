# Opt-Out Providers

Information on providers who have decided not to participate in
Medicare.

## Usage

``` r
opt_out(
  npi = NULL,
  first = NULL,
  last = NULL,
  specialty = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  order_refer = NULL,
  count = FALSE,
  set = FALSE
)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- specialty:

  `<chr>` Provider's specialty

- address:

  `<chr>` Provider's address

- city:

  `<chr>` Provider's city

- state:

  `<chr>` Provider's state abbreviation

- zip:

  `<chr>` Provider's zip code

- order_refer:

  `<lgl>` Indicates order and refer eligibility

- count:

  `<lgl>` Return the dataset's total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Opting Out

Providers who do not wish to enroll in the Medicare program may
"opt-out", meaning neither they nor the beneficiary can bill Medicare
for services rendered.

Instead, a private contract between provider and beneficiary is signed,
neither party is reimbursed by Medicare and the beneficiary pays the
provider out-of-pocket.

To opt out, a provider must:

- Be of an **eligible specialty** type

- Submit an **opt-out affidavit** to Medicare

- Enter into a **private contract** with their Medicare patients

## Opt-Out Periods

Opt-out periods last for two years and cannot be terminated early unless
the provider is opting out for the very first time and terminates the
opt-out no later than 90 days after the opt-out period's effective date.
Opt-out statuses are effective for two years and automatically renew.

Providers may **NOT** opt-out if they intend to be a Medicare Advantage
(Part C) provider or furnish services covered by traditional Medicare
fee-for-service (Part B).

## References

- [Medicare Opt Out Affidavits
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)

## Examples

``` r
opt_out(count = TRUE)
#> Error in c("cli::cli_alert_info(c(\"{.strong {endpoint}} has \", \"{.strong {mark(x)}} \", ", "    \"{cli::qty(x)}row{?s}.\"))"): ! Could not evaluate cli `{}` expression: `mark(x)`.
#> Caused by error in `uuid_cms(self@end)`:
#> ! `endpoint` "eval" is invalid.
opt_out(npi = 1043522824)
#> Error in uuid_cms(self@end): `endpoint` "eval" is invalid.
opt_out(state = "AK")
#> Error in uuid_cms(self@end): `endpoint` "eval" is invalid.
opt_out(specialty = "Psychiatry", order_refer = FALSE)
#> Error in uuid_cms(self@end): `endpoint` "eval" is invalid.
```
