#' (to - from) / by
#' cheapr::seq_size(from = 1L, to = 500, by = 150)
#'
#' @param id `<int>` Vector of identifiers, i.e., NPIs, CCNs. ENIDs, PACs
#' @param threshold `<int>` Length at which `id` should repeatedly split into chunk
#' @param length `<int>` Number of elements in `id` vector
#' @param chunks `<int>` Number of chunks `id` vector will be split into
#' @noRd
chunk <- function(id, threshold, length, chunks) {
  i <- seq_len(chunks)
  i <- cheapr::rep_each_(i, threshold)
  i <- cheapr::sset(i, seq_len(length))

  vctrs::vec_split(cheapr::attrs_rm(id), i)$val
}

#' @noRd
Key <- S7::new_class(
  "Key",
  S7::class_character,
  package = NULL,
  properties = list(
    threshold = S7::new_property(
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
        if (self@length <= self@threshold) {
          return(1L)
        }
        cheapr::seq_size(1L, self@length, self@threshold)
      }
    ),
    split = S7::new_property(
      S7::class_list,
      getter = function(self) {
        if (self@chunks <= 1L) {
          return()
        }
        chunk(self, self@chunks, self@threshold, self@length)
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
as_key <- function(x, threshold = 150L) {
  x <- uq(x)

  if (!is.character(x)) {
    x <- as.character(x)
  }

  x <- Key(x, threshold = threshold)

  if (x@length == 0L) {
    return(NULL)
  }
  if (x@chunks == 1L) {
    return(S7::S7_data(x))
  }
  return(x)
}

#' @noRd
shave <- S7::new_generic("shave", "x")

#' @noRd
S7::method(shave, s3_opt_out) <- function(x) {
  x <- collapse::ss(
    x = x,
    i = x[["order_refer"]] %==% 1L,
    j = "npi",
    check = FALSE
  )

  x <- unlist_(x)
  as_key(x, 150L)
}

#' @noRd
S7::method(shave, s3_hospitals) <- function(x) {
  as_key(x[["ccn"]], 200L)
}

#' @noRd
S7::method(shave, s3_providers) <- function(x) {
  uq(x[["npi"]])
}
