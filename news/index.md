# Changelog

## provider 0.0.1.9122 (2026-04-28)

- clean up

## provider 0.0.1.9121 (2026-04-28)

- fixed a bug in polish

## provider 0.0.1.9120 (2026-04-28)

- added
  [`esrd()`](https://andrewallenbruce.github.io/provider/reference/esrd.md)

## provider 0.0.1.9119 (2026-04-27)

- added example for
  [`quality_metrics()`](https://andrewallenbruce.github.io/provider/reference/quality_metrics.md)

## provider 0.0.1.9118 (2026-04-27)

- quality_metrics impl

## provider 0.0.1.9117 (2026-04-27)

- documentation

## provider 0.0.1.9116 (2026-04-27)

- rolled back to manually entering the function name into the base\_\*
  class

## provider 0.0.1.9115 (2026-04-27)

- fixed eval bug in execute

## provider 0.0.1.9114 (2026-04-27)

- completed migration to new execute engine
- added test structure for testing Modifier behavior

## provider 0.0.1.9113 (2026-04-27)

- cleaning, restructuring, dynamic dots removed from use in modifiers
- rebuilt README

## provider 0.0.1.9112 (2026-04-26)

- rebuild README
- file reorganization

## provider 0.0.1.9111 (2026-04-26)

- list_cms class and methods

## provider 0.0.1.9110 (2026-04-25)

- re-rendered README

## provider 0.0.1.9109 (2026-04-25)

- replaced all cms & prov endpoints with new execute method (non-groups)

## provider 0.0.1.9108 (2026-04-25)

- begin moving to new execute method

## provider 0.0.1.9107 (2026-04-25)

- testing base_prov execute method

## provider 0.0.1.9106 (2026-04-25)

- refining execute method

## provider 0.0.1.9105 (2026-04-25)

- testing more integrated S7 endpoint class

## provider 0.0.1.9104 (2026-04-25)

- fixed bug in flatten_opts
  ([\#100](https://github.com/andrewallenbruce/provider/issues/100))

## provider 0.0.1.9103 (2026-04-25)

- added arg check wrappers

## provider 0.0.1.9102 (2026-04-24)

- fixed bug in `req_multi` method for `base_cms` class
- renamed hospital param; dba_name -\> org_dba
- re-rendered README

## provider 0.0.1.9101 (2026-04-24)

- refactored checks for modifiers with dots

## provider 0.0.1.9100 (2026-04-24)

- init S7 execute method

## provider 0.0.1.9099 (2026-04-24)

- streamlining req\_\* methods

## provider 0.0.1.9098 (2026-04-24)

- renamed modifiers `na()`/`not_na()` to
  [`is_blank()`](https://andrewallenbruce.github.io/provider/reference/modifier.md)/[`not_blank()`](https://andrewallenbruce.github.io/provider/reference/modifier.md)
- re-rendered README

## provider 0.0.1.9097 (2026-04-24)

- added enums to
  [`hospitals2()`](https://andrewallenbruce.github.io/provider/reference/hospitals.md)
- added `rc_integer_supp` (as.integer with suppressed NA conversion)

## provider 0.0.1.9096 (2026-04-24)

- added `set` param to prov endpoints

## provider 0.0.1.9095 (2026-04-24)

- added fqhc\_\* endpoints

## provider 0.0.1.9094 (2026-04-24)

- fix to rhc_owner recode method

## provider 0.0.1.9093 (2026-04-24)

- polish methods for both rhc endpoints

## provider 0.0.1.9092 (2026-04-24)

- refactored polish_recode methods

## provider 0.0.1.9091 (2026-04-24)

- updated S7 dependency
- filled out
  [`rhc_enroll()`](https://andrewallenbruce.github.io/provider/reference/rhc_enroll.md)
  structure

## provider 0.0.1.9090 (2026-04-18)

- initial rhc\_\* impls

## provider 0.0.1.9089 (2026-04-17)

- quality impl setup

## provider 0.0.1.9088 (2026-04-17)

- Completed initial S7 url/request implementation

## provider 0.0.1.9087 (2026-04-17)

- switch to new execute methods

## provider 0.0.1.9086 (2026-04-17)

- execute method for multiple APIs

## provider 0.0.1.9085 (2026-04-17)

- checks, print methods

## provider 0.0.1.9084 (2026-04-16)

- more checks for modifiers

## provider 0.0.1.9083 (2026-04-16)

- testing S7 methods with CMS endpoints

## provider 0.0.1.9082 (2026-04-16)

- S7 url class/methods

## provider 0.0.1.9081 (2026-04-15)

- building S7 url base class

## provider 0.0.1.9080 (2026-04-15)

- fixed bug in `RC_clinicians`
- updated dependencies
- init url class/execute method

## provider 0.0.1.9079 (2026-04-15)

- rebuild README

## provider 0.0.1.9078 (2026-04-15)

- polish methods

## provider 0.0.1.9077 (2026-04-15)

- added `not_na()` modifier

## provider 0.0.1.9076 (2026-04-15)

- [`hospitals()`](https://andrewallenbruce.github.io/provider/reference/hospitals.md)
  fixes

## provider 0.0.1.9075 (2026-04-15)

- added more `recode_with` implementations

## provider 0.0.1.9074 (2026-04-15)

- added helpers for building queries

## provider 0.0.1.9073 (2026-04-13)

- fixed bug in modifiers
- fixed bug in enum
- rebuilt README

## provider 0.0.1.9072 (2026-04-13)

- added enums

## provider 0.0.1.9071 (2026-04-13)

- init recode\_\* methods

## provider 0.0.1.9070 (2026-04-12)

- experimenting with S7 query build

## provider 0.0.1.9069 (2026-04-12)

- differentiate between a “count” call and a “query + count” call

## provider 0.0.1.9068 (2026-04-12)

- fixed bug in `exec_cms2()`
- re-render readme

## provider 0.0.1.9067 (2026-04-11)

- documentation, typos

## provider 0.0.1.9066 (2026-04-11)

- added parameters to
  [`clia()`](https://andrewallenbruce.github.io/provider/reference/clia.md)
- updated dependencies

## provider 0.0.1.9065 (2026-04-11)

- added `set` parameter

## provider 0.0.1.9064 (2026-04-05)

- url object

## provider 0.0.1.9063 (2026-03-23)

- fixed bug in `exec_cms2()`

## provider 0.0.1.9062 (2026-03-23)

- added
  [`hospitals2()`](https://andrewallenbruce.github.io/provider/reference/hospitals.md)
  endpoint

## provider 0.0.1.9061 (2026-03-20)

- refactored hrsa functions

## provider 0.0.1.9060 (2026-03-20)

- added
  [`hrsa_select()`](https://andrewallenbruce.github.io/provider/reference/hrsa.md),
  `provider_types()`

## provider 0.0.1.9059 (2026-03-20)

- `hrsa` functionality,.
  [`nppes()`](https://andrewallenbruce.github.io/provider/reference/nppes.md)
  refactoring

## provider 0.0.1.9058 (2026-03-19)

- nppes work

## provider 0.0.1.9057 (2026-03-18)

- added `api_medicare2`

## provider 0.0.1.9056 (2026-03-18)

- added exec_cms2

## provider 0.0.1.9055 (2026-03-18)

- refactored query formatting
- added arguments to
  [`hospitals()`](https://andrewallenbruce.github.io/provider/reference/hospitals.md)

## provider 0.0.1.9054 (2026-03-17)

- modifier cleanup

## provider 0.0.1.9053 (2026-03-17)

- Modifier refactoring

## provider 0.0.1.9052 (2026-03-17)

- A warning is now thrown when 0 results are returned, instead of a
  ‘success’ message

## provider 0.0.1.9051 (2026-03-17)

- rebuild readme, documentation
- [`hospitals()`](https://andrewallenbruce.github.io/provider/reference/hospitals.md)’
  [`subgroups()`](https://andrewallenbruce.github.io/provider/reference/subgroups.md)
  helper now exported
- `cli_hybrid` for calls to different APIs within one function

## provider 0.0.1.9050 (2026-03-16)

- `pending` APIs (hybrid) restructuring
- added checks for API-specific modifiers

## provider 0.0.1.9049 (2026-03-16)

- Query modifiers are now an S7 class

## provider 0.0.1.9048 (2026-03-16)

- partially fixed bug in modifiers

## provider 0.0.1.9047 (2026-03-16)

- documentation, notes

## provider 0.0.1.9046 (2026-03-15)

- refining `exec_` functionality

## provider 0.0.1.9045 (2026-03-15)

- checks for parameters not allowed to use query modifiers

## provider 0.0.1.9044 (2026-03-15)

- cleaning up query logic

## provider 0.0.1.9043 (2026-03-14)

- [`transparency()`](https://andrewallenbruce.github.io/provider/reference/transparency.md)
  is now working correctly

## provider 0.0.1.9042 (2026-03-14)

- tweaking `query()` functionality

## provider 0.0.1.9041 (2026-03-14)

- tweaking `exec_*` functionality

## provider 0.0.1.9040 (2026-03-14)

- [`pending()`](https://andrewallenbruce.github.io/provider/reference/pending.md)
  now queries both endpoints

## provider 0.0.1.9039 (2026-03-14)

- added
  [`transparency()`](https://andrewallenbruce.github.io/provider/reference/transparency.md)
  endpoint

## provider 0.0.1.9038 (2026-03-14)

- added type checks to modifier function args
- API-calling functions now use `exec_cms()` or `exec_prov()` framework
- API-calling examples now call
  [`httr2::is_online()`](https://httr2.r-lib.org/reference/is_online.html)

## provider 0.0.1.9037 (2026-03-12)

- a LOT of cleaning up

## provider 0.0.1.9036 (2026-03-12)

- Generalized both API flows into new `exec_*` functions

## provider 0.0.1.9035 (2026-03-12)

- added
  [`revocations()`](https://andrewallenbruce.github.io/provider/reference/revocations.md)
  endpoint

## provider 0.0.1.9034 (2026-03-12)

- tweaking control flow of each api

## provider 0.0.1.9033 (2026-03-12)

- added `enum_()` helper for enum function args

## provider 0.0.1.9032 (2026-03-11)

- added `count` arg to api calls

## provider 0.0.1.9031 (2026-03-11)

- documentation, tweaking error handling

## provider 0.0.1.9030 (2026-03-11)

- tweaking helpers

## provider 0.0.1.9029 (2026-03-10)

- modifiers working for both api syntaxes
- cleaning up

## provider 0.0.1.9028 (2026-03-10)

- cleaned up old files

## provider 0.0.1.9027 (2026-03-10)

- added
  [`subgroups()`](https://andrewallenbruce.github.io/provider/reference/subgroups.md)
  helper
- added `cdc_labs` CLIA example dataset

## provider 0.0.1.9026 (2026-03-10)

- re-rendered `README.Rmd`

## provider 0.0.1.9025 (2026-03-10)

- removed old dependencies
- vignette & article cleaning

## provider 0.0.1.9024 (2026-03-10)

- refactored
  [`hospitals()`](https://andrewallenbruce.github.io/provider/reference/hospitals.md)

## provider 0.0.1.9023 (2026-03-09)

- refactored `laboratories()`

## provider 0.0.1.9022 (2026-03-09)

- spring cleaning

## provider 0.0.1.9021 (2026-03-09)

- modifier tweaking

## provider 0.0.1.9020 (2026-03-09)

- refactored
  [`reassignments()`](https://andrewallenbruce.github.io/provider/reference/reassignments.md)
- added Provider Type Code Reference dataset

## provider 0.0.1.9019 (2026-03-08)

- refactored
  [`opt_out()`](https://andrewallenbruce.github.io/provider/reference/opt_out.md)
- added `modifier` class

## provider 0.0.1.9018 (2026-03-08)

- another round of mothballing/tweaking

## provider 0.0.1.9017 (2026-03-08)

- abstracting away some repeated code

## provider 0.0.1.9016 (2026-03-07)

- refactored
  [`order_refer()`](https://andrewallenbruce.github.io/provider/reference/order_refer.md)

## provider 0.0.1.9015 (2026-03-07)

- mothballed several functions to concentrate on a smaller subset

## provider 0.0.1.9014 (2026-03-07)

- refactored
  [`providers()`](https://andrewallenbruce.github.io/provider/reference/providers.md)

## provider 0.0.1.9013 (2026-03-06)

- api catalog helpers

## provider 0.0.1.9012 (2026-03-06)

- refactored
  [`clinicians()`](https://andrewallenbruce.github.io/provider/reference/clinicians.md)

## provider 0.0.1.9011 (2026-03-06)

- tinkering with affiliations

## provider 0.0.1.9010 (2026-03-05)

- clean up

## provider 0.0.1.9009 (2026-03-04)

- simplified formatting queries

## provider 0.0.1.9008 (2026-03-04)

- removed several unused deps, tests

## provider 0.0.1.9007 (2026-03-03)

- affiliations fleshing out

## provider 0.0.1.9006 (2026-03-02)

- query helpers

## provider 0.0.1.9005 (2026-03-02)

- [`affiliations()`](https://andrewallenbruce.github.io/provider/reference/affiliations.md)
  refinement

## provider 0.0.1.9004 (2026-03-02)

- [`affiliations()`](https://andrewallenbruce.github.io/provider/reference/affiliations.md)
  refactoring

## provider 0.0.1.9003 (2026-02-26)

- fixed bug in internal `format_param()`
- removed R-CMD-check gh action for now

## provider 0.0.1.9002 (2026-02-26)

- more spring cleaning
- roxyglobals version corrected

## provider 0.0.1.9001 (2026-02-26)

- beginning of clean-up/overhaul
- quality_payment reworking
- fixed bug in betos cols function and subsequent failing test
- fixed bug due to standalone-helpers update
- pkgdown theming
- updated standalone-helpers
- removed gt, gtExtras, fontawesome and htmltools from dependencies
- moved rxnorm and strex to Suggests
- moved summary_stats to fuimus
- updated standalone-helpers from fuimus
- rebuild readme
- fix more warnings and errors
- removed zipcodeR dependency
- disabled zip code formatting in `tidyup` post-processing
- removed add_counties
- imported standalone-helpers
- unexported calculations functions
- slight article clean up
- rename format_api_params .R file
- quality_payment rewriting
- formatting_api_params rewrite
- added helpers
- removed lifecycle svgs from man directory
- removed lifecycle as a dependency
- quality payment rewrite
- first pass at cms_distributions reimplementation
- removed assets folder in pkgdown dir
- imported standalone-cli functions
- tmp fix for quality_payment bug
- removed 13 dependencies only needed for pkgdown articles
- documentation cleanup
- removed chronic conditions functions, as their endpoints have
  disappeared
- fix: bug in change
  ([\#85](https://github.com/andrewallenbruce/provider/issues/85))
- fix: failing tests
- all functions now use validate_npi()
  ([\#17](https://github.com/andrewallenbruce/provider/issues/17))
- fix vignette
- added tests
- article update
- test fixes
- added dint::as_y() class for year cols

## provider 0.0.1

- first version release

## provider 0.0.0.9010 (2023-02-08)

- added hospital_enrollment() function

## provider 0.0.0.9009 (2023-02-08)

- implemented cms_update_ids() to applicable functions

## provider 0.0.0.9008 (2023-02-07)

- added addl_phone_numbers() function
- added nucc_taxonomy_230 dataset
- added examples for new functions

## provider 0.0.0.9007 (2023-02-04)

- doctors_and_clinicians() function
- facility_affiliations() function

## provider 0.0.0.9006 (2023-02-03)

- pending_applications() function

## provider 0.0.0.9005 (2023-01-22)

- nesting larger outputs

## provider 0.0.0.9004 (2023-01-21)

- initial implementation of distribution id update functions
- open_payments() vignette

## provider 0.0.0.9003 (2023-01-16)

- open_payments() function added

## provider 0.0.0.9001 (2022-08-31)

- Updated README.
