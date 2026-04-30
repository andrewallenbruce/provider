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

