
#' @param pac < *integer* > 10-digit individual provider associate level variable
#' @autoglobal
#' @noRd
individuals <- function(pac) {

  p <- providers(pac = pac)

  if (isTRUE(vctrs::vec_is_empty(p))) {
    cli::cli_abort(c("x" = "{.val {pac}} returned no results."),
                   call = rlang::caller_env())
  }

  enroll_id <- enroll_ind_check(p$enroll_id)

  d <- revalidation_date(enroll_id = enroll_id)

  if (isTRUE(vctrs::vec_is_empty(d))) {
    cli::cli_abort(c("x" = "{.val {enroll_id}} returned no results."),
                   call = rlang::caller_env())
  }

  r <- revalidation_reassign(pac_ind = pac)

  if (isTRUE(vctrs::vec_is_empty(r))) {
    cli::cli_abort(c("x" = "{.val {pac}} returned no results."),
                   call = rlang::caller_env())
  }

  c <- clinicians(pac = pac)

  if (isTRUE(vctrs::vec_is_empty(c))) {
    cli::cli_abort(c("x" = "{.val {pac}} returned no results."),
                   call = rlang::caller_env())
  }

  c$phone_org  <- NULL
  c$assign_ind <- NULL
  c$assign_org <- NULL

  dplyr::full_join(p, d) |>
    dplyr::full_join(r) |>
    dplyr::full_join(c)

}
