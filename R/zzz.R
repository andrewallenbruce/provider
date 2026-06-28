# nocov start
.onLoad <- function(libname, pkgname) {
  cms_temporal <<- memoise::memoise(cms_temporal)
  S7::methods_register()
} # nocov end
