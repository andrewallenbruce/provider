# the <- NULL
# the <- new.env(parent = emptyenv())
#
# .onLoad <- function(libname, pkgname) {
#   S7::methods_register()
#   catalogs <<- memoise::memoise(catalogs)
#   endpoint <<- memoise::memoise(endpoint)
#   rlang::run_on_load()
# }
#
# the$clog <- catalogs()
# the$aka <- make_aka()
# the$col <- make_col()
