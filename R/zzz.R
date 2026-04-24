utils::globalVariables(c(
  "abort",
  "caller_arg",
  "caller_env",
  "env_get_list",
  "ffi_standalone_check_number_1.0.7",
  "ffi_standalone_is_bool_1.0.7",
  "is_call",
  "is_character",
  "is_closure",
  "is_environment",
  "is_formula",
  "is_function",
  "is_list",
  "is_logical",
  "is_missing",
  "is_na",
  "is_null",
  "is_string",
  "is_symbol",
  "is_vector",
  "na_chr",
  "own_add_1",
  "own_add_2",
  NULL
))

.onLoad <- function(libname, pkgname) {
  hrsa_open <<- memoise::memoise(hrsa_open)
  hrsa_layers <<- memoise::memoise(hrsa_layers)
  S7::methods_register()
}
