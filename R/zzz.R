utils::globalVariables(c(
  "accessURL",
  "describedBy",
  "description",
  "identifier",
  "prog_year",
  "title",
  NULL
))

.onLoad <- function(libname, pkgname) {
  qpp_uuid <<- memoise::memoise(qpp_uuid)
  S7::methods_register()
}
