fs::dir_info("D:/CMS National Provider Directory")
files <- fs::dir_ls("D:/CMS National Provider Directory")
length(files)
x <- yyjsonr::read_ndjson_file(files[6], nread = 10L)
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

x$identifier[[1]] |>
  collapse::unlist2d() |>
  collapse::qTBL()

x$name

x$address

x$qualification |>
  collapse::unlist2d() |>
  collapse::qTBL()

x <- hospitals(prov_type = c("cah", "reh"))
x <- cms(end = "hospitals", set = TRUE)
