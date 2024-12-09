## Dr. Angeline N. Beltsos

nppes <- nppes_npi(first_name = "Angeline", last_name = "Beltsos")

provider_enrollment(last_name = "Beltsos")

doctors_and_clinicians(last_name = "Beltsos")

opt_out(last_name = "Beltsos")

order_refer(last_name = "Beltsos")

revalidation_date(last_name = "Beltsos")

beltsos_op <- open_payments(last_name = "Beltsos", year = 2021)
beltsos_op |>
  dplyr::filter(!is.na(covered)) |>
  janitor::remove_empty(which = c("rows", "cols")) |>
  dplyr::select(!c(profile_id:cov_type,
                   country:payer_id,
                   payer_country,
                   phys_ownship:related_product,
                   covered))

beltsos_op <- 2016:2021 |>
  purrr::map(\(x) open_payments(year = x, npi = 1558404251)) |>
  purrr::list_rbind() |>
  janitor::remove_empty(which = c("rows", "cols")) |>
  dplyr::select(!c(primary_other, specialty_other, license_state_other))

beltsos_op |>
  dplyr::filter(pay_total > 0.00) |>
  dplyr::group_by(payer_name) |>
  dplyr::summarise(payments = dplyr::n(),
                   amount = sum(pay_total)) |>
  dplyr::arrange(dplyr::desc(amount)) |>
  provider:::gt_prov() |>
  gt::fmt_currency(columns = c(amount)) |>
  gt::grand_summary_rows(columns = c(amount),
                         fns =  list(label = "TOTALS",
                                     id = "totals",
                                     fn = "sum"),
                         fmt = ~ gt::fmt_currency(.),
                         side = "bottom")

nppes_npi(npi = 1225701881) |>
  dplyr::filter(purpose == "PRACTICE") |>
  dplyr::glimpse()

kindbody <- c(1225701881,
              1174270805,
              1235702796,
              1962116806,
              1013647569,
              1306500665,
              1982296737,
              1083295638,
              1841967825,
              1891390084,
              1275117269,
              1992338701,
              1891355863,
              1548743511,
              1023473279,
              1861857013,
              1689182859,
              1982059275) |>
  purrr::map(\(x) nppes_npi(npi = x)) |>
  purrr::list_rbind()

kindbody |> dplyr::group_nest(npi)
