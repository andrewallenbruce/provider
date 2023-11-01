## code to prepare `georgia_reassignments` dataset goes here
ga <- reassignments(state = "GA")

board <- pins::board_folder(here::here("pkgdown/assets/pins-board"))

board |> pins::pin_write(ga,
                         name = "georgia_reassignments",
                         description = "Georgia Provider Reassignments",
                         type = "qs")

board |> pins::write_board_manifest()
