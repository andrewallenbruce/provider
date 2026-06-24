#' @noRd
quality_get <- function(x, y) {
  y <- as.character(y)
  y <- rlang::arg_match0(y, c("2017", "2022", "2023"))
  z <- switch(
    y,
    "2017" = as.character(2017:2021),
    "2022" = "2022",
    "2023" = as.character(2023:2024)
  )

  if (!collapse::has_elem(x, z)) {
    return(list())
  }

  x <- collapse::get_elem(x, z, keep.tree = TRUE) |>
    rowbind2("year", fill = TRUE)

  NMS <- RE_NAME[["quality"]][[y]]

  collapse::setrename(x, NMS, .nse = FALSE)
  replace_nz(x)

  x <- collapse::gv(x, unlist_(NMS)) |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    pivot_quality()

  if (y == "2017") {
    x <- collapse::av(
      x,
      cred = vec_na(x),
      dual_ratio = vec_na(x, "double"),
      small_bonus = vec_na(x, "integer")
    )
  }

  if (y %in% c("2017", "2022")) {
    x <- collapse::av(
      x,
      reporting = vec_na(x),
      mvp = vec_na(x),
      ci_score = vec_na(x, "double")
    )
  }
  return(x)
}

#' @noRd
S7::method(polish, s3_quality) <- function(x) {
  x <- c(2017, 2022, 2023) |>
    purrr::map(\(year) quality_get(x, year)) |>
    collapse::rowbind(fill = TRUE) |>
    add_class("quality")

  x <- recode(x)
  collapse::roworderv(x, c("npi", "year"))
}
