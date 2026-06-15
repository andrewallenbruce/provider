x <- param_cms(
  npi = npis::generate(200),
  state = state.abb
)

p <- EndpointCMS(
  end = "providers",
  url = url_cms("providers"),
  query = param_cms(
    NPI = npis::generate(200),
    STATE_CD = state.abb
  ) |>
    build()
)

fuimus::random_npi_generator(185)

S7_order_refer <- S7::new_class(
  "S7_order_refer",
  S7::class_call,
  package = NULL
)
# S7_order_refer <- S7_order_refer(str2lang("order_refer"))
# S7_order_refer <- S7_order_refer(rlang::call2("order_refer", .ns = "provider"))
rlang::call_modify(
  S7::S7_data(S7_order_refer),
  first = "Jennifer",
  last = "Smith",
  ptb = FALSE
) |>
  rlang::eval_bare()
