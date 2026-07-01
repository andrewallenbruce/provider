# end = S7::new_property(S7::class_character, setter = function(self, value) self@end <- rlang::eval_bare(EndPoint),

PROTO <- function(x) {
  switch(
    x,
    proto = "type",
    cli::cli_abort("{.arg x} {.val {x}} is invalid.")
  )
}

base_proto <- S7::new_class(
  "base_proto",
  properties = list(
    end = S7::new_property(S7::class_character, default = EndPoint),
    # url = S7::new_property(S7::class_character, getter = function(self) PROTO(self@end)),
    count = S7::class_logical,
    set = S7::class_logical,
    arg = arg_cms
  )
)

proto <- function(
  city = NULL,
  state = NULL,
  zip = NULL,
  compliant = NULL,
  active = NULL,
  count = FALSE,
  set = FALSE
) {
  base_proto(
    count = count,
    set = set,
    arg = param_cms(
      CITY_NAME = city,
      STATE_CD = state,
      ZIP_CD = zip
    )
  )
}
base_proto()
proto(city = "valdosta")


fac_type = list(
  hospital = "Hospital",
  ltch = "Long-term care hospital",
  nurse = "Nursing home",
  irf = "Inpatient rehabilitation facility",
  hha = "Home health agency",
  snf = "Skilled nursing facility",
  hospice = "Hospice",
  esrd = "Dialysis facility"
)
# <hospitals>
prov_type = list(
  hospital = "00-09",
  reh = "00-24",
  cah = "00-85"
)

Enum <- S7::new_class(
  "Enum",
  package = NULL,
  properties = list(
    end = S7::new_property(S7::class_character, default = EndPoint),
    # url = S7::new_property(S7::class_character, getter = function(self) PROTO(self@end)),
    count = S7::class_logical,
    set = S7::class_logical,
    arg = arg_cms
  )
)

tag_enum <- function(x = NULL, call = rlang::caller_env()) {
  if (is.null(x)) {
    return(NULL)
  }

  VAR <- rlang::as_string(rlang::call_args(rlang::call_match())$x)

  ENUM <- enumerations(VAR)

  x <- rlang::arg_match(
    arg = x,
    values = rlang::names2(ENUM),
    multiple = TRUE,
    error_arg = VAR,
    error_call = call
  )

  unlist_(ENUM[x])
}
