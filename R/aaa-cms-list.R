#' @noRd
cms_temporal <- function(rex = NULL, as_list = TRUE) {
  x <- RcppSimdJson::fload(
    json = "https://data.cms.gov/data.json",
    query = "/dataset"
  ) |>
    collapse::get_elem(elem = "distribution") |>
    collapse::rowbind(fill = TRUE)

  if (!is.null(rex)) {
    x <- collapse::ss(
      x,
      grep(rex, x[["title"]], perl = TRUE),
      check = FALSE
    )
  }

  cheapr::lag_(x[["downloadURL"]], -1L, set = TRUE)

  i_1 <- !cheapr::is_na(x[["accessURL"]])
  i_2 <- cheapr::is_na(x[["description"]])

  x <- collapse::ss(
    x,
    cheapr::which_(i_1 & i_2),
    c(
      "title",
      "modified",
      "temporal",
      "accessURL",
      "resourcesAPI",
      "downloadURL"
    ),
    check = FALSE
  )

  if (is.null(rex)) {
    x[["title"]] <- purrr::map_chr(
      strsplit(
        x = x[["title"]],
        split = " : ",
        fixed = TRUE
      ),
      function(x) purrr::pluck(x, 1)
    )
    return(collapse::qTBL(x))
  }

  if (!as_list) {
    return(collapse::qTBL(x))
  }

  rlang::set_names(
    as.list(uuid_from_url(x[["accessURL"]])),
    extract_year(x[["title"]])
  )
}

#' @noRd
url_cms_list <- function(x) {
  x <- switch(
    x,
    pending = list(
      Physician = "6bd6b1dd-208c-4f9c-88b8-b15fec6db548",
      `Non-Physician` = "261b83b6-b89f-43ad-ae7b-0d419a3bc24b"
    ),
    facility = list(
      HHA = "15f64ab4-3172-4a27-b589-ebd67a6d28aa",
      RHC = "3b7e7659-067e-41ea-8e36-f9ee2036e1f6",
      FQHC = "4bcae866-3411-439a-b762-90a6187c194b",
      SNF = "5f2c306f-3b1c-42cd-b037-187b2ce22126",
      Hospice = "25704213-e833-4b8b-9dbc-58dd17149209"
    ),
    owner = list(
      HHA = "fc009b2d-7846-44b1-b4a1-692f0c143879",
      RHC = "ab03c9bc-0c22-4ca4-b032-21dd3408210d",
      FQHC = "ed289c89-0bb8-4221-a20a-85776066381b",
      SNF = "a4358712-e910-4eaf-8f24-5e90ba3cf8d0",
      Hospice = "e983965e-1603-4cb8-82b5-c40090e380d1",
      Hospital = "60625dc8-b621-45f0-9423-077fd133b13e"
    ),
    quality = cms_temporal("^Quality"),
    inpatient = cms_temporal("Inpatient Hospitals - by Provider :"),
    outpatient = cms_temporal("Outpatient Hospitals - by Provider"),
    utilization = cms_temporal("Practitioners - by Provider :"),
    services = cms_temporal("Practitioners - by Provider and Service :"),
    geography = cms_temporal("Practitioners - by Geography and Service :"),
    cli::cli_abort(
      "{.strong {.pkg CMS LIST} Endpoint} `{.field {x}}` not found."
    )
  )

  a <- "https://data.cms.gov/data-api/v1/dataset/"
  z <- "/data"

  set_names2(as.list(paste0(a, x, z)), x)
}

#' @noRd
end_cmslist <- function(
  count = FALSE,
  set = FALSE,
  select = NULL,
  ...,
  end = NULL
) {
  if (is.null(end)) {
    end <- rlang::eval_bare(
      rlang::call_name(rlang::caller_call()),
      parent.frame(3)
    )
  }

  x <- param_cms(...)

  url <- url_cms_list(end)

  if (!is.null(select)) {
    select <- as.character(select)
    select <- rlang::arg_match(
      select,
      rlang::names2(url),
      multiple = TRUE
    )
    url <- url[collapse::fmatch(select, rlang::names2(url), nomatch = 0L)]
  }

  x <- EndpointCMSList(
    end = end,
    url = url,
    query = build(x) %||% character(0),
    action = count_set(count, set)
  )

  count(x)
}
