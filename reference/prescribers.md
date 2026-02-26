# Prescriber Utilization & Demographics by Year

Access information on prescription drugs provided to Medicare
beneficiaries enrolled in Part D (Prescription Drug Coverage), by
physicians and other health care providers; aggregated by provider, drug
and geography.

The Medicare Part D Prescribers Datasets contain information on
prescription drug events (PDEs) incurred by Medicare beneficiaries with
a Part D prescription drug plan. The Part D Prescribers Datasets are
organized by National Provider Identifier (NPI) and drug name and
contains information on drug utilization (claim counts and day supply)
and total drug costs.

## Usage

``` r
prescribers(
  year,
  type,
  npi = NULL,
  first = NULL,
  last = NULL,
  organization = NULL,
  credential = NULL,
  gender = NULL,
  entype = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  fips = NULL,
  ruca = NULL,
  country = NULL,
  specialty = NULL,
  brand_name = NULL,
  generic_name = NULL,
  level = NULL,
  opioid = NULL,
  opioidLA = NULL,
  antibiotic = NULL,
  antipsychotic = NULL,
  tidy = TRUE,
  nest = TRUE,
  na.rm = TRUE,
  ...
)

prescribers_(year = rx_years(), ...)
```

## Arguments

- year:

  \< *integer* \> // **required** Year data was reported, in `YYYY`
  format. Run
  [`rx_years()`](https://andrewallenbruce.github.io/provider/reference/years.md)
  to return a vector of the years currently available.

- type:

  `<chr>` // **required** dataset to query, `"Provider"`, `"Drug"`,
  `"Geography"`

- npi:

  `<int>` 10-digit national provider identifier

- first, last, organization:

  `<chr>` Individual/Organizational prescriber's name

- credential:

  `<chr>` Individual prescriber's credentials

- gender:

  `<chr>` Individual prescriber's gender; `"F"` (Female), `"M"` (Male)

- entype:

  `<chr>` Prescriber entity type; `"I"` (Individual), `"O"`
  (Organization)

- city:

  `<chr>` City where prescriber is located

- state:

  `<chr>` State where prescriber is located

- zip:

  `<chr>` Prescriber’s zip code

- fips:

  `<chr>` Prescriber's state's FIPS code

- ruca:

  `<chr>` Prescriber’s RUCA code

- country:

  `<chr>` Country where prescriber is located

- specialty:

  `<chr>` Prescriber specialty code reported on the largest number of
  claims submitted

- brand_name:

  `<chr>` Brand name (trademarked name) of the drug filled, derived by
  linking the National Drug Codes (NDCs) from PDEs to a drug information
  database.

- generic_name:

  `<chr>` USAN generic name of the drug filled (short version); A term
  referring to the chemical ingredient of a drug rather than the
  trademarked brand name under which the drug is sold, derived by
  linking the National Drug Codes (NDCs) from PDEs to a drug information
  database.

- level:

  `<chr>` Geographic level by which the data will be aggregated:

  - `"State"`: Data is aggregated for each state

  - `"National"`: Data is aggregated across all states for a given HCPCS
    Code

- opioid:

  `<lgl>` *type = 'Geography'*, `TRUE` returns Opioid drugs

- opioidLA:

  `<lgl>` *type = 'Geography'*, `TRUE` returns Long-acting Opioids

- antibiotic:

  `<lgl>` *type = 'Geography'*, `TRUE` returns antibiotics

- antipsychotic:

  `<lgl>` *type = 'Geography'*, `TRUE` returns antipsychotics

- tidy:

  `<lgl>` // **default:** `TRUE` Tidy output

- nest:

  `<lgl>` // **default:** `TRUE` Nest output

- na.rm:

  `<lgl>` // **default:** `TRUE` Remove empty rows and columns

- ...:

  Pass arguments to `prescribers()`.

## By Provider

**type =**`"Provider"`:

The Medicare Part D Prescribers by **Provider** dataset summarizes for
each prescriber the total number of prescriptions that were dispensed,
which include original prescriptions and any refills, and the total drug
cost.

## By Provider and Drug

**type =**`"Drug"`:

The Medicare Part D Prescribers by **Provider and Drug** dataset
contains the total number of prescription fills that were dispensed and
the total drug cost paid organized by prescribing National Provider
Identifier (NPI), drug brand name (if applicable) and drug generic name.

## By Geography and Drug

**type =**`"Geography"`:

For each drug, the **Geography and Drug** dataset includes the total
number of prescriptions that were dispensed, which include original
prescriptions and any refills, and the total drug cost.

The total drug cost includes the ingredient cost of the medication,
dispensing fees, sales tax, and any applicable administration fees and
is based on the amount paid by the Part D plan, Medicare beneficiary,
government subsidies, and any other third-party payers.

## Links

- [Medicare Part D Prescribers: by
  Provider](https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-provider)

- [Medicare Part D Prescribers: by Provider and
  Drug](https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-provider-and-drug)

- [Medicare Part D Prescribers: by Geography and
  Drug](https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-geography-and-drug)

- [Medicare Part D Prescribers Technical
  Specifications](https://data.cms.gov/sites/default/files/2021-08/mup_dpr_ry21_20210819_technical_specifications.pdf)

*Update Frequency:* **Annually**

## Examples

``` r
if (FALSE) { # interactive()
prescribers(year = 2020,
            type = 'Provider',
            npi = 1003000423)

prescribers(year = 2019,
            type = 'Drug',
            npi = 1003000126)

prescribers(year = 2021,
            type = 'Geography',
            brand_name = 'Clotrimazole-Betamethasone')

prescribers(year = 2017,
            type = 'Geography',
            level = 'National',
            brand_name = 'Paroxetine Hcl')

prescribers(year = 2017,
            type = 'Geography',
            opioid = TRUE)

# Use the years helper function to
# retrieve results for every year:
rx_years() |>
map(\(x) prescribers(year = x,
                     type = 'Provider',
                     npi = 1043477615)) |>
list_rbind()

# Parallelized version
prescribers_(type = 'Provider',
             npi = 1043477615)

prescribers_(type = 'Drug',
             npi = 1003000423)

prescribers_(type = 'Geography',
             level = 'National',
             generic_name = 'Mirabegron')
}
```
