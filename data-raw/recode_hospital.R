x <- readr::read_csv(
  file = fs::path(
    "C:/Users/Andrew/Downloads/Hospital_Enrollments_2025.10.01.csv"
  ),
  num_threads = 4L,
  col_types = readr::cols(
    `ENROLLMENT ID` = readr::col_character(),
    `ENROLLMENT STATE` = readr::col_character(),
    `PROVIDER TYPE CODE` = readr::col_character(),
    `PROVIDER TYPE TEXT` = readr::col_character(),
    NPI = readr::col_integer(),
    `MULTIPLE NPI FLAG` = readr::col_character(),
    CCN = readr::col_character(),
    `ASSOCIATE ID` = readr::col_character(),
    `ORGANIZATION NAME` = readr::col_character(),
    `DOING BUSINESS AS NAME` = readr::col_character(),
    `INCORPORATION DATE` = readr::col_character(),
    `INCORPORATION STATE` = readr::col_character(),
    `ORGANIZATION TYPE STRUCTURE` = readr::col_character(),
    `ORGANIZATION OTHER TYPE TEXT` = readr::col_character(),
    `PROPRIETARY NONPROFIT` = readr::col_character(),
    `ADDRESS LINE 1` = readr::col_character(),
    `ADDRESS LINE 2` = readr::col_character(),
    CITY = readr::col_character(),
    STATE = readr::col_character(),
    `ZIP CODE` = readr::col_character(),
    `PRACTICE LOCATION TYPE` = readr::col_character(),
    `LOCATION OTHER TYPE TEXT` = readr::col_character(),
    `SUBGROUP - GENERAL` = readr::col_character(),
    `SUBGROUP - ACUTE CARE` = readr::col_character(),
    `SUBGROUP - ALCOHOL DRUG` = readr::col_character(),
    `SUBGROUP - CHILDRENS` = readr::col_character(),
    `SUBGROUP - LONG-TERM` = readr::col_character(),
    `SUBGROUP - PSYCHIATRIC` = readr::col_character(),
    `SUBGROUP - REHABILITATION` = readr::col_character(),
    `SUBGROUP - SHORT-TERM` = readr::col_character(),
    `SUBGROUP - SWING-BED APPROVED` = readr::col_character(),
    `SUBGROUP - PSYCHIATRIC UNIT` = readr::col_character(),
    `SUBGROUP - REHABILITATION UNIT` = readr::col_character(),
    `SUBGROUP - SPECIALTY HOSPITAL` = readr::col_character(),
    `SUBGROUP - OTHER` = readr::col_character(),
    `SUBGROUP - OTHER TEXT` = readr::col_character(),
    `REH CONVERSION FLAG` = readr::col_character(),
    `REH CONVERSION DATE` = readr::col_character(),
    `CAH OR HOSPITAL CCN` = readr::col_character()
  )
)

attr(x, "spec") <- NULL
attr(x, "problems") <- NULL

res <- x |>
  collapse::mtt(
    `INCORPORATION DATE` = as_date(`INCORPORATION DATE`, fmt = "%m/%d/%Y"),
    `REH CONVERSION DATE` = as_date(`REH CONVERSION DATE`, fmt = "%m/%d/%Y"),
    `ADDRESS LINE 1` = combine_(`ADDRESS LINE 1`, `ADDRESS LINE 2`),
    `ADDRESS LINE 2` = NULL,
    `MULTIPLE NPI FLAG` = bin_(`MULTIPLE NPI FLAG`),
    `REH CONVERSION FLAG` = bin_(`REH CONVERSION FLAG`),
    `SUBGROUP - GENERAL` = bin_(`SUBGROUP - GENERAL`),
    `SUBGROUP - ACUTE CARE` = bin_(`SUBGROUP - ACUTE CARE`),
    `SUBGROUP - ALCOHOL DRUG` = bin_(`SUBGROUP - ALCOHOL DRUG`),
    `SUBGROUP - CHILDRENS` = bin_(`SUBGROUP - CHILDRENS`),
    `SUBGROUP - LONG-TERM` = bin_(`SUBGROUP - LONG-TERM`),
    `SUBGROUP - PSYCHIATRIC` = bin_(`SUBGROUP - PSYCHIATRIC`),
    `SUBGROUP - REHABILITATION` = bin_(`SUBGROUP - REHABILITATION`),
    `SUBGROUP - SHORT-TERM` = bin_(`SUBGROUP - SHORT-TERM`),
    `SUBGROUP - SWING-BED APPROVED` = bin_(`SUBGROUP - SWING-BED APPROVED`),
    `SUBGROUP - PSYCHIATRIC UNIT` = bin_(`SUBGROUP - PSYCHIATRIC UNIT`),
    `SUBGROUP - REHABILITATION UNIT` = bin_(`SUBGROUP - REHABILITATION UNIT`),
    `SUBGROUP - SPECIALTY HOSPITAL` = bin_(`SUBGROUP - SPECIALTY HOSPITAL`),
    `SUBGROUP - OTHER` = bin_(`SUBGROUP - OTHER`)
  )

