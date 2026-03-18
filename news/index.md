# Changelog

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
  [`subgroups()`](https://andrewallenbruce.github.io/provider/reference/hospitals.md)
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
  [`subgroups()`](https://andrewallenbruce.github.io/provider/reference/hospitals.md)
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
