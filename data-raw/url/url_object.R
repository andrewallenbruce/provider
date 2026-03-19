get_uri <- function(x) {
  switch(
    x,
    clinicians = ,
    affiliations = paste0(
      "https://data.cms.gov/provider-data/api/1/datastore/query/<<uuid>>/0?",
      "schema=false&keys=true&format=json&rowIds=false&count=true&"
    ),
    "https://data.cms.gov/data-api/v1/dataset/<<uuid>>/data<<end>>"
  )
}

get_uuid <- function(x) {
  switch(
    x,
    affiliations = "27ea-46a8",
    clinicians = "mj5m-pzi6",
    providers = "2457ea29-fc82-48b0-86ec-3b0755de7515",
    opt_out = "9887a515-7552-4693-bf58-735c77af46d7",
    order_refer = "c99b5865-1119-4436-bb80-c5af2773ea1f",
    hospitals = "f6f6505c-e8b0-4d57-b258-e2b94133aaf2",
    clia = "d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16",
    reassignments = "20f51cff-4137-4f3a-b6b7-bfc9ad57983b",
    revocations = "a6496a7d-4e19-479a-a9ad-d4c0a49e07c3",
    transparency = "6a3aa708-3c9d-411a-a1a4-e046d3ade7ef",
    quality = "7adb8b1b-b85c-4ed3-b314-064776e50180",
    rhc = list(
      Enrollment = "3b7e7659-067e-41ea-8e36-f9ee2036e1f6",
      Owners = "ab03c9bc-0c22-4ca4-b032-21dd3408210d"
    ),
    fqhc = list(
      Enrollment = "4bcae866-3411-439a-b762-90a6187c194b",
      Owners = "ed289c89-0bb8-4221-a20a-85776066381b"
    ),
    pending = list(
      Physician = "6bd6b1dd-208c-4f9c-88b8-b15fec6db548",
      `Non-Physician` = "261b83b6-b89f-43ad-ae7b-0d419a3bc24b"
    ),
    utilization = list(
      geography = "6fea9d79-0129-4e4c-b1b8-23cd86a4f435",
      provider = "8889d81e-2ee7-448f-8713-f071038289b5",
      service = "92396110-2aed-4d63-a6a2-5d6207d46a29"
    ),
    cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
  )
}

cms <- list(
  uri = "https://data.cms.gov/data-api/v1/dataset/<<uuid>>/data<<end>>",
  uid = "2457ea29-fc82-48b0-86ec-3b0755de7515",
  end = list(stats = "/stats?", qmk = "?"),
  opt = list(size = 10, offset = 0)
)

prov <- list(
  uri = "https://data.cms.gov/provider-data/api/1/datastore/query/<<uuid>>/0?",
  uid = "mj5m-pzi6",
  opt = "schema=false&keys=true&format=json&rowIds=false&count=true&",
  results = "true",
  offset = 0,
  limit = 10
)

Endpoint <- S7::new_class(
  "Endpoint",
  package = NULL,
  properties = list(
    uri = S7::class_character | S7::class_list,
    end = S7::class_list,
    offset = S7::class_integer,
    limit = S7::class_integer
  )
)

Medicare <- S7::new_class(
  "Medicare",
  Endpoint,
  package = NULL,
  constructor = function(endpoint, limit = 10L, offset = 0L) {
    S7::new_object(
      Endpoint,
      uri = glue::glue(
        "https://data.cms.gov/data-api/v1/dataset/{get_uuid(endpoint)}/data<<end>>"
      ),
      end = list(stats = "/stats?", qmk = "?"),
      limit = limit,
      offset = offset
    )
  }
)

x <- Medicare("providers")

count <- S7::new_generic("count", "x")

S7::method(count, Medicare) <- function(x) {
  glue::glue(
    x@uri,
    .open = "<<",
    .close = ">>",
    end = x@end$stats
  )
}

count(x)

bare <- S7::new_generic("bare", "x")

S7::method(bare, Medicare) <- function(x) {
  paste0(
    glue::glue(
      x@uri,
      .open = "<<",
      .close = ">>",
      end = x@end$qmk
    ),
    paste0(c("offset", "size"), "=", c(x@offset, x@limit), collapse = "&")
  )
}

bare(x)

S7::set_props(x, limit = 5000L, .check = FALSE)

constants("providers")


Endpoint(
  uri = "https://data.cms.gov/provider-data/api/1/datastore/query/<<uuid>>/0?",
  uid = "mj5m-pzi6",
  end = "schema=false&keys=true&format=json&rowIds=false&count=true&",
  opt = list(results = "true", limit = 10L, offset = 0L)
)
