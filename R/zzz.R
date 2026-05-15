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
  S7::methods_register()
}
