# nocov start
.onLoad <- function(libname, pkgname) {
  temporal_uuid <<- memoise::memoise(temporal_uuid)
  S7::methods_register()
} # nocov end
