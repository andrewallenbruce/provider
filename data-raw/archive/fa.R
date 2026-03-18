fontawesome::fa(
  "book-medical",
  height = "2em",
  prefer_type = "solid",
  fill = "#A6081A"
)

fontawesome::fa(
  "staff-snake",
  height = "5em",
  prefer_type = "solid",
  fill = "#202C56"
)

"as fa-at"

fontawesome::fa("i", height = "5em", prefer_type = "solid", fill = "#202C56")
fontawesome::fa("o")

fontawesome::fa(
  "person",
  height = "5em",
  prefer_type = "solid",
  fill = "#202C56"
)

fontawesome::fa("person-shelter")
fontawesome::fa("people-roof")
fontawesome::fa("people-line")
fontawesome::fa("people-group")
fontawesome::fa("people-arrows")
fontawesome::fa("scroll")

fontawesome::fa(
  "r-project",
  height = "2em",
  prefer_type = "solid",
  fill = "#A6081A"
)

fontawesome::fa("prescription")
fontawesome::fa("prescription-bottle")
fontawesome::fa("prescription-bottle-medical")
fontawesome::fa("pills")

fontawesome::fa("people-arrows")
fontawesome::fa("notes-medical")

fontawesome::fa("lungs")
fontawesome::fa("lungs-virus")
fontawesome::fa("laptop-medical")

fontawesome::fa("layer-group")
fontawesome::fa("kit-medical")


fontawesome::fa("address-card")
fontawesome::fa("id-card")
fontawesome::fa("id-card-clip")

fontawesome::fa("house-medical")
fontawesome::fa("house-medical-circle-check")
fontawesome::fa("house-medical-circle-exclamation")
fontawesome::fa("house-medical-circle-xmark")
fontawesome::fa("house-medical-flag")
fontawesome::fa("house-chimney-medical")

fontawesome::fa("hospital")
fontawesome::fa("hospital-user")
fontawesome::fa("hand-holding-medical")
fontawesome::fa("flask-vial")

fontawesome::fa("file-medical")
fontawesome::fa("eye")
fontawesome::fa("arrows-to-eye")
fontawesome::fa("arrows-down-to-people")
fontawesome::fa("explosion")
fontawesome::fa("comment-medical")
fontawesome::fa("capsules")
fontawesome::fa("briefcase-medical")
fontawesome::fa("bacterium")

library(fontawesome)
library(gt)

fa_icons_vec <- c()

for (i in seq_len(nrow(fontawesome:::fa_tbl))) {
  icon_svg_i <- as.character(fontawesome::fa(fontawesome:::fa_tbl[i, ][[
    "full_name"
  ]]))
  fa_icons_vec <- c(fa_icons_vec, icon_svg_i)
}

fontawesome:::fa_tbl |>
  dplyr::tibble() |>
  dplyr::select(icon = name, label, icon_name = name, full_name) |>
  dplyr::mutate(icon = fa_icons_vec) |>
  gt() |>
  fmt_markdown(columns = icon) |>
  cols_label(
    icon = ""
  ) |>
  cols_label_with(fn = function(x) gsub("_", " ", x)) |>
  tab_style(
    style = list(
      cell_text(
        font = system_fonts(name = "monospace-code"),
        size = px(12)
      ),
      cell_borders(
        sides = c("l", "r"),
        color = "lightblue",
        weight = px(1.5)
      )
    ),
    locations = cells_body(columns = -icon)
  ) |>
  tab_style(
    style = css(position = "sticky", top = "-1em", `z-index` = 10),
    locations = cells_column_labels()
  ) |>
  tab_style(
    style = cell_fill(color = "lightblue"),
    locations = cells_body(columns = icon)
  ) |>
  cols_align(align = "center", columns = icon) |>
  cols_width(
    icon ~ px(50),
    label ~ px(200),
    icon_name ~ px(200),
    full_name ~ px(230)
  ) |>
  opt_all_caps() |>
  opt_stylize(style = 6) |>
  tab_options(
    table.border.top.style = "hidden",
    column_labels.border.bottom.style = "hidden",
    container.height = px(490)
  ) |>
  opt_interactive(
    active = FALSE,
    use_search = TRUE,
    use_filters = TRUE
  )


xx <- utilization(year = 2021, npi = 1043477615, type = "Service", rbcs = FALSE)

rbcs_util(xx)
betos(hcpcs = "0001U", )
