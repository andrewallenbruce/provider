uuid <- function(end) {
  switch(
    end,
    providers = "2457ea29-fc82-48b0-86ec-3b0755de7515",
    opt_out = "9887a515-7552-4693-bf58-735c77af46d7",
    order_refer = "c99b5865-1119-4436-bb80-c5af2773ea1f",
    hospitals = "f6f6505c-e8b0-4d57-b258-e2b94133aaf2",
    clia = "d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16",
    reassignments = "20f51cff-4137-4f3a-b6b7-bfc9ad57983b",
    revocations = "a6496a7d-4e19-479a-a9ad-d4c0a49e07c3",
    transparency = "6a3aa708-3c9d-411a-a1a4-e046d3ade7ef",
    cli::cli_abort("{.arg end} {.val {endpoint}} is invalid.")
  )
}

new_url <- function(
  base = character(),
  opts = list(),
  args = list()
) {
  structure(
    list(
      base = base,
      opts = opts,
      args = args
    ),
    class = "url"
  )
}

cms_url <- function(end, action = c("count", "results"), args = NULL) {
  structure(
    new_url(
      base = paste0(
        "https://data.cms.gov/data-api/v1/dataset/",
        uuid(end),
        "/data",
        switch(
          rlang::arg_match(action),
          count = "/stats?",
          results = "?"
        )
      ),
      opts = params(size = 1500L, offset = 0L),
      args = args %&&% query(end, args)
    ),
    class = c("cms", "url")
  )
}

cms_url(.c(providers), args = list(provider = contains("sdgkjhskg")))
