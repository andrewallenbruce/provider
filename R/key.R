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
  i <- vctrs::vec_split(x = cheapr::attrs_rm(id), by = i)
  i[["val"]]
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
as_key <- function(x, threshold) {
  x <- uq(x)

  if (!is.character(x)) {
    x <- as.character(x)
  }

  if (threshold == 1L) {
    return(x)
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
carve <- S7::new_generic("carve", "x")

#' @noRd
S7::method(carve, s3_opted_out) <- function(x, key, threshold) {
  x <- collapse::ss(x, x[["order_refer"]] %==% 1L, check = FALSE)
  key <- rlang::arg_match0(key, c("npi"))
  as_key(x[[key]], threshold = threshold)
}

#' @noRd
S7::method(carve, s3_hospital) <- function(x, key, threshold) {
  key <- rlang::arg_match0(key, c("ccn", "npi", "pac", "enid"))
  as_key(x[[key]], threshold = threshold)
}

#' @noRd
S7::method(carve, s3_providers) <- function(x, key, threshold) {
  key <- rlang::arg_match0(key, c("npi", "pac", "enid"))
  as_key(x[[key]], threshold = threshold)
}
