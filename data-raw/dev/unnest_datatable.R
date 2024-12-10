unnest_dt <- function(tbl, col) {

  tbl <- data.table::as.data.table(tbl)

  col <- rlang::ensyms(col)

  col_names <- rlang::syms(setdiff(colnames(tbl), as.character(col)))

  tbl <- rlang::eval(
    rlang::expr(
      tbl[,
          as.character(unlist(!!!col)),
          by = list(!!!col_names)])
  )

  colnames(tbl) <- c(as.character(col_names), as.character(col))

  tbl
}


unnest_dt2 <- function(tbl, ...) {

  tbl <- data.table::as.data.table(tbl)

  col <- rlang::ensyms(...)

  clnms <- rlang::syms(setdiff(colnames(tbl), as.character(col)))

  tbl <- data.table::as.data.table(tbl)

  tbl <- rlang::eval(
    rlang::expr(tbl[, lapply(.SD, unlist), by = list(!!!clnms), .SDcols = as.character(col)])
  )

  colnames(tbl) <- c(as.character(clnms), as.character(col))

  tbl
}

#' Unnest data.table List Columns
#'
#' @param x `<data.table>` with nested columns
#'
#' @param cols `<chr>` list-column names
#'
#' @param prefix `<lgl>` or `<chr>` prefix for new columns
#'
#' @returns `<data.table>`
#'
#' @noRd
unnest = function(x, cols, prefix = NULL) {

  for (col in intersect(cols, names(x))) {
    values = x[[col]]
    if (!is.list(values)) {
      next
    }

    tmp = rbindlist2(values)
    if (!is.null(prefix)) {
      setnames(tmp, paste0(gsub("{col}", col, prefix, fixed = TRUE), names(tmp)))
    }

    x = rcbind(remove_named(x, col), tmp)
  }

  x[]
}

#' Unnest data.table List Columns
#'
#' @param x `<data.table>` with nested columns
#'
#' @param cols `<chr>` list-column names
#'
#' @param prefix `<lgl>` or `<chr>` prefix for new columns
#'
#' @returns `<data.table>`
#'
#' @noRd
rbindlist2 = function(values) {

  new_cols = rbindlist(lapply(values, function(row) {

    if (all(lengths(row) == 0L)) {
      return(list("__rbindlist2_dummy__" = NA))
    }

    # wrap non-atomics into an extra list
    ii = which(!map_lgl(row, is.atomic))
    if (length(ii)) {
      row[ii] = lapply(row[ii], list)
    }

    row
  }), fill = TRUE, use.names = TRUE)

  remove_named(new_cols, "__rbindlist2_dummy__")
}

#' Bind Columns by Reference
#'
#' @param x `<data.table>` to add columns to
#'
#' @param y `<data.table>` to take columns from
#'
#' @returns `<data.table>`
#'
#' @noRd
rcbind = function(x, y) {

  if (ncol(x) == 0L)
    return(y)

  if (ncol(y) == 0L)
    return(x)

  if (nrow(x) != nrow(y))
    stopf("Tables have different number of rows (x: %i, y: %i)",
          nrow(x), nrow(y))

  dup = intersect(names(x), names(y))
  if (length(dup)) {
    stopf("Duplicated names: %s", str_collapse(dup))
  }

  ..y = NULL
  x[, (names(y)) := ..y][]
}

#' @noRd
remove_named.data.table = function(x, nn) { # nolint
  nn = intersect(nn, names(x))
  if (length(nn)) {
    x[, (nn) := NULL][]
  }
  x
}

str_wrap = function(str, width = FALSE) {

  if (!width)
    return(str)

  if (width)
    width <- as.integer(0.9 * getOption("width"))

  paste0(strwrap(gsub("[[:space:]]+", " ", str), width = width), collapse = "\n")
}

#' @noRd
stopf = \(msg, ..., wrap = FALSE) {
  stop(simpleError(str_wrap(sprintf(msg, ...), width = wrap), call = NULL))
}
