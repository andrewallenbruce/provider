Enum <- S7::new_class(
  "Enum",
  package = NULL,
  properties = list(
    param = S7::class_character,
    remap = S7::class_list,
    choices = S7::new_property(
      S7::class_character,
      getter = function(self) names2(self@remap)
    )
  )
)

enum_acr_org <- Enum(
  "acr_org",
  list(
    a2la = "A2LA_ACRDTD_Y_MATCH_SW",
    aabb = "AABB_ACRDTD_Y_MATCH_SW",
    aoa = "AOA_ACRDTD_Y_MATCH_SW",
    ashi = "ASHI_ACRDTD_Y_MATCH_SW",
    cap = "CAP_ACRDTD_Y_MATCH_SW",
    cola = "COLA_ACRDTD_Y_MATCH_SW",
    jcaho = "JCAHO_ACRDTD_Y_MATCH_SW"
  )
)

proto <- function(acr_org = NULL) {
  if (is.null(acr_org)) {
    return(NULL)
  }
  if (!all2(acr_org %in% enum_acr_org@choices)) {
    v <- cli::cli_vec(enum_acr_org@choices, list("vec-last" = " or "))
    cli::cli_abort(
      "{.arg acr_org} must be {.emph one or more} of: {.val {v}}.",
      call = rlang::caller_call()
    )
  }
  x <- enum_acr_org@remap[acr_org]
  set_names(as.list(rep.int("Y", length(x))), x)
}

proto(acr_org = c("a2la", "aabb"))
