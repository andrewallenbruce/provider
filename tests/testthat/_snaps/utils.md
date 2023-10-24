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

