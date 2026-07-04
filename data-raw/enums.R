library(enum)
cert_type = list(
  cmp = 1,
  wav = 2,
  acr = 3,
  ppm = 4,
  reg = 9
)
certificate <- enum::enum(
  cmp = 1,
  wav = 2,
  acr = 3,
  ppm = 4,
  reg = 9
)
certificate(c("acr", "reg"))

clia(sites = 20, certificate = c("acr", "reg"))



#' @noRd
certificate <- enum::enum(
  cmp = 1,
  wav = 2,
  acr = 3,
  ppm = 4,
  reg = 9
)

#' @noRd
accrediting <- enum::enum(
  a2la = "A2LA_ACRDTD_Y_MATCH_SW",
  aabb = "AABB_ACRDTD_Y_MATCH_SW",
  aoa = "AOA_ACRDTD_Y_MATCH_SW",
  ashi = "ASHI_ACRDTD_Y_MATCH_SW",
  cap = "CAP_ACRDTD_Y_MATCH_SW",
  cola = "COLA_ACRDTD_Y_MATCH_SW",
  jcaho = "JCAHO_ACRDTD_Y_MATCH_SW"
)

accrediting <- enum::Enum(
  name = "accrediting",
  a2la = "A2LA_ACRDTD_Y_MATCH_SW",
  aabb = "AABB_ACRDTD_Y_MATCH_SW",
  aoa = "AOA_ACRDTD_Y_MATCH_SW",
  ashi = "ASHI_ACRDTD_Y_MATCH_SW",
  cap = "CAP_ACRDTD_Y_MATCH_SW",
  cola = "COLA_ACRDTD_Y_MATCH_SW",
  jcaho = "JCAHO_ACRDTD_Y_MATCH_SW",
  transform = function(x) {
    rlang::set_names(as.list(rep.int("Y", length(x))), x)
  }
)
