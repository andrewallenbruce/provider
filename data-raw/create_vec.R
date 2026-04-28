create_vec <- function(x) {
  wrp <- c("x <- c(", ")")
  ptt <- "[-\\s()]"

  lhs <- cheapr::if_else_(
    grepl(ptt, x, perl = TRUE),
    encodeString(x, quote = "`", na.encode = FALSE),
    x
  )
  rhs <- encodeString(
    gsub(ptt, "_", x, perl = TRUE),
    quote = '"',
    na.encode = FALSE
  )

  res <- cheapr::paste_(lhs, " = ", rhs, collapse = ", ")
  res <- cheapr::paste_(wrp[1], res, wrp[2], collapse = "")
  res <- styler::style_text(text = res)

  return(res)
}

create_vec(colnames(ex$`2022`))
