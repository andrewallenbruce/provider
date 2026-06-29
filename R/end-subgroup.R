#' @noRd
Subgroups <- S7::new_class(
  name = "Subgroups",
  parent = S7::class_list,
  package = NULL
)

#' @noRd
is_subgroups <- function(x) {
  S7::S7_inherits(x, Subgroups)
}

#' @noRd
check_subgroups <- function(
  x,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (is_subgroups(x)) {
    return(invisible(NULL))
  }
  cli::cli_abort(
    c(
      "{.arg {arg}} must be a {.cls Subgroups} object, not a {.obj_type_friendly {x}}",
      "i" = "Use {.fn provider::subgroups} to create one"
    ),
    arg = arg,
    call = call
  )
}

#' @noRd
S7::method(print, Subgroups) <- function(x, ...) {
  x <- S7::S7_data(x)
  n <- cheapr::unlisted_length(x)

  cli::cli_text(cli::col_cyan("<Subgroups[{n}]>"))
  if (length(x)) {
    cli::cat_bullet(
      paste0(
        cli::col_yellow(left(names(x))),
        cli::col_silver(" : "),
        left(mark(unname(x)))
      ),
      bullet_col = "silver"
    )
  }
  invisible(x)
}

#' Hospital Subgroups
#'
#' @param acute `<lgl>` Acute/Short Term Care Hospital
#' @param drug `<lgl>` Alcohol/Drug Treatment
#' @param child `<lgl>` Children's Hospital
#' @param general `<lgl>` General Hospital
#' @param long `<lgl>` Long-Term Care
#' @param short `<lgl>` Short-Term Care
#' @param psych `<lgl>` Psychiatric
#' @param rehab `<lgl>` Rehabilitation
#' @param swing `<lgl>` Swing-Bed Approved
#' @param psych_unit `<lgl>` Psychiatric Unit
#' @param rehab_unit `<lgl>` Rehabilitation Unit
#' @param specialty `<lgl>` Specialty Hospital
#' @param other `<lgl>` Unlisted on CMS form
#' @returns An S7 `<Subgroups>` object
#' @examples
#' subgroups(acute = TRUE, rehab = FALSE)
#' subgroups()
#' @export
subgroups <- function(
  acute = NULL,
  drug = NULL,
  child = NULL,
  general = NULL,
  long = NULL,
  short = NULL,
  psych = NULL,
  rehab = NULL,
  swing = NULL,
  psych_unit = NULL,
  rehab_unit = NULL,
  specialty = NULL,
  other = NULL
) {
  check_bool_(general)
  check_bool_(acute)
  check_bool_(drug)
  check_bool_(child)
  check_bool_(long)
  check_bool_(psych)
  check_bool_(rehab)
  check_bool_(short)
  check_bool_(swing)
  check_bool_(psych_unit)
  check_bool_(rehab_unit)
  check_bool_(specialty)
  check_bool_(other)

  x <- purrr::map(
    list(
      `SUBGROUP %2D GENERAL` = general,
      `SUBGROUP %2D ACUTE CARE` = acute,
      `SUBGROUP %2D ALCOHOL DRUG` = drug,
      `SUBGROUP %2D CHILDRENS` = child,
      `SUBGROUP %2D LONG-TERM` = long,
      `SUBGROUP %2D PSYCHIATRIC` = psych,
      `SUBGROUP %2D REHABILITATION` = rehab,
      `SUBGROUP %2D SHORT-TERM` = short,
      `SUBGROUP %2D SWING-BED APPROVED` = swing,
      `SUBGROUP %2D PSYCHIATRIC UNIT` = psych_unit,
      `SUBGROUP %2D REHABILITATION UNIT` = rehab_unit,
      `SUBGROUP %2D SPECIALTY HOSPITAL` = specialty,
      `SUBGROUP %2D OTHER` = other
    ),
    tag_bool
  )

  Subgroups(params(!!!x))
}
