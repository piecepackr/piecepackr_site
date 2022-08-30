Generating alternative textures for James H. Vipond's piecepack components
==========================================================================

:date: 2020-02-08
:summary: James H. Vipond is a 3D artist who has created high quality `Wavefront OBJ files and associated textures of piecepack game pieces <http://vipondweb.byethost3.com/gameroom/PoserPiecepack.html?i=1>`_. Although Vipond has created some nice png textures to go with his OBJ files you may want to be able to use other piecepack designs.  Here is some example code that given a particular piecepackr_ configuration_ will allow one to generate appropriate png textures for use with Vipond's OBJ assets.



.. include:: ../../links.rst

James H. Vipond is a 3D artist who has created high quality `Wavefront OBJ files and associated textures of piecepack game pieces <http://vipondweb.byethost3.com/gameroom/PoserPiecepack.html?i=1>`_.  `Wavefront OBJ`_ files allow one to make 3D graphics with a variety of software programs.  Although Vipond has created some nice png textures to go with his OBJ files you may want to be able to use other piecepack designs.  Here is some example code that given a particular piecepackr_ configuration_ will allow one to generate appropriate png textures for use with Vipond's OBJ assets.

.. contents::

Code
----


.. sourcecode:: r
    

    library("piecepackr")
    library("grid")
    save_3d_textures <- function(cfg = pp_cfg(), directory = tempdir()) {
        cfg <- as_pp_cfg(cfg)
        for (suit in 1:cfg$n_suits) {
            write_die_texture(suit, cfg, directory)
            write_pawn_texture(suit, cfg, directory)
            for (rank in 1:cfg$n_ranks) {
                write_coin_texture(suit, rank, cfg, directory)
                write_tile_texture(suit, rank, cfg, directory)
            }
        }
        invisible(NULL)
    }
    
    write_pawn_texture <- function(suit = 1, cfg = pp_cfg(), directory = tempdir()) {
        f <- file.path(directory, paste0("pawn_belt_s", suit, ".png"))
        png(f, height = 265, width = 189)
        grid.piece("belt_face", suit = suit,
                   x = 2 / 5, width = 4 / 5, height = 2 / 3, use_pictureGrob = TRUE, cfg = cfg)
        dev.off()
    }
    
    write_coin_texture <- function(suit = 1, rank = 1, cfg = pp_cfg(), directory = tempdir()) {
        f <- file.path(directory, paste0("coin_s", suit, "_r", rank, ".png"))
        png(f, height = 2048, width = 2048)
        pushViewport(viewport(clip = "off"))
        grid.piece(c("coin_back", "coin_face"), suit = suit, rank = rank, angle = c(0, 180),
                   x = c(1 / 4, 3 / 4), width = 1 / 2, height = 1 / 2, use_pictureGrob = TRUE, cfg = cfg)
        popViewport()
        dev.off()
    }
    
    write_die_texture <- function(suit = 1, cfg = pp_cfg(), directory = tempdir()) {
        f <- file.path(directory, paste0("die_s", suit, ".png"))
        png(f, height = 512, width = 512)
        opt <- cfg$get_piece_opt("die_face", suit, 3)
        grid.rect(gp = gpar(col = NA, fill = opt$background_color))
        grid.piece("die_face", suit = suit, rank = c(6, 5, 1, 2, 4, 3),
                   x = rep(c(3 / 12, 9 / 12), 3),
                   y = rep(c(3 / 3, 2 / 3, 1 / 3) - 1 / 6, each = 2),
                   width = 1 / 3, height = 1 / 3, use_pictureGrob = TRUE, cfg = cfg)
        dev.off()
    }
    
    write_tile_texture <- function(suit = 1, rank = 1, cfg = pp_cfg(), directory = tempdir()) {
        f <- file.path(directory, paste0("tile_face_s", suit, "_r", rank, ".png"))
        png(f, height = 250, width = 250)
        grid.piece("tile_face", suit = suit, rank = rank,
               width = 1, height = 1, use_pictureGrob = TRUE, cfg = cfg)
        dev.off()
    }


Configuration notes
-------------------

Here are some tips for creating good configurations to work well with Vipond's assets:

1. Don’t use border lines. You can achieve this by setting ``border_color = "transparent"``.
2. Note the height to width ratio of Vipond's pawn belts are 265 to 189 whereas the default for piecepackr is 0.5" to 2.356194" (in order to fully wrap around a 3/4" diameter pawn). You may consider setting ``belt_face.width=1, belt_face.height=265/189`` if using save_3d_textures.
3. You may want to put thought into your edge color for certain pieces like tiles and coins. To simulate a black laser-cut burned look perhaps use ``edge_color.tile = "black", edge_color.coin = "black"``.
