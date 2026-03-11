#' @autoglobal
#' @noRd
convert_lgl <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }
  cheapr::val_match(
    x,
    TRUE ~ "Y",
    FALSE ~ "N"
  )
}

#' @autoglobal
#' @noRd
params <- function(...) {
  purrr::compact(rlang::list2(...))
}

#' @autoglobal
#' @noRd
opts <- function(
  count = NULL,
  results = NULL,
  schema = NULL,
  size = NULL,
  limit = NULL,
  offset = 0
) {
  x <- params(
    count = count,
    results = results,
    schema = schema,
    size = size,
    limit = limit,
    offset = offset
  )
  paste0(names(x), "=", unlist_(x), collapse = "&")
}

#' @autoglobal
#' @noRd
url_ <- function(base, opts, query = NULL) {
  if (is.null(query)) {
    paste0(base, opts)
  } else {
    paste(paste0(base, opts), query, sep = "&")
  }
}

#' @autoglobal
#' @noRd
offset <- function(n, limit, which = "size") {
  if (n == 0L) {
    return(0L)
  }

  switch(
    which,
    size = cheapr::seq_size(from = 0L, to = n, by = limit),
    seq = cheapr::seq_(from = 0L, to = n, by = limit)
  )
}

#' @noRd
base_url <- function(endpoint) {
  a <- "https://data.cms.gov/"
  p <- \(id) paste0(a, "provider-data/api/1/datastore/query/", id, "/0?")
  m <- \(id) paste0(a, "data-api/v1/dataset/", id, "/data")
  switch(
    endpoint,
    affiliations = p("27ea-46a8"),
    clinicians = p("mj5m-pzi6"),
    providers = m("2457ea29-fc82-48b0-86ec-3b0755de7515"),
    opt_out = m("9887a515-7552-4693-bf58-735c77af46d7"),
    order_refer = m("c99b5865-1119-4436-bb80-c5af2773ea1f"),
    hospitals = m("f6f6505c-e8b0-4d57-b258-e2b94133aaf2"),
    laboratories = m("d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16"),
    reassignments = m("20f51cff-4137-4f3a-b6b7-bfc9ad57983b"),
    rhcs = list(
      owner = m("ab03c9bc-0c22-4ca4-b032-21dd3408210d"),
      enroll = m("3b7e7659-067e-41ea-8e36-f9ee2036e1f6")
    ),
    fqhcs = list(
      owner = m("ed289c89-0bb8-4221-a20a-85776066381b"),
      enroll = m("4bcae866-3411-439a-b762-90a6187c194b")
    ),
    pending = list(
      non = m("261b83b6-b89f-43ad-ae7b-0d419a3bc24b"),
      phys = m("6bd6b1dd-208c-4f9c-88b8-b15fec6db548")
    ),
    revocations = m("a6496a7d-4e19-479a-a9ad-d4c0a49e07c3"),
    transparency = m("6a3aa708-3c9d-411a-a1a4-e046d3ade"),
    quality_payment = m("7adb8b1b-b85c-4ed3-b314-064776e50180"),
    utilization = list(
      geography = m("6fea9d79-0129-4e4c-b1b8-23cd86a4f435"),
      provider = m("8889d81e-2ee7-448f-8713-f071038289b5"),
      service = m("92396110-2aed-4d63-a6a2-5d6207d46a29")
    ),
    cli::cli_abort("{.arg endpoint} {.val {endpoint}} not recognized")
  )
}

#' @noRd
limit <- function(endpoint) {
  switch(
    endpoint,
    affiliations = ,
    clinicians = 1500L,
    5000L
  )
}

#' @noRd
constants <- function(endpoint) {
  list(
    url = base_url(endpoint),
    limit = limit(endpoint),
    names = renames(endpoint)
  )
}
