#' Mount [pins][pins::pins-package] board
#'
#' @param source `"local"` or `"remote"`
#'
#' @return `<pins_board_folder>` or `<pins_board_url>`
#'
#' @noRd
mount_board <- function(source = c("local", "remote")) {

  source <- match.arg(source)

  switch(
    source,
    local  = pins::board_folder(
      fs::path_package(
        "extdata/pins",
        package = "provider")
    ),
    remote = pins::board_url(
      fuimus::gh_raw(
        "andrewallenbruce/provider/master/inst/extdata/pins/")
    )
  )
}

#' @autoglobal
#' @noRd
# nocov start
georgia_reassignments <- function() {
  pins::board_url(github_raw("andrewallenbruce/provider/main/pkgdown/assets/pins-board/")) |>
    pins::pin_read("georgia_reassignments")
}
# nocov end
