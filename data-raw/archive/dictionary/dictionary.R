## Code
code <- function(var, lvl, lbl) {
  cheapr::new_df(
    var = var,
    lvl = lvl,
    lbl = lbl
  ) |>
    df_tbl_()
}

code("SEX", c(0L, 1L), c("Male", "Female"))

## Codebook
codebook <- function(...) {
  map <- rlang::list2(...)

  rlang::names2(map) <- purrr::map_chr(map, function(x) x$var[1])

  return(map)
}

cb <- codebook(
  code("SEX", lvl = 0:1, lbl = c("Male", "Female")),
  code("STUDY", lvl = 1:3, lbl = c("S1", "S2", "S3"))
)
cb

## Encode
encode <- function(data, codebook) {
  mapped_vars <- rlang::names2(codebook)

  mapped_data <- purrr::map2(
    data,
    rlang::names2(data),
    function(x, var, m) {
      if (!var %in% mapped_vars) {
        return(x)
      }

      x <- factor(x, levels = m[[var]]$lvl, labels = m[[var]]$lbl)

      return(x)
    },
    m <- codebook
  )
  cheapr::as_df(mapped_data) |>
    df_tbl_()
}

labels <- codebook(
  code("SEX", 0:1, c("Male", "Female")),
  code("STUDY", 1:3, c("S1", "S2", "S3"))
)

dataset <- cheapr::new_df(
  STUDY = c(1L, 1L, 1L, 2L, 2L, 2L),
  SEX = c(0L, 0L, 1L, 1L, 1L, 0L),
  AGE = c(32L, 18L, 64L, 52L, 26L, 80L)
)

encode(dataset, labels)

## Decode
decode <- function(data, codebook) {
  mapped_vars <- rlang::names2(codebook)

  mapped_data <- purrr::map2(
    data,
    rlang::names2(data),
    function(x, var, m) {
      if (!var %in% mapped_vars) {
        return(x)
      }

      x_chr <- as.character(x)

      x_lvl <- m[[var]]$lvl

      x_lab <- m[[var]]$lbl

      x <- x_lvl[collapse::fmatch(x_chr, x_lab)]

      return(x)
    },
    m <- codebook
  )
  cheapr::as_df(mapped_data) |>
    df_tbl_()
}

labels <- codebook(
  code("SEX", c(0L, 1L), c("Male", "Female")),
  code("STUDY", c(1L, 2L, 3L), c("S1", "S2", "S3"))
)

dataset <- cheapr::new_df(
  STUDY = factor(c("S1", "S1", "S1", "S2", "S2", "S2")),
  SEX = factor(c("Male", "Male", "Female", "Female", "Female", "Male")),
  AGE = c(32L, 18L, 64L, 52L, 26L, 80L)
)

decode(dataset, labels)
