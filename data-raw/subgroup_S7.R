#' @noRd
prop_sub <- S7::new_property(S7::new_union(NULL, S7::class_logical))

#' @noRd
subgroup <- S7::new_class(
  name = "subgroup",
  package = NULL,
  properties = list(
    `SUBGROUP %2D GENERAL` = prop_sub,
    `SUBGROUP %2D ACUTE CARE` = prop_sub,
    `SUBGROUP %2D ALCOHOL DRUG` = prop_sub,
    `SUBGROUP %2D CHILDRENS` = prop_sub,
    `SUBGROUP %2D LONG-TERM` = prop_sub,
    `SUBGROUP %2D PSYCHIATRIC` = prop_sub,
    `SUBGROUP %2D REHABILITATION` = prop_sub,
    `SUBGROUP %2D SHORT-TERM` = prop_sub,
    `SUBGROUP %2D SWING-BED APPROVED` = prop_sub,
    `SUBGROUP %2D PSYCHIATRIC UNIT` = prop_sub,
    `SUBGROUP %2D REHABILITATION UNIT` = prop_sub,
    `SUBGROUP %2D SPECIALTY HOSPITAL` = prop_sub,
    `SUBGROUP %2D OTHER` = prop_sub
  ),
  constructor = function(
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
    S7::new_object(
      S7::S7_object(),
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
    )
  }
)

#' @noRd
is_subgroup <- function(x) {
  S7::S7_inherits(x, subgroup)
}

x <- purrr::map(purrr::compact(S7::props(x)), bool_)
