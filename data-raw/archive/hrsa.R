snf_dist <- hrsa_select("snf_dist")
snf_dual <- hrsa_select("snf_dual")
snf_all <- hrsa_select("snf_all")

file_path <- function(obj) {
  fs::path(
    fs::path_home("Desktop", "HRSA"),
    obj,
    ext = "csv"
  )
}

readr::write_csv(
  x = snf_dual,
  file = file_path("snf_dual")
)
