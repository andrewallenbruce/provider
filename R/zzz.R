# nocov start
.onLoad <- function(libname, pkgname) {
  cms_temporal <<- memoise::memoise(cms_temporal)
  S7::methods_register()
  requireNamespace("pillar", quietly = TRUE)
} # nocov end
