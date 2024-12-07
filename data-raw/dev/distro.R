`%==%` <- collapse::`%==%`

datasets <- c(
  hospitals = "^Hospital Enrollments",
  providers = "^Medicare Fee-For-Service  Public Provider Enrollment",
  crosswalk = "^Medicare Provider and Supplier Taxonomy Crosswalk",
  orderrefer = "^Order and Referring",
  pending = "^Pending Initial Logging and Tracking",
  quality_payment = "^Quality Payment Program Experience",
  rbcs = "^Restructured BETOS Classification System",
  reassignment = "^Revalidation Clinic Group Practice Reassignment",
  optout = "^Opt Out Affidavits",
  utilization = "^Medicare Physician & Other Practitioners",
  outpatient = "^Medicare Outpatient Hospitals",
  laboratories = "^Provider of Services File - Clinical Laboratories",
  beneficiaries = "^Medicare Monthly Enrollment",
  prescribers = "^Medicare Part D Prescribers"
)

cms_distro <- \() {
  resp <- httr2::request("https://data.cms.gov/data.json") |>
    httr2::req_perform()

  resp <- arknpi::as_date(
    regmatches(resp[["headers"]][["Last-Modified"]],
    regexpr("[0-9]{2} [A-Za-z]{3} [0-9]{4}",
            resp[["headers"]][["Last-Modified"]],
            perl = TRUE)),
    fmt = "%d %b %Y")

  arrow_cms <- arrow::read_json_arrow(
    file = "https://data.cms.gov/data.json",
    col_select = c("dataset"))

  arrow_cms <- arrow_cms[["dataset"]][[1]][
    c("title", "modified", "distribution")] |>
    collapse::fsubset(
      codex::sf_detect(
        title,
        codex::sf_smush(
          unname(datasets), "|")
        )
      ) |>
    tidyr::unnest(
      cols = distribution,
      names_sep = "_",
      keep_empty = TRUE) |>
    collapse::fsubset(
      distribution_format %==% "API") |>
    collapse::fcompute(
      year = as.integer(
        regmatches(
          distribution_title,
          regexpr(
            "\\d{4}(?=-\\d{2}-\\d{2})",
            distribution_title,
            perl = TRUE))),
      modified = as.Date.character(distribution_modified),
      distribution = regmatches(
        distribution_accessURL,
        regexpr(
          "(?<=dataset/).*?(?=/data)",
          distribution_accessURL,
          perl = TRUE)),
      keep = "title") |>
    collapse::fsubset(
      data.table::rleid(
        title,
        year,
        modified) != collapse::flag(
        data.table::rleid(
          title,
          year,
          modified
          ),
        -1)
      )

  list(
    last_modified = resp,
    distributions = arrow_cms
    )
}

c(
  "Managing Clinician Aggregation Group Performance",
  "Quarterly Prescription Drug Plan Formulary, Pharmacy Network, and Pricing Information",
  "Medicare Clinical Laboratory Fee Schedule Private Payer Rates and Volumes",
  "Hospital Price Transparency Enforcement Activities and Outcomes",
  "Federally Qualified Health Center Enrollments",
  "Rural Health Clinic Enrollments"
)


body <- RcppSimdJson::fparse(
  resp$body
)[["dataset"]][
  c("title",
    "modified",
    "distribution")]



unnest_dt <- function(tbl, col) {

  tbl <- data.table::as.data.table(tbl)

  col <- rlang::ensyms(col)

  col_names <- rlang::syms(setdiff(colnames(tbl), as.character(col)))

  tbl <- rlang::eval(
    rlang::expr(
      tbl[,
          as.character(unlist(!!!col)),
          by = list(!!!col_names)])
  )

  colnames(tbl) <- c(as.character(col_names), as.character(col))

  tbl
}


unnest_dt2 <- function(tbl, ...) {

  tbl <- data.table::as.data.table(tbl)

  col <- rlang::ensyms(...)

  clnms <- rlang::syms(setdiff(colnames(tbl), as.character(col)))

  tbl <- data.table::as.data.table(tbl)

  tbl <- rlang::eval(
    rlang::expr(tbl[, lapply(.SD, unlist), by = list(!!!clnms), .SDcols = as.character(col)])
  )

  colnames(tbl) <- c(as.character(clnms), as.character(col))

  tbl
}
