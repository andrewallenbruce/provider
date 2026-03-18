library(yaml12)


apis <- c(
  main = c(
    hospitals = "Hospital Enrollments",
    laboratories = "Provider of Services File - Clinical Laboratories",
    order_refer = "Order and Referring",
    providers = "Medicare Fee-For-Service  Public Provider Enrollment",
    reassignments = "Revalidation Reassignment List",
    opt_out = "Opt Out Affidavits",
  ),
  other = c(
    affiliations = "Facility Affiliation Data",
    clinicians = "National Downloadable File",
    open_payments = "General Payment Data"
  )
)

x <- list(
  dataset = list(
    pets = c("cat", "dog"),
    numbers = c(1, 2.5, 16, Inf, NA_real_),
    integers = c(1L, 2L, 3L, 16L, NA_integer_),
    flags = list(enabled = TRUE, label = "on"),
    literal = "hello\nworld\n",
    folded = "hello world\n",
    quoted = c("line\nbreak", "quote: 'here'"),
    plain = c("yes", "no"),
    mixed = list("won't simplify", 123L, TRUE)
  )
)

format_yaml(x) |> cat("\n")
