x

ind <- collapse::ss(x, x[["entity"]] %==% 1L, check = FALSE)
key <- collapse::ss(ind, j = c("npi", "entity"), check = FALSE)

o = rlang::set_names(ind[["other"]], ind[["npi"]]) |>
  cheapr::list_drop_null() |>
  rowbind2("npi", fill = TRUE) |>
  collapse::recode_char("--" = NA_character_)

collapse::recode_char(
  colnames(o),
  "credential" = "cred",
  "first_name" = "first",
  "middle_name" = "middle",
  "last_name" = "last",
  "organization_name" = "org_dba",
  set = TRUE
)

collapse::settransformv(o, "npi", as.integer)
o = collapse::ss(
  o,
  j = colnames(o) %iin% c("npi", "first", "middle", "last", "cred", "org_dba"),
  check = FALSE
)

o = rc_combine(o, "first", "middle", sep = " ")
o = rc_combine(o, "first", "last", sep = " ")
o = rc_combine(o, "first", "cred", sep = ": ")
names(o) <- c("npi", "other")
o


org <- collapse::ss(x, x[["entity"]] %==% 2L, check = FALSE)
key <- collapse::ss(org, j = c("npi", "entity"), check = FALSE)
o = rlang::set_names(org[["other"]], org[["npi"]]) |>
  cheapr::list_drop_null() |>
  rowbind2("npi", fill = TRUE) |>
  collapse::recode_char("--" = NA_character_)
