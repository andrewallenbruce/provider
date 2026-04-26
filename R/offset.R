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
offset2 <- function(url, n, limit) {
  purrr::map_chr(
    offset(n, limit, "seq"),
    function(x) {
      sub_idx(url, x)
    }
  )
}

#' @noRd
offset3 <- function(url, n, limit) {
  purrr::map2(url, n, function(y, z) {
    offset2(url = y, n = z, limit = limit)
  })
}
