
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `provider` <img src="man/figures/logo.svg" align="right" height="150" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Project Status: WIP - Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://choosealicense.com/licenses/mit/)
[![code
size](https://img.shields.io/github/languages/code-size/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider)
[![last
commit](https://img.shields.io/github/last-commit/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider/commits/main)
[![Codecov test
coverage](https://codecov.io/gh/andrewallenbruce/provider/branch/main/graph/badge.svg)](https://app.codecov.io/gh/andrewallenbruce/provider?branch=main)
<!-- badges: end -->

The goal of `provider` is to provide performant and reliable open-source
tools to facilitate easy access to [healthcare
provider](https://en.wikipedia.org/wiki/Health_care_provider) data
through publicly available APIs & sources. The current list of supported
APIs are:

<br>

-   [NPPES National Provider Identifier (NPI) Registry
    API](https://npiregistry.cms.hhs.gov/search)
-   [Medicare Fee-For-Service Public Provider Enrollment
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
-   [Medicare Order and Referring
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
-   [Medicare Provider and Supplier Taxonomy Crosswalk
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)
-   [Medicare Physician & Other Practitioners
    API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
-   [Medicare Revalidation Due Date
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
-   [Medicare Revalidation Clinic Group Practice Reassignment
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)
-   [Medicare Opt Out Affidavits
    API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
-   [Medicare Market Saturation & Utilization State-County
    API](https://data.cms.gov/summary-statistics-on-use-and-payments/program-integrity-market-saturation-by-type-of-service/market-saturation-utilization-state-county)
-   [Medicare Provider of Services File - Clinical Laboratories
    API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)
-   [CMS Public Reporting of Missing Digital Contact Information
    API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)

<br>

Search for Providers:

-   `provider_nppes()` : by NPI, name, location, organization, taxonomy,
    etc.
-   `provider_mppe()` : who are actively approved to bill Medicare.
-   `provider_moar()` : who are legally eligible to order and refer in
    the Medicare program.
-   `provider_mooa()` : that have opted out of Medicare, along with
    their effective dates.
-   `provider_mpstc()` : eligible to enroll in Medicare programs with
    the proper provider taxonomy code.
-   `provider_mrdd()` : who are due to revalidate in the following six
    months.
-   `provider_mpop()` : and their utilization data across three related
    datasets and eight years.
-   `provider_promdci()` : who do not have adequate contact information
    in the NPPES system.
-   `provider_rcgpr()` : and the group practice they reassign their
    billing to.

## Installation

You can install the development version of `provider` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andrewallenbruce/provider")

# install.packages("remotes")
remotes::install_github("andrewallenbruce/provider")
```

<br>

<br>

## Motivating Example

You’re billing for a healthcare provider and receive a `CO-8` denial on
a claim and you need to confirm whether or not the correct taxonomy code
was entered on the claim. Armed with the provider’s NPI, you can search
the **NPPES NPI Registry API** with the `provider_nppes()` function:

<br>

``` r
# Load library
library(provider)

# Query the NPPES API by NPI
nppes_ex <- provider_nppes(npi = 1083879860)
#> Error: 'provider_luhn' is not an exported object from 'namespace:provider'

# Or by Name, City, State, etc.
# nppes_ex <- provider_nppes(first = "Chris", 
#                            last  = "Aaron",
#                            city  = "Cresson",
#                            state = "PA")
```

<br>

    #> Error in eval(expr, envir, enclos): object 'nppes_ex' not found

<br>

Unpack the API response with the `provider_unpack()` function:

<br>

``` r
nppes_unpack <- provider_unpack(nppes_ex)
#> Error in dplyr::filter(df, outcome == "Errors"): object 'nppes_ex' not found
```

<br>

``` r
nppes_unpack
#> Error in eval(expr, envir, enclos): object 'nppes_unpack' not found
```

<br>

Filter and wrangle the data for presentation:

<br>

<details>
<summary>
Code
</summary>

``` r
nppes_table <- nppes_unpack |> 
   dplyr::select("NPI"           = npi, 
                 "Last Name"     = last_name,
                 "Provider Type" = prov_type, 
                 "Description"   = taxon_desc, 
                 "Code"          = taxon_code, 
                 "Primary"       = taxon_primary, 
                 "State"         = taxon_state, 
                 "License"       = taxon_license) |> 
   dplyr::distinct(Primary, 
                   .keep_all = TRUE) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "NPPES NPI Registry Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime),
                        cgroup = c("", "Taxonomy Information"), 
                        n.cgroup = c(3,5))
#> Error in dplyr::select(nppes_unpack, NPI = npi, `Last Name` = last_name, : object 'nppes_unpack' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'nppes_table' not found

<br>

What if you need the provider’s PECOS PAC ID or Enrollment ID? Using the
`provider_mppe()` function, you can search Medicare’s **Fee-For-Service
Public Provider Enrollment API**:

<br>

``` r
mppe_ex <- provider_mppe(nppes_unpack$npi[[1]])
#> Error in provider_mppe(nppes_unpack$npi[[1]]): object 'nppes_unpack' not found
```

<br>

<details>
<summary>
Code
</summary>

``` r
mppe_table <- mppe_ex |> 
   dplyr::select("NPI"             = npi, 
                 "Last Name"       = last_name, 
                 "PAC ID"    = pecos_asct_cntl_id, 
                 "Enrollment ID" = enrlmt_id, 
                 "Specialty"       = provider_type_desc, 
                 "State"           = state_cd) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Fee-For-Service Public Provider Enrollment Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in dplyr::select(mppe_ex, NPI = npi, `Last Name` = last_name, `PAC ID` = pecos_asct_cntl_id, : object 'mppe_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'mppe_table' not found

<br>

Is a Provider currently eligible to: \* Make referrals to Medicare Part
B or a Home Health Agency (HHA)? \* Order Durable Medical Equipment
(DME) or Power Mobility Devices (PMDs)?

<br>

Search Medicare’s **Order and Referring API** with `provider_moar()`:

<br>

``` r
moar_ex <- provider_moar(nppes_unpack$npi[[1]])
#> Error in provider_moar(nppes_unpack$npi[[1]]): object 'nppes_unpack' not found
```

<br>

<details>
<summary>
Code
</summary>

``` r
moar_table <- moar_ex |> 
   dplyr::select("NPI"        = npi, 
                 "Last Name"  = last_name,
                 "First Name" = first_name, 
                 "Part B"     = partb, 
                 "DME"        = dme,
                 "HHA"        = hha, 
                 "PMD"        = pmd) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Order and Referring Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in dplyr::select(moar_ex, NPI = npi, `Last Name` = last_name, `First Name` = first_name, : object 'moar_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'moar_table' not found

You may need to find Medicare’s specialty codes for this provider’s
taxonomies. You can search Medicare’s **Provider and Supplier Taxonomy
Crosswalk API** with `provider_mpstc()`:

<br>

``` r
mpstc_ex <- provider_mpstc(nppes_unpack$taxon_code[[1]])
#> Error in provider_mpstc(nppes_unpack$taxon_code[[1]]): object 'nppes_unpack' not found
```

<br>

<details>
<summary>
Code
</summary>

``` r
mpstc_table <- mpstc_ex |> 
   dplyr::select("Taxonomy Code"                  = provider_taxonomy_code, 
                 "Medicare Specialty Code"        = medicare_specialty_code,
                 "Medicare Specialty Description" = medicare_provider_supplier_type_description,
                 "Specialty"                      = medicare_provider_supplier_type_description, 
                 "Classification"                 = provider_taxonomy_description_type_classification_specialization) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Provider and Supplier Taxonomy Crosswalk Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in dplyr::select(mpstc_ex, `Taxonomy Code` = provider_taxonomy_code, : object 'mpstc_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'mpstc_table' not found

You can check to see if a provider is due to revalidate their Medicare
enrollment by accessing Medicare’s **Revalidation Due Date API** with
`provider_mrdd()`:

<br>

``` r
mrdd_ex <- provider_mrdd(nppes_unpack$npi[[1]])
#> Error in provider_mrdd(nppes_unpack$npi[[1]]): object 'nppes_unpack' not found
```

<br>

<details>
<summary>
Code
</summary>

``` r
mrdd_table <- mrdd_ex |> 
   dplyr::select("NPI"                   = national_provider_identifier, 
                 "Last Name"             = last_name,
                 "Enrollment ID"         = enrollment_id,
                 "Enrollment Type"       = provider_type_text,
                 "Enrollment Specialty"  = enrollment_specialty,
                 "State"                 = enrollment_state_code,
                 "Provider Type"         = provider_type_text, 
                 "Revalidation Due Date" = revalidation_due_date) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Revalidation Due Date Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in dplyr::select(mrdd_ex, NPI = national_provider_identifier, `Last Name` = last_name, : object 'mrdd_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'mrdd_table' not found

<br>

Providers may need to update their digital contact information in the
NPPES system. To check, you can access the **CMS Public Reporting of
Missing Digital Contact Information API** with `provider_promdci()`. If
they appear in the search results, it’s time to update their NPPES
contact information:

<br>

``` r
provider_promdci(nppes_unpack$npi[[1]])
#> Error in provider_promdci(nppes_unpack$npi[[1]]): object 'nppes_unpack' not found
```

<br>

You can find out if a provider has opted out of Medicare by searching
the **Medicare Opt Out Affidavits API** with `provider_mooa()`:

<br>

``` r
mooa_ex <- provider_mooa(nppes_unpack$npi[[1]])
#> Error in provider_mooa(nppes_unpack$npi[[1]]): object 'nppes_unpack' not found
```

<br>

<details>
<summary>
Code
</summary>

``` r
mooa_ex |> 
   dplyr::select(NPI                        = npi,
                 Last                       = last_name,
                 First                      = first_name,
                 "Optout Effective Date"    = optout_effective_date,
                 "Optout End Date"          = optout_end_date,
                 "Order & Refer Eligible"   = eligible_to_order_and_refer,
                 Updated                    = last_updated,
                 Specialty                  = specialty,
                 Address                    = first_line_street_address,
                 City                       = city_name,
                 State                      = state_code) |>
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Revalidation Due Date Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in dplyr::select(mooa_ex, NPI = npi, Last = last_name, First = first_name, : object 'mooa_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'mooa_table' not found

<br>

`provider_rcgpr()` accesses **Medicare’s Revalidation Clinic Group
Practice Reassignment API**:

<br>

``` r
rcgpr_ex <- provider_rcgpr(nppes_unpack$npi[[1]])
#> Error in provider_rcgpr(nppes_unpack$npi[[1]]): object 'nppes_unpack' not found
```

<br>

<details>
<summary>
Code
</summary>

``` r
rcgpr_table <- rcgpr_ex |> 
   dplyr::select("NPI"                           = individual_npi,
                 "Last"                          = individual_last_name,
                 "Type"                          = record_type,
                 "PAC ID Group "                 = group_pac_id,
                 "Enroll ID Group"               = group_enrollment_id,
                 "Business Name"                 = group_legal_business_name,
                 "Due Date Group"                = group_due_date,
                 "PAC ID Ind"                    = individual_pac_id,
                 "Enroll ID Ind"                 = individual_enrollment_id,
                 "Due Date Ind"                  = individual_due_date,
                 "Reassignments & Phys Assts"    = group_reassignments_and_physician_assistants,
                 "Employer Associations"         = individual_total_employer_associations) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Revalidation Clinic Group Practice Reassignment Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in dplyr::select(rcgpr_ex, NPI = individual_npi, Last = individual_last_name, : object 'rcgpr_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'rcgpr_table' not found

<br>

Using `provider_mpop()`, you can access **Medicare’s Physician & Other
Practitioners API**, enabling you to choose between three related
datasets:

> 1.  by Provider and Service API:

<br>

``` r
mpop_serv_ex <- provider_mpop(npi = nppes_unpack$npi[[1]], 
                              set = "serv",
                              year = "2020")
#> Error in provider_mpop(npi = nppes_unpack$npi[[1]], set = "serv", year = "2020"): object 'nppes_unpack' not found
```

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_serv_table <- mpop_serv_ex |> 
   dplyr::select(Year            = year,
                 NPI             = rndrng_npi,
                 Last            = rndrng_prvdr_last_org_name,
                 City            = rndrng_prvdr_city,
                 State           = rndrng_prvdr_state_abrvtn,
                 PAR             = rndrng_prvdr_mdcr_prtcptg_ind,
                 HCPCS           = hcpcs_cd,
                 Beneficiaries   = tot_benes,
                 "Services"      = tot_srvcs,
                 "Avg Billed"    = avg_sbmtd_chrg,
                 "Avg Allowed"   = avg_mdcr_alowd_amt,
                 "Avg Payment"   = avg_mdcr_pymt_amt) |>
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Provider & Service Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in dplyr::select(mpop_serv_ex, Year = year, NPI = rndrng_npi, Last = rndrng_prvdr_last_org_name, : object 'mpop_serv_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'mpop_serv_table' not found

<br>

> 2.  by Geography and Service API:

<br>

``` r
mpop_geo_ex <- provider_mpop(hcpcs   = "99214", 
                             set     = "geo",
                             geo_lvl = "National",
                             year    = "2020")
```

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_geo_table <- mpop_geo_ex |> 
   dplyr::select(Year                       = year, 
                 HCPCS                      = hcpcs_cd,
                 Region                     = rndrng_prvdr_geo_desc,
                 POS                        = place_of_srvc,
                 Providers                  = tot_rndrng_prvdrs,
                 Beneficiaries              = tot_benes, 
                 Services                   = tot_srvcs, 
                 "Avg Charge"               = avg_sbmtd_chrg, 
                 "Avg Allowed"              = avg_mdcr_alowd_amt, 
                 "Avg Payment"              = avg_mdcr_pymt_amt) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Geography & Service Search Results", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in format(x, format = "Retrieved on %A, %B %d, %Y at %I:%M %p"): object 'nppes_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'mpop_geo_table' not found

<br>

> 3.  by Provider API:

<br>

``` r
mpop_prov_ex <- provider_mpop(npi  = nppes_unpack$npi[[1]], 
                              set  = "prov",
                              year = "2020")
#> Error in provider_mpop(npi = nppes_unpack$npi[[1]], set = "prov", year = "2020"): object 'nppes_unpack' not found
```

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_prov_totals_table <- mpop_prov_ex |> 
   dplyr::select("Year"              = year,
                 "Unique HCPCS"      = tot_hcpcs_cds,
                 "Beneficiaries"     = tot_benes, 
                 "Services"          = tot_srvcs, 
                 "Charges Submitted" = tot_sbmtd_chrg,
                 "Amount Allowed"    = tot_mdcr_alowd_amt,
                 "Payments"          = tot_mdcr_pymt_amt) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Provider: Yearly Totals", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in dplyr::select(mpop_prov_ex, Year = year, `Unique HCPCS` = tot_hcpcs_cds, : object 'mpop_prov_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'mpop_prov_totals_table' not found

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_prov_age_table <- mpop_prov_ex |> 
   dplyr::select("Year"     = year,
                 "Average Age" = bene_avg_age,
                 "Under 65" = bene_age_lt_65_cnt,
                 "65 - 74" = bene_age_65_74_cnt,
                 "75 - 84" = bene_age_75_84_cnt,
                 "Over 84" = bene_age_gt_84_cnt) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Provider: Beneficiary Age", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in dplyr::select(mpop_prov_ex, Year = year, `Average Age` = bene_avg_age, : object 'mpop_prov_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'mpop_prov_age_table' not found

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_prov_demo_table <- mpop_prov_ex |> 
   dplyr::select("Year" = year,
                 "Female" = bene_feml_cnt,
                 "Male" = bene_male_cnt,
                 "White" = bene_race_wht_cnt,
                 "Black" = bene_race_black_cnt,
                 "Dual" = bene_dual_cnt,
                 "Non-Dual" = bene_ndual_cnt) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Provider: Beneficiary Demographics", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in dplyr::select(mpop_prov_ex, Year = year, Female = bene_feml_cnt, : object 'mpop_prov_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'mpop_prov_demo_table' not found

<br>

<br>

<details>
<summary>
Code
</summary>

``` r
mpop_prov_ccw_table <- mpop_prov_ex |> 
   dplyr::select("Year" = year,
                 "Cancer" = bene_cc_cncr_pct,
                 "CKD" = bene_cc_ckd_pct,
                 "Diabetes" = bene_cc_dbts_pct,
                 "Hyperlipidemia" = bene_cc_hyplpdma_pct,
                 "Hypertension" = bene_cc_hyprtnsn_pct,
                 "Rheumatoid Arthritis / Osteoarthritis" = bene_cc_raoa_pct,
                 "Avg. HCC Risk Score" = bene_avg_risk_scre) |> 
   htmlTable::addHtmlTableStyle(align        = "l", 
                                align.header = "l") |> 
   htmlTable::htmlTable(caption = "Medicare Physician & Other Practitioners by Provider: Beneficiary Chronic Disease Percentages", 
                        ctable = c("solid", "double"),
                        tfoot = lubridate::stamp("Retrieved on Sunday, January 1, 1999 at 3:34 pm", 
                                                 quiet = TRUE)(nppes_ex$datetime))
#> Error in dplyr::select(mpop_prov_ex, Year = year, Cancer = bene_cc_cncr_pct, : object 'mpop_prov_ex' not found
```

</details>

<br>

    #> Error in eval(expr, envir, enclos): object 'mpop_prov_ccw_table' not found

------------------------------------------------------------------------

Using packages like {gt} & {ggplot2}, you can create tables and graphs
for reporting purposes:

<br>

<br>

<img src="man/figures/gt_provider.png" style="width:100.0%" />

<img src="man/figures/gt_provider2.png" style="width:100.0%" />

<img src="man/figures/gt_provider3.png" style="width:100.0%" />

<br> <br>

------------------------------------------------------------------------

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
