source("docs/slides/img/hexwall.R")

wall <- hexwall(path = "docs/slides/img/hex",
        sticker_row_size = 2, sticker_width = 200)


wall |> magick::image_write("docs/slides/img/hex_wall.png")
