#' @noRd
#' @autoglobal
api_provider <- function() {
  rex <- paste0(
    c(
      "Facility Affiliation Data",
      "National Downloadable File",
      "Long-Term Care Hospital",
      "Inpatient Rehabilitation Facility",
      "Hospital General Information",
      "Hospice",
      "Home Health Care",
      "Dialysis Facility",
      "Ambulatory Surgical Center",
      "Birthing Friendly Hospitals"
    ),
    collapse = "|"
  )

  RcppSimdJson::fload(
    "https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items"
  ) |>
    collapse::sbt(stringr::str_which(title, rex)) |>
    collapse::gv(c(
      "title",
      "released",
      "description",
      "identifier",
      "landingPage",
      "nextUpdateDate"
    )) |>
    collapse::roworderv(c("title", "released")) |>
    df_tbl_()
}

#' @noRd
#' @autoglobal
api_medicare <- function() {
  rex <- paste0(
    c(
      "Public Provider Enrollment",
      "Order and Refer",
      "Opt Out Affidavits",
      "Hospital Enrollment",
      "Clinical Laboratories",
      "Pending Initial",
      "Revalidation",
      "Medicare Physician & Other Practitioners",
      "Medicare Part D Prescribers",
      "Quality Payment Program Experience",
      "Rural Health Clinic",
      "Revoked Medicare Providers and Suppliers",
      "Hospital Price Transparency Enforcement Activities and Outcomes",
      "Federally Qualified Health Center",
      "^Skilled Nursing Facility",
      "Hospital & Non-Hospital Facilities",
      "Medicare Inpatient Hospitals",
      "Medicare Outpatient Hospitals",
      "Medicare Dialysis Facilities",
      "Long-Term Care Facility Characteristics",
      "Hospice",
      "Home Health Agency",
      "Hospital Change",
      "Hospital Provider Cost Report",
      "Income and Asset Ownership",
      "Nursing Home Chain",
      "Payroll Based Journal"
    ),
    collapse = "|"
  )

  RcppSimdJson::fload(
    json = "https://data.cms.gov/data.json",
    query = "/dataset"
  ) |>
    collapse::sbt(stringr::str_which(title, rex)) |>
    collapse::gv(c("title", "modified", "description", "identifier")) |>
    collapse::roworderv(c("title", "modified")) |>
    df_tbl_()
}

#' @noRd
uuid_from_url <- function(x) {
  stringr::str_extract(
    x,
    pattern = paste(
      "(?:[0-9a-fA-F]){8}",
      "(?:[0-9a-fA-F]){4}",
      "(?:[0-9a-fA-F]){4}",
      "(?:[0-9a-fA-F]){4}",
      "(?:[0-9a-fA-F]){12}",
      sep = "-?"
    )
  )
}

#' @noRd
extract_year <- function(x) {
  as.integer(stringr::str_extract(x, "[12]{1}[0-9]{3}"))
}

#' @noRd
#' @autoglobal
api_medicare2 <- function(x) {
  rex <- paste0(
    c(
      # "Public Provider Enrollment",
      # "Order and Refer",
      # "Opt Out Affidavits",
      # "Hospital Enrollment",
      # "Clinical Laboratories",
      # "Pending Initial",
      # "Revalidation",
      # "Rural Health Clinic",
      # "Revoked Medicare Providers and Suppliers",
      # "Hospital Price Transparency Enforcement Activities and Outcomes",
      # "Federally Qualified Health Center",
      "^Skilled Nursing Facility",
      "Hospital & Non-Hospital Facilities",
      "Medicare Inpatient Hospitals",
      "Medicare Outpatient Hospitals",
      "Medicare Dialysis Facilities",
      "Long-Term Care Facility Characteristics",
      "Hospice",
      "Home Health Agency",
      "Hospital Change",
      "Hospital Provider Cost Report",
      "Income and Asset Ownership",
      "Nursing Home Chain",
      "Payroll Based Journal"
    ),
    collapse = "|"
  )

  ss_na <- \(x) cheapr::sset(x, cheapr::which_(cheapr::row_na_counts(x) < 3L))

  x <- RcppSimdJson::fload(
    json = "https://data.cms.gov/data.json",
    query = "/dataset"
  )

  d <- collapse::get_elem(x, "distribution") |>
    collapse::rowbind(fill = TRUE) |>
    collapse::fcompute(
      year = extract_year(title),
      title = gsub(
        " : [0-9]{4}-[0-9]{2}-[0-9]{2}([0-9A-Za-z]{1,3})?$",
        "",
        title,
        perl = TRUE
      ),
      format = cheapr::if_else_(
        cheapr::is_na(description),
        format,
        description
      ),
      identifier = accessURL
    ) |>
    collapse::roworderv(c("title", "year"), decreasing = c(FALSE, TRUE))

  d <- ss_na(d)

  x <- collapse::mtt(
    x,
    uuid = uuid_from_url(identifier),
    dictionary = describedBy,
    .keep = c("title", "description", "identifier")
  ) |>
    collapse::join(
      collapse::sbt(d, format %==% "latest", "title"),
      on = "title",
      verbose = 0,
      multiple = TRUE
    ) |>
    collapse::roworderv("title") |>
    collapse::colorderv(c("title", "description"))

  x <- ss_na(x)

  d <- collapse::sbt(d, format %!=% "latest", -format) |>
    collapse::roworderv(c("title", "year"), decreasing = c(FALSE, TRUE)) |>
    collapse::sbt(!cheapr::is_na(identifier)) |>
    collapse::join(
      collapse::gv(x, c("title", "description", "dictionary")),
      on = "title",
      verbose = 0,
      multiple = TRUE
    ) |>
    collapse::sbt(stringr::str_which(
      title,
      pattern = paste0(
        c(
          "Medicare Physician & Other Practitioners",
          "Medicare Part D Prescribers",
          "Quality Payment Program Experience"
        ),
        collapse = "|"
      )
    ))

  x <- collapse::ss(x, stringr::str_which(x$title, rex))
  x <- collapse::ss(
    x,
    stringr::str_which(x$title, "CMS Program Statistics", TRUE)
  )

  list(
    current = df_tbl_(x),
    temporal = df_tbl_(d) |>
      collapse::rsplit(~title)
  )
}
