# Relationships with Drug & Medical Device Companies

Allows the user access to CMS' Open Payments Program API

The **Open Payments** program is a national disclosure program that
collects and publishes information about financial relationships between
drug and medical device companies (referred to as "reporting entities")
and certain health care providers (referred to as "covered recipients").
These relationships may involve payments to providers for things
including but not limited to research, meals, travel, gifts or speaking
fees.

## Usage

``` r
open_payments(
  year,
  npi = NULL,
  covered_type = NULL,
  first = NULL,
  last = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  teaching_hospital = NULL,
  payer = NULL,
  payer_id = NULL,
  pay_form = NULL,
  pay_nature = NULL,
  offset = 0L,
  tidy = TRUE,
  pivot = TRUE,
  add.ndc = TRUE,
  na.rm = FALSE,
  ...
)

open_payments_(year = open_years(), ...)
```

## Arguments

- year:

  \< *integer* \> // **required** Year data was reported, in `YYYY`
  format. Run
  [`open_years()`](https://andrewallenbruce.github.io/provider/reference/years.md)
  to return a vector of the years currently available.

- npi:

  \< *integer* \> Covered recipient's 10-digit National Provider
  Identifier

- covered_type:

  \< *character* \> Type of covered recipient, e.g.:

  - `"Physician"`

  - `"Non-Physician Practitioner"`

  - `"Teaching Hospital"`

- first, last:

  \< *character* \> Covered recipient's name

- city:

  \< *character* \> Covered recipient's city

- state:

  \< *character* \> Covered recipient's state abbreviation

- zip:

  \< *character* \> Covered recipient's zip code

- teaching_hospital:

  \< *character* \> Name of teaching hospital, e.g.:

  - `"Vanderbilt University Medical Center"`

- payer:

  \< *character* \> Paying entity's name, e.g.:

  - `"Pharmacosmos Therapeutics Inc."`

  - `"Getinge USA Sales, LLC"`

  - `"Agiliti Health, Inc."`

  - `"OrthoScan, Inc."`

- payer_id:

  \< *integer* \> Paying entity's unique 10-digit Open Payments ID

- pay_form:

  \< *character* \> Form of payment, e.g.:

  - `"Stock option"`

  - `"Cash or cash equivalent"`

  - `"In-kind items and services"`

- pay_nature:

  \< *character* \> Nature of payment or transfer of value, e.g.:

  - `"Royalty or License"`

  - `"Charitable Contribution"`

  - `"Current or prospective ownership or investment interest"`

  - `"Food and Beverage"`

- offset:

  \< *integer* \> // **default:** `0L` API pagination

- tidy:

  \< *boolean* \> // **default:** `TRUE` Tidy output

- pivot:

  \< *boolean* \> // **default:** `TRUE` Pivot output

- add.ndc:

  \< *boolean* \> // **default:** `TRUE` Add output from
  [`ndc_lookup()`](https://andrewallenbruce.github.io/provider/reference/ndc_lookup.md)

- na.rm:

  \< *boolean* \> // **default:** `FALSE` Remove empty rows and columns

- ...:

  Pass arguments to `open_payments()`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Terminology

**Reporting Entities**: Applicable manufacturers or GPOs.

**Applicable Group Purchasing Organizations** (GPOs) are entities that
operate in the United States and purchase, arrange for or negotiate the
purchase of covered drugs, devices, biologicals, or medical supplies for
a group of individuals or entities, but not solely for use by the entity
itself.

**Applicable Manufacturers** are entities that operate in the United
States and are (1) engaged in the production, preparation, propagation,
compounding, or conversion of a covered drug, device, biological, or
medical supply, but not if such covered drug, device, biological or
medical supply is solely for use by or within the entity itself or by
the entity's own patients (this definition does not include distributors
or wholesalers (including, but not limited to, re-packagers,
re-labelers, and kit assemblers) that do not hold title to any covered
drug, device, biological or medical supply); or are (2) entities under
common ownership with an entity described in part (1) of this
definition, which provides assistance or support to such entities with
respect to the production, preparation, propagation, compounding,
conversion, marketing, promotion, sale, or distribution of a covered
drug, device, biological or medical supply.

**Covered Recipients** are any physician, physician assistant, nurse
practitioner, clinical nurse specialist, certified registered nurse
anesthetist, or certified nurse-midwife who is not a bona fide employee
of the applicable manufacturer that is reporting the payment; or a
teaching hospital, which is any institution that received a payment.

**Teaching Hospitals** are hospitals that receive payment for Medicare
direct graduate medical education (GME), IPPS indirect medical education
(IME), or psychiatric hospital IME programs.

**Natures of Payment** are categories that must be used to describe why
a payment or other transfer of value was made. They are only applicable
to the “general” payment type, not research or ownership. The categories
are:

- Acquisitions (2021 - current)

- Charitable contributions:

  - Compensation for services other than consulting

  - Compensation for serving as faculty or speaker for an/a:

    - Accredited/certified continuing education program (2013 - 2020)

    - Unaccredited/non-certified continuing education program (2013 -
      2020)

    - Medical education program (2021 - current)

- Consulting fees

- Current or prospective ownership or investment interest (prior to
  2023)

- Debt Forgiveness (2021 - current)

- Education

- Entertainment

- Food and beverage

- Gift

- Grant

- Honoraria

- Long-term medical supply or device loan (2021 - current)

- Royalty or license

- Space rental or facility fees (Teaching Hospitals only)

- Travel and lodging

**Transfers of Value** are anything of value given by an applicable
manufacturer or applicable GPO to a covered recipient or physician
owner/investor that does not fall within one of the excluded categories
in the rule.

**Ownership and Investment Interests** include, but are not limited to:

- Stock

- Stock option(s) (not received as compensation, until they are
  exercised)

- Partnership share(s)

- Limited liability company membership(s)

- Loans

- Bonds

- Financial instruments secured with an entity’s property or revenue

This may be direct or indirect and through debt, equity or other means.

## Links

- [What is the Open Payments
  Program?](https://www.cms.gov/priorities/key-initiatives/open-payments)

- [Open Payments: General
  Resources](https://www.cms.gov/OpenPayments/Resources)

## Update Frequency

Yearly

## Examples

``` r
if (FALSE) { # interactive()
open_payments(year = 2021, npi = 1043218118)
open_payments(year = 2021, pay_nature = "Royalty or License")
open_payments(year = 2021, pay_form = "Stock option")
open_payments(year = 2021, payer = "Adaptive Biotechnologies Corporation")
open_payments(year = 2021, teaching_hospital = "Nyu Langone Hospitals")

# Use the years helper function to retrieve results for all available years:
open_years() |>
map(\(x) open_payments(year = x, npi = 1043477615)) |>
list_rbind()

# Or simply use the parallelized version
open_payments_(npi = 1043218118)
}
```
