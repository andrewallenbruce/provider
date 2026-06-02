utils::globalVariables(c(
  "accessURL",
  "describedBy",
  "description",
  "identifier",
  "title",
  NULL
))

.onLoad <- function(libname, pkgname) {
  uuid_cms_list <<- memoise::memoise(uuid_cms_list)
  S7::methods_register()
}
