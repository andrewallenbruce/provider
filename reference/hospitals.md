# Hospitals Enrolled in Medicare

Access information on all hospitals currently enrolled in Medicare. Data
returned includes the hospital's sub-group types, legal business name,
doing-business-as name, organization type and address.

*Update Frequency:* **Monthly**

## Usage

``` r
hospitals(
  npi = NULL,
  facility_ccn = NULL,
  enid_org = NULL,
  enid_state = NULL,
  pac_org = NULL,
  specialty_code = NULL,
  organization = NULL,
  dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  registration = NULL,
  multi_npi = NULL,
  reh = NULL,
  subgroup = list(),
  tidy = TRUE,
  pivot = TRUE,
  na.rm = TRUE,
  ...
)
```

## Arguments

- npi:

  `<int>`

  10-digit Organizational National Provider Identifier

- facility_ccn:

  `<int>`

  6-digit CMS Certification Number

- enid_org:

  `<chr>`

  15-digit Organizational Medicare Enrollment ID

- enid_state:

  `<chr>`

  Hospital’s enrollment state

- pac_org:

  `<int>`

  10-digit Organizational PECOS Associate Control ID

- specialty_code:

  `<chr>`

  Medicare Part A Provider specialty code:

  - `"00-00"`: Religious Non-Medical Healthcare Institution (RNHCI)

  - `"00-01"`: Community Mental Health Center

  - `"00-02"`: Comprehensive Outpatient Rehabilitation Facility (CORF)

  - `"00-03"`: End-Stage Renal Disease Facility (ESRD)

  - `"00-04"`: Federally Qualified Health Center (FQHC)

  - `"00-05"`: Histocompatibility Laboratory

  - `"00-06"`: Home Health Agency (HHA)

  - `"00-08"`: Hospice

  - `"00-09"`: Hospital

  - `"00-10"`: Indian Health Services Facility

  - `"00-13"`: Organ Procurement Organization (OPO)

  - `"00-14"`: Outpatient PT/Occupational Therapy/Speech Pathology

  - `"00-17"`: Rural Health Clinic (RHC)

  - `"00-18"`: Skilled Nursing Facility (SNF)

  - `"00-19"`: Other

  - `"00-24"`: Rural Emergency Hospital (REH)

  - `"00-85"`: Critical Access Hospital (CAH)

- organization:

  `<chr>`

  Hospital’s legal business name

- dba:

  `<chr>`

  Hospital’s doing-business-as name

- city:

  `<chr>`

  City of the hospital’s practice location

- state:

  `<chr>`

  State of the hospital’s practice location

- zip:

  `<int>`

  Zip code of the hospital’s practice location

- registration:

  `<chr>`

  Hospital's IRS designation:

  - `"P"`: Registered as **Proprietor**

  - `"N"`: Registered as **Non-Profit**

- multi_npi:

  `<lgl>`

  Indicates hospital has more than one NPI

- reh:

  `<lgl>`

  Indicates a former Hospital or Critical Access Hospital (CAH) that
  converted to a Rural Emergency Hospital (REH)

- subgroup:

  `<list>`

  `subgroup = list(acute = TRUE, swing = FALSE)`

  Indicates hospital’s subgroup/unit designation:

  - `acute`: Acute Care

  - `alc_drug`: Alcohol/Drug

  - `child`: Children's Hospital

  - `gen`: General

  - `long`: Long-Term

  - `short`: Short-Term

  - `psych`: Psychiatric

  - `rehab`: Rehabilitation

  - `swing`: Swing-Bed Approved

  - `psych_unit`: Psychiatric Unit

  - `rehab_unit`: Rehabilitation Unit

  - `spec`: Specialty Hospital

  - `other`: Not listed on CMS form

- tidy:

  `<lgl>` // **default:** `TRUE`

  Tidy output

- pivot:

  `<lgl>` // **default:** `TRUE`

  Pivot output

- na.rm:

  `<lgl>` // **default:** `TRUE`

  Remove empty rows and columns

- ...:

  Empty

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|                     |                                                                |
|---------------------|----------------------------------------------------------------|
| **Field**           | **Description**                                                |
| `npi`               | Hospital's 10-digit National Provider Identifier               |
| `pac_org`           | Hospital’s 10-digit PECOS Associate Control ID                 |
| `enid_org`          | Hospital’s 15-digit Enrollment ID                              |
| `enid_state`        | Hospital’s Enrollment State                                    |
| `facility_ccn`      | Hospital’s CMS Certification Number                            |
| `organization`      | Hospital’s Legal Business Name                                 |
| `doing_business_as` | Hospital’s Doing-Business-As Name                              |
| `specialty_code`    | Hospital’s Medicare Part A Provider Specialty Code             |
| `specialty`         | Specialty Code Description                                     |
| `incorp_date`       | Date the Business was Incorporated                             |
| `incorp_state`      | State in which the Business was Incorporated                   |
| `structure`         | Hospital’s Organization Structure Type                         |
| `address`           | Hospital’s Practice Location Address                           |
| `city`              | Hospital’s Practice Location City                              |
| `state`             | Hospital’s Practice Location State                             |
| `zip`               | Hospital’s Practice Location Zip Code                          |
| `location_type`     | Practice Location Type                                         |
| `multi_npi`         | Indicates Hospital has more than one NPI                       |
| `reh_date`          | Date the Hospital/CAH converted to an REH                      |
| `reh_ccns`          | CCNs associated with the Hospital/CAH that converted to an REH |
| `registration`      | Hospital’s IRS Registration Status                             |
| `subgroup`          | Hospital's Subgroup/Unit Designations, REH Conversion Status   |
| `other`             | If `subgroup` is `"Other"`, description of Subgroup/Unit       |

## Links

- [Hospital
  Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)

## Examples

``` r
if (FALSE) { # interactive()
hospitals(pac_org = 6103733050)

hospitals(state = "GA", reh = TRUE)

hospitals(city = "Savannah", state = "GA")

hospitals(city = "Savannah",
          state = "GA",
          subgroup = list(acute = FALSE))

hospitals(city = "Savannah",
          state = "GA",
          subgroup = list(
          gen = TRUE,
          rehab = FALSE))
}
```
