# The Quality Payment Program (QPP) Experience dataset provides
# participation and performance information in the Merit-based
# Incentive Payment System (MIPS) during each performance year.
# They cover eligibility and participation, performance categories,
# and final score and payment adjustments. The dataset provides
# additional details at the TIN/NPI level on what was published in
# the previous performance year. You can sort the data by variables
# like clinician type, practice size, scores, and payment adjustments.
#
# https://data.cms.gov/resources/quality-payment-program-experience-data-dictionary
#
# x <- api_medicare2()
# x$current |>
#   fastplyr::as_tbl() |>
#   collapse::sbt(title == "Quality Payment Program Experience") |>
#   _$identifier
#
# x$temporal$`Quality Payment Program Experience`
