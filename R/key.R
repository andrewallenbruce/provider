#' @noRd
key <- S7::new_generic("key", "x")

#' @noRd
Key <- S7::new_class(
  "Key",
  S7::class_character,
  package = NULL,
  properties = list(
    size = S7::new_property(
      S7::class_integer,
      default = 150L
    ),
    length = S7::new_property(
      S7::class_integer,
      getter = function(self) collapse::fnobs(self)
    ),
    chunks = S7::new_property(
      S7::class_integer,
      getter = function(self) {
        if (self@length == 0L) {
          return(0L)
        }
        cheapr::seq_size(1L, self@length, self@size)
      }
    ),
    split = S7::new_property(
      S7::class_list,
      getter = function(self) {
        if (self@chunks <= 1L) {
          return()
        }
        chunk(
          self,
          self@chunks,
          self@size,
          self@length
        )
      }
    )
  )
)

#' @noRd
is_key <- function(x) {
  S7::S7_inherits(x, Key)
}

#' @noRd
check_key <- function(
  x,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (!is_key(x)) {
    cli::cli_abort(
      "{.arg {arg}} must be a {.cls {Key}} object, not {.obj_type_friendly {x}}",
      arg = arg,
      call = call
    )
  }
}

#' @noRd
chunk <- function(x, chunks, size, length) {
  idx <- cheapr::rep_each_(seq_len(chunks), size) |>
    cheapr::sset(seq_len(length))

  vctrs::vec_split(cheapr::attrs_rm(x), idx)$val
}

#' @noRd
extract_key <- function(x) {
  check_key(x)
  if (x@length == 0L) {
    return(NULL)
  }
  if (x@chunks == 1L) {
    return(S7::S7_data(x))
  }
  return(x)
}

#' @noRd
S7::method(key, s3_opt_out) <- function(x) {
  x <- collapse::ss(
    x = x,
    i = x[["order_refer"]] %==% 1L,
    j = "npi",
    check = FALSE
  )
  x <- unlist_(x)
  x <- collapse::funique(collapse::na_rm(x))
  x <- as.character(x)
  k <- Key(x, 150L)
  extract_key(k)
}

#' @noRd
S7::method(key, s3_hospitals) <- function(x) {
  x <- collapse::funique(collapse::na_rm(x[["ccn"]]))
  k <- Key(x, 200L)
  extract_key(k)
}
