## code to prepare dataset goes here
nucc <- provider::download_nucc_csv()

board <- pins::board_folder(here::here("pkgdown/assets/pins-board"))

board |> pins::pin_write(nucc,
                         name = "taxonomy_codes",
                         description = "NUCC Health Care Provider Taxonomy code set",
                         type = "qs")

board |> pins::write_board_manifest()
