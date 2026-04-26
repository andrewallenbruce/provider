#' @noRd
data_frame <- function(x, call = caller_env()) {
  check_data_frame(x, call = call)
  structure(x, class = c("tbl_df", "tbl", "data.frame"))
}

#' @noRd
df_tbl_ <- function(x) {
  `class<-`(cheapr::as_df(x), c("tbl_df", "tbl", "data.frame"))
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
provider_types <- function(
  code = NULL,
  type = NULL,
  spec = NULL,
  desc = NULL,
  negate = FALSE
) {
  x <- provider::provider_type_code
  x <- if (!is.null(code)) collapse::ss(x, x$code %iin% code) else x
  x <- if (!is.null(type)) collapse::ss(x, x$type %iin% type) else x
  x <- if (!is.null(spec)) collapse::ss(x, x$spec %iin% spec) else x
  x <- if (!is.null(desc)) {
    collapse::ss(
      x,
      stringr::str_which(x$spec_description, desc, negate = negate)
    )
  } else {
    x
  }
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
set_names2 <- function(x, y, ...) {
  rlang::set_names(x, nm = rlang::names2(y), ...)
}

#' @noRd
rowbind2 <- function(x, nm, fill = FALSE) {
  collapse::rowbind(x, idcol = nm, id.factor = FALSE, return = 4L, fill = fill)
}

#' @noRd
sum2 <- function(x, ...) {
  collapse::fsum(x, na.rm = TRUE, ...)
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
left <- function(x, ...) {
  format(x, justify = "left", ...)
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
