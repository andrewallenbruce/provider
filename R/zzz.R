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
  NULL
))

.onLoad <- function(libname, pkgname) {
  S7::methods_register()
}
