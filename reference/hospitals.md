# Hospital General Information

A list of all hospitals that have been registered with Medicare. The
list includes addresses, phone numbers, hospital type, and overall
hospital rating.

Hospitals currently enrolled in Medicare. Data includes the hospital's
sub-group types, legal business name, doing-business-as name,
organization type and address.

## Usage

``` r
hospitals2(
  ccn = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  hosp_type = NULL,
  ownership = NULL,
  rating = NULL,
  count = FALSE,
  set = FALSE
)

hospitals(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  enid_state = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  prov_type = NULL,
  loc_type = NULL,
  subgroup = subgroups(),
  count = FALSE,
  set = FALSE
)
```

## Source

- [API: Hospital General
  Information](https://data.cms.gov/provider-data/dataset/27ea-46a8)

- [API: Data
  Dictionary](https://data.cms.gov/provider-data/dataset/xubh-q36u#data-dictionary)

&nbsp;

- [API: Hospital
  Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)

## Arguments

- ccn:

  `<int>` CMS Certification Number

- org_name:

  `<chr>` Legal business name

- city, state, zip:

  `<chr>` Location city, state, zip

- county:

  `<chr>` Location county

- hosp_type:

  `<enum>` Provider type:

  - `acute` = Acute Care

  - `cah` = Critical Access Hospital

  - `child` = Childrens' Hospital

  - `dod` = Acute Care - Department of Defense

  - `ltc` = Long-term

  - `psych` = Psychiatric

  - `reh` = Rural Emergency Hospital

  - `vha` = Acute Care - Veterans Administration

- ownership:

  `<enum>` Ownership type:

  - `private` = Voluntary non-profit - Private

  - `other` = Voluntary non-profit - Other

  - `church` = Voluntary non-profit - Church

  - `district` = Government - Hospital District or Authority

  - `local` = Government - Local

  - `federal` = Government - Federal

  - `state` = Government - State

  - `dod` = Department of Defense

  - `profit` = Proprietary

  - `physician` = Physician

  - `tribal` = Tribal

  - `vha` = Veterans Health Administration

- rating:

  `<int>` Hospital rating; 1-5 or "Not Available"

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

- npi:

  `<int>` National Provider Identifier

- pac:

  `<chr>` PECOS Associate Control ID

- enid, enid_state:

  `<chr>` Medicare Enrollment ID, Enrollment state

- org_dba:

  `<chr>` Doing-business-as name

- multi:

  `<lgl>` Does hospital have more than one NPI?

- status:

  `<enum>` Organization status

  - `P` = Proprietary

  - `N` = Non-Profit

  - `D` = Unknown

- org_type:

  `<enum>` Organization structure type

  - `corp` = Corporation

  - `other` = Other

  - `llc` = LLC

  - `part` = Partnership

  - `sole` = Sole Proprietor

- prov_type:

  `<enum>` Provider type:

  - `hospital` = Medicare Part A Hospital

  - `reh` = Rural Emergency Hospital

  - `cah` = Critical Access Hospital

- loc_type:

  `<enum>` Practice location type

  - `main` = Main/Primary Hospital Location

  - `psych` = Hospital Psychiatric Unit

  - `rehab` = Hospital Rehabilitation Unit

  - `swing` = Hospital Swing-Bed Unit

  - `ext` = Opt Extension Site

  - `other` = Other Hospital Practice Location

- subgroup:

  `<subgroups>` Hospital’s subgroup/unit. See
  [`subgroups()`](https://andrewallenbruce.github.io/provider/reference/subgroups.md).

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
hospitals(count = TRUE)
#> ═ hospitals Totals
#> • Rows  : 9,182
#> • Pages : 2    
#> 

hospitals2(count = TRUE)
#> ═ hospitals2 Totals
#> • Rows  : 5,426
#> • Pages : 4    
#> 

hospitals(prov_type = "reh", count = TRUE)
#> ✔ hospitals returned 48 results.
hospitals2(hosp_type = "reh", count = TRUE)
#> ✔ hospitals2 returned 39 results.

x <- hospitals(
  city = "Atlanta",
  state = "GA",
  subgroup = subgroups(
    acute = FALSE,
    psych = TRUE))
#> ✔ hospitals returned 2 results.
x
#> # A tibble: 2 × 38
#>   enid  enid_state prov_type prov_desc    npi multi ccn   pac   org_name org_dba
#> * <chr> <chr>      <chr>     <chr>      <int> <int> <chr> <chr> <chr>    <chr>  
#> 1 O201… GA         00-09     PART A P… 1.02e9     1 1140… 4486… UHS OF … ANCHOR…
#> 2 O201… GA         00-09     PART A P… 1.09e9     0 1140… 9234… UHS OF … PEACHF…
#> # ℹ 28 more variables: inc_date <date>, inc_state <chr>, org_type <chr>,
#> #   org_otxt <chr>, status <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, loc_otxt <chr>, sub_gen <int>, sub_acute <int>,
#> #   sub_adu <int>, sub_child <int>, sub_ltc <int>, sub_psy <int>,
#> #   sub_irf <int>, sub_stc <int>, sub_sba <int>, sub_psu <int>, sub_iru <int>,
#> #   sub_spec <int>, sub_oth <int>, sub_otxt <int>, `REH CONVERSION FLAG` <chr>,
#> #   reh_date <date>, reh_ccn <chr>, address <chr>

hospitals2(ccn = x$ccn)
#> ✔ hospitals2 returned 2 results.
#> # A tibble: 2 × 38
#>   ccn    org_name     address city  state zip   county phone hosp_type ownership
#> * <chr>  <chr>        <chr>   <chr> <chr> <chr> <chr>  <chr> <chr>     <chr>    
#> 1 114010 PEACHFORD B… 2151 P… ATLA… GA    30338 DE KA… (770… Psychiat… Propriet…
#> 2 114032 SO CRESCENT… 5454 Y… COLL… GA    30349 FULTON (770… Psychiat… Governme…
#> # ℹ 28 more variables: emergency_services <chr>,
#> #   meets_criteria_for_birthing_friendly_designation <chr>, rating <int>,
#> #   hospital_overall_rating_footnote <chr>, mort_group_measure_count <chr>,
#> #   count_of_facility_mort_measures <chr>, count_of_mort_measures_better <chr>,
#> #   count_of_mort_measures_no_different <chr>,
#> #   count_of_mort_measures_worse <chr>, mort_group_footnote <chr>,
#> #   safety_group_measure_count <chr>, …

x <- hospitals2()
#> ═ hospitals2 Totals
#> • Rows  : 5,426
#> • Pages : 4    
#> 
#> ! No Query ❯ Returning first 10 rows...
#> 
x
#> # A tibble: 10 × 38
#>    ccn    org_name    address city  state zip   county phone hosp_type ownership
#>  * <chr>  <chr>       <chr>   <chr> <chr> <chr> <chr>  <chr> <chr>     <chr>    
#>  1 010001 SOUTHEAST … 1108 R… DOTH… AL    36301 HOUST… (334… Acute Ca… Governme…
#>  2 010005 MARSHALL M… 2505 U… BOAZ  AL    35957 MARSH… (256… Acute Ca… Governme…
#>  3 010006 NORTH ALAB… 1701 V… FLOR… AL    35630 LAUDE… (256… Acute Ca… Propriet…
#>  4 010007 MIZELL MEM… 702 N … OPP   AL    36467 COVIN… (334… Acute Ca… Voluntar…
#>  5 010008 CRENSHAW C… 101 HO… LUVE… AL    36049 CRENS… (334… Acute Ca… Propriet…
#>  6 010011 ST. VINCEN… 50 MED… BIRM… AL    35235 JEFFE… (205… Acute Ca… Voluntar…
#>  7 010012 DEKALB REG… 200 ME… FORT… AL    35968 DE KA… (256… Acute Ca… Propriet…
#>  8 010016 SHELBY BAP… 1000 F… ALAB… AL    35007 SHELBY (205… Acute Ca… Voluntar…
#>  9 010018 CALLAHAN E… 1720 U… BIRM… AL    35233 JEFFE… (205… Acute Ca… Voluntar…
#> 10 010019 HELEN KELL… 1300 S… SHEF… AL    35660 COLBE… (256… Acute Ca… Governme…
#> # ℹ 28 more variables: emergency_services <chr>,
#> #   meets_criteria_for_birthing_friendly_designation <chr>, rating <int>,
#> #   hospital_overall_rating_footnote <chr>, mort_group_measure_count <chr>,
#> #   count_of_facility_mort_measures <chr>, count_of_mort_measures_better <chr>,
#> #   count_of_mort_measures_no_different <chr>,
#> #   count_of_mort_measures_worse <chr>, mort_group_footnote <chr>,
#> #   safety_group_measure_count <chr>, …

hospitals(ccn = x$ccn)
#> ✔ hospitals returned 8 results.
#> # A tibble: 8 × 38
#>   enid  enid_state prov_type prov_desc    npi multi ccn   pac   org_name org_dba
#> * <chr> <chr>      <chr>     <chr>      <int> <int> <chr> <chr> <chr>    <chr>  
#> 1 O200… AL         00-09     PART A P… 1.16e9     0 0100… 9436… HOUSTON… SOUTHE…
#> 2 O201… AL         00-09     PART A P… 1.41e9     0 0100… 8527… HH HEAL… MARSHA…
#> 3 O201… AL         00-09     PART A P… 1.48e9     0 0100… 8123… RCHP - … NORTH …
#> 4 O200… AL         00-09     PART A P… 1.01e9     0 0100… 6507… MIZELL … NA     
#> 5 O200… AL         00-09     PART A P… 1.84e9     0 0100… 8921… ST. VIN… ST. VI…
#> 6 O202… AL         00-09     PART A P… 1.77e9     0 0100… 6709… HH HEAL… DEKALB…
#> 7 O201… AL         00-09     PART A P… 1.81e9     0 0100… 7810… BBH SBM… BAPTIS…
#> 8 O201… AL         00-09     PART A P… 1.51e9     0 0100… 1759… HH HEAL… HELEN …
#> # ℹ 28 more variables: inc_date <date>, inc_state <chr>, org_type <chr>,
#> #   org_otxt <chr>, status <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, loc_otxt <chr>, sub_gen <int>, sub_acute <int>,
#> #   sub_adu <int>, sub_child <int>, sub_ltc <int>, sub_psy <int>,
#> #   sub_irf <int>, sub_stc <int>, sub_sba <int>, sub_psu <int>, sub_iru <int>,
#> #   sub_spec <int>, sub_oth <int>, sub_otxt <int>, `REH CONVERSION FLAG` <chr>,
#> #   reh_date <date>, reh_ccn <chr>, address <chr>

hospitals2(state = "GA", rating = 5) |> str()
#> ✔ hospitals2 returned 4 results.
#> tibble [4 × 38] (S3: tbl_df/tbl/data.frame)
#>  $ ccn                                             : chr [1:4] "110050" "110128" "110200" "110237"
#>  $ org_name                                        : chr [1:4] "ADVENTHEALTH MURRAY" "MEMORIAL HEALTH MEADOWS HOSPITAL" "PIEDMONT COLUMBUS REGIONAL NORTHSIDE" "NORTHEAST GEORGIA MEDICAL CENTER LUMPKIN"
#>  $ address                                         : chr [1:4] "707 OLD DALTON ELLIJAY ROAD, PO BOX 1406" "ONE MEADOWS PARKWAY" "100 FRIST COURT" "227 MOUNTAIN DRIVE"
#>  $ city                                            : chr [1:4] "CHATSWORTH" "VIDALIA" "COLUMBUS" "DAHLONEGA"
#>  $ state                                           : chr [1:4] "GA" "GA" "GA" "GA"
#>  $ zip                                             : chr [1:4] "30705" "30474" "31909" "30533"
#>  $ county                                          : chr [1:4] "MURRAY" "TOOMBS" "MUSCOGEE" "LUMPKIN"
#>  $ phone                                           : chr [1:4] "(706) 517-2031" "(912) 535-5828" "(706) 494-2101" "(770) 219-7146"
#>  $ hosp_type                                       : chr [1:4] "Acute Care Hospitals" "Acute Care Hospitals" "Acute Care Hospitals" "Acute Care Hospitals"
#>  $ ownership                                       : chr [1:4] "Voluntary non-profit - Private" "Proprietary" "Proprietary" "Voluntary non-profit - Other"
#>  $ emergency_services                              : chr [1:4] "No" "Yes" "No" "Yes"
#>  $ meets_criteria_for_birthing_friendly_designation: chr [1:4] NA NA NA NA
#>  $ rating                                          : int [1:4] 5 5 5 5
#>  $ hospital_overall_rating_footnote                : chr [1:4] NA NA NA NA
#>  $ mort_group_measure_count                        : chr [1:4] "7" "7" "7" "7"
#>  $ count_of_facility_mort_measures                 : chr [1:4] "3" "5" "5" "3"
#>  $ count_of_mort_measures_better                   : chr [1:4] "0" "0" "0" "0"
#>  $ count_of_mort_measures_no_different             : chr [1:4] "3" "5" "5" "3"
#>  $ count_of_mort_measures_worse                    : chr [1:4] "0" "0" "0" "0"
#>  $ mort_group_footnote                             : chr [1:4] NA NA NA NA
#>  $ safety_group_measure_count                      : chr [1:4] "8" "8" "8" "8"
#>  $ count_of_facility_safety_measures               : chr [1:4] "Not Available" "3" "6" "1"
#>  $ count_of_safety_measures_better                 : chr [1:4] "Not Available" "0" "2" "0"
#>  $ count_of_safety_measures_no_different           : chr [1:4] "Not Available" "3" "4" "1"
#>  $ count_of_safety_measures_worse                  : chr [1:4] "Not Available" "0" "0" "0"
#>  $ safety_group_footnote                           : chr [1:4] "5" NA NA NA
#>  $ readm_group_measure_count                       : chr [1:4] "11" "11" "11" "11"
#>  $ count_of_facility_readm_measures                : chr [1:4] "5" "9" "7" "4"
#>  $ count_of_readm_measures_better                  : chr [1:4] "1" "0" "0" "0"
#>  $ count_of_readm_measures_no_different            : chr [1:4] "4" "9" "7" "4"
#>  $ count_of_readm_measures_worse                   : chr [1:4] "0" "0" "0" "0"
#>  $ readm_group_footnote                            : chr [1:4] NA NA NA NA
#>  $ pt_exp_group_measure_count                      : chr [1:4] "8" "8" "8" "8"
#>  $ count_of_facility_pt_exp_measures               : chr [1:4] "Not Available" "8" "8" "8"
#>  $ pt_exp_group_footnote                           : chr [1:4] "5" NA NA NA
#>  $ te_group_measure_count                          : chr [1:4] "12" "12" "12" "12"
#>  $ count_of_facility_te_measures                   : chr [1:4] "8" "11" "8" "7"
#>  $ te_group_footnote                               : chr [1:4] NA NA NA NA
```
