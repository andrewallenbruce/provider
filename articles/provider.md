# Get started with provider

``` r
library(provider)
```

The overarching goal of
[provider](https://andrewallenbruce.github.io/provider/) is to make the
experience of accessing publicly-available Provider data easier and more
consistent across a variety of sources. It aims to accomplish this
through the following goals:

- **Variable Standardization**: for the express purpose of making it
  easier to understand (and make connections between) each API’s output.
  This will also allow for the removal of duplicate information and
  greatly simplify the process of merging data across outputs.

- **Input Validation**: Not only is this simply good practice, it also
  prevents unnecessary querying of APIs.

- **Helpful Documentation**: The impetus for this package was to cobble
  together a motivating example of using a programming language to
  streamline the process of data acquisition for, among other things,
  medical coding, billing, and healthcare revenue cycle management.
  Though it’s now grown beyond that, the intended audience remains the
  same: non-programmers in healthcare who are interested in what a
  programming language like R can do to make their work easier. As such,
  the documentation is written with in a way that assumes no prior
  knowledge of R or programming in general. Domain-specific terminology
  and concepts are explained in detail, as there is not one person in
  existence that understands every aspect of the business of health
  care, including the author of this package.

## Package Architecture

The provider package is built on a three-layer architecture designed to
abstract the complexities of the Centers for Medicare & Medicaid
Services (CMS) APIs into a tidy, R-native interface. It leverages the S7
object system to handle the disparate requirements of the two primary
CMS API “flavors” (the Data API and the Provider Data API) through a
unified execution pipeline.

### The Three-Layer Architecture

The system operates as a linear pipeline that transforms user intent
(Natural Language/R function calls) into network requests, and finally
into tidy data frames.

1.  **User-Facing API Layer**: This layer consists of exported functions
    like
    [`clinicians()`](https://andrewallenbruce.github.io/provider/reference/clinicians.md),
    [`hospitals()`](https://andrewallenbruce.github.io/provider/reference/hospitals.md),
    and
    [`nppes()`](https://andrewallenbruce.github.io/provider/reference/nppes.md).
    These functions perform input validation using the check\_\* family
    of functions and capture user arguments into S7 classes (`arg_cms`
    or `arg_prov`).
2.  **S7 Execute Pipeline**: The core logic is encapsulated in the
    execute generic. When a user-facing function calls `execute()`, the
    S7 dispatch system determines the correct URL construction,
    pagination strategy, and parallelization logic based on the class of
    the input object.
3.  **HTTP/JSON Layer**: The bottom layer interacts with the web via
    `httr2`. It handles the raw JSON responses from CMS, which are then
    parsed by `RcppSimdJson` and passed to the `polish()` function for
    renaming and type casting.

### Handling API Flavors

The package distinguishes between two primary CMS infrastructures. This
distinction is vital because they use different pagination parameters
and filtering syntax:

1.  **Data API (CMS)**:
    - Base URL: data.cms.gov/data-api/v1/dataset/…
    - Pagination: Uses size(5000) and offset.
    - Logic: Handled by arg_cms and req_multi.base_cms2.
2.  **Provider Data API (PROV)**:
    - Base URL: data.cms.gov/provider-data/api/v1/dataset/…
    - Pagination: Uses limit(1500) and offset.
    - Logic: Handled by arg_prov and req_multi.base_prov2.

### The Role of `polish`

The `polish()` function is the final stage of the pipeline. It
orchestrates three critical transformations:

1.  Renaming: Converts raw API keys (e.g., adr_ln_1) into snake_case
    (e.g., address_1) via column_renames().
2.  Recoding: Converts coded values (e.g., “01”) into human-readable
    strings (e.g., “Community Hospital”) using recode_with().
3.  Type Casting: Ensures numeric strings are converted to doubles or
    integers, and dates are parsed correctly via helpers like
    rc_integer_supp and rc_date_ymd.

------------------------------------------------------------------------

## Provider Identifiers

> **NPI**: A National Provider Identifier (NPI) is a unique 10-digit
> identification number issued to health care providers in the United
> States by the Centers for Medicare and Medicaid Services (CMS) through
> the National Plan and Provider Enumeration System (NPPES). All
> individual HIPAA–covered healthcare providers or organizations must
> obtain an NPI. Once assigned, a provider’s NPI is permanent and
> remains with the provider regardless of job or location changes.

``` r
# Must be 10 digits long
open_payments(year = 2021, npi = 12345691234)

# Must be numeric
nppes(npi = "O12345678912")

# Must pass Luhn check
pending(npi = 001234569123)
```

> **PAC**: A Provider associate-level control ID (PAC ID) is a 10-digit
> unique numeric identifier that is assigned to each individual or
> organization in PECOS. The PAC ID links all entity-level information
> (e.g., tax identification numbers and organizational names) and may be
> associated with multiple enrollment IDs if the individual or
> organization enrolled multiple times under different circumstances.

``` r
# Must be 10 digits long
affiliations(pac = 0123456789)

# Must be numeric
hospitals(pac_org = "O12345678912")
```

> **ENID**: A Medicare Enrollment ID is a 15-digit unique alphanumeric
> identifier that is assigned to each new provider enrollment
> application. All enrollment-level information (e.g., enrollment type,
> enrollment state, provider specialty and reassignment of benefits) is
> linked through the Enrollment ID.

``` r
# Must be a character vector
clinicians(enid = 0123456789123456)

# Must be 15 characters long
reassignments(enid = "I123456789123456")

# Must begin with a capital I (Individual) or O (Organization/Group)
providers(enid = "L12345678912345")

# Some functions require one of ID types
hospitals(enid_org = "I20180115000174")
```

> **CCN**: A CMS Certification Number is a standardized sequence of
> alphanumeric characters that uniquely identify health care providers
> and suppliers who interact with the Medicare and Medicaid programs.
> Providers and suppliers paid under Medicare Part A have a 6 digit CCN.
> Suppliers paid by Part B carriers have a 10-digit CCN.

> **Taxonomy Code**: A NUCC Healthcare Taxonomy Code is a.

> **Provider Type Code**: A Medicare Provider Type Code is a.

``` r
provider::provider_type_code
#> # A tibble: 305 × 5
#>    code  type  type_description spec  spec_description                          
#>    <chr> <chr> <chr>            <chr> <chr>                                     
#>  1 00-00 00    PART A PROVIDER  00    RELIGIOUS NON-MEDICAL HEALTH CARE INSTITU…
#>  2 00-01 00    PART A PROVIDER  01    COMMUNITY MENTAL HEALTH CENTER            
#>  3 00-02 00    PART A PROVIDER  02    COMPREHENSIVE OUTPATIENT REHABILITATION F…
#>  4 00-03 00    PART A PROVIDER  03    END-STAGE RENAL DISEASE FACILITY (ESRD)   
#>  5 00-04 00    PART A PROVIDER  04    FEDERALLY QUALIFIED HEALTH CENTER (FQHC)  
#>  6 00-05 00    PART A PROVIDER  05    HISTOCOMPATIBILITY LABORATORY             
#>  7 00-06 00    PART A PROVIDER  06    HOME HEALTH AGENCY                        
#>  8 00-08 00    PART A PROVIDER  08    HOSPICE                                   
#>  9 00-09 00    PART A PROVIDER  09    HOSPITAL                                  
#> 10 00-10 00    PART A PROVIDER  10    INDIAN HEALTH SERVICES FACILITY           
#> # ℹ 295 more rows
```
