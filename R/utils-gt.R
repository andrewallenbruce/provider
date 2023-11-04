#' @name gt_entype_badge
#' @title entity type badge
#' @param x column
#' @autoglobal
#' @export
#' @keywords internal
# nocov start
gt_entype_badge <- function(x) {

  add_color <- if (x == "Ind") {

    "background: hsl(116, 60%, 90%); color: hsl(116, 30%, 25%);"

  } else if (x == "Org") {

    "background: hsl(350, 70%, 90%); color: hsl(350, 45%, 30%);"

  } else if (x != "Ind" | x != "Org") {
    x
  }

  div_out <- htmltools::div(
    style = paste("display: inline-block; padding: 2px 12px; border-radius: 15px; font-weight: 600; font-size: 16px;",
                  add_color),
    x)

  as.character(div_out) |> gt::html()
}

#' @name gt_check_xmark
#' @title check or x mark icon
#' @param gt_tbl gt_tbl object
#' @param cols columns in data frame
#' @autoglobal
#' @export
#' @keywords internal
gt_check_xmark <- function(gt_tbl, cols) {

  gt_tbl |>
    gt::text_case_when(
      x == TRUE ~ gt::html(
        fontawesome::fa("check",
                        prefer_type = "solid",
                        fill = "black")),
      x == FALSE ~ gt::html(
        fontawesome::fa("xmark",
                        prefer_type = "solid",
                        fill = "red")),
      .default = NA,
      .locations = gt::cells_body(
        columns = {{ cols }}))
}

#' @name gt_qmark
#' @title check, x, question mark
#' @param gt_tbl gt_tbl object
#' @param cols columns in data frame
#' @autoglobal
#' @export
#' @keywords internal
gt_qmark <- function(gt_tbl, cols) {

  gt_tbl |>
    gt::text_case_when(
      x == "Y" ~ gt::html(
        fontawesome::fa("circle-check",
                        prefer_type = "solid",
                        fill = "black",
                        height = "1.75em",
                        width = "1.75em")),
      x == "N" ~ gt::html(
        fontawesome::fa("circle-xmark",
                        prefer_type = "solid",
                        fill = "red",
                        height = "1.75em",
                        width = "1.75em")),
      x == "M" ~ gt::html(
        fontawesome::fa("circle-question",
                        prefer_type = "solid",
                        fill = "red",
                        height = "1.75em",
                        width = "1.75em")),
      .default = "",
      .locations = gt::cells_body(
        columns = {{ cols }}))
}

#' @name gt_datadict
#' @title data dictionary theme
#' @param df data frame
#' @autoglobal
#' @export
#' @keywords internal
gt_datadict <- function(df) {

  df |>
    gt::gt() |>
    gt::fmt_markdown(columns = Variable) |>
    gtExtras::gt_add_divider(
      columns = c("Variable"), # nolint
      style = "solid",
      color = "gray",
      weight = gt::px(2),
      include_labels = FALSE) |>
    gtExtras::gt_merge_stack(col1 = Description,
                             col2 = Definition,
                             small_cap = FALSE,
                             font_size = c("16px", "14px"),
                             font_weight = c("bold", "normal"),
                             palette = c("black", "darkgray")) |>
    gt::opt_stylize(style = 6,
                    color = "red",
                    add_row_striping = FALSE) |>
    gt::opt_table_lines(extent = "default") |>
    gt::opt_table_outline(style = "none") |>
    gt::opt_table_font(font = gt::google_font(name = "Karla")) |>
    gt::tab_options(table.width = gt::pct(100))

}

#' @name gt_prov
#' @title gt theme
#' @param df data frame
#' @param divider description
#' @param title description
#' @param subtitle description
#' @param source description
#' @param checkmark description
#' @param qmark description
#' @param dollars description
#' @param pct description
#' @param pctchg description
#' @autoglobal
#' @export
#' @keywords internal
gt_prov <- function(df,
                    divider   = NULL,
                    title     = NULL,
                    subtitle  = NULL,
                    source    = NULL,
                    checkmark = NULL,
                    qmark     = NULL,
                    dollars   = NULL,
                    pct       = NULL,
                    pctchg    = NULL,
                    clean     = TRUE) {

  results <- df |>
    gt::gt() |>
    gtExtras::gt_theme_538() |>
    gt::sub_missing(columns = dplyr::everything(), missing_text = "--") |>
    gt::tab_options(table.width = gt::pct(100),
                    column_labels.background.color = "white",
                    column_labels.font.weight = "bolder",
                    heading.background.color = "white",
                    column_labels.border.top.color = "white",
                    column_labels.border.bottom.color = "black",
                    table_body.border.bottom.color = "black")

  if (clean) {
    results <- results |>
      gt::cols_label_with(fn = ~ janitor::make_clean_names(., case = "title"))
  }

  if (!is.null(divider)) {
    results <- results |>
      gtExtras::gt_add_divider(
        columns = {{ divider }},
        style = "solid",
        color = "black",
        weight = gt::px(3),
        include_labels = FALSE)
  }

  if (!is.null(title)) {
    results <- results |> gt::tab_header(title = title)
  }

  if (!is.null(subtitle)) {
    results <- results |> gt::tab_header(title = title, subtitle = subtitle)
  }

  if (!is.null(source)) results <- gt::tab_source_note(results, source_note = source) # nolint

  if (!is.null(checkmark)) {
    results <- results |> gt_check_xmark(cols = checkmark)
  }

  if (!is.null(qmark)) {
    results <- results |> gt_qmark(cols = qmark)
  }

  if (!is.null(dollars)) {
    results <- results |>
      gt::fmt_currency(columns = {{ dollars }},
                       currency = "USD",
                       suffixing = TRUE,
                       sep_mark = ",",
                       incl_space = TRUE)
  }

  if (!is.null(pct)) {
    results <- results |> gt::fmt_percent(columns = {{ pct }}, decimals = 0)
  }

  if (!is.null(pctchg)) {
    results <- results |>
      gt::fmt_percent(columns = {{ pctchg }},
                      decimals = 1,
                      force_sign = TRUE)
  }
  return(results)
}
# nocov end
