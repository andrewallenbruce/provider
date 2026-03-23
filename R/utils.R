#' Parameter list helper
#'
#' @param ... dots
#' @keywords internal
#' @export
params <- function(...) {
  purrr::compact(rlang::list2(...))
}

#' @noRd
offset <- function(n, limit, which = "size") {
  check_number_whole(n, min = 0)
  check_number_whole(limit, min = 1)

  if (n == 0L) {
    return(0L)
  }

  if (n <= limit) {
    return(
      switch(
        which,
        size = 1L,
        seq = 0L
      )
    )
  }

  switch(
    which,
    size = cheapr::seq_size(0L, n, limit),
    seq = cheapr::seq_(0L, n, limit)
  )
}

#' @noRd
uuid_from_url <- function(x) {
  stringr::str_extract(
    x,
    pattern = paste(
      "(?:[0-9a-fA-F]){8}",
      "(?:[0-9a-fA-F]){4}",
      "(?:[0-9a-fA-F]){4}",
      "(?:[0-9a-fA-F]){4}",
      "(?:[0-9a-fA-F]){12}",
      sep = "-?"
    )
  )
}

#' @noRd
extract_year <- function(x) {
  as.integer(stringr::str_extract(x, "[12]{1}[0-9]{3}"))
}

#' @noRd
sub_idx <- function(what, with) {
  gsub(
    x = what,
    pattern = "<<i>>",
    replacement = with,
    fixed = TRUE
  )
}

#' @noRd
provider_types <- function(code = NULL, type = NULL, spec = NULL) {
  x <- provider::provider_type_code
  x <- if (!is.null(code)) collapse::ss(x, x$code %iin% code) else x
  x <- if (!is.null(type)) collapse::ss(x, x$type %iin% type) else x
  x <- if (!is.null(spec)) collapse::ss(x, x$spec %iin% spec) else x
  return(x)
}

#' @noRd
set_args <- function(fn) {
  invisible(
    list2env(
      as.list(
        rlang::fn_fmls(fn)
      ),
      envir = .GlobalEnv
    )
  )
}

#' @noRd
any2 <- function(x) {
  collapse::anyv(x, TRUE)
}

#' @noRd
all2 <- function(x) {
  collapse::allv(x, TRUE)
}

#' @noRd
mark <- function(x) {
  prettyNum(x, big.mark = ",")
}

#' @noRd
plus <- function(x) {
  gsub(" ", "+", x, fixed = TRUE)
}

#' @noRd
under <- function(x) {
  gsub(" ", "_", x, fixed = TRUE)
}

#' @noRd
unlist_ <- function(x) {
  unlist(x, use.names = FALSE)
}

#' @noRd
has_letter <- function(x) {
  grepl("[A-Z]", x, ignore.case = TRUE, perl = TRUE)
}

#' @noRd
is_numeric <- function(x) {
  !has_letter(x)
}

#' @noRd
to_string <- function(x) {
  purrr::map_chr(x, \(i) toString(unlist_(i), width = NULL))
}
