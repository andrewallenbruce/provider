fs::dir_info("D:/CMS National Provider Directory")

files <- fs::dir_ls("D:/CMS National Provider Directory")

x <- yyjsonr::read_ndjson_file(files[6], nread = 100L)

# x <- arrow::read_json_arrow(files[6])

x <- collapse::qTBL(x)

base <- collapse::ss(x, j = c("resourceType", "id", "active", "gender"))

meta <- x$meta |>
  collapse::unlist2d() |>
  collapse::qTBL() |>
  collapse::rnm(
    ".id" = ".id.1",
    "lastUpdated" = "V1",
    .nse = FALSE
  ) |>
  collapse::get_vars(c(".id", "lastUpdated"))

base <- cheapr::col_c(base, meta) |>
  collapse::mtt(
    lastUpdated = anytime::anytime(lastUpdated),
    .id = NULL
  )

# purrr::map(x$identifier, \(x) fastplyr::as_tbl(x)) |>
npi <- x$identifier |>
  collapse::unlist2d() |>
  collapse::qTBL()

npi <- cheapr::col_c(
  npi,
  npi$type |>
    collapse::unlist2d(idcols = FALSE) |>
    collapse::qTBL()
)

npi$type <- NULL

period <- set_names(npi$period, npi$value) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "value", fill = TRUE, id.factor = FALSE) |>
  collapse::qTBL() |>
  collapse::mtt(
    start = anytime::anytime(start),
    end = anytime::anytime(end)
  )

npi$period <- NULL

npi <- collapse::join(npi, period, on = "value") |>
  collapse::gv(c("use", "value", "code", "display", "start", "end"))

base <- cheapr::col_c(base, npi)

name <- set_names(x$name, base$value) |>
  cheapr::list_drop_null() |>
  collapse::rowbind(idcol = "value", fill = TRUE, id.factor = FALSE) |>
  collapse::qTBL()

prefix <- set_names(name$prefix, name$value) |>
  vctrs::list_drop_empty() |>
  collapse::unlist2d(idcols = "value") |>
  collapse::qTBL() |>
  collapse::rnm("prefix" = "V1", .nse = FALSE)

name$prefix <- NULL

name <- collapse::join(name, prefix, on = "value")

given <- set_names(name$given, name$value) |>
  vctrs::list_drop_empty() |>
  collapse::unlist2d(idcols = "value") |>
  collapse::qTBL() |>
  collapse::rnm("first" = "V1", "last" = "V2", .nse = FALSE)

name <- collapse::join(name, given, on = "value")

name$given <- NULL

period <- set_names(name$period, name$value) |>
  vctrs::list_drop_empty() |>
  collapse::unlist2d(idcols = c("value", "X")) |>
  collapse::qTBL() |>
  collapse::rnm("start" = "V1", .nse = FALSE) |>
  collapse::slt(1, 3)

name <- collapse::join(name, period, on = "value")

name$period <- NULL
name$start <- anytime::anytime(name$start)

suffix <- set_names(name$suffix, name$value) |>
  vctrs::list_drop_empty() |>
  collapse::unlist2d(idcols = "value") |>
  collapse::qTBL() |>
  collapse::rnm("suffix" = "V1", .nse = FALSE)

name$suffix <- NULL

name <- collapse::join(name, suffix, on = "value")

# cheapr::col_c(base, meta)

address <- set_names(x$address, base$value) |>
  vctrs::list_drop_empty() |>
  collapse::rowbind(idcol = "value", fill = TRUE) |>
  collapse::qTBL()


x$qualification |>
  collapse::unlist2d() |>
  collapse::qTBL()
