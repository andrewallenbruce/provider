utils::globalVariables(c(
  "accessURL",
  "describedBy",
  "description",
  "identifier",
  "title",
  NULL
))

.onLoad <- function(libname, pkgname) {
  temporal_uuid <<- memoise::memoise(temporal_uuid)
  S7::methods_register()
}
