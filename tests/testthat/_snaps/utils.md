# abb2full() works

    Code
      abb2full("YN")
    Condition
      Error:
      ! "YN" is not a valid state abbreviation.

# format_param() works

    Code
      format_param()
    Condition
      Error in `format_param()`:
      ! `param` is absent but must be supplied.

---

    Code
      format_param(param = a)
    Condition
      Error in `format_param()`:
      ! `arg` is absent but must be supplied.

---

    Code
      format_param(arg = b)
    Condition
      Error in `format_param()`:
      ! `param` is absent but must be supplied.

---

    Code
      format_param(a, b, "filthy")
    Condition
      Error in `format_param()`:
      ! `type` must be one of "filter" or "sql", not "filthy".
      i Did you mean "filter"?

# file_url() works

    Code
      file_url(fn = "c", args = args, offset = 0L)
    Output
      [1] "https://data.cms.gov/provider-data/api/1/datastore/sql?query=%5BSELECT%20%2A%20FROM%20e0a27e9f-abcc-5fe6-b86e-2dad63125545%5D%5BWHERE%20NPI%20=%20%221144544834%22%5D%5BLIMIT%2010000%20OFFSET%200%5D;&show_db_columns"

---

    Code
      file_url(fn = "a", args = args, offset = 0L)
    Output
      [1] "https://data.cms.gov/provider-data/api/1/datastore/sql?query=%5BSELECT%20%2A%20FROM%20f91c3db8-f570-5e7e-9607-c170950f26fc%5D%5BWHERE%20NPI%20=%20%221144544834%22%5D%5BLIMIT%2010000%20OFFSET%200%5D;&show_db_columns"

# format_cli() works

    Code
      format_cli(args)
    Message
      x No results for NPI = 1144544834

