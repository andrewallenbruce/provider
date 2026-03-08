<!-- NEWS.md is maintained by https://cynkra.github.io/fledge, do not edit -->

# provider 0.0.1.9015 (2026-03-07)

* mothballed several functions to concentrate on a smaller subset


# provider 0.0.1.9014 (2026-03-07)

* refactored `providers()`


# provider 0.0.1.9013 (2026-03-06)

* api catalog helpers


# provider 0.0.1.9012 (2026-03-06)

* refactored `clinicians()`


# provider 0.0.1.9011 (2026-03-06)

* tinkering with affiliations


# provider 0.0.1.9010 (2026-03-05)

* clean up


# provider 0.0.1.9009 (2026-03-04)

* simplified formatting queries


# provider 0.0.1.9008 (2026-03-04)

* removed several unused deps, tests


# provider 0.0.1.9007 (2026-03-03)

* affiliations fleshing out


# provider 0.0.1.9006 (2026-03-02)

* query helpers


# provider 0.0.1.9005 (2026-03-02)

* `affiliations()` refinement


# provider 0.0.1.9004 (2026-03-02)

* `affiliations()` refactoring


# provider 0.0.1.9003 (2026-02-26)

* fixed bug in internal `format_param()`
* removed R-CMD-check gh action for now


# provider 0.0.1.9002 (2026-02-26)

* more spring cleaning
* roxyglobals version corrected


# provider 0.0.1.9001 (2026-02-26)

* beginning of clean-up/overhaul
* quality_payment reworking
* fixed bug in betos cols function and subsequent failing test
* fixed bug due to standalone-helpers update
* pkgdown theming
* updated standalone-helpers
* removed gt, gtExtras, fontawesome and htmltools from dependencies
* moved rxnorm and strex to Suggests
* moved summary_stats to fuimus
* updated standalone-helpers from fuimus
* rebuild readme
* fix more warnings and errors
* removed zipcodeR dependency
* disabled zip code formatting in `tidyup` post-processing
* removed add_counties
* imported standalone-helpers
* unexported calculations functions
* slight article clean up
* rename format_api_params .R file
* quality_payment rewriting
* formatting_api_params rewrite
* added helpers
* removed lifecycle svgs from man directory
* removed lifecycle as a dependency
* quality payment rewrite
* first pass at cms_distributions reimplementation
* removed assets folder in pkgdown dir
* imported standalone-cli functions
* tmp fix for quality_payment bug
* removed 13 dependencies only needed for pkgdown articles
* documentation cleanup
* removed chronic conditions functions, as their endpoints have disappeared
* fix: bug in change (#85)
* fix: failing tests
- all functions now use validate_npi() (#17)
- fix vignette
- added tests
- article update
- test fixes
- added dint::as_y() class for year cols

# provider 0.0.1

* first version release

# provider 0.0.0.9010 (2023-02-08)

* added hospital_enrollment() function


# provider 0.0.0.9009 (2023-02-08)

* implemented cms_update_ids() to applicable functions


# provider 0.0.0.9008 (2023-02-07)

* added addl_phone_numbers() function
* added nucc_taxonomy_230 dataset
* added examples for new functions


# provider 0.0.0.9007 (2023-02-04)

* doctors_and_clinicians() function
* facility_affiliations() function


# provider 0.0.0.9006 (2023-02-03)

* pending_applications() function


# provider 0.0.0.9005 (2023-01-22)

* nesting larger outputs


# provider 0.0.0.9004 (2023-01-21)

* initial implementation of distribution id update functions
* open_payments() vignette


# provider 0.0.0.9003 (2023-01-16)

* open_payments() function added


# provider 0.0.0.9001 (2022-08-31)

- Updated README.


