#' @noRd
query_mod <- function(x) {
  M <- is_modifier(x)
  V <- if (M) plus(value(x)) else plus(unlist_(x))
  O <- if (M) {
    operator(x)
  } else if (length(V) > 1L) {
    "IN"
  } else {
    "="
  }
  list(V = V, O = O)
}

#' @autoglobal
#' @noRd
query_pro <- function(x, N) {
  .c(V, O) %=% query_mod(x)

  property <- "conditions[<<i>>][property]="
  operator <- "conditions[<<i>>][operator]="
  value <- "conditions[<<i>>][value]"
  index <- if (length(V) > 1L) "[]=" else "="

  c(
    paste0(property, plus(N)),
    paste0(operator, tolower(plus(O))),
    paste0(value, index, V)
  )
}

#' @autoglobal
#' @noRd
query_cms <- function(x, N) {
  .c(V, O) %=% query_mod(x)

  property <- "filter[<<i>>][condition][path]="
  operator <- "filter[<<i>>][condition][operator]="
  value <- "filter[<<i>>][condition][value]"
  index <- if (length(V) > 1L) paste0("[", seq_along(V), "]=") else "="

  c(
    paste0(property, plus(N)),
    paste0(operator, under(O)),
    paste0(value, index, V)
  )
}
