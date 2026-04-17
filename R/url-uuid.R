#' @noRd
uuid_cms2 <- function(endpoint) {
  switch(
    endpoint,
    clia = "d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16",
    hospitals = "f6f6505c-e8b0-4d57-b258-e2b94133aaf2",
    opt_out = "9887a515-7552-4693-bf58-735c77af46d7",
    order_refer = "c99b5865-1119-4436-bb80-c5af2773ea1f",
    pending = list(
      Physician = "6bd6b1dd-208c-4f9c-88b8-b15fec6db548",
      `Non-Physician` = "261b83b6-b89f-43ad-ae7b-0d419a3bc24b"
    ),
    providers = "2457ea29-fc82-48b0-86ec-3b0755de7515",
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
    utilization = list(
      Geography = "6fea9d79-0129-4e4c-b1b8-23cd86a4f435",
      Provider = "8889d81e-2ee7-448f-8713-f071038289b5",
      Service = "92396110-2aed-4d63-a6a2-5d6207d46a29"
    ),

    cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
  )
}

#' @noRd
uuid_prov2 <- function(endpoint) {
  switch(
    endpoint,
    affiliations = "27ea-46a8",
    clinicians = "mj5m-pzi6",
    hospitals2 = "xubh-q36u",
    cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
  )
}