collapse::gvr(res, "ENROLLMENT ID|SUBGROUP") |>
  collapse::pivot(
    ids = c("ENROLLMENT ID"),
    factor = FALSE,
    names = list("SUBGROUP", "ind")
  ) |>
  collapse::roworderv("ENROLLMENT ID") |>
  collapse::sbt(ind %==% 1L, -ind) |>
  collapse::mtt(var = stringr::str_remove(var, "SUBGROUP - ")) |>
  collapse::gby(`ENROLLMENT ID`) |>
  collapse::mtt(var = toString(var)) |>
  collapse::fungroup() |>
  collapse::funique()

# PRACTICE LOCATION TYPE (character):
# OTHER HOSPITAL PRACTICE LOCATION  3291  38.94
# MAIN/PRIMARY HOSPITAL LOCATION    2860  33.84
# HOSPITAL PSYCHIATRIC UNIT          850  10.06
# HOSPITAL SWING-BED UNIT            738   8.73
# HOSPITAL REHABILITATION UNIT       694   8.21
# OPT EXTENSION SITE                  19   0.22

# PROPRIETARY NONPROFIT (character):
# N  6728  73.00
# P  2432  26.39
# D    57   0.62

# ORGANIZATION TYPE STRUCTURE (character):
# CORPORATION      5207  56.49
# OTHER            2092  22.70
# LLC              1738  18.86
# PARTNERSHIP       179   1.94
# SOLE PROPRIETOR     1   0.01

# PROVIDER TYPE TEXT (character):
# 00-09 PART A PROVIDER - HOSPITAL                        6452  70.00
# 00-85 PART A PROVIDER - CRITICAL ACCESS HOSPITAL        2724  29.55
# 00-24 PART A PROVIDER - RURAL EMERGENCY HOSPITAL (REH)    41   0.44

x |> collapse::descr()

list(
  NPI = "strtoi",
  `MULTIPLE NPI FLAG` = "bin_",
  `INCORPORATION DATE` = "as_date",
  `ADDRESS LINE 1` = "combine_",
  `ADDRESS LINE 2` = "combine_",
  `PRACTICE LOCATION TYPE` = "combine_",
  `LOCATION OTHER TYPE TEXT` = "combine_",
  `SUBGROUP - GENERAL` = "bin_",
  `SUBGROUP - ACUTE CARE` = "bin_",
  `SUBGROUP - ALCOHOL DRUG` = "bin_",
  `SUBGROUP - CHILDRENS` = "bin_",
  `SUBGROUP - LONG-TERM` = "bin_",
  `SUBGROUP - PSYCHIATRIC` = "bin_",
  `SUBGROUP - REHABILITATION` = "bin_",
  `SUBGROUP - SHORT-TERM` = "bin_",
  `SUBGROUP - SWING-BED APPROVED` = "bin_",
  `SUBGROUP - PSYCHIATRIC UNIT` = "bin_",
  `SUBGROUP - REHABILITATION UNIT` = "bin_",
  `SUBGROUP - SPECIALTY HOSPITAL` = "bin_",
  `SUBGROUP - OTHER` = "bin_",
  `REH CONVERSION FLAG` = "bin_",
  `REH CONVERSION DATE` = "as_date"
) |>
  collapse::unlist2d(idcols = "column") |>
  collapse::rsplit(~V1)
